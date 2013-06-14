package utils
{
	import data.Config;
	
	import flash.net.URLLoaderDataFormat;
	
	import ghostcat.events.OperationEvent;
	import ghostcat.operation.load.LoadOper;

	public class UIDataUtil
	{
		public function UIDataUtil()
		{
		}
		
		public static function publish():void
		{
			
		}
		
		public static function save():void
		{
			
		}
		
		public static function open():void
		{
			var loader:LoadOper = new LoadOper(Config.outputXMLPath,null,rhandler);
			loader.type = LoadOper.URLLOADER;
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.commit();
		}
		
		private static function rhandler(evt:OperationEvent):void
		{
			trace((evt.target as LoadOper).data);
		}
	}
}