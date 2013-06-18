package uidata
{
	import data.PropertyType;
	
	import flash.filters.GlowFilter;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.IDataOutput;
	
	import mhqy.ui.UIManager;
	import mhqy.ui.UIType;
	import mhqy.ui.label.MAssetLabel;
	
	import uidata.vo.PropertyVo;

	public class UIElementLabelInfo extends UIElementBaseInfo
	{
		public var font:String;
		public var color:uint;
		public var label:String;
		public var bold:Boolean;
		public var size:int;
		public var underLine:Boolean;
		public var align:String = TextFormatAlign.LEFT;
		public var leading:int;
		public var wrap:Boolean;
		
		public function UIElementLabelInfo(label:String="",font:String="",color:uint=0xffffff,size:int=12,leading:int=0)
		{
			type = UIType.LABEL;
			canScale = true;
			if(font != "")
			{
				this.font = font;
			}else
			{
				this.font = UIData.labelFontData[0];
			}
			this.label = label;
			this.color = color;
			this.size = size;
			this.leading = leading;
		}

		/**结构同MassLabel的[new TextFormat(FONT1,12,ColorUtils.QUALITYCOLORS_INT[0]),MAssetLabel.FILTER1],*/
		public function get typeArr():Array
		{
			var arr:Array = [];
			arr[0] = new TextFormat(MAssetLabel.FONT1,size,color,bold,null,null,null,null,align,null,null,null,leading);
			arr[1] = MAssetLabel.FILTER1;
			return arr;
		}
		
		override public function readXML(xml:XML):void
		{
			super.readXML(xml);
			font = xml.@font;
			color = xml.@color;
			label = xml.@label;
			bold = xml.@bold == "true";
			size = xml.@size;
			underLine = xml.@underLine == "true";
			align = xml.@align;
			leading = xml.@leading;
			wrap = xml.@wrap == "true";
		}
		
		override public function writeData(source:IDataOutput):void
		{
			super.writeData(source);
			source.writeByte(0);
			
			source.writeUTF(label);
			var fontIndex:int = App.uiData.getFontIndex(font);
			source.writeByte(fontIndex);
			var colorIndex:int = App.uiData.getColorIndex(color);
			source.writeByte(colorIndex);
			source.writeByte(size);
			source.writeBoolean(bold);
			source.writeBoolean(underLine);
			source.writeByte(leading);
			source.writeUTF(align);
			source.writeBoolean(wrap);
		}
		
		override public function getPropertys():Vector.<PropertyVo>
		{
			var vec:Vector.<PropertyVo> = new Vector.<PropertyVo>();
			vec.push(new PropertyVo("label","文本，可以是纯文本或者语言包",PropertyType.STRING,this.label));
			vec.push(new PropertyVo("color","字体颜色",PropertyType.DATAPROVIDER,this.color,UIData.labelColorData));
			vec.push(new PropertyVo("font","字体",PropertyType.DATAPROVIDER,this.font,UIData.labelFontData));
			vec.push(new PropertyVo("align","对齐方式",PropertyType.DATAPROVIDER,this.align,App.uiData.alignTypeList));
			vec.push(new PropertyVo("bold","是否粗体",PropertyType.DATAPROVIDER,this.bold,[true,false]));
			vec.push(new PropertyVo("size","字体大小",PropertyType.NUMBER,this.size));
			vec.push(new PropertyVo("underLine","是否下划线",PropertyType.DATAPROVIDER,this.underLine,[true,false]));
			vec.push(new PropertyVo("leading","行距",PropertyType.NUMBER,this.leading));
			vec.push(new PropertyVo("wrap","是否自动换行",PropertyType.DATAPROVIDER,this.wrap,[true,false]));
			return vec.concat(super.getPropertys());
		}
		
		override public function clone(source:*):*
		{
			if(!(source is UIElementLabelInfo))
			{
				throw new Error("clone error");
			}
			var info:UIElementLabelInfo = source as UIElementLabelInfo;
			info.label = label;
			info.color = color;
			info.bold = bold;
			info.size = size;
			info.align = align;
			info.leading = leading;
			info.wrap = wrap;
			info.underLine = underLine;
			super.clone(source);
			return info;
		}
		
		override public function toString():String
		{
			var arr:Array = [
				["font",font],
				["color",color],
				["label",label],
				["bold",bold],
				["size",size],
				["underLine",underLine],
				["align",align],
				["leading",leading],
				["wrap",wrap],
			];
			return creatContent(arr) + super.toString();
		}
	}
}