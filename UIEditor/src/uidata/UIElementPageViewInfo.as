package uidata
{
	import flash.utils.IDataOutput;
	
	import mhqy.ui.UIType;

	public class UIElementPageViewInfo extends UIElementBaseInfo
	{
		public function UIElementPageViewInfo(width:int=70)
		{
			this.width = width;
			type = UIType.PAGE_VIEW;
		}
		
		override public function writeData(source:IDataOutput):void
		{
			super.writeData(source);
			source.writeByte(0);
		}
	}
}