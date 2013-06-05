package data
{
	import flash.sampler.getMemberNames;

	public class MenuType
	{
		/**菜单栏目起始ID 1000*/
		public static const MAIN:int = 1001;
		public static const EDIT:int = 1002;
		
		public static var MEAN_TYPES:Vector.<MenuInfo>;
		
		public static function setup():void
		{
			MEAN_TYPES = new Vector.<MenuInfo>();
			MEAN_TYPES.push(new MenuInfo(MAIN,"菜单"));
			MEAN_TYPES.push(new MenuInfo(EDIT,"编辑"));
			
			//
			getMenuInfoByType(MAIN).add(new MenuInfo(1,"打开 Ctrl + O"));
			getMenuInfoByType(MAIN).add(new MenuInfo(2,"保存"));
			
			getMenuInfoByType(EDIT).add(new MenuInfo(3,"编辑1"));
			getMenuInfoByType(EDIT).add(new MenuInfo(4,"编辑2"));
		}
		
		/**获取菜单项*/
		public static function getMenuInfoByType(type:int):MenuInfo
		{
			for each (var info:MenuInfo in MEAN_TYPES) 
			{
				if(info.type == type)
				{
					return info;
				}
				for each (var subInfo:MenuInfo in info.children)
				{
					if(subInfo.type == type)
					{
						return subInfo;
					}
				}
			}
			
			return null;
		}
		
		public static function get menubarXML():XMLList
		{
			var content:String = "<rss>" + "\n";
			for (var i:int = 0; i < MEAN_TYPES.length; i++) 
			{
				content += "<menuItem label='" + MEAN_TYPES[i].title + "' data='" + MEAN_TYPES[i].type + "'>" + "\n";
				for (var j:int = 0; j < MEAN_TYPES[i].children.length; j++) 
				{
					content += "<menuItem label='" + MEAN_TYPES[i].children[j].title + "' data='" + MEAN_TYPES[i].children[j].type + "'>" + "\n";
					content += "</menuItem>" + "\n";
				}
				content += "</menuItem>" + "\n";
			}
			content += "</rss>" + "\n";
			var xmlList:XML = XML(content);
			return xmlList.children();
		}
	}
}

class MenuInfo
{
	public var children:Vector.<MenuInfo> = new Vector.<MenuInfo>();
	public var type:int;
	public var title:String;
	
	public function MenuInfo(type:int,title:String):void
	{
		this.type = type;
		this.title = title;
	}
	
	public function add(info:MenuInfo):void
	{
		if(children.indexOf(info) == -1)children.push(info);
	}
}
