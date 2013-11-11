package help
{
	import data.Config;
	
	import event.UIEvent;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoaderDataFormat;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import ghostcat.events.OperationEvent;
	import ghostcat.operation.load.LoadOper;
	
	import manager.LanguageManager;
	
	import nochump.util.zip.*;

	public class ResourceTxtLoader
	{
		private var _loadCount:int;
		
		/**语言包资源加载*/
		public function ResourceTxtLoader(isRefresh:Boolean = false)
		{
			if(!isRefresh)
			{
				loadConfig();
				loadLanguaue();
			}
			loadXml();
			loadRSLLibs();
		}
		
		private function loadConfig():void
		{
			var browserFile:File = new File(File.applicationDirectory.nativePath + "\\Config.xml");
			if(!browserFile.exists)return;
			var fileSteam:FileStream = new FileStream();
			fileSteam.open(browserFile,FileMode.READ);
			fileSteam.position = 0;
			var str:String = fileSteam.readUTFBytes(fileSteam.bytesAvailable);
			var xml:XML = XML(str);
			App.configXML = xml;
			
			var languagePath:String = xml.LANGUAGE_PATH.toString();
			var swfsPath:String = xml.SWFS_PATH.toString();
			var outputPath:String = xml.OUTPUT_PATH.toString();
			var outputXMLPath:String = xml.OUTPUT_XML_PATH.toString();
			
			
			if(xml.LANGUAGE_PATH.@isRelative == "true")
				languagePath = File.applicationDirectory.nativePath + "\\" + xml.LANGUAGE_PATH.toString();
			if(xml.SWFS_PATH.@isRelative == "true")
				swfsPath = File.applicationDirectory.nativePath + "\\" + xml.SWFS_PATH.toString();
			if(xml.OUTPUT_PATH.@isRelative == "true")
				outputPath = File.applicationDirectory.nativePath + "\\" + xml.OUTPUT_PATH.toString();
			if(xml.OUTPUT_XML_PATH.@isRelative == "true")
				outputXMLPath = File.applicationDirectory.nativePath + "\\" + xml.OUTPUT_XML_PATH.toString();
			var len:int = xml.OUTSIDE_IMGS.length();
			var vec:Vector.<String> = new Vector.<String>();
			for (var i:int = 0; i < len; i++) 
			{
				var outsideImgPath:String = xml.OUTSIDE_IMGS[i].toString();
				if(xml.OUTSIDE_IMGS[i].@isRelative == "true")
					outsideImgPath = File.applicationDirectory.nativePath + "\\" + xml.OUTSIDE_IMGS[i].toString();
				vec.push(outsideImgPath);
			}
			
			if(xml.OUTSIDE_IMGS.@isRelative == "true")
				outsideImgPath = File.applicationDirectory.nativePath + "\\" + xml.OUTSIDE_IMGS.toString();
			
			Config.languagePath = languagePath + "?rnd=" + Math.random();
			Config.swfsPath = swfsPath;
			Config.outputPath = outputPath;
			Config.outputXMLPath = outputXMLPath; 
			Config.outsideImgPath = vec;
			Config.site = xml.SITE.toString();
		}
		
		private function loadXml():void
		{
			var browserFile:File = new File(Config.outputXMLPath);
			if(!browserFile.exists)
			{
				App.log.warn("当前还没有生成配置文件");
				return;
			}
			var fileArr:Array = browserFile.getDirectoryListing();
			for (var i:int = 0; i < fileArr.length; i++) 
			{
				var file:File = fileArr[i];
				if(file.extension == "xml")
				{
					var fileSteam:FileStream = new FileStream();
					fileSteam.open(file,FileMode.READ);
					fileSteam.position = 0;
					var str:String = fileSteam.readUTFBytes(fileSteam.bytesAvailable);
					var fileName:String = file.name.replace(".xml","");
					try
					{
						App.addClassList(str,fileName);
					} 
					catch(error:Error) 
					{
						App.log.error(fileName,"====xml配置错误",error.message);
					}
					fileSteam.close();
				}
			}
			App.xmlLoaded = true;
			App.dispathEvent(new UIEvent(UIEvent.XML_CLASS_LOADED));
		}
		
		private function loadLanguaue():void
		{
			var loader:LoadOper = new LoadOper(Config.languagePath,null,rhandler);
			loader.type = LoadOper.URLLOADER;
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.commit();
		}
		
		private function rhandler(evt:OperationEvent):void
		{
			var byte:ByteArray = (evt.target as LoadOper).data as ByteArray;
			byte.uncompress();
			var str:String = byte.readUTFBytes(byte.bytesAvailable);
			LanguageManager.setup(str);
		}
		
		private function loadRSLLibs():void
		{
			var file:File = new File(Config.swcsLibsPath);
			var loaderContext:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
			loaderContext.allowCodeImport = true;
			if(file.exists)
			{
				var arr:Array = file.getDirectoryListing();
				for (var i:int = 0; i < arr.length; i++) 
				{
					var loadFile:File = arr[i];
					var stream:FileStream = new FileStream();
					stream.open(loadFile,FileMode.READ);
					
					var byte:ByteArray = new ByteArray();
					stream.readBytes(byte,0,stream.bytesAvailable);
					
					var loader:Loader = new Loader();
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onCompleteHandler);
					loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onError);
					var dataByte:ByteArray;
					
					trace(loadFile.nativePath);
					
					if(loadFile.extension == "swf")
					{
						dataByte = byte;
					}else if(loadFile.extension == "swc")
					{
						var zipFile:ZipFile = new ZipFile(byte);
						for(var j:int = 0; j < zipFile.entries.length; j++) {
							var entry:ZipEntry = zipFile.entries[j];
//							trace(entry.name);
							if(entry.name.indexOf("swf") != -1)
							{
								dataByte = zipFile.getInput(entry);
							}
						}
					}
					loader.loadBytes(dataByte,loaderContext);
					_loadCount ++;
				}
				checkAllComplete();
			}else
			{
				checkAllComplete();
			}
			try
			{
				trace(getDefinitionByName("mhsm.interfaces.moviewrapper.IMovieManager"));
				trace(getDefinitionByName("mhsm.interfaces.layer.IPanel"));
				trace(getDefinitionByName("mhqy.ui.mcache.btns.MCacheAsset1Btn"));
			} 
			catch(error:Error) 
			{
				trace(error.message);
			}
		}
		
		protected function onError(evt:IOErrorEvent):void
		{
			App.log.error(evt.text);
			_loadCount --;
			checkAllComplete();
		}
		
		protected function onCompleteHandler(event:Event):void
		{
			_loadCount --;
			checkAllComplete();
		}
		
		private function checkAllComplete():void
		{
			if(App.rslLoaded)return;
			if(_loadCount <= 0)
			{
				App.rslLoaded = true;
				App.dispathEvent(new UIEvent(UIEvent.RSL_LOAD_COMPLETE));
			}
			trace(getDefinitionByName("mhsm.interfaces.moviewrapper.IMovieManager"));
			trace(getDefinitionByName("mhqy.ui.mcache.btns.MCacheAsset1Btn"));
		}
	}
}