package uidata
{
	import flash.utils.IDataOutput;
	
	import mhqy.ui.UIType;

	public class UIElementRadioGroupInfo extends UIElementBaseInfo
	{
		public var groupName:String;
		
		private var _children:Vector.<UIElementRadioButtonInfo> = new Vector.<UIElementRadioButtonInfo>();
		
		/**UI界面不直接使用此类，发布生成二进制数据辅助类*/
		public function UIElementRadioGroupInfo()
		{
			type = UIType.RADIO_BTN; 
		}
		
		public function add(info:UIElementRadioButtonInfo):void
		{
			if(_children.indexOf(info) == -1)
				_children.push(info);
			updateBtnSize();
		}
		
		private function updateBtnSize():void
		{
			var tempWidth:Number = 100;
			var tempHeight:Number = 30;
			for (var i:int = 0; i < _children.length; i++) 
			{
				if(tempWidth < _children[i].width)tempWidth = _children[i].width;
				if(tempHeight < _children[i].height)tempHeight = _children[i].height;
			}
			width = tempWidth;
			height = tempHeight;
		}
		
		override public function writeData(source:IDataOutput):void
		{
			variable = groupName;
			super.writeData(source);
			source.writeByte(0);
			source.writeUTF(groupName);
			source.writeByte(_children.length);
			for (var i:int = 0; i < _children.length; i++) 
			{
				source.writeUTF(_children[i].label);
				source.writeShort(_children[i].x);
				source.writeShort(_children[i].y);
			}
		}
	}
}