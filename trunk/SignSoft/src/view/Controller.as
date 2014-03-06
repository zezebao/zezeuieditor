package view
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.utils.getTimer;
	
	public class Controller extends ControllerAsset
	{
		/**
		 * 1 毛笔
		 * 2 钢笔
		 * 3 铅笔
		 * 4 橡皮擦
		 */
		public static var brushType:int = 1;
		/**
		 * 1,2,3,4,5,6
		 */
		public static var brushSize:int = 3;
		public static var brushColor:uint = 0x000000;
		
		private var _colors:Array = [
			0x000000,0xffffff,0xff0000,0x00ff00,0x0000ff,
			0xff00ff,0xcccccc,0xd2ff99,0x44ff44,0x333333,
			0x36f0ff,0x00f799,0xd2560f,0x4ff34f,0x7632ff
		];
		
		private var _brushTypeList:Vector.<MovieClip> = new Vector.<MovieClip>();
		private var _brushSizeList:Vector.<MovieClip> = new Vector.<MovieClip>();
		private var _brushColorList:Vector.<MovieClip> = new Vector.<MovieClip>();
		private var _glow:GlowFilter = new GlowFilter(0,0.6,3,3);		
		
		private var _main:Main;
		private var _downTime:Number;
		private var _isDrag:Boolean = false;
		private var _dragObj:Sprite;
		
		public function Controller(main:Main)
		{
			this._main = main;
			super();
			if(stage)init();
			else this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(evt:Event=null):void
		{
			stage.addEventListener(Event.RESIZE,onResizeHandler);
			onResizeHandler(null);
			
			_brushTypeList.push(brush1);
			_brushTypeList.push(brush2);
			_brushTypeList.push(brush3);
			_brushTypeList.push(brush4);
			
			_brushSizeList.push(sizeList.size1);
			_brushSizeList.push(sizeList.size2);
			_brushSizeList.push(sizeList.size3);
			_brushSizeList.push(sizeList.size4);
			_brushSizeList.push(sizeList.size5);
			_brushSizeList.push(sizeList.size6);
			
			var offset:int = 33; 
			for (var i:int = 0; i < _colors.length; i++) 
			{
				var sp:MovieClip = new MovieClip();
				sp.graphics.beginFill(_colors[i],1);
				sp.graphics.drawRect(0,0,offset,offset);
				sp.graphics.endFill();
				color.addChild(sp);
				
				_brushColorList.push(sp);
				
				sp.x = (i % 5) * (offset + 1) + 31;
				sp.y = int(i / 5) * (offset + 1)+ 55;
			}
			
			brush1.filters = sizeList.size3.filters = _brushColorList[0].filters = [_glow];
			
			initEvent();
		}
		
		private function initEvent():void
		{
			stage.addEventListener(MouseEvent.MOUSE_UP,upHandler);
			sizeList.addEventListener(MouseEvent.MOUSE_DOWN,downHandler);
			color.addEventListener(MouseEvent.MOUSE_DOWN,downHandler);
			var i:int;
			for (i = 0; i < _brushTypeList.length; i++) 
			{
				_brushTypeList[i].addEventListener(MouseEvent.CLICK,clickType);
				_brushTypeList[i].addEventListener(MouseEvent.MOUSE_DOWN,downHandler);
			}
			for (i = 0; i < _brushSizeList.length; i++) 
			{
				_brushSizeList[i].addEventListener(MouseEvent.CLICK,clickSize);
			}
			for (i = 0; i < _brushColorList.length; i++) 
			{
				_brushColorList[i].addEventListener(MouseEvent.CLICK,clickColor);
			}
		}
		
		protected function upHandler(event:MouseEvent):void
		{
			if(getTimer() - _downTime >= 300)
			{
				_isDrag = true;
			}else
			{
				_isDrag = false;
			}
			
			if(_dragObj)_dragObj.stopDrag();
			_dragObj = null;
		}
		
		protected function downHandler(event:MouseEvent):void
		{
			_downTime = getTimer();
			_dragObj = event.currentTarget as Sprite;
			_dragObj.startDrag(false);
		}
		
		protected function clickType(event:MouseEvent):void
		{
			if(_isDrag)return;
			var vec:Vector.<MovieClip> = _brushTypeList;
			var index:int = vec.indexOf(event.target);
			for (var i:int = 0; i < vec.length; i++) 
			{
				if(event.target == vec[i])
				{
					vec[i].filters = [_glow];
				}else
				{
					vec[i].filters = [];
				}
			}
			brushType = index + 1;
			
			_main.changeType();
		}
		
		protected function clickSize(event:MouseEvent):void
		{
			if(_isDrag)return;
			var vec:Vector.<MovieClip> = _brushSizeList;
			var index:int = vec.indexOf(event.target);
			for (var i:int = 0; i < vec.length; i++) 
			{
				if(event.target == vec[i])
				{
					vec[i].filters = [_glow];
				}else
				{
					vec[i].filters = [];
				}
			}
			brushSize = index + 1;			
		}
		
		protected function clickColor(event:MouseEvent):void
		{
			if(_isDrag)return;
			var vec:Vector.<MovieClip> = _brushColorList;
			var index:int = vec.indexOf(event.target);
			for (var i:int = 0; i < vec.length; i++) 
			{
				if(event.target == vec[i])
				{
					vec[i].filters = [new GlowFilter(0xff000000,1,3,3,6)];
				}else
				{
					vec[i].filters = [];
				}
			}
			brushColor = _colors[index];	
		}
		
		protected function onResizeHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			this.x = stage.stageWidth - 500;
			this.y = 20;
		}
		
		public function change():void
		{
						
		}
	}
}