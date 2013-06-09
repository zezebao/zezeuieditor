package lt.ui.util
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
//	import lt.ui.buttons.UICheckBoxButton;
//	import lt.ui.buttons.UIRadioButton;
//	import lt.ui.container.UILabel;
//	import lt.ui.core.UIType;
//	import lt.ui.defaults.UIDefaultButton;
//	import lt.ui.defaults.UIDefaultSelectButton;
//	import lt.ui.horizontalLine_asset;
//	import lt.ui.panel_bg_asset;
//	import lt.ui.ui_bar1_asset;
//	import lt.ui.ui_bar2_asset;
//	import lt.ui.ui_bar3_asset;
//	import lt.ui.ui_bar4_asset;
//	import lt.ui.ui_bar5_asset;
//	import lt.ui.ui_bar6_asset;
//	import lt.ui.ui_bar7_asset;
//	import lt.ui.ui_bar8_asset;
//	import lt.ui.ui_bar9_asset;
//	import lt.ui.ui_border1_asset;
//	import lt.ui.ui_border2_asset;
//	import lt.ui.ui_border3_asset;
//	import lt.ui.ui_border4_asset;
//	import lt.ui.ui_border5_asset;
//	import lt.ui.ui_btn3_asset;
//	import lt.ui.verticalLine_assset;

	public class UIElementCreator
	{
//		public static function createItem(type:int,width:int,height:int,param1:int = 0,param2:int = 0,param:Object = null):DisplayObject
//		{
//			var item:DisplayObject;
//			switch(type)
//			{
//				case UIType.UIDEFAULTBORDER:
//					item = getDefaultBorder(param1,width,height);
//					(item as MovieClip).mouseChildren = (item as MovieClip).mouseEnabled = false;
//					break;
//				case UIType.UIDEFAULTBAR:
//					item = getDefaultBar(param1,width,height);
//					(item as MovieClip).mouseChildren = (item as MovieClip).mouseEnabled = false;
//					break;
//				case UIType.UICHECKBOX:
//					if(!param)
//					{
//						param = "";
//					}
//					item = new UICheckBoxButton(param as String);
//					break;
//				case UIType.UIRADIO:
//					if(!param)
//					{
//						param = "";
//					}
//					item = new UIRadioButton(param as String);
//					break;
//				case UIType.UIDEFAULTBUTTON:
//					item = new UIDefaultButton(param1,param2);
//					break;
//				case UIType.UIDEFAULTSELECTBUTTON:
//					item = new UIDefaultSelectButton(param1,param2);
//					break;
//				case UIType.UIDEFAULTVELINE:
//					item = new verticalLine_assset();
//					item.height = height;
//					(item as MovieClip).mouseChildren = (item as MovieClip).mouseEnabled = false;
//					break;
//				case UIType.UIDEFAULTHOLINE:
//					item = new horizontalLine_asset();
//					item.width = width;
//					(item as MovieClip).mouseChildren = (item as MovieClip).mouseEnabled = false;
//					break;
//				case UIType.UIPAENLBG:
//					item = getDefaultBorder(0,width,height);
//					(item as MovieClip).mouseChildren = (item as MovieClip).mouseEnabled = false;
//					break;
//				case UIType.UILABEL:
//					if(!param)
//					{
//						param = "";
//					}
//					item = LabelCreator.createLabel(String(param),LabelCreator.TFList[param1],false,width,height,int(param2));
//					break;
//				case UIType.UIBITMAP:
//					var cla:Class = param as Class;
//					item = new Bitmap(new cla());
//					if(param1 == 1)
//					{
//						item.width = width;
//						item.height = height;
//					}
//					break;
//			}
//			return item;
//		}
//		
//		private static function getDefaultBorder(type:int,width:int,height:int):MovieClip
//		{
//			var cla:Class;
//			switch(type)
//			{
//				case 0:
//					cla = panel_bg_asset;
//					break;
//				case 1:
//					cla = ui_border1_asset;
//					break;
//				case 2:
//					cla = ui_border2_asset;
//					break;
//				case 3:
//					cla = ui_border3_asset;
//					break;
//				case 4:
//					cla = ui_border4_asset;
//					break;
//				case 5:
//					cla = ui_border5_asset;
//					break;
//			}
//			var border:MovieClip = new cla() as MovieClip;
//			border.width = width;
//			border.height = height;
//			return border;
//		}
//		private static function getDefaultBar(type:int,width:int,height:int):MovieClip
//		{
//			var cla:Class;
//			switch(type)
//			{
//				case 1:
//					cla = ui_bar1_asset;
//					break;
//				case 2:
//					cla = ui_bar2_asset;
//					break;
//				case 3:
//					cla = ui_bar3_asset;
//					break;
//				case 4:
//					cla = ui_bar4_asset;
//					break;
//				case 5:
//					cla = ui_bar5_asset;
//					break;
//				case 6:
//					cla = ui_bar6_asset;
//					break;
//				case 7:
//					cla = ui_bar7_asset;
//					break;
//				case 8:
//					cla = ui_bar8_asset;
//					break;
//				case 9:
//					cla = ui_bar9_asset;
//					break;
//			}
//			var bar:MovieClip = new cla() as MovieClip;
//			bar.width = width;
//			bar.height = height;
//			return bar;
//		}
		
	}
}
