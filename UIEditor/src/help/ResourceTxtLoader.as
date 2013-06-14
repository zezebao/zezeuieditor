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
			loadLanguaue();
			loadXml();
		}
		
		private function loadXml():void
		{
			var browserFile:File = new File(Config.outputXMLPath);
			var fileSteam:FileStream = new FileStream();
			fileSteam.open(browserFile,FileMode.READ);
			fileSteam.position = 0;
			var str:String = fileSteam.readUTFBytes(fileSteam.bytesAvailable);  
		}
		
		private function loadLanguaue():void
		{
			var loader:LoadOper = new LoadOper(Config.languePath,null,rhandler);
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