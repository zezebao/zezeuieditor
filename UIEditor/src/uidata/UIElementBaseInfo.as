package uidata
{
	import event.UIEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import uidata.vo.PropertyVo;

	public class UIElementBaseInfo extends EventDispatcher
	{
		public var x:int;
		public var y:int;
		public var width:int;
		public var height:int;
		public var isjoin:Boolean;
		public var name:String="";
		public var variable:String="";
		//类型标识
		public var type:int;
		//具体类映射
		public var className:String="";
		
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
			isjoin = d.readBoolean();
			name = d.readUTF();
			variable = d.readUTF();
		}
		
		public function writeData(source:ByteArray):void
		{
			source.writeShort(x);
			source.writeShort(y);
			source.writeShort(width);
			source.writeShort(height);
			source.writeBoolean(isjoin);
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
			vec.push(new PropertyVo("variable","变量名",String,this.variable));
			vec.push(new PropertyVo("x","x坐标",Number,this.x));
			vec.push(new PropertyVo("y","y坐标",Number,this.y));
			vec.push(new PropertyVo("width","宽度",Number,this.width));
			vec.push(new PropertyVo("height","高度",Number,this.height));
			vec.push(new PropertyVo("name","name",String,this.name));
			return vec;
		}
		
		public function update():void
		{
			dispatchEvent(new Event(Event.CHANGE));
		}
	}
}