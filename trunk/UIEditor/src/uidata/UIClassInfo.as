package uidata
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import mhqy.ui.UIType;
	
	import utils.UIElementCreator;
	
	public class UIClassInfo extends EventDispatcher
	{
		public var className:String;
		public var folder:String;
		/**读取*/
		public var childrenInfo:Vector.<UIElementBaseInfo> = new Vector.<UIElementBaseInfo>();
		/**UI层级包含的其他类【辅助】*/
		public var helpClassList:Vector.<String> = new Vector.<String>();
		
		public function UIClassInfo(className:String,folder:String="")
		{
			this.className = className;
			this.folder = folder;
			super();
		}
		
		public function parseXML(xmlData:XML):void
		{
			var len:int = xmlData.item.length();
			for (var i:int = 0; i < len; i++) 
			{
				var info:UIElementBaseInfo = UIElementCreator.creatInfo(parseInt(xmlData.item[i].@type));
				info.readXML(xmlData.item[i]);
				childrenInfo.push(info);
			}
		}
		
		public function get publishInfoList():Vector.<UIElementBaseInfo>
		{
			var vec:Vector.<UIElementBaseInfo> = new Vector.<UIElementBaseInfo>();
			for (var i:int = 0; i < childrenInfo.length; i++) 
			{
				if(childrenInfo[i].type != UIType.RADIO_BTN)
				{
					vec.push(childrenInfo[i]);
				}
			}
			vec = vec.concat(radioGroups);
			return vec;
		}
		
		private function get radioGroups():Vector.<UIElementRadioGroupInfo>
		{
			var vec:Vector.<UIElementRadioGroupInfo> = new Vector.<UIElementRadioGroupInfo>();
			var dic:Dictionary = new Dictionary();
			for (var i:int = 0; i < childrenInfo.length; i++) 
			{
				if(childrenInfo[i].type == UIType.RADIO_BTN)
				{
					var groupName:String = UIElementRadioButtonInfo(childrenInfo[i]).groupName;
					if(dic[groupName] == null)
					{
						dic[groupName] =  new Vector.<UIElementRadioButtonInfo>();	
					}
					dic[groupName].push(childrenInfo[i]);
				}
			}
			for(var gname:String in dic) 
			{
				var info:UIElementRadioGroupInfo = new UIElementRadioGroupInfo();
				info.groupName = gname;
				var btns:Vector.<UIElementRadioButtonInfo> = dic[gname];
				for (var j:int = 0; j < btns.length; j++) 
				{
					info.add(btns[j]);
				}
				vec.push(info);
			}
			return vec;
		}
		
		public function get xmlStr():String
		{
			var content:String = "<className className='" + className + "' helpClassList='" + helpClassList.join(",") + "'>\n";
			for (var i:int = 0; i < childrenInfo.length; i++) 
			{
				content += "<item " + childrenInfo[i].toString() + " />\n";
			}
			content += "</className>\n";
			return content;
		}
	}
}