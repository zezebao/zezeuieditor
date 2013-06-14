package uidata
{
	import flash.utils.IDataOutput;
	
	import mhqy.ui.UIType;

	public class UIElementComboboxInfo extends UIElementBaseInfo
	{
		public function UIElementComboboxInfo(width:int,height:int)
		{
			this.width = width;
			this.height = height;
			canScale = true;
			type = UIType.COMBO_BOX;
		}
		
		override public function writeData(source:IDataOutput):void
		{
			super.writeData(source);
			source.writeByte(0);
		}
	}
}