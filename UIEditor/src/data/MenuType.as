package data
{
	import flash.sampler.getMemberNames;

	public class MenuType
	{
		/**主菜单【菜单栏目起始ID 1000】*/
		public static const PROJECT:int = 1000;
		public static const MAIN:int = 1001;
		public static const EDIT:int = 1002;
		/**子菜单[起始ID 10000]*/
		//------项目-----------
		public static const PROJECT_SEETING:uint = 10001;
		public static const PROJECT_OPEN:uint = 10002;			//打开项目
		
		//-----日志-------------
		public static const LOG:uint = 100010;
		public static const ERROR_LOG:uint = 100011;
		
		
		public static var MEAN_TYPES:Vector.<MenuInfo>;
		
		public static function setup():void
		{
			MEAN_TYPES = new Vector.<MenuInfo>();
			MEAN_TYPES.push(new MenuInfo(PROJECT,"项目"));
			MEAN_TYPES.push(new MenuInfo(MAIN,"菜单"));
			MEAN_TYPES.push(new MenuInfo(EDIT,"日志"));
			
			//
			getMenuInfoByType(PROJECT).add(new MenuInfo(PROJECT_SEETING,"项目配置"));
			getMenuInfoByType(PROJECT).add(new MenuInfo(PROJECT_OPEN,"打开项目"));
			
			getMenuInfoByType(MAIN).add(new MenuInfo(1,"打开 Ctrl + O"));
			getMenuInfoByType(MAIN).add(new MenuInfo(2,"保存"));
			
			getMenuInfoByType(EDIT).add(new MenuInfo(LOG,"更新日志"));
			getMenuInfoByType(EDIT).add(new MenuInfo(ERROR_LOG,"错误日志"));
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
