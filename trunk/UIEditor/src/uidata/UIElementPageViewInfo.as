package uidata
{
	import data.PropertyType;
	
	import flash.utils.IDataOutput;
	
	import mhqy.ui.UIType;
	
	import uidata.vo.PropertyVo;

	public class UIElementPageViewInfo extends UIElementBaseInfo
	{
		public var argShowOtherBtn:Boolean;
		
		public function UIElementPageViewInfo(width:int=70)
		{
			this.width = width;
			type = UIType.PAGE_VIEW;
		}
		
		override public function writeData(source:IDataOutput):void
		{
			super.writeData(source);
			source.writeByte(0);
			source.writeBoolean(argShowOtherBtn);
		}
		
		override public function clone():*
		{
			var info:UIElementPageViewInfo = super.clone() as UIElementPageViewInfo;
			info.argShowOtherBtn = argShowOtherBtn;
			return info;
		}
		
		override public function getPropertys():Vector.<PropertyVo>
		{
			var vec:Vector.<PropertyVo> = new Vector.<PropertyVo>();
			vec.push(new PropertyVo("argShowOtherBtn","是否显示左右翻到底的按钮",PropertyType.DATAPROVIDER,this.argShowOtherBtn,[true,false],true,true));
			return vec.concat(super.getPropertys());
		}
		
		override public function readXML(xml:XML):void
		{
			super.readXML(xml);
			argShowOtherBtn = xml.@argShowOtherBtn == "true";
		}
		
		override public function toString():String
		{
			var arr:Array = [
				["argShowOtherBtn",argShowOtherBtn]
			];
			return creatContent(arr) + super.toString();
		}
	}
}