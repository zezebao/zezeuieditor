package uidata
{
	import data.PropertyType;
	
	import flash.utils.IDataOutput;
	
	import mhqy.ui.UIType;
	
	import uidata.vo.PropertyVo;

	public class UIElementCheckBoxInfo extends UIElementBaseInfo
	{
		public var label:String;
		
		public function UIElementCheckBoxInfo(label:String="")
		{
			this.label = label;
			type = UIType.CHECKBOX;
		}
		
		override public function clone(source:*):*
		{
			if(!(source is UIElementCheckBoxInfo))
			{
				throw new Error("clone error");
			}
			var info:UIElementCheckBoxInfo = source as UIElementCheckBoxInfo;
			info.label = label;
			super.clone(source);
			return info;
		}
		
		override public function getPropertys():Vector.<PropertyVo>
		{
			var vec:Vector.<PropertyVo> = new Vector.<PropertyVo>();
			vec.push(new PropertyVo("label","文本",PropertyType.STRING,this.label,null,true,true));
			return vec.concat(super.getPropertys());
		}
		
		override public function readXML(xml:XML):void
		{
			super.readXML(xml);
			label = xml.@label;
		}
		
		override public function toString():String
		{
			var arr:Array = [
				["label",label]
			];
			return creatContent(arr) + super.toString();
		}
		
		override public function writeData(source:IDataOutput):void
		{
			super.writeData(source);
			source.writeByte(0);
			source.writeUTF(label);
		}
	}
}