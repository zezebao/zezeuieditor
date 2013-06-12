package test111111111111111
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.utils.getDefinitionByName;
	
	import mhsm.ui.BarAsset1;
	import mhsm.ui.BarAsset3;
	import mhsm.ui.BarAsset6;
	import mhsm.ui.BarAsset7;
	import mhsm.ui.BarAsset8;
	import mhsm.ui.BorderAsset1;
	import mhsm.ui.BorderAsset2;
	import mhsm.ui.BorderAsset4;
	import mhsm.ui.BorderAsset5;
	import mhsm.ui.BorderAsset6;
	import mhsm.ui.BorderAsset7;
	import mhsm.ui.BorderAsset8;
	import mhsm.ui.BorderAsset9;
	
	import uidata.UIClassType;
	import uidata.UIData;
	import uidata.UIElementBarInfo;
	import uidata.UIElementBaseInfo;
	import uidata.UIElementBorderInfo;

	public class UIElementCreatorTest
	{
		public function UIElementCreatorTest()
		{
		}
		
		public static function createItem(info:UIElementBaseInfo):DisplayObject
		{
			var item:DisplayObject;
			switch(info.type)
			{
				case UIClassType.UIBITMAP:
					var cla:Class = getDefinitionByName(info.className) as Class;
					item = new Bitmap(new cla());
					break;
				case UIClassType.UIDEFAULTBAR:
					item = getBarByType(UIElementBarInfo(info).barType);
					item.width = info.width;
					item.height = info.height;
					break;
				case UIClassType.UIDEFAULTBORDER:
					item = getBorderByType(UIElementBorderInfo(info).borderType);
					item.width = info.width;
					item.height = info.height;
					break;
				case UIClassType.UIDEFAULTBUTTON:
					break;
				case UIClassType.UILABEL:
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
				case 4:return new BorderAsset4();
				case 5:return new BorderAsset5();
				case 6:return new BorderAsset6();
				case 7:return new BorderAsset7();
				case 8:return new BorderAsset8();
				case 9:return new BorderAsset9();
			}
			return new BorderAsset2();
		}
		
		private static function getBarByType(type:int):DisplayObject
		{
			switch(type)
			{
				case 1:return new BarAsset1();
				case 3:return new BarAsset3();
				case 6:return new BarAsset6();
				case 8:return new BarAsset8();
			}
			return new BarAsset3();
		}
		
//		public static function createItem(type:int,width:int,height:int,param1:int = 0,param2:int = 0,param:Object = null):DisplayObject
//		{
//			var item:DisplayObject;
//			switch(type)
//			{
//				case UIClassType.UIBITMAP:
//					var cla:Class = param as Class;
//					item = new Bitmap(new cla());
//					if(param1 == 1)
//					{
//						item.width = width;
//						item.height = height;
//					}
//					break;
//				case UIClassType.UIDEFAULTBAR:
//					break;
//				case UIClassType.UIDEFAULTBORDER:
//					break;
//				case UIClassType.UIDEFAULTBUTTON:
//					break;
//				case UIClassType.UILABEL:
//					break;
//			}
//			return item;
//		}
	}
}