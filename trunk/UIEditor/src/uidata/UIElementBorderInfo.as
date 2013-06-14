package uidata
{
	import data.PropertyType;
	
	import flash.utils.ByteArray;
	import flash.utils.IDataOutput;
	
	import mhqy.ui.UIType;
	
	import uidata.vo.PropertyVo;

	public class UIElementBorderInfo extends UIElementBaseInfo
	{
		public var borderType:int;
		
		public function UIElementBorderInfo(borderType:int=1)
		{
			type = UIType.BORDOR;
			
			this.borderType = borderType;
			canScale = true;
			width = 100;
			height = 50;
		}
		
		override public function readXML(xml:XML):void
		{
			super.readXML(xml);
			borderType = xml.@borderType;
		}
		
		override public function writeData(source:IDataOutput):void
		{
			super.writeData(source);
			source.writeByte(borderType);
		}
		
		override public function getPropertys():Vector.<PropertyVo>
		{
			var vec:Vector.<PropertyVo> = new Vector.<PropertyVo>();
			vec.push(new PropertyVo("borderType","border类型",PropertyType.DATAPROVIDER,this.borderType,[1,2,3,4,5,6,7],true,true));
			return vec.concat(super.getPropertys());
		}
		
		override public function clone(source:*):*
		{
			if(!(source is UIElementBorderInfo))
			{
				throw new Error("clone error");
			}
			var info:UIElementBorderInfo = source as UIElementBorderInfo;
			info.borderType = borderType;
			super.clone(source);
			return info;
		}
		
		override public function toString():String
		{
			var arr:Array = [
				["borderType",borderType],
			];
			return creatContent(arr) + super.toString();
		}
	}
}