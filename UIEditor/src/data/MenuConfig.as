package data
{
	import commands.menu.ErrorLogCommand;
	import commands.menu.SaveCommand;
	import commands.menu.UpdateLogCommand;
	
	import data.vo.MenuVo;
	
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;

	public class MenuConfig
	{
		/**key：MenuName,子项：'Vector.<'MenuVo'>'*/
		private var _menuItems:Dictionary = new Dictionary();
		//编辑
		private var _edit:Vector.<MenuVo> = new Vector.<MenuVo>();
		
		
		
		public function MenuConfig()
		{
			initData();
		}
		
		public function initData():void
		{
			_menuItems["编辑"] = _edit;
			
			_edit.push(new MenuVo("保存",new SaveCommand()));
			_edit.push(new MenuVo("更新日志",new UpdateLogCommand()));
			_edit.push(new MenuVo("错误日志",new ErrorLogCommand()));
		}
		
		private function addMenuItem():void
		{
			new MenuVo("保存",new SaveCommand());
		}
		
		public function get menuData():ArrayCollection
		{
			var array:Array = [];
			for (var key:String in _menuItems)
			{
				var vec:Vector.<MenuVo> = _menuItems[key];
				var temp:ArrayCollection = new ArrayCollection();
				for (var i:int = 0; i < vec.length; i++) 
				{
					temp.addItem({label:vec[i].title,data:vec[i].title,value:vec[i].command});
				}
				array.push({label:key,data:key,children:temp});
			}
			return new ArrayCollection(array);
		}
	}
}