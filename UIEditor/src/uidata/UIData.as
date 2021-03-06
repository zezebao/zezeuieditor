package uidata
{
	import flash.text.TextFormatAlign;
	
	import mhqy.ui.UIType;
	import mhqy.ui.label.MAssetLabelII;
	
	import mx.collections.ArrayCollection;
	
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
				new UIClassVo("TabButton1",new UIElementButtonInfo(100,0,"示例")),
				new UIClassVo("TabButton2",new UIElementButtonInfo(101,0,"示例")),
				new UIClassVo("SelectBtn",new UIElementButtonInfo(102,0,"示例")),
				//checkBox
				new UIClassVo("CheckBox",new UIElementCheckBoxInfo("示例")),
				//line
				new UIClassVo("Line1",new UIElementLineInfo(0,100,2)),
				new UIClassVo("Line2",new UIElementLineInfo(1,100,2)),
				new UIClassVo("Line3",new UIElementLineInfo(2,2,100)),
				new UIClassVo("Line4",new UIElementLineInfo(3,2,100)),
				new UIClassVo("Line6",new UIElementLineInfo(4,100,2)),
				
				new UIClassVo("RadioButton",new UIElementRadioButtonInfo("groupName","示例")),
				new UIClassVo("Combobox",new UIElementComboboxInfo(170,22)),
				new UIClassVo("PageView",new UIElementPageViewInfo()),
				
				new UIClassVo("HotArea",new UIElementHotAreaInfo()),
				new UIClassVo("MTile",new UIElementTileInfo()),
				new UIClassVo("MScrollPanel",new UIElementScrollPanelInfo()),
				new UIClassVo("只获取位置类型...",new UIElementPosInfo()),
			];
			var len:int = App.configXML.UI_BITMAPS.UI_BITMAP.length();
			for (var i:int = 0; i < len; i++) 
			{
				var describe:String = App.configXML.UI_BITMAPS.UI_BITMAP[i].@describe;
				var className:String = App.configXML.UI_BITMAPS.UI_BITMAP[i].@className;
				UIClassArr.push(new UIClassVo(describe,new UIElementBitmapInfo(className)));
			}
		}
		
		private static var _typeArrayCollection:ArrayCollection;
		public static function get typeArrayCollection():ArrayCollection
		{
			if(_typeArrayCollection != null)return _typeArrayCollection;
			_typeArrayCollection = new ArrayCollection();
			_typeArrayCollection.addItem({label:"混合多选",value:99});
			_typeArrayCollection.addItem({label:"UI_BITMAP",value:UIType.BITMAP});
			_typeArrayCollection.addItem({label:"UI_BITMAPBTN",value:UIType.BITMAP_BTN});
			_typeArrayCollection.addItem({label:"UI_BORDER",value:UIType.BORDOR});
			_typeArrayCollection.addItem({label:"UI_BAR",value:UIType.BAR});
			_typeArrayCollection.addItem({label:"UI_BUTTON",value:UIType.BUTTON});
			_typeArrayCollection.addItem({label:"UI_TABBUTTON",value:UIType.TAB_BTN});
			_typeArrayCollection.addItem({label:"UI_LABEL",value:UIType.LABEL});
			
			_typeArrayCollection.addItem({label:"UI_CHECKBOX",value:UIType.CHECKBOX});
			_typeArrayCollection.addItem({label:"UI_RADIO_BTN",value:UIType.RADIO_BTN});
			_typeArrayCollection.addItem({label:"UI_LINE",value:UIType.LINE});
			_typeArrayCollection.addItem({label:"UI_PAGE_VIEW",value:UIType.PAGE_VIEW});
			_typeArrayCollection.addItem({label:"UI_COMBO_BOX",value:UIType.COMBO_BOX});
			_typeArrayCollection.addItem({label:"UI_TILE",value:UIType.TILE});
			_typeArrayCollection.addItem({label:"UI_HOTAREA",value:UIType.HOTSPOT});
			_typeArrayCollection.addItem({label:"UI_MOVIECLIP",value:UIType.MOVIECLIP});
			_typeArrayCollection.addItem({label:"UI_SCROLLPANEL",value:UIType.SCROLL_PANEL});
			_typeArrayCollection.addItem({label:"只获取位置，宽高",value:UIType.POS});
			return _typeArrayCollection;
		}
		
		public static function getLabelByType(type:int):String
		{
			for(var i:int=0;i<typeArrayCollection.length;i++){
				var obj:Object = typeArrayCollection.getItemAt(i);
				if(obj.value == type)
				{
					return obj.label;
				}
			}
			return "不知道类型。。。。囧啊";
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
			var temp:Array = MAssetLabelII.colorList;
			var arr:Array = new Array(temp.length);
			for (var i:int = 0; i < temp.length; i++) 
			{
				arr[i] = [temp[i].toString(16),temp[i]];
			}
			return arr;
		}
		public function getColorIndex(color:uint):int
		{
			var temp:Array = MAssetLabelII.colorList;
			for (var i:int = 0; i < temp.length; i++) 
			{
				if(color == temp[i])
					return i;
			}
			return 0;
		}
		public static function get labelFontData():Array
		{
			var temp:Array = MAssetLabelII.fontList;
			return temp;
		}
		public function getFontIndex(font:String):int
		{
			var temp:Array = MAssetLabelII.fontList;
			for (var i:int = 0; i < temp.length; i++) 
			{
				if(font == temp[i])
					return i;
			}
			return 0;
		}
	}
}