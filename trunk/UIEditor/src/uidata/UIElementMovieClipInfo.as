package uidata
{
	import data.PropertyType;
	
	import flash.utils.IDataOutput;
	
	import mhqy.ui.UIType;
	
	import uidata.vo.PropertyVo;

	public class UIElementMovieClipInfo extends UIElementBaseInfo
	{
		public var className:String;
		
		public function UIElementMovieClipInfo(className:String)
		{
			this.className = className;
			type = UIType.MOVIECLIP;
			canScale = true;
		}
		
		override public function clone():*
		{
			var info:UIElementMovieClipInfo = super.clone() as UIElementMovieClipInfo;
			info.className = className;
			return info;
		}
		
		override public function readXML(xml:XML):void
		{
			super.readXML(xml);
			className = xml.@className;
		}
		
		override public function writeData(source:IDataOutput):void
		{
			super.writeData(source);
			source.writeByte(0);
			source.writeUTF(className);
		}
		
		override public function getPropertys():Vector.<PropertyVo>
		{
			var vec:Vector.<PropertyVo> = new Vector.<PropertyVo>();
			vec.push(new PropertyVo("className","类链接名",PropertyType.STRING,this.className));
			return vec.concat(super.getPropertys());
		}
		
		override public function toString():String
		{
			var arr:Array = [
				["className",className]
			];
			return creatContent(arr) + super.toString();
		}
	}
}