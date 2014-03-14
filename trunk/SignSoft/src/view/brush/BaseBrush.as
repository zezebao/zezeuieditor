package view.brush 
{
	import data.Config;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import view.Controller;
	
	/**
	 * 带笔触的书写
	 */
	public class BaseBrush extends Sprite
	{
		protected var bmd:BitmapData;
		protected var bm:Bitmap;
		protected var oldX:Number;
		protected var oldY:Number;
		protected var isDown:Boolean = false;
		protected var brushSp:Sprite;
		protected var container:Sprite ;//容器
		protected var canNotDraw:Boolean = true;
		protected var emptySp:Sprite;//清屏对象
		protected var moveSpeed:Point = new Point();
		
		protected var _main:IApplication;
		
		public function BaseBrush(main:IApplication) 
		{
			this._main = main;
			if(stage)init();
			else this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		protected function init(evt:Event=null):void
		{
			bmd = new BitmapData(1920, 1080,true,0x0);
			bm = new Bitmap(bmd);
			brushSp = new Sprite();
			container = new Sprite();
			addChildAt(container, 0);
			container.addChild(bm);
			if(Config.USE_TOUCH)
			{
				this.addEventListener(TouchEvent.TOUCH_BEGIN, onMouseDownHandler);
				stage.addEventListener(TouchEvent.TOUCH_END, onMouseUpHandler);
			}else
			{
				this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);	
			}
			
			emptySp = new Sprite();
			addChild(emptySp);
			
			emptySp.visible = false;
		}
		
		public function clear():void 
		{
			bmd.dispose();
			bmd = new BitmapData(1920, 1080,true,0x0);
			bm.bitmapData = bmd;
		}
		
		public function erase():void
		{
			if(Controller.brushType == 4)
			{
				var radio:Number = 40;
				var sp:Sprite = new Sprite();
				sp.graphics.beginFill(0,1);
				sp.graphics.drawCircle(-radio/2,-radio/2,radio);
				sp.graphics.endFill();
				brushSp.addChild(sp);
				sp.x = stage.mouseX;
				sp.y = stage.mouseY;
				
				bmd.draw(brushSp,new Matrix(),new ColorTransform(),BlendMode.ERASE);
				while (brushSp.numChildren>0) {
					brushSp.removeChildAt(0);
				}
			}
		}
		
		protected function onEnterFrameHandler(e:Event):Boolean 
		{
			if(! stage)return false;
			if (! isDown)return false; 
				
			if(Controller.brushType == 4)
			{
				_main.erase();
				return false;
			}
			if (isNaN(oldX)) return false;
			moveSpeed.x = mouseX - oldX;
			moveSpeed.y = mouseY - oldY;
//			trace("moveSpeed:",moveSpeed.length);
			return true;
		}
		protected function onMouseDownHandler(e:Event):void 
		{
			if (canNotDraw) 
			{
				if(Config.USE_TOUCH)
				{
					stage.addEventListener(TouchEvent.TOUCH_MOVE, onEnterFrameHandler);	
				}else
				{
					stage.addEventListener(MouseEvent.MOUSE_MOVE, onEnterFrameHandler);	
				}
				isDown = true;
				oldX = mouseX;
				oldY = mouseY;
			}
		}
		
		protected function onMouseUpHandler(e:Event):void
		{
			if(! stage)return;
			if(Config.USE_TOUCH)
			{
				stage.removeEventListener(TouchEvent.TOUCH_MOVE, onEnterFrameHandler);	
			}else
			{
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, onEnterFrameHandler);	
			}
			isDown = false;
			oldX = NaN;
			stopDrag();
		}
		
		public function dispose():void
		{
			if(parent)parent.removeChild(this);
		}
	}
}