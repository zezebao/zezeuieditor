package uidata
{
	import flash.utils.IDataOutput;
	
	import mhqy.ui.UIType;

	public class UIElementHotAreaInfo extends UIElementBaseInfo
	{
		public function UIElementHotAreaInfo()
		{
			type = UIType.HOTSPOT;
			canScale = true;
			width = 100;
			height = 100;
		}
		
		override public function writeData(source:IDataOutput):void
		{
			super.writeData(source);
			source.writeByte(0);
		}
		
	}
}