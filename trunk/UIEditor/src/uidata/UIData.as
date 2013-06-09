package uidata
{
	import fl.controls.ComboBox;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import mhqy.ui.ProgressBarGreen;
	import mhqy.ui.button.MAssetButton;
	import mhqy.ui.button.MBitmapButton;
	import mhqy.ui.button.MCheckBox;
	import mhqy.ui.button.MTabButton;
	import mhqy.ui.label.MAssetLabel;
	import mhqy.ui.mcache.btns.MCacheAsset1Btn;
	import mhqy.ui.mcache.btns.MCacheAsset3Btn;
	import mhqy.ui.mcache.btns.MCacheAsset4Btn;
	import mhqy.ui.mcache.btns.MCacheAsset5Btn;
	import mhqy.ui.mcache.btns.MCacheAsset6Btn;
	import mhqy.ui.mcache.btns.MCacheAsset7Btn;
	import mhqy.ui.mcache.btns.selectBtns.MCacheSelectBtn;
	import mhqy.ui.mcache.btns.tabBtns.MCacheTab1Btn;
	import mhqy.ui.mcache.splits.MCacheSplit1Line;
	import mhqy.ui.mcache.splits.MCacheSplit2Line;
	import mhqy.ui.mcache.splits.MCacheSplit3Line;
	import mhqy.ui.mcache.splits.MCacheSplit4Line;
	import mhqy.ui.progress.ProgressBar;
	
	import mhsm.ui.BarAsset1;
	import mhsm.ui.BarAsset3;
	import mhsm.ui.BarAsset6;
	import mhsm.ui.BarAsset8;
	import mhsm.ui.BorderAsset1;
	import mhsm.ui.BorderAsset2;
	import mhsm.ui.BorderAsset5;
	import mhsm.ui.BorderAsset6;
	import mhsm.ui.BorderAsset8;
	import mhsm.ui.BorderAsset9;
	import mhsm.ui.BtnAsset7;
	import mhsm.ui.CellBgAsset1;
	import mhsm.ui.CellBgAsset2;
	import mhsm.ui.CellBgAsset3;
	import mhsm.ui.CellBgAsset4;
	import mhsm.ui.CellBgAsset5;
	
	import uidata.vo.UIClassVo;
	
	public class UIData
	{
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
			new UIClassVo(MAssetLabel,new UIElementBaseInfo(),"示例",MAssetLabel.getStyle1(),"left"),
			new UIClassVo(MCacheAsset1Btn,new UIElementBaseInfo(),0,"示例"),
			new UIClassVo(MCacheAsset3Btn,new UIElementBaseInfo(),0,"示例"),
			new UIClassVo(MCacheAsset4Btn,new UIElementBaseInfo(),0,"示例"),
			new UIClassVo(MCacheAsset5Btn,new UIElementBaseInfo(),0,"示例"),
			
			new UIClassVo(MCacheTab1Btn,new UIElementBaseInfo(),0,1,"示例"),
			
			new UIClassVo(MCheckBox,new UIElementBaseInfo(),"CheckBox示例"),
			
			new UIClassVo(BorderAsset1,new UIElementBaseInfo()),
			new UIClassVo(BorderAsset2,new UIElementBaseInfo()),
			new UIClassVo(BorderAsset5,new UIElementBaseInfo()),
			new UIClassVo(BorderAsset6,new UIElementBaseInfo()),
			new UIClassVo(BorderAsset8,new UIElementBaseInfo()),
			new UIClassVo(BorderAsset9,new UIElementBaseInfo()),
			new UIClassVo(BarAsset1,new UIElementBaseInfo()),
			new UIClassVo(BarAsset3,new UIElementBaseInfo()),
			new UIClassVo(BarAsset6,new UIElementBaseInfo()),
			new UIClassVo(BarAsset8,new UIElementBaseInfo()),
			new UIClassVo(BtnAsset7,new UIElementBaseInfo()),
			new UIClassVo(CellBgAsset1,new UIElementBaseInfo()),
			new UIClassVo(CellBgAsset2,new UIElementBaseInfo()),
			new UIClassVo(CellBgAsset3,new UIElementBaseInfo()),
			new UIClassVo(CellBgAsset4,new UIElementBaseInfo()),
			new UIClassVo(CellBgAsset5,new UIElementBaseInfo()),
		];
	}
}