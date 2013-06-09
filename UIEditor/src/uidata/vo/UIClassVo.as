/**--------------------------2012-9-5-------------------------------**/
package uidata.vo
{
	import avmplus.getQualifiedClassName;
	
	import flash.display.DisplayObject;
	
	import uidata.UIElementBaseInfo;

	/**
	 *  UIClassVo.as 
	 *  @author feilong
	 */
	public class UIClassVo
	{
		public var className:String;
		public var info:UIElementBaseInfo;
		public var parms:Array;
		/**
		 * @param className
		 * @param info
		 * @param parms  构造函数需要的默认参数
		 */		
		public function UIClassVo(className:*,info:UIElementBaseInfo,...parms)
		{
			this.parms = parms;
			if(className is String)
			{
				this.className = className;
			}else if(className is Class || className is DisplayObject)
			{
				this.className = getQualifiedClassName(className);
			}
			this.info = info;
		}
	}
}