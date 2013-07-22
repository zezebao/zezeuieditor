package uidata
{
	import flash.utils.IDataOutput;
	
	import mhqy.ui.UIType;

	public class UIElementScrollPanelInfo extends UIElementBaseInfo
	{
		public function UIElementScrollPanelInfo()
		{
			type = UIType.SCROLL_PANEL;
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