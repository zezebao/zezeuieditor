/**--------------------------2012-9-5-------------------------------**/
package uidata.vo
{
	import avmplus.getQualifiedClassName;
	
	import flash.display.DisplayObject;
	
	import mhqy.ui.UIType;
	
	import uidata.UIElementBaseInfo;

	/**
	 *  UIClassVo.as 
	 *  @author feilong
	 */
	public class UIClassVo
	{
		public var describe:String;
		public var className:String;
		public var info:UIElementBaseInfo;
		public var parms:Array;
		/**
		 * @param className
		 * @param info
		 * @param parms  构造函数需要的默认参数
		 */		
		public function UIClassVo(describe:String,info:UIElementBaseInfo,...parms)
		{
			this.describe = describe;
			this.parms = parms;
			this.info = info;
		}
	}
}