package uidata
{
	import data.PropertyType;
	
	import flash.utils.IDataOutput;
	
	import mhqy.ui.UIType;
	
	import uidata.vo.PropertyVo;

	public class UIElementRadioButtonInfo extends UIElementBaseInfo
	{
		public var groupName:String;
		public var label:String;
		
		public function UIElementRadioButtonInfo(groupName:String="groupName",label:String="")
		{
			this.groupName = groupName;
			this.label = label;
			type = UIType.RADIO_BTN;
			width = 200;
			height = 30;
//			canScale = true;
		}
		
		override public function clone(source:*):*
		{
			if(!(source is UIElementRadioButtonInfo))
			{
				throw new Error("clone error");
			}
			var info:UIElementRadioButtonInfo = source as UIElementRadioButtonInfo;
			info.label = label;
			info.groupName = groupName;
			super.clone(source);
			return info;
		}
		
		override public function getPropertys():Vector.<PropertyVo>
		{
			var vec:Vector.<PropertyVo> = new Vector.<PropertyVo>();
			vec.push(new PropertyVo("groupName","组名字",PropertyType.STRING,this.groupName));
			vec.push(new PropertyVo("label","文本",PropertyType.STRING,this.label));
			return vec.concat(super.getPropertys());
		}
		
		override public function readXML(xml:XML):void
		{
			super.readXML(xml);
			label = xml.@label;
			groupName = xml.@groupName;
		}
		
		override public function toString():String
		{
			var arr:Array = [
				["groupName",groupName],
				["label",label],
			];
			return creatContent(arr) + super.toString();
		}
		
		override public function writeData(source:IDataOutput):void
		{
			super.writeData(source);
			source.writeByte(0);
			source.writeUTF(groupName);
			source.writeUTF(label);
		}
	}
}