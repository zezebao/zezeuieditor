package uidata
{
	import flash.utils.IDataOutput;
	
	import mhqy.ui.UIType;

	public class UIElementPosInfo extends UIElementBaseInfo
	{
		public function UIElementPosInfo()
		{
			type = UIType.POS;
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