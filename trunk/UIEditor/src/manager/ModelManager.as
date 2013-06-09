package manager
{
	import flash.display.LoaderInfo;
	import flash.system.ApplicationDomain;

	public class ModelManager
	{
		public function ModelManager(){}
		private static var _instance:ModelManager;
		public static function getInstance():ModelManager
		{
			if (_instance == null)
			{
				_instance = new ModelManager();
			}
			return _instance;
		}
		public var swfAry:Array = [];
	}
}