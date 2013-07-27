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
	import uidata.vo.RecordVo;
	
	import utils.UIElementCreator;

	public class UIElementBaseInfo extends EventDispatcher implements ICloneAble
	{
		private var _x:int;
		private var _y:int;
		private var _width:int;
		private var _height:int;
		public var name:String="";
		public var variable:String="";
		//类型标识
		protected var _type:int;
		
		private var _layout:String = "";
		
		/**可否拉伸*/
		public var canScale:Boolean = false;
		public var locked:Boolean = false;

		private var _proVec:Vector.<PropertyVo>;
		
		/**资源是否出错：若出错，则width、height属性不能被改变（如Bitmap的宽高在不能正常加载会出错等情况）*/
		public var isResourceError:Boolean;
		
		private var _recordList:Vector.<RecordVo> = new Vector.<RecordVo>(); 
		
		public function UIElementBaseInfo()
		{
			type = UIType.BITMAP;
		}

		/**
		 * 记录改变，若前一记录状态与之相同，则不记录 
		 * @return 
		 */		
		public function record():Boolean
		{
			var recordVo:RecordVo = new RecordVo();
			recordVo.x = this.x;
			recordVo.y = this.y;
			recordVo.width = this.width;
			recordVo.height = this.height;
			if(_recordList.length > 0)
			{
				var preRecordVo:RecordVo = _recordList[_recordList.length - 1];
				if(recordVo.equal(preRecordVo))
					return false;
			}
			_recordList.push(recordVo);
			
			return true;
		}
		
		/**撤销改变*/
		public function undo():void
		{
			if(_recordList.length > 0)
			{
				var recordVo:RecordVo = _recordList.pop();
				this.x = recordVo.x;
				this.y = recordVo.y;
				this.width = recordVo.width;
				this.height = recordVo.height;
				
				update("x");
			}
		}
		
		public function update(propertyName:String):void
		{
			dispatchEvent(new UIEvent(UIEvent.INFO_UPDATE_PROPERTY,getProperty(propertyName).isChangeView));
		}
		
		public function readXML(xml:XML):void
		{
			x = xml.@x;
			y = xml.@y;
			_width = xml.@width;
			_height = xml.@height;
			name = xml.@name;
			variable = xml.@variable;
			locked = xml.@locked == "true";
			layout = xml.@layout;
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
			_proVec = new Vector.<PropertyVo>();
			_proVec.push(new PropertyVo("variable","变量名",PropertyType.STRING,this.variable));
			if(canLayout)_proVec.push(new PropertyVo("layout","格式：1,2,3,4,代表：列，行，X间隔，Y间隔",PropertyType.STRING,this.layout,null,true,true));
			_proVec.push(new PropertyVo("x","x坐标",PropertyType.NUMBER,this.x));
			_proVec.push(new PropertyVo("y","y坐标",PropertyType.NUMBER,this.y));
			_proVec.push(new PropertyVo("width","宽度",PropertyType.NUMBER,this.width,null,true,hasLayout));
			_proVec.push(new PropertyVo("height","高度",PropertyType.NUMBER,this.height,null,true,hasLayout));
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
			return new PropertyVo("","",0,null);
		}
		
		public function clone():*
		{
			var info:UIElementBaseInfo = UIElementCreator.creatInfo(type);
			info.x = x;
			info.y = y;
			info.width = width;
			info.height = height;
			info.name = name;
			info.variable = variable;
			info.layout = layout;
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
				["variable",variable],
				["locked",locked],
				["layout",layout],
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
		
		//===================setter,getter============================
		public function get y():int
		{
			return _y;
		}
		public function set y(value:int):void
		{
			_y = value;
		}
		public function get x():int
		{
			return _x;
		}
		public function set x(value:int):void
		{
			_x = value;
		}
		public function get height():int
		{
			return _height;
		}
		public function set height(value:int):void
		{
			if(!isResourceError)
			{
				_height = value;
			}
		}
		public function get width():int
		{
			return _width;
		}
		public function set width(value:int):void
		{
			if(!isResourceError)
			{
				_width = value;
			}
		}
		
		public function get layoutData():Object
		{
			return null;
		}
		//====================================================
		
		//-------布局信息------------------------------------
		private function get canLayout():Boolean
		{
			return type != UIType.CHECKBOX 
				&& type != UIType.COMBO_BOX 
				&& type != UIType.PAGE_VIEW 
				&& type != UIType.RADIO_BTN
				&& type != UIType.SCROLL_PANEL
				&& type != UIType.TILE
		}
		/**格式：1,2,3,4,代表：列，行，X间隔，Y间隔*/
		public function get layout():String
		{
			return _layout;
		}
		/**
		 * @private
		 */
		public function set layout(value:String):void
		{
			_layout = value;
			canScale = !hasLayout;
		}
		public function get hasLayout():Boolean
		{
			return layoutColumn != 0 && layoutRow != 0;
		}
		public function get layoutColumn():uint
		{
			var arr:Array = layout.split(",");
			if(arr.length > 0)
				return arr[0];
			return 0;
		}
		public function get layoutRow():uint
		{
			var arr:Array = layout.split(",");
			if(arr.length > 1)
				return arr[1];
			return 0;
		}
		public function get layoutOffsetX():uint
		{
			var arr:Array = layout.split(",");
			if(arr.length > 2)
				return arr[2];
			return 0;
		}
		public function get layoutOffsetY():uint
		{
			var arr:Array = layout.split(",");
			if(arr.length > 3)
				return arr[3];
			return 0;
		}
	}
}