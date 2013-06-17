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
	import flash.utils.IDataInput;
	import flash.utils.getDefinitionByName;
	
	import ghostcat.events.OperationEvent;
	import ghostcat.operation.load.LoadOper;
	
	import mhsm.core.manager.LanguageManager;
	import mhsm.interfaces.layer.IPanel;
	
	import nochump.util.zip.*;
	
	import spark.components.Application;

	public class ResourceTxtLoader
	{
		private var _loadCount:int;
		
		/**语言包资源加载*/
		public function ResourceTxtLoader()
		{
			loadConfig();
			loadLanguaue();
			loadXml();
			loadRSLLibs();
		}
		
		private function loadConfig():void
		{
			var browserFile:File = new File(File.applicationDirectory.nativePath + "\\Config.xml");
			var fileSteam:FileStream = new FileStream();
			fileSteam.open(browserFile,FileMode.READ);
			fileSteam.position = 0;
			var str:String = fileSteam.readUTFBytes(fileSteam.bytesAvailable);
			var xml:XML = XML(str);
			
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
			
			Config.languagePath = languagePath + "?rnd=" + Math.random();
			Config.swfsPath = swfsPath;
			Config.outputPath = outputPath;
			Config.outputXMLPath = outputXMLPath; 
			
		}
		
		private function loadXml():void
		{
			var browserFile:File = new File(Config.outputXMLPath);
			if(browserFile.exists)
			{
				var fileSteam:FileStream = new FileStream();
				fileSteam.open(browserFile,FileMode.READ);
				fileSteam.position = 0;
				var str:String = fileSteam.readUTFBytes(fileSteam.bytesAvailable);
			}
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
			var str:String = byte.readUTF();
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
			}
		}
		
		protected function onError(evt:IOErrorEvent):void
		{
			App.log.error(evt.text);
			_loadCount --;
			if(_loadCount <= 0)
			{
				allComplete();
			}
		}
		
		protected function onCompleteHandler(event:Event):void
		{
			_loadCount --;
			if(_loadCount <= 0)
			{
				allComplete();
			}
			try
			{
				trace(getDefinitionByName("mhsm.interfaces.layer.IPanel"));
				trace(getDefinitionByName("mhsm.interfaces.moviewrapper.IMovieManager"));
				trace(getDefinitionByName("mhqy.ui.mcache.btns.MCacheAsset1Btn"));
			} 
			catch(error:Error) 
			{
				trace(error.message);
			}
		}
		
		private function allComplete():void
		{
			App.dispathEvent(new UIEvent(UIEvent.RSL_LOAD_COMPLETE));
			trace(getDefinitionByName("mhsm.interfaces.moviewrapper.IMovieManager"));
			trace(getDefinitionByName("mhqy.ui.mcache.btns.MCacheAsset1Btn"));
		}
	}
}