package uidata
{
	import flash.text.TextFormatAlign;
	
	import mhqy.ui.mcache.btns.MCacheAsset1Btn;
	import mhqy.ui.mcache.btns.MCacheAsset3Btn;
	import mhqy.ui.mcache.btns.MCacheAsset4Btn;
	import mhqy.ui.mcache.btns.MCacheAsset5Btn;
	
	import mhsm.ui.BarAsset1;
	import mhsm.ui.BarAsset8;
	import mhsm.ui.BorderAsset2;
	
	import uidata.vo.UIClassVo;
	
	public class UIData
	{
		/**
		 * 面板元素-对应info初始化数据 
		 */		
		public var UIClassArr:Array;
		
		public function UIData()
		{
			UIClassArr = [
				//label
				new UIClassVo("Label",new UIElementLabelInfo("示例文本")),
				//bar
				new UIClassVo("BarAsset1",new UIElementBarInfo(1)),
				new UIClassVo("BarAsset2",new UIElementBarInfo(2)),
				new UIClassVo("BarAsset3",new UIElementBarInfo(3)),
				new UIClassVo("BarAsset4",new UIElementBarInfo(4)),
				new UIClassVo("BarAsset5",new UIElementBarInfo(5)),
				//bordor
				new UIClassVo("BorderAsset1",new UIElementBorderInfo(1)),
				new UIClassVo("BorderAsset2",new UIElementBorderInfo(2)),
				new UIClassVo("BorderAsset3",new UIElementBorderInfo(3)),
				new UIClassVo("BorderAsset4",new UIElementBorderInfo(4)),
				new UIClassVo("BorderAsset5",new UIElementBorderInfo(5)),
				new UIClassVo("BorderAsset6",new UIElementBorderInfo(6)),
				new UIClassVo("BorderAsset7",new UIElementBorderInfo(7)),
				//btns
				new UIClassVo("Btn1",new UIElementButtonInfo(1,0,"示例")),
				new UIClassVo("Btn2",new UIElementButtonInfo(2,0,"示例")),
				new UIClassVo("Btn3",new UIElementButtonInfo(3,0,"示例")),
				new UIClassVo("Btn4",new UIElementButtonInfo(4,0,"示例")),
				new UIClassVo("Btn5",new UIElementButtonInfo(5,0,"示例")),
				new UIClassVo("Btn6",new UIElementButtonInfo(6,0,"示例")),
				new UIClassVo("Btn7",new UIElementButtonInfo(7,0,"示例")),
				//tabBtns
				new UIClassVo("TABBUTTON1",new UIElementButtonInfo(100,0,"示例")),
				new UIClassVo("TABBUTTON2",new UIElementButtonInfo(101,0,"示例")),
				//checkBox
				new UIClassVo("CheckBox",new UIElementCheckBoxInfo("示例")),
				//line
				new UIClassVo("Line1",new UIElementLineInfo(0,100,2)),
				new UIClassVo("Line2",new UIElementLineInfo(1,100,2)),
				new UIClassVo("Line3",new UIElementLineInfo(2,2,100)),
				new UIClassVo("Line4",new UIElementLineInfo(3,2,100)),
				new UIClassVo("Line6",new UIElementLineInfo(4,100,2)),
				
				new UIClassVo("Combobox",new UIElementComboboxInfo(170,22)),
				new UIClassVo("PageView",new UIElementPageViewInfo()),
			];
		}
		
		/**
		 * 对齐方式 
		 */		
		public var alignTypeList:Array = [
			TextFormatAlign.LEFT,
			TextFormatAlign.CENTER,
			TextFormatAlign.RIGHT
		];
		
		/**temp  label datas*/
		public static function get labelColorData():Array
		{
			var temp:Array = [0xffffff,0xfff100,0xff0000,0x00ff00];
			var arr:Array = new Array(temp.length);
			for (var i:int = 0; i < temp.length; i++) 
			{
				arr[i] = [temp[i].toString(16),temp[i]];
			}
			return arr;
		}
		public function getColorIndex(color:uint):int
		{
			var temp:Array = [0xffffff,0xfff100,0xff0000,0x00ff00];
			for (var i:int = 0; i < temp.length; i++) 
			{
				if(color == temp[i])
					return i;
			}
			return 0;
		}
		public static function get labelFontData():Array
		{
			var temp:Array = ["微软雅黑","宋体"];
			return temp;
		}
		public function getFontIndex(font:String):int
		{
			var temp:Array = ["微软雅黑","宋体"];
			for (var i:int = 0; i < temp.length; i++) 
			{
				if(font == temp[i])
					return i;
			}
			return 0;
		}
	}
}