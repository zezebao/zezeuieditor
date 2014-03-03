package data
{
	import flash.geom.Point;
	import flash.net.SharedObject;

	public class ShareObjectManager
	{
		private static var _instance:ShareObjectManager;
		public static function getInstance():ShareObjectManager
		{
			if(_instance == null)
			{
				_instance = new ShareObjectManager();
			}
			return _instance;
		}
		
		
		
		protected var _so:SharedObject;
		
		public function ShareObjectManager()
		{
			_so = SharedObject.getLocal("signSoft");
			initDefaultSettings();
		}
		
		private function initDefaultSettings():void
		{
			if(_so.data.info == null)
			{
				_so.data.info = new Object();
				//相对于右上角的位置
				_so.data.info[Config.POS_PHOTO] = new Point(200,10);
				_so.data.info[Config.POS_SIGN] = new Point(200,160);
				_so.data.info[Config.POS_SAVE] = new Point(200,310);
				_so.data.info[Config.POS_PREVIEW] = new Point(200,460);
				_so.data.info[Config.POS_PRINT] = new Point(200,610);
			}
		}
		
		public function getProperty(propertyName:String):*
		{
			if(_so.data.info == null)
			{
				throw(new Error("so没有实例化"));
				return null;
			}
			return _so.data.info[propertyName];
		}
		
		public function setProperty(propertyName:String,value:Object):void
		{
			if(_so.data.info == null)
			{
				throw(new Error("so没有实例化"));
				return null;
			}
			
			_so.data.info[propertyName] = value;
			_so.flush();
		}
	}
}