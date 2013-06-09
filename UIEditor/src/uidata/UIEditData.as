package uidata
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	public class UIEditData extends EventDispatcher
	{
		private var _modules:Vector.<UIElementModuleInfo>;
		
		public function UIEditData()
		{
			_modules = new Vector.<UIElementModuleInfo>();
		}
		
		public function writeModuleData(moduleId:int,source:ByteArray):void
		{
			var module:UIElementModuleInfo;
			for(var i:int = 0; i < _modules.length; i++)
			{
				if(_modules[i].id == moduleId)
				{
					module = _modules[i];
					break;
				}
			}
			module.writeData(source);
		}
	}
}