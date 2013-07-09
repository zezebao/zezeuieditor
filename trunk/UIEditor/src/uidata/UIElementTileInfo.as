package uidata
{
	import data.PropertyType;
	
	import flash.utils.IDataOutput;
	
	import mhqy.ui.UIType;
	
	import uidata.vo.PropertyVo;

	public class UIElementTileInfo extends UIElementBaseInfo
	{
		public var itemWidth:int = 100;
		public var itemHeight:int = 20;
		public var columns:int = 1;
		public var itemGapH:int = 2;
		public var itemGapW:int = 2;
		
		public function UIElementTileInfo()
		{
			type = UIType.TILE;
//			canScale = true;
			
			width = 300;
			height = 300;
		}
		
		override public function clone():*
		{
			var info:UIElementTileInfo = super.clone() as UIElementTileInfo;
			info.itemWidth = itemWidth;
			info.itemHeight = itemHeight;
			info.columns = columns;
			info.itemGapH = itemGapH;
			info.itemGapW = itemGapW;
			return info;
		}
		
		override public function readXML(xml:XML):void
		{
			super.readXML(xml);
			itemWidth = xml.@itemWidth;
			itemHeight = xml.@itemHeight;
			columns = xml.@columns;
			itemGapH = xml.@itemGapH;
			itemGapW = xml.@itemGapW;
		}
		
		override public function writeData(source:IDataOutput):void
		{
			super.writeData(source);
			source.writeByte(0);
			source.writeShort(itemWidth);
			source.writeShort(itemHeight);
			source.writeByte(columns);
			source.writeByte(itemGapH);
			source.writeByte(itemGapW);
		}
		
		override public function getPropertys():Vector.<PropertyVo>
		{
			var vec:Vector.<PropertyVo> = new Vector.<PropertyVo>();
			vec.push(new PropertyVo("itemWidth","itemWidth",PropertyType.NUMBER,this.itemWidth,null,true,true));
			vec.push(new PropertyVo("itemHeight","itemHeight",PropertyType.NUMBER,this.itemHeight,null,true,true));
			vec.push(new PropertyVo("columns","纵列",PropertyType.NUMBER,this.columns,null,true,true));
			vec.push(new PropertyVo("itemGapH","item间隔高度",PropertyType.NUMBER,this.itemGapH,null,true,true));
			vec.push(new PropertyVo("itemGapW","item间隔宽度",PropertyType.NUMBER,this.itemGapW,null,true,true));
			return vec.concat(super.getPropertys());
		}
		
		override public function toString():String
		{
			var arr:Array = [
				["itemWidth",itemWidth],
				["itemHeight",itemHeight],
				["columns",columns],
				["itemGapH",itemGapH],
				["itemGapW",itemGapW]
			];
			return creatContent(arr) + super.toString();
		}
	}
}