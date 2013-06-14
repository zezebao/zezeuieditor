package uidata
{
	import data.PropertyType;
	
	import flash.utils.ByteArray;
	import flash.utils.IDataOutput;
	
	import mhqy.ui.UIType;
	
	import uidata.vo.PropertyVo;

	public class UIElementBarInfo extends UIElementBaseInfo
	{
		public var barType:int;
		
		public function UIElementBarInfo(barType:int=1)
		{
			this.barType = barType;
			
			type = UIType.BAR;
			canScale = true;
			width = 100;
			height = 20;
		}
		
		override public function clone(source:*):*
		{
			if(!(source is UIElementBarInfo))
			{
				throw new Error("clone error");
			}
			var info:UIElementBarInfo = source as UIElementBarInfo;
			info.barType = barType;
			super.clone(source);
			return info;
		}
		
		override public function readXML(xml:XML):void
		{
			super.readXML(xml);
			barType = xml.@barType;
		}
		
		override public function writeData(source:IDataOutput):void
		{
			super.writeData(source);
			source.writeByte(barType);
		}
		
		override public function getPropertys():Vector.<PropertyVo>
		{
			var vec:Vector.<PropertyVo> = new Vector.<PropertyVo>();
			vec.push(new PropertyVo("barType","bar类型",PropertyType.DATAPROVIDER,this.barType,[1,2,3,4,5],true,true));
			return vec.concat(super.getPropertys());
		}
		
		override public function toString():String
		{
			var arr:Array = [
				["barType",barType]
			];
			return creatContent(arr) + super.toString();
		}
	}
}