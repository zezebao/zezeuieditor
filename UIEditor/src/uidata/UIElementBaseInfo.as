package uidata
{
	import data.PropertyType;
	
	import event.UIEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.utils.IDataOutput;
	
	import interfaces.ICloneAble;
	
	import mhqy.ui.UIType;
	
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
		protected var _type:int;
		
		/**可否拉伸*/
		public var canScale:Boolean = false;

		private var _proVec:Vector.<PropertyVo>;
		
		public function UIElementBaseInfo()
		{
			type = UIType.BITMAP;
		}
		
		public function update():void
		{
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function readXML(xml:XML):void
		{
			x = xml.@x;
			y = xml.@y;
			width = xml.@width;
			height = xml.@height;
			name = xml.@name;
			variable = xml.@variable;
		}
		
		public function writeData(source:IDataOutput):void
		{
			source.writeUTF(variable);
			source.writeByte(type);
			source.writeShort(x);
			source.writeShort(y);
			source.writeShort(width);
			source.writeShort(height);
		}
		/**
		 * 获取UIElement一系列可操作属性 
		 * @return 
		 */		
		public function getPropertys():Vector.<PropertyVo>
		{
			if(_proVec)return _proVec;
			_proVec = new Vector.<PropertyVo>();
			_proVec.push(new PropertyVo("variable","变量名",PropertyType.STRING,this.variable));
			_proVec.push(new PropertyVo("x","x坐标",PropertyType.NUMBER,this.x));
			_proVec.push(new PropertyVo("y","y坐标",PropertyType.NUMBER,this.y));
			_proVec.push(new PropertyVo("width","宽度",PropertyType.NUMBER,this.width));
			_proVec.push(new PropertyVo("height","高度",PropertyType.NUMBER,this.height));
			return _proVec;
		}
		
		protected function getProperty(property:String):PropertyVo
		{
			var vec:Vector.<PropertyVo> = getPropertys();
			for (var i:int = 0; i < vec.length; i++) 
			{
				if(vec[i].proterty == property)
					return vec[i];
			}
			return new PropertyVo("","",0,null);//for no errors
		}
		
		public function clone(source:*):*
		{
			if(!(source is UIElementBaseInfo))
			{
				throw new Error("clone error");
			}
			var info:UIElementBaseInfo = source as UIElementBaseInfo;
			info.x = x;
			info.y = y;
			info.width = width;
			info.height = height;
			info.name = name;
			info.variable = variable;
			return info;
		}
		
		public function get type():int
		{
			return _type;
		}
		
		public function set type(value:int):void
		{
			_type = value;
		}
		
		/**
		 * 返回类型如 "x='1' y='22'..."  注：<item></item>标签外部添加(方便子类重写)
		 * @return 
		 */		
		override public function toString():String
		{
			var arr:Array = [
				["type",type],
				["x",x],
				["y",y],
				["width",width],
				["height",height],
				["name",name],
				["variable",variable]
			];
			return creatContent(arr);
		}
		
		/**arr为二维数组[type,value]*/
		protected function creatContent(arr:Array):String
		{
			var content:String = "";
			for (var i:int = 0; i < arr.length; i++) 
			{
				content += arr[i][0] + "='" + arr[i][1] + "' ";
			}
			return content;
		}
	}
}