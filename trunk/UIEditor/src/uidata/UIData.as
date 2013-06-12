package uidata
{
	import mhqy.ui.mcache.btns.MCacheAsset1Btn;
	import mhqy.ui.mcache.btns.MCacheAsset3Btn;
	import mhqy.ui.mcache.btns.MCacheAsset4Btn;
	import mhqy.ui.mcache.btns.MCacheAsset5Btn;
	
	import mhsm.ui.BarAsset8;
	import mhsm.ui.BorderAsset2;
	
	import uidata.vo.UIClassVo;
	
	public class UIData
	{
		public static var defaultBarInfo:UIElementBaseInfo;
		public static var defaultBorderInfo:UIElementBaseInfo;
		public static var defaultBtnInfo:UIElementBaseInfo;
		
		
		public static function setup():void
		{
			defaultBarInfo = new UIElementBaseInfo();
			
		}
		
		/**
		 * 对齐方式 
		 */		
		public static var alignTypeList:Array = [
			"none",
			"left",
			"center",
			"right"
		];
		/**
		 * 按钮类型1 
		 */		
		public static var btnTypeList1:Array = [
			0,1,2,3,4,5,6,7,8,9
		];
		/**
		 * 按钮类型2 
		 */		
		public static var btnTypeList2:Array = [
			0,1,2,3,4,5,6,7,8,9
		];
		
		//-------面板元素INFO数据----------------------------------
		/**
		 * 面板元素-对应info初始化数据 
		 */		
		public static var UIClassArr:Array = [
//			new UIClassVo(MAssetLabel,new UIElementBaseInfo(),"示例",MAssetLabel.getStyle1(),"left"),
//			new UIClassVo(MCacheAsset1Btn,new UIElementBaseInfo(),0,"示例"),
//			new UIClassVo(MCacheAsset3Btn,new UIElementBaseInfo(),0,"示例"),
//			new UIClassVo(MCacheAsset4Btn,new UIElementBaseInfo(),0,"示例"),
//			new UIClassVo(MCacheAsset5Btn,new UIElementBaseInfo(),0,"示例"),
//			
//			new UIClassVo(MCacheTab1Btn,new UIElementBaseInfo(),0,1,"示例"),
//			
//			new UIClassVo(MCheckBox,new UIElementBaseInfo(),"CheckBox示例"),
//			
//			new UIClassVo(BorderAsset1,new UIElementBaseInfo()),
//			new UIClassVo(BorderAsset2,new UIElementBaseInfo()),
//			new UIClassVo(BorderAsset5,new UIElementBaseInfo()),
//			new UIClassVo(BorderAsset6,new UIElementBaseInfo()),
//			new UIClassVo(BorderAsset8,new UIElementBaseInfo()),
//			new UIClassVo(BorderAsset9,new UIElementBaseInfo()),
//			new UIClassVo(BarAsset1,new UIElementBaseInfo()),
//			new UIClassVo(BarAsset3,new UIElementBaseInfo()),
//			new UIClassVo(BarAsset6,new UIElementBaseInfo()),
			new UIClassVo(BarAsset8,new UIElementBarInfo()),
			new UIClassVo(BorderAsset2,new UIElementBorderInfo()),
//			new UIClassVo(BtnAsset7,new UIElementBaseInfo()),
		];
		
		public static var btnDatas:Array = [
			[1,MCacheAsset1Btn],
			[3,MCacheAsset3Btn],
			[4,MCacheAsset4Btn],
			[5,MCacheAsset5Btn],
		];
	}
}