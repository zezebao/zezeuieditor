package uidata
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class UIClassInfo extends EventDispatcher
	{
		public var className:String;
		public var childrenInfo:Vector.<UIElementBaseInfo> = new Vector.<UIElementBaseInfo>();
		
		public function UIClassInfo(className:String)
		{
			this.className = className;
			super();
		}
		
		
		
		public function get xml():XML
		{
			var content:String = "<className className='" + className + "'>\n";
			for (var i:int = 0; i < childrenInfo.length; i++) 
			{
				content += "<item " + childrenInfo[i].toString() + " />\n";
			}
			content += "</className>\n";
		}
	}
}