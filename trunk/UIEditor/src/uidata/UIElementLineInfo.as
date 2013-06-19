package uidata
{
	import data.PropertyType;
	
	import flash.utils.IDataOutput;
	
	import mhqy.ui.UIType;
	
	import uidata.vo.PropertyVo;

	public class UIElementLineInfo extends UIElementBaseInfo
	{
		public var lineType:int;
		
		public function UIElementLineInfo(lineType:int,width:int,height:int)
		{
			this.lineType = lineType;
			this.width = width;
			this.height = height;
			canScale = true;
			type = UIType.LINE;
		}
		
		override public function clone():*
		{
			var info:UIElementLineInfo = super.clone() as UIElementLineInfo;
			info.lineType = lineType;
			return info;
		}
		
		override public function getPropertys():Vector.<PropertyVo>
		{
			var vec:Vector.<PropertyVo> = new Vector.<PropertyVo>();
			vec.push(new PropertyVo("lineType","线类型",PropertyType.DATAPROVIDER,this.lineType,[0,1,2,3,4]));
			return vec.concat(super.getPropertys());
		}
		
		override public function readXML(xml:XML):void
		{
			super.readXML(xml);
			lineType = xml.@lineType;
		}
		
		override public function toString():String
		{
			var arr:Array = [
				["lineType",lineType]
			];
			return creatContent(arr) + super.toString();
		}
		
		override public function writeData(source:IDataOutput):void
		{
			super.writeData(source);
			source.writeByte(lineType);
		}
	}
}