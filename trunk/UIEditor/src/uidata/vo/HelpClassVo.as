package uidata.vo
{
	public class HelpClassVo
	{
		public var className:String;
		public var locked:Boolean; 
		public var visible:Boolean;
		
		public function HelpClassVo(className:String = "",locked:Boolean = false,visible:Boolean = true)
		{
			this.className = className;
			this.locked = locked;
			this.visible = visible;
		}
		
		public function parseData(value:String):void
		{
			var arr:Array = value.split("|");
			className = arr[0];
			try
			{
				locked = arr[1] == "1";
				visible = arr[2] == "1";				
			} 
			catch(error:Error) 
			{
				
			}
		}
		
		public function toString():String
		{
			return className + "|" + int(locked) + "|" + int(visible);
		}
		
	}
}