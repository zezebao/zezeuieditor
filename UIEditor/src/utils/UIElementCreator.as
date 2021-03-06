package utils
{
	import fl.controls.CheckBox;
	import fl.controls.ComboBox;
	import fl.controls.RadioButton;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	
	import manager.LanguageManager;
	
	import mhqy.ui.UIType;
	import mhqy.ui.button.MBitmapButton;
	import mhqy.ui.container.MTile;
	import mhqy.ui.label.MAssetLabelII;
	import mhqy.ui.mcache.btns.MCacheAsset1Btn;
	import mhqy.ui.mcache.btns.MCacheAsset3Btn;
	import mhqy.ui.mcache.btns.MCacheAsset4Btn;
	import mhqy.ui.mcache.btns.MCacheAsset5Btn;
	import mhqy.ui.mcache.btns.MCacheAsset6Btn;
	import mhqy.ui.mcache.btns.MCacheAsset7Btn;
	import mhqy.ui.mcache.btns.MCacheAsset8Btn;
	import mhqy.ui.mcache.btns.selectBtns.MCacheSelectBtn;
	import mhqy.ui.mcache.btns.tabBtns.MCacheTab1Btn;
	import mhqy.ui.mcache.splits.MCacheSplit1Line;
	import mhqy.ui.mcache.splits.MCacheSplit2Line;
	import mhqy.ui.mcache.splits.MCacheSplit3Line;
	import mhqy.ui.mcache.splits.MCacheSplit4Line;
	import mhqy.ui.mcache.splits.MCacheSplit6Line;
	import mhqy.ui.page.PageView;
	
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
	
	import uidata.UIData;
	import uidata.UIElementBarInfo;
	import uidata.UIElementBaseInfo;
	import uidata.UIElementBitmapInfo;
	import uidata.UIElementBorderInfo;
	import uidata.UIElementButtonInfo;
	import uidata.UIElementCheckBoxInfo;
	import uidata.UIElementComboboxInfo;
	import uidata.UIElementHotAreaInfo;
	import uidata.UIElementLabelInfo;
	import uidata.UIElementLineInfo;
	import uidata.UIElementMovieClipInfo;
	import uidata.UIElementPageViewInfo;
	import uidata.UIElementPosInfo;
	import uidata.UIElementRadioButtonInfo;
	import uidata.UIElementScrollPanelInfo;
	import uidata.UIElementTileInfo;
	import uidata.vo.PropertyVo;

	public class UIElementCreator
	{
		public function UIElementCreator()
		{
		}
		
		/**创建Item，注：x,y不在此处设置*/
		public static function createItem(info:UIElementBaseInfo):DisplayObject
		{
			var item:DisplayObject;
			var child:Object;
			var cla:Class;
			var label:String;
			if(info.hasOwnProperty("label"))
			{
				label = LanguageManager.getWord(info["label"]);
				if(label == "")label = info["label"];
			}
			switch(info.type)
			{
				case UIType.BITMAP:
					if(UIElementBitmapInfo(info).isOutside)
					{
						item = UIElementBitmapInfo(info).bitmap;
					}else
					{
						try
						{
							cla = getDefinitionByName(UIElementBitmapInfo(info).className) as Class;
							child = new cla();
							if(child is BitmapData)
							{
								item = new Bitmap(child as BitmapData);						
							}else if(child is DisplayObject)
							{
								item = child as DisplayObject;
							}
							if(info.width != 0)item.width = info.width;
							if(info.height != 0)item.height = info.height;
						} 
						catch(error:Error) 
						{
							var bmd:BitmapData = new BitmapData(info.width,info.height);
							info.isResourceError = true;
							var tf:TextField = new TextField();
							tf.width = 100;
							tf.wordWrap = true;
							if(tf.width > info.width)tf.width = info.width;
							if(tf.height > info.height)tf.height = info.height;
							tf.textColor = 0xff0000;
							tf.text = info["className"] + "不存在";
							bmd.draw(tf);
							item = new Bitmap(bmd);
							App.log.error("找不到类：",info["className"]);
						}
					}
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
					item = new MAssetLabelII(label,UIElementLabelInfo(info).typeArr[0],UIElementLabelInfo(info).wrap);
//					MAssetLabelII(item).setSize(info.width,info.height);
					update(item,info);
					break;
				case UIType.BITMAP_BTN:
					if(UIElementBitmapInfo(info).isOutside)
					{
						item = UIElementBitmapInfo(info).bitmap;
					}else
					{
						try
						{
							cla = getDefinitionByName(UIElementBitmapInfo(info).className) as Class;
							if(cla)
							{
								item = new MBitmapButton(new cla(),label);
							}
						} 
						catch(error:Error) 
						{
							item = new MBitmapButton(new BitmapData(100,100),label);
							App.log.error("找不到类：",info["className"]);
						}
					}
					item.width = info.width;
					item.height = info.height;
					break;
				case UIType.CHECKBOX:
					item = new CheckBox();
					item.width = info.width;
					CheckBox(item).label = label;
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
					break;
				case UIType.RADIO_BTN:
					item = new RadioButton();
					RadioButton(item).label = label;
					RadioButton(item).setSize(info.width,info.height);
					break;
				case UIType.HOTSPOT:
					item = new Sprite();
					Sprite(item).graphics.beginFill(0xff0000,0.3);
					Sprite(item).graphics.drawRect(0,0,info.width,info.height);
					Sprite(item).graphics.endFill();
					break;
				case UIType.MOVIECLIP:
					try
					{
						cla = getDefinitionByName(UIElementMovieClipInfo(info).className) as Class;
						if(cla)
						{
							item = new cla();
							item.width = info.width;
							item.height = info.height;
						}
					} 
					catch(error:Error) 
					{
						App.log.error("找不到类：",info["className"]);
					}
					break;
				case UIType.TILE:
					item = getTile(info as UIElementTileInfo);
					break;
				case UIType.SCROLL_PANEL:
				case UIType.POS:
					var sp:Sprite = new Sprite();
					sp.graphics.beginFill(0,0.2);
					sp.graphics.drawRect(0,0,info.width,info.height);
					sp.graphics.endFill();
					item = sp;
					var txt:TextField = new TextField();
					txt.width = 100;
					txt.wordWrap = true;
					txt.text = UIData.getLabelByType(info.type);
					if(txt.width > info.width)txt.width = info.width;
					if(txt.height > info.height)txt.height = info.height;
					sp.addChild(txt);
					break;
			}
			if(item is Sprite)
			{
				Sprite(item).mouseChildren = Sprite(item).mouseEnabled = false;
			}
			return item;
		}
		
		private static function getTile(info:UIElementTileInfo):MTile
		{
			var tile:MTile = new MTile(info.itemWidth,info.itemHeight,info.columns);
			tile.graphics.beginFill(0x00ff00,0.1);
			tile.graphics.drawRect(0,0,info.width,info.height);
			tile.graphics.endFill();
			tile.itemGapH = info.itemGapH;
			tile.itemGapW = info.itemGapW;
			tile.setSize(info.width,info.height);
			
			addTileItem(tile,info);
			
			return tile;
		}
		
		private static function addTileItem(tile:MTile,info:UIElementTileInfo):void
		{
			for (var i:int = 0; i < 8; i++)
			{
				var sp:Sprite = new Sprite();
				sp.graphics.beginFill(0xffffff,0.4);
				sp.graphics.drawRect(0,0,info["itemWidth"],info["itemHeight"]);
				sp.graphics.endFill();
				tile.appendItem(sp);
			}
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
				//tab button   100代表0,101代表1 102代表2
				case 100:return new MCacheTab1Btn(0,info.scaleType,content);
				case 101:return new MCacheTab1Btn(1,info.scaleType,content);
				case 102:return new MCacheSelectBtn(2,info.scaleType,content);
			}
			return new MCacheAsset1Btn(info.scaleType,content);
		}
		
		public static function getLineByInfo(info:UIElementLineInfo):DisplayObject
		{
			switch(info.lineType)
			{
				case 0:return new MCacheSplit1Line(info.width,info.height);
				case 1:return new MCacheSplit2Line(100,info.width,info.height);
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
					return new UIElementCheckBoxInfo();
				case UIType.LINE:
					return new UIElementLineInfo(0,100,2);
				case UIType.PAGE_VIEW:
					return new UIElementPageViewInfo();
				case UIType.COMBO_BOX:
					return new UIElementComboboxInfo(170,22);
				case UIType.RADIO_BTN:
					return new UIElementRadioButtonInfo();
				case UIType.HOTSPOT:
					return new UIElementHotAreaInfo();
				case UIType.MOVIECLIP:
					return new UIElementMovieClipInfo("");
				case UIType.TILE:
					return new UIElementTileInfo();
				case UIType.SCROLL_PANEL:
					return new UIElementScrollPanelInfo();
				case UIType.POS:
					return new UIElementPosInfo();
			}
			throw new Error("clone info Error,error type lost:" + type);
		}

		public static function update(target:DisplayObject,info:UIElementBaseInfo):void
		{
			var content:String;
			if(info.hasOwnProperty("label"))
			{
				content = LanguageManager.getWord(info["label"]);
				if(content == "")content = info["label"];
			}
			switch(info.type)
			{
				case UIType.LABEL:
					var labelInfo:UIElementLabelInfo = info as UIElementLabelInfo;
					var label:MAssetLabelII = target as MAssetLabelII;
					label.width = labelInfo.width;
					label.height = labelInfo.height;
					var tf:TextFormat = label.defaultTextFormat;
					if(labelInfo.font == "华文行楷")
					{
						tf.font = "STXingkai";
					}else if(labelInfo.font == "微软雅黑")
					{
						tf.font = "Microsoft YaHei";						
					}else
					{
						tf.font = labelInfo.font;
					}
					tf.bold = labelInfo.bold;
					tf.leading = labelInfo.leading;
					tf.align = labelInfo.align;
					tf.color = labelInfo.color;
					tf.size = labelInfo.size;
					tf.underline = labelInfo.underLine;
					label.defaultTextFormat = tf;
					label.wordWrap = labelInfo.wrap;
					label.htmlText = content;
					label.setTextFormat(tf);
					break;
				case UIType.BORDOR:
				case UIType.BAR:
				case UIType.LINE:
				case UIType.PAGE_VIEW:
				case UIType.COMBO_BOX:
				case UIType.HOTSPOT:
				case UIType.MOVIECLIP:
				case UIType.SCROLL_PANEL:
				case UIType.POS:
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
					if(target.hasOwnProperty("label"))
					{
						target["label"] = content;
					}
					break;
				case UIType.CHECKBOX:
					CheckBox(target).label = content;
					target.width = info.width;
					break;
				case UIType.RADIO_BTN:
					RadioButton(target).label = content;
					RadioButton(target).setSize(info.width,info.height);
					break;
				case UIType.BITMAP:
				case UIType.BITMAP_BTN:
					target.width = info.width;
					target.height = info.height;
					if(target.hasOwnProperty("label"))
					{
						target["label"] = content;
					}
					break;
				case UIType.TILE:
					var tile:MTile = target as MTile;
					tile.graphics.clear();
					tile.graphics.beginFill(0x00ff00,0.1);
					tile.graphics.drawRect(0,0,info.width,info.height);
					tile.graphics.endFill();
					tile.setSize(info.width,info.height);
					tile.clearItems();
					
					addTileItem(tile,info as UIElementTileInfo);
					break;
			}
		}
	}
}