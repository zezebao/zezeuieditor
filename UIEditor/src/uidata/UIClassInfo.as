package uidata
{
	import event.UIEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import mhqy.ui.UIType;
	
	import uidata.vo.HelpClassVo;
	
	import utils.UIElementCreator;
	
	public class UIClassInfo extends EventDispatcher
	{
		public var className:String;
		public var folder:String;
		/**读取*/
		public var childrenInfo:Vector.<UIElementBaseInfo> = new Vector.<UIElementBaseInfo>();
		private var _helpClassList:Vector.<HelpClassVo> = new Vector.<HelpClassVo>();
		
		public function UIClassInfo(className:String,folder:String="")
		{
			this.className = className;
			this.folder = folder;
			super();
		}
		
		public function set helpClassList(value:Vector.<HelpClassVo>):void
		{
			_helpClassList = value;
		}

		/**UI层级包含的其他类名【辅助】*/
		public function get helpClassList():Vector.<HelpClassVo>
		{
			if(!hasHelpClass(className))
			{
				_helpClassList.push(new HelpClassVo(className));
			}
			return _helpClassList;
		}
		
		public function addHelpClass(value:String):void
		{
			if(!hasHelpClass(value))
			{
				_helpClassList.push(new HelpClassVo(value));
				helpClassUpdate();
			}
			trace(helpClassList.join(","));			
		}
		
		public function getHelpVo(value:String):HelpClassVo
		{
			for (var i:int = 0; i < _helpClassList.length; i++) 
			{
				if(_helpClassList[i].className == value)
					return _helpClassList[i];
			}
			return null;	
		}
		
		public function getHelpClassIndex(value:String):int
		{
			for (var i:int = 0; i < _helpClassList.length; i++) 
			{
				if(_helpClassList[i].className == value)
					return i;
			}
			return -1;		
		}
		
		public function hasHelpClass(value:String):Boolean
		{
			for (var i:int = 0; i < _helpClassList.length; i++) 
			{
				if(_helpClassList[i].className == value)
					return true;
			}
			return false;		
		}
		
		public function delHelpClass(value:String):void
		{
			var index:int = _helpClassList.indexOf(value); 
			if(index != -1)
			{
				_helpClassList.splice(index,1);
				helpClassUpdate();
			}
		}
		
		private function helpClassUpdate():void
		{
			App.dispathEvent(new UIEvent(UIEvent.HELP_CLASS_UPDATE));
		}
		
		public function parseXML(xmlData:XML):void
		{
			var helpClassStr:String = String(xmlData.@helpClassList);
			if(helpClassStr != "")
			{
				var arr:Array = helpClassStr.split(",");
				var vec:Vector.<HelpClassVo> = new Vector.<HelpClassVo>();
				for (var j:int = 0; j < arr.length; j++) 
				{
					var vo:HelpClassVo = new HelpClassVo();
					vo.parseData(arr[j]);
					vec.push(vo);
				}
				_helpClassList = vec;
			}
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