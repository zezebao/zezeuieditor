package uidata
{
	import data.PropertyType;
	
	import flash.utils.IDataOutput;
	
	import mhqy.ui.UIType;
	
	import mhsm.core.manager.LanguageManager;
	
	import uidata.vo.PropertyVo;

	public class UIElementButtonInfo extends UIElementBaseInfo
	{
		public var btnType:int;
		public var scaleType:int;
		public var label:String;
		
		public function UIElementButtonInfo(btnType:int,scaleType:int,label:String)
		{
			type = UIType.BUTTON;
			
			this.btnType = btnType;
			this.scaleType = scaleType;
			this.label = label;
		}

		override public function readXML(xml:XML):void
		{
			super.readXML(xml);
			btnType = xml.@btnType;
			scaleType = xml.@scaleType;
			label = xml.@label;
		}
		
		override public function writeData(source:IDataOutput):void
		{
			super.writeData(source);
			if(btnType >= 100)
			{
				source.writeByte(btnType - 100);
			}else
			{
				source.writeByte(btnType);
			}
			source.writeByte(scaleType);
			source.writeUTF(label);
		}
		
		override public function getPropertys():Vector.<PropertyVo>
		{
			var vec:Vector.<PropertyVo> = new Vector.<PropertyVo>();
			vec.push(new PropertyVo("btnType","按钮类型",PropertyType.DATAPROVIDER,this.btnType,[1,2,3,4,5,6,7,8,100,101],true,true));
			vec.push(new PropertyVo("scaleType","缩放类型",PropertyType.DATAPROVIDER,this.scaleType,[0,1,2,3,4,5,6,7,8],true,true));
			vec.push(new PropertyVo("label","按钮标题",PropertyType.STRING,this.label));
			return vec.concat(super.getPropertys());
		}
		
		override public function clone(source:*):*
		{
			if(!(source is UIElementButtonInfo))
			{
				throw new Error("clone error");
			}
			var info:UIElementButtonInfo = source as UIElementButtonInfo;
			info.btnType = btnType;
			info.scaleType = scaleType;
			info.label = label;
			super.clone(source);
			return info;
		}
		
		override public function get type():int
		{
			if(btnType >= 100)return UIType.TAB_BTN;
			return super.type;
		}
		
		override public function toString():String
		{
			var arr:Array = [
				["btnType",btnType],
				["scaleType",scaleType],
				["label",label]
			];
			return creatContent(arr) + super.toString();
		}
		
	}
}