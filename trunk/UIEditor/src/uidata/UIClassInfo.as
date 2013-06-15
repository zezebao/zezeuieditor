package uidata
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import utils.UIElementCreator;
	
	public class UIClassInfo extends EventDispatcher
	{
		public var className:String;
		public var folder:String;
		public var childrenInfo:Vector.<UIElementBaseInfo> = new Vector.<UIElementBaseInfo>();;
		
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
		
		public function get xmlStr():String
		{
			var content:String = "<className className='" + className + "'>\n";
			for (var i:int = 0; i < childrenInfo.length; i++) 
			{
				content += "<item " + childrenInfo[i].toString() + " />\n";
			}
			content += "</className>\n";
			return content;
		}
	}
}