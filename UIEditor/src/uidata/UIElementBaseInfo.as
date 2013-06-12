package uidata
{
	import event.UIEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import interfaces.ICloneAble;
	
	import uidata.vo.PropertyVo;

	public class UIElementBaseInfo extends EventDispatcher implements ICloneAble
	{
		public var x:int;
		public var y:int;
		public var width:int;
		public var height:int;
		public var name:String="";
		public var variable:String="";
		//类型标识
		public var type:int;
		//具体类映射
		public var className:String="";
		
		
		/**可否拉伸*/
		public var canScale:Boolean = false;
		
		public function UIElementBaseInfo()
		{
			type = UIClassType.UIBITMAP;
		}

		public function parseData(d:ByteArray):void
		{
			x = d.readShort();
			y = d.readShort();
			width = d.readShort();
			height = d.readShort();
			name = d.readUTF();
			variable = d.readUTF();
		}
		
		public function writeData(source:ByteArray):void
		{
			source.writeShort(x);
			source.writeShort(y);
			source.writeShort(width);
			source.writeShort(height);
			source.writeUTF(name);
			source.writeUTF(variable);
		}
		/**
		 * 获取UIElement一系列可操作属性 
		 * @return 
		 */		
		public function getPropertys():Vector.<PropertyVo>
		{
			var vec:Vector.<PropertyVo> = new Vector.<PropertyVo>();
			vec.push(new PropertyVo("variable",String,this.variable));
			vec.push(new PropertyVo("x",Number,this.x));
			vec.push(new PropertyVo("y",Number,this.y));
			vec.push(new PropertyVo("width",Number,this.width));
			vec.push(new PropertyVo("height",Number,this.height));
			vec.push(new PropertyVo("name",String,this.name));
			return vec;
		}
		
		public function update():void
		{
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function clone():*
		{
			var info:UIElementBaseInfo = new UIElementBaseInfo();
			info.x = x;
			info.y = y;
			info.width = width;
			info.height = height;
			info.name = name;
			info.variable = variable;
			info.className = className;
			return info;
		}
		
	}
}