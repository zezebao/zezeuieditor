package help
{
	import data.Config;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoaderDataFormat;
	import flash.utils.ByteArray;
	
	import ghostcat.events.OperationEvent;
	import ghostcat.operation.load.LoadOper;
	
	import mhsm.core.manager.LanguageManager;

	public class ResourceTxtLoader
	{
		/**语言包资源加载*/
		public function ResourceTxtLoader()
		{
			loadConfig();
			loadLanguaue();
			loadXml();
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
	}
}