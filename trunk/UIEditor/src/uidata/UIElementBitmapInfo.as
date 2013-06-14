package uidata
{
	import data.PropertyType;
	
	import flash.utils.IDataOutput;
	
	import mhqy.ui.UIType;
	
	import uidata.vo.PropertyVo;

	public class UIElementBitmapInfo extends UIElementBaseInfo
	{
		//具体类映射
		public var className:String;
		public var isBitmapButton:Boolean;
		public var label:String="";
		
		public function UIElementBitmapInfo(className:String="")
		{
			this.className = className;
			type = UIType.BITMAP;
		}
		
		override public function get type():int
		{
			if(isBitmapButton)return UIType.BITMAP_BTN;
			return _type;
		}
		
		override public function readXML(xml:XML):void
		{
			super.readXML(xml);
			className = xml.@className;
			isBitmapButton = xml.@isBitmapButton == "true";
			label = xml.@label;
		}
		
		override public function writeData(source:IDataOutput):void
		{
			super.writeData(source);
			source.writeByte(0);
			source.writeUTF(className);
			if(isBitmapButton)
			{
				source.writeUTF(label);
			}
		}
		
		override public function getPropertys():Vector.<PropertyVo>
		{
			var vec:Vector.<PropertyVo> = new Vector.<PropertyVo>();
			vec.push(new PropertyVo("isBitmapButton","是否是按钮",PropertyType.DATAPROVIDER,this.isBitmapButton,[true,false],true,true));
			vec.push(new PropertyVo("className","反射类名",PropertyType.STRING,this.className,null,true,true));
			vec.push(new PropertyVo("label","如果是BITMAP_BUTTON，则设置此参数",PropertyType.STRING,this.label));
			return vec.concat(super.getPropertys());
		}
		
		override public function clone(source:*):*
		{
			if(!(source is UIElementBitmapInfo))
			{
				throw new Error("clone error");
			}
			var info:UIElementBitmapInfo = source as UIElementBitmapInfo;
			info.className = className;
			super.clone(source);
			return info;
		}
		
		override public function toString():String
		{
			var arr:Array = [
				["className",className],
				["isBitmapButton",isBitmapButton],
				["label",label]
			];
			return creatContent(arr) + super.toString();
		}
	}
}