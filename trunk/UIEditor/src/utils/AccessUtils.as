/**--------------------------2012-9-17-------------------------------**/
package utils
{
	import flash.display.DisplayObject;
	import flash.utils.ByteArray;
	
	import uidata.UIClassType;
	import uidata.UIData;
	import uidata.UIElementBaseInfo;
	import uidata.UIElementBgInfo;
	import uidata.UIElementBtnInfo;
	import uidata.UIElementCheckBoxInfo;
	import uidata.UIElementMAssetLabelInfo;
	import uidata.UIElementMTextAreaInfo;
	import uidata.UIElementMTileInfo;
	import uidata.UIElementModuleInfoII;
	import uidata.UIElementPageViewInfo;
	import uidata.UIElementPanelInfo;
	import uidata.UIElementViewInfo;
	import uidata.vo.UIClassVo;

	/**
	 *  AccessUtils.as 
	 *  @author feilong
	 *  数据 [存取/解析]  工具类
	 */
	public class AccessUtils
	{
		public function AccessUtils()
		{
		}
		/**
		 * 存储目的:[modelInfo,[PANEL1,PANEL2,PANEL3...],[TABVIEW1,TABVIEW2,TABVIEW3...]];
		 *  
		 * @param modelInfo
		 * @return 
		 * 
		 */		
		public static function save(modelInfo:UIElementModuleInfoII):ByteArray
		{
			var byte:ByteArray = new ByteArray();
			var len1:int = modelInfo.panels.length;
			var len2:int = modelInfo.tabviews.length;
			modelInfo.writeData(byte);			
			byte.writeByte(len1);
			for (var i:int = 0; i < len1; i++) 
			{
				modelInfo.panels[i].writeData(byte);
				//////////////////////////////////////////////
				//---这段代码解析的位置，后期优化(是否放在PanelInfo里面解析?)
				var len:int = modelInfo.panels[i].infos.length;
				for (var k:int = 0; k < len; k++) 
				{
					byte.writeByte(modelInfo.panels[i].infos[k].type);
					byte.writeUTF(modelInfo.panels[i].infos[k].className);
					modelInfo.panels[i].infos[k].writeData(byte);
				}
				//结束标志位
				byte.writeByte(UIClassType.END_SIGN);
				//////////////////////////////////////////////
			}
			byte.writeByte(len2);
			for (var j:int = 0; j < len2; j++) 
			{
				modelInfo.tabviews[j].writeData(byte);
			}
			//完成后解压缩、保存
			byte.compress();
			return byte;
		}
		/**
		 * 解析一个模块 
		 * @param byte
		 * 1.模块信息
		 * 2.面板信息列表
		 * 3.切卡信息列表
		 */		
		public static function open(byte:ByteArray,modelInfo:UIElementModuleInfoII):void
		{
			byte.uncompress();
			byte.position = 0;
			modelInfo.parseData(byte);
			var len1:int = byte.readByte();
			for (var i:int = 0; i < len1; i++) 
			{
				var pinfo:UIElementPanelInfo = new UIElementPanelInfo();
				pinfo.parseData(byte);
				prasePanel(byte,pinfo);
				modelInfo.panels.push(pinfo);
			}
			var len2:int = byte.readByte();
			for (var j:int = 0; j < len2; j++) 
			{
				var vinfo:UIElementViewInfo = new UIElementViewInfo();
				vinfo.parseData(byte);
				modelInfo.tabviews.push(vinfo);
			}
		}
		
		//解析Panel
		public static function prasePanel(byte:ByteArray,pinfo:UIElementPanelInfo):void
		{
			var type:int;
			var className:String;
			var info:UIElementBaseInfo;
			//解析panel内的info
			while(byte.bytesAvailable)
			{
				type = byte.readByte();
				if(type == UIClassType.END_SIGN)return;//结束标志位
				className = byte.readUTF();
				info = null;
				info = praseInfo(byte,type);
				if(type == UIClassType.MPANEL3)
				{
					pinfo = info as UIElementPanelInfo;
				}else
				{
					info.className = className;
					pinfo.infos.push(info);
				}
			}
		}
		
		/**
		 * 解析数据并返回UIElementBaseInfo实例，注意：UIElementPanelInfo为每个Panel的第一个info实例，应在外部特殊处理（因为这个info的infos成员变量将对之后的所有info进行push操作）
		 * @param byte
		 * @param type
		 * @return 
		 * 
		 */		
		public static function praseInfo(byte:ByteArray,type:int):UIElementBaseInfo
		{
			var info:UIElementBaseInfo;
			switch(type)
			{
				case UIClassType.MPANEL3:
					info = new UIElementPanelInfo();
					info.parseData(byte);
					break;
				case UIClassType.BG:
					info = new UIElementBgInfo();
					info.parseData(byte);
					break;
				case UIClassType.BTNS:
					info = new UIElementBtnInfo();
					info.parseData(byte);
					break;
				case UIClassType.CHECKBOX:
					info = new UIElementCheckBoxInfo();
					info.parseData(byte);
					break;
				case UIClassType.MASSETLABEL:
					info = new UIElementMAssetLabelInfo();
					info.parseData(byte);
					break;
				case UIClassType.MTEXTAREA:
					info = new UIElementMTextAreaInfo();
					info.parseData(byte);
					break;
				case UIClassType.MTILE:
					info = new UIElementMTileInfo();
					info.parseData(byte);
					break;
				case UIClassType.PAGEVIEW:
					info = new UIElementPageViewInfo();
					info.parseData(byte);
					break;
				case UIClassType.PROGRESSBARS:
					break;
			}
			return info;
		}
		
	}
}