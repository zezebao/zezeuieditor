/**--------------------------2012-8-24-------------------------------**/
package utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mhqy.ui.backgroundUtil.BackgroundInfo;
	import mhqy.ui.backgroundUtil.BackgroundType;
	import mhqy.ui.backgroundUtil.BackgroundUtils;
	import mhqy.ui.button.MAssetButton;
	import mhqy.ui.button.MCheckBox;
	import mhqy.ui.container.MPanel3;
	import mhqy.ui.label.MAssetLabel;
	
	import mhsm.core.manager.LanguageManager;
	import mhsm.core.utils.AssetUtil;
	import mhsm.interfaces.moviewrapper.IMovieWrapper;
	
	import mx.utils.ObjectUtil;
	
	import uidata.UIClassType;
	import uidata.UIData;
	import uidata.UIElementBaseInfo;
	import uidata.UIElementBgInfo;
	import uidata.UIElementBtnInfo;
	import uidata.UIElementCheckBoxInfo;
	import uidata.UIElementMAssetLabelInfo;
	import uidata.UIElementPanelInfo;
	import uidata.UIElementViewInfo;
	import uidata.vo.UIClassVo;

	/**
	 *  UIUtils.as 
	 *  @author feilong
	 */
	public class UIUtils
	{
		public function UIUtils()
		{
		}
		
		/**
		 * 处理元素与数据的关系（不处理位置,放在包装容器UIElementItem处理显示）
		 * (UI编辑器用)
		 */		
		public static function handler(obj:DisplayObject,info:UIElementBaseInfo):void
		{
			if(!obj || !info)return;
			switch(info.type)
			{
				case UIClassType.CHECKBOX:
					checkBoxHandler(obj,info);
					break;
				case UIClassType.MASSETLABEL:
					massLabelHandler(obj,info);					
					break;
				case UIClassType.BTNS:
					btnsHandler(obj,info);	
					break;
				case UIClassType.MPANEL3:
					mpanelHandler(obj,info);
					break;
				case UIClassType.BG:
					bgHandler(obj,info);
					break;
				case UIClassType.MTEXTAREA:
					break;
				case UIClassType.MTILE:
					break;
				case UIClassType.PAGEVIEW:
					break;
				case UIClassType.PROGRESSBARS:
					break;
			}
		}
		
		//----------------------------------------------------------------------
		//---------------处理函数放在下面
		//----------------------------------------------------------------------
		
		//文本处理
		private static function massLabelHandler(obj:DisplayObject,info:UIElementBaseInfo):void
		{
			var mlabel:MAssetLabel = obj as MAssetLabel;
			var minfo:UIElementMAssetLabelInfo = info as UIElementMAssetLabelInfo;
			mlabel.defaultTextFormat = UIData.StyleListData[minfo.labelType][0];
			mlabel.filters = [UIData.StyleListData[minfo.labelType][1]];
			mlabel.width = minfo.width;
			mlabel.height = minfo.height;
			if(minfo.alignType != "none" && minfo.alignType != "")
			{
				mlabel.autoSize = minfo.alignType;
			}
			mlabel.wordWrap = minfo.wordWrap;
			
			if(minfo.isLanguage)
			{
				mlabel.setValue(LanguageManager.getWord(minfo.defaultText));
			}else
			{
				mlabel.setValue(minfo.defaultText);
			}
		}
		
		//背景处理
		private static function bgHandler(obj:DisplayObject,info:UIElementBaseInfo):void
		{
			var bginfo:UIElementBgInfo = info as UIElementBgInfo;
			if(bginfo.width != 0)
				obj.width = bginfo.width;
			else
				bginfo.width = obj.width;
			if(bginfo.height != 0)
				obj.height = bginfo.height;
			else
				bginfo.height = obj.height
			if(bginfo.bgType == 2)
			{
				Bitmap(obj).bitmapData = AssetUtil.getAsset(bginfo.bitmapdataClass) as BitmapData;
			}
		}
		
		//Mpanel3处理
		private static function mpanelHandler(obj:DisplayObject, info:UIElementBaseInfo):void
		{
			var minfo:UIElementPanelInfo = info as UIElementPanelInfo;
			var mpanel:MPanel3 = obj as MPanel3;
			mpanel.setSize(minfo.width,minfo.height);			
						
		}
		
		//按钮处理
		private static function btnsHandler(obj:DisplayObject, info:UIElementBaseInfo):void
		{
			var btnInfo:UIElementBtnInfo = info as UIElementBtnInfo;
			var btn:MAssetButton = obj as MAssetButton;
			btn.label = btnInfo.label;
		}
		
		//CheckBox处理
		private static function checkBoxHandler(obj:DisplayObject, info:UIElementBaseInfo):void
		{
			var checkBoxInfo:UIElementCheckBoxInfo = info as UIElementCheckBoxInfo;
			var checkBox:MCheckBox = obj as MCheckBox;
			if(checkBoxInfo.isLanguage)
			{
				checkBox.label = LanguageManager.getWord(checkBoxInfo.defaultText);
			}else
			{
				checkBox.label = checkBoxInfo.defaultText;
			}
		}
		
		//------------------------------------------------------------------------------------------------
		//----------------------------------------------------------------------------------
		//------------------------------------------------------------------------------------------------
		
		
		/**
		 *	根据Obj克隆元素
		 *  备注 UIElmentItem.onInfoChangeHandler里的按钮重新生成代码待提取
		 * (UI编辑器用)
		 * @param obj
		 * @param info
		 * @return 
		 */		
		public static function clone(obj:DisplayObject,info:UIElementBaseInfo):DisplayObject
		{
			var Cl:Class = getDefinitionByName(getQualifiedClassName(obj)) as Class;
			var returnObj:DisplayObject;
			
			
			switch(info.type)
			{
				case UIClassType.MASSETLABEL:
					returnObj = new MAssetLabel("",MAssetLabel.getStyle1(),UIElementMAssetLabelInfo(info).alignType);
					massLabelHandler(returnObj,info);
					break;
				case UIClassType.BTNS:
					//一个参数
					var binfo:UIElementBtnInfo = info as UIElementBtnInfo;
					if(binfo.btnType != -1 && binfo.btnType2 == -1)
					{
						returnObj = new Cl(binfo.btnType,binfo.label);
					}
					//2个参数
					else if(binfo.btnType != -1 && binfo.btnType2 != -1)
					{
						returnObj = new Cl(binfo.btnType,binfo.btnType2,binfo.label);
					}
					//MbitmapButton
					else if(binfo.sourceClass != "")
					{
						try
						{
							//域中未找到资源的情况
							var BD:Class = getDefinitionByName(binfo.sourceClass) as Class;
							returnObj = new Cl(new BD());
						}	 
						catch(error:Error) 
						{
							returnObj = new Cl(new BitmapData(binfo.width,binfo.height));
						} 
					}
					break;
				case UIClassType.CHECKBOX:
					returnObj = new Cl();
					break;
				case UIClassType.BG:
					returnObj = new Cl();
					if(obj is Bitmap)
					{
						Cl = getDefinitionByName(getQualifiedClassName(Bitmap(obj).bitmapData)) as Class;
						returnObj = new Bitmap(new Cl() as BitmapData);
					}
					break;
				case UIClassType.MTEXTAREA:
					break;
				case UIClassType.MTILE:
					break;
				case UIClassType.PAGEVIEW:
					break;
				case UIClassType.PROGRESSBARS:
					break;
			}
			return returnObj;
		}
		/**
		 * (UI编辑器用) 
		 * @param info
		 * @return 
		 * 
		 */		
		public static function cloneInfo(info:UIElementBaseInfo):UIElementBaseInfo
		{
			var Cl:Class = getDefinitionByName(getQualifiedClassName(info)) as Class;
			var rinfo:UIElementBaseInfo = new Cl();
			var arr:Array = ObjectUtil.getClassInfo(info).properties as Array;
			var len:int = arr.length;
			for (var i:int = 0; i < len; i++) 
			{
				if(rinfo.hasOwnProperty(arr[i]))
				{
					Object(rinfo)[arr[i].toString()] = Object(info)[arr[i].toString()]; 
				}
			}
			return rinfo;
		}
		/**
		 * (UI编辑器用) 
		 * @param info
		 * @return 
		 * 
		 */		
		public static function getObjByInfo(info:UIElementBaseInfo):DisplayObject
		{
			if(!info)return null;
			var obj:DisplayObject;
			var arr:Array = UIData.UIClassArr;
			var len:int = arr.length;
			for (var i:int = 0; i < len; i++) 
			{
				var vo:UIClassVo = arr[i] as UIClassVo;
				if(vo && vo.info && vo.obj)
				{
					var cn:String = getQualifiedClassName(vo.obj)
					if(vo.obj is Bitmap)
					{
						cn = getQualifiedClassName(Bitmap(vo.obj).bitmapData);
					}
					if(info.className == cn)
					{
						obj = UIUtils.clone(vo.obj,info);
						break;
					}
				}
			}
			return obj;
		}
		
		//事件收发
		public static var dispatcher:EventDispatcher = new EventDispatcher();
		
		//------------------------------------------------------
		//--------以下方法均为游戏逻辑部署界面用----------------
		//------------------------------------------------------
		/**
		 * 部署面板界面（面板基本元素及切卡按钮）
		 * 游戏逻辑用 
		 */		
		public static function deployPanel(parent:DisplayObjectContainer,panelInfo:UIElementPanelInfo):void
		{
			var bgArr:Array = [];
			var varArr:Array = [];
			var len:int = panelInfo.infos.length;
			for (var i:int = 0; i < len; i++) 
			{
				var obj:DisplayObject = UIUtils.getObjByInfo(panelInfo.infos[i]);
				if(obj && panelInfo.infos[i])
				{
					obj.x = panelInfo.infos[i].x;
					obj.y = panelInfo.infos[i].y;
					UIUtils.handler(obj,panelInfo.infos[i]);
					if(panelInfo.infos[i].variable != "")
					{
						varArr.push(obj);
						obj.name = panelInfo.infos[i].variable;
						if(parent.hasOwnProperty("objs"))
							parent["objs"][panelInfo.infos[i].variable] = obj;
					}else
					{
						bgArr.push(new BackgroundInfo(BackgroundType.DISPLAY,new Rectangle(panelInfo.infos[i].x,panelInfo.infos[i].y),obj));
					}
				}
			}
			Object(parent).setToBackgroup(bgArr);
			len = varArr.length;
			for (var j:int = 0; j < len; j++) 
			{
				Object(parent).addContent(varArr[j] as DisplayObject);
			}
		}
		/**
		 * 部署面板界面（切卡视图）
		 * 游戏逻辑用 
		 */	
		public static function deployTabView(parent:DisplayObjectContainer,viewInfo:UIElementViewInfo):void
		{
			var bgArr:Array = [];
			var varArr:Array = [];
			var len:int = viewInfo.infos.length;
			for (var i:int = 0; i < len; i++) 
			{
				var obj:DisplayObject = UIUtils.getObjByInfo(viewInfo.infos[i]);
				if(obj && viewInfo.infos[i])
				{
					obj.x = viewInfo.infos[i].x;
					obj.y = viewInfo.infos[i].y;
					UIUtils.handler(obj,viewInfo.infos[i]);
					if(viewInfo.infos[i].variable != "")
					{
						varArr.push(obj);
						obj.name = viewInfo.infos[i].variable;
						if(parent.hasOwnProperty("objs"))
							parent["objs"][viewInfo.infos[i].variable] = obj;
					}else
					{
						bgArr.push(new BackgroundInfo(BackgroundType.DISPLAY,new Rectangle(viewInfo.infos[i].x,viewInfo.infos[i].y),obj));
					}
				}
			}
			if(bgArr.length > 0)
			{
				var bg:IMovieWrapper = BackgroundUtils.setBackground(bgArr);
				parent.addChild(bg as DisplayObject);
			}
			len = varArr.length;
			for (var j:int = 0; j < len; j++)
			{
				parent.addChild(varArr[j] as DisplayObject);
			}
		}
	}
	
}