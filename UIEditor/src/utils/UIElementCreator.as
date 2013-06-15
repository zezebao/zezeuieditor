package utils
{
	import avmplus.getQualifiedClassName;
	
	import fl.controls.ComboBox;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	
	import mhqy.ui.UIType;
	import mhqy.ui.button.MBitmapButton;
	import mhqy.ui.button.MCheckBox;
	import mhqy.ui.label.MAssetLabel;
	import mhqy.ui.mcache.btns.MCacheAsset1Btn;
	import mhqy.ui.mcache.btns.MCacheAsset3Btn;
	import mhqy.ui.mcache.btns.MCacheAsset4Btn;
	import mhqy.ui.mcache.btns.MCacheAsset5Btn;
	import mhqy.ui.mcache.btns.MCacheAsset6Btn;
	import mhqy.ui.mcache.btns.MCacheAsset7Btn;
	import mhqy.ui.mcache.btns.MCacheAsset8Btn;
	import mhqy.ui.mcache.btns.tabBtns.MCacheTab1Btn;
	import mhqy.ui.mcache.splits.MCacheSplit1Line;
	import mhqy.ui.mcache.splits.MCacheSplit2Line;
	import mhqy.ui.mcache.splits.MCacheSplit3Line;
	import mhqy.ui.mcache.splits.MCacheSplit4Line;
	import mhqy.ui.mcache.splits.MCacheSplit6Line;
	import mhqy.ui.page.PageView;
	
	import mhsm.core.manager.LanguageManager;
	import mhsm.ui.BarAsset1;
	import mhsm.ui.BarAsset3;
	import mhsm.ui.BarAsset6;
	import mhsm.ui.BarAsset8;
	import mhsm.ui.BarAsset9;
	import mhsm.ui.BorderAsset1;
	import mhsm.ui.BorderAsset2;
	import mhsm.ui.BorderAsset4;
	import mhsm.ui.BorderAsset5;
	import mhsm.ui.BorderAsset6;
	import mhsm.ui.BorderAsset8;
	import mhsm.ui.BorderAsset9;
	
	import uidata.UIElementBarInfo;
	import uidata.UIElementBaseInfo;
	import uidata.UIElementBitmapInfo;
	import uidata.UIElementBorderInfo;
	import uidata.UIElementButtonInfo;
	import uidata.UIElementCheckBoxInfo;
	import uidata.UIElementComboboxInfo;
	import uidata.UIElementLabelInfo;
	import uidata.UIElementLineInfo;
	import uidata.UIElementPageViewInfo;
	import uidata.vo.PropertyVo;

	public class UIElementCreator
	{
		public function UIElementCreator()
		{
		}
		
		public static function createItem(info:UIElementBaseInfo):DisplayObject
		{
			var item:DisplayObject;
			var cla:Class;
			var content:String;
			switch(info.type)
			{
				case UIType.BITMAP:
					cla = getDefinitionByName(UIElementBitmapInfo(info).className) as Class;
					item = new Bitmap(new cla());
					break;
				case UIType.BAR:
					item = getBarByType(UIElementBarInfo(info).barType);
					item.width = info.width;
					item.height = info.height;
					break;
				case UIType.BORDOR:
					item = getBorderByType(UIElementBorderInfo(info).borderType);
					item.width = info.width;
					item.height = info.height;
					break;
				case UIType.BUTTON:
				case UIType.TAB_BTN:
					item = getBtnByInfo(info as UIElementButtonInfo);
					break;
				case UIType.LABEL:
					content = LanguageManager.getWord(UIElementLabelInfo(info).label);
					if(content == "")content = UIElementLabelInfo(info).label;
					item = new MAssetLabel(content,UIElementLabelInfo(info).typeArr,UIElementLabelInfo(info).align,UIElementLabelInfo(info).wrap);
					break;
				case UIType.BITMAP_BTN:
					cla = getDefinitionByName(UIElementBitmapInfo(info).className) as Class;
					content = LanguageManager.getWord(UIElementBitmapInfo(info).label);
					if(content == "")content = UIElementBitmapInfo(info).label;
					if(cla)
					{
						item = new MBitmapButton(new cla(),content);	
					}else
					{
						item = new MBitmapButton(new BitmapData(100,100),content);
					}
					break;
				case UIType.CHECKBOX:
					content = LanguageManager.getWord(UIElementCheckBoxInfo(info).label);
					if(content == "")content = UIElementCheckBoxInfo(info).label;
					item = new MCheckBox(content);
					break;
				case UIType.LINE:
					item = getLineByInfo(info as UIElementLineInfo);
					item.width = info.width;
					item.height = info.height;
					break;
				case UIType.PAGE_VIEW:
					item = new PageView(1,UIElementPageViewInfo(info).argShowOtherBtn);
					break;
				case UIType.COMBO_BOX:
					item = new ComboBox();
					ComboBox(item).setSize(info.width,info.height);
//					item.width = info.width;
//					item.height = info.height;
					break;
				case UIType.RADIO_BTN:
					break;
			}
			return item;
		}
		
		private static function getBorderByType(type:int):DisplayObject
		{
			switch(type)
			{
				case 1:return new BorderAsset1();
				case 2:return new BorderAsset2();
				case 3:return new BorderAsset4();
				case 4:return new BorderAsset5();
				case 5:return new BorderAsset6();
				case 6:return new BorderAsset8();
				case 7:return new BorderAsset9();
			}
			return new BorderAsset2();
		}
		
		private static function getBarByType(type:int):DisplayObject
		{
			switch(type)
			{
				case 1:return new BarAsset1();
				case 2:return new BarAsset3();
				case 3:return new BarAsset6();
				case 4:return new BarAsset8();
				case 5:return new BarAsset9();
			}
			return new BarAsset3();
		}
		
		private static function getBtnByInfo(info:UIElementButtonInfo):DisplayObject
		{
			var content:String = LanguageManager.getWord(info.label);
			if(content == "")content = info.label;
			switch(info.btnType)
			{
				case 1:return new MCacheAsset1Btn(info.scaleType,content);
				case 2:return new MCacheAsset3Btn(info.scaleType,content);
				case 3:return new MCacheAsset4Btn(info.scaleType,content);
				case 4:return new MCacheAsset5Btn(info.scaleType,content);
				case 5:return new MCacheAsset6Btn(info.scaleType,content);
				case 6:return new MCacheAsset7Btn(info.scaleType,content);
				case 7:return new MCacheAsset8Btn(info.scaleType,content);
				//tab button   100代表0,101代表1
				case 100:return new MCacheTab1Btn(0,info.scaleType,content);
				case 101:return new MCacheTab1Btn(1,info.scaleType,content);
			}
			return new MCacheAsset1Btn(info.scaleType,content);
		}
		
		public static function getLineByInfo(info:UIElementLineInfo):DisplayObject
		{
			switch(info.lineType)
			{
				case 0:return new MCacheSplit1Line(info.width,info.height);
				case 1:return new MCacheSplit2Line(info.width,info.height);
				case 2:return new MCacheSplit3Line();
				case 3:return new MCacheSplit4Line();
				case 4:return new MCacheSplit6Line();
			}
			return new MCacheSplit1Line(info.width,info.height);
		}
		
		//new uiinfo 拿来克隆数据用（克隆源需要类型，因此有此方法）
		public static function creatInfo(type:int):UIElementBaseInfo
		{
			switch(type)
			{
				case UIType.BITMAP:
				case UIType.BITMAP_BTN:
					return new UIElementBitmapInfo();
				case UIType.BAR:
					return new UIElementBarInfo();
				case UIType.BORDOR:
					return new UIElementBorderInfo();
				case UIType.BUTTON:
				case UIType.TAB_BTN:
					return new UIElementButtonInfo(1,0,"");
				case UIType.LABEL:
					return new UIElementLabelInfo();
				case UIType.CHECKBOX:
					return new UIElementCheckBoxInfo("");
				case UIType.LINE:
					return new UIElementLineInfo(0,100,2);
				case UIType.PAGE_VIEW:
					return new UIElementPageViewInfo();
				case UIType.COMBO_BOX:
					return new UIElementComboboxInfo(170,22);
			}
			return null;
		}

		public static function update(target:DisplayObject,info:UIElementBaseInfo):void
		{
			var content:String;
			switch(info.type)
			{
				case UIType.LABEL:
					var labelInfo:UIElementLabelInfo = info as UIElementLabelInfo;
					var label:MAssetLabel = target as MAssetLabel;
					label.width = labelInfo.width;
					label.height = labelInfo.height;
					var tf:TextFormat = label.defaultTextFormat;
					tf.font = labelInfo.font;
					tf.bold = labelInfo.bold;
					tf.leading = labelInfo.leading;
					tf.align = labelInfo.align;
					tf.color = labelInfo.color;
					tf.size = labelInfo.size;
					tf.underline = labelInfo.underLine;
					label.defaultTextFormat = tf;
					label.wordWrap = labelInfo.wrap;
					content = LanguageManager.getWord(labelInfo.label);
					if(content == "")content = labelInfo.label;
					label.htmlText = content;
					break;
				case UIType.BITMAP:
				case UIType.BORDOR:
				case UIType.BAR:
				case UIType.LINE:
				case UIType.PAGE_VIEW:
				case UIType.COMBO_BOX:
					var vec:Vector.<PropertyVo> = info.getPropertys();
					for (var i:int = 0; i < vec.length; i++) 
					{
						if(target.hasOwnProperty(vec[i].proterty) && vec[i].proterty != "x" && vec[i].proterty != "y")
						{
							target[vec[i].proterty] = vec[i].value;
						}
					}
					break;
				case UIType.BUTTON:
				case UIType.TAB_BTN:
					content = LanguageManager.getWord(UIElementButtonInfo(info).label);
					if(content == "")content = UIElementButtonInfo(info).label;
					if(target.hasOwnProperty("label"))
					{
						target["label"] = content;
					}
					break;
				case UIType.CHECKBOX:
					content = LanguageManager.getWord(UIElementCheckBoxInfo(info).label);
					if(content == "")content = UIElementCheckBoxInfo(info).label;
					MCheckBox(target).label = content;
					break;
			}
		}
	}
}