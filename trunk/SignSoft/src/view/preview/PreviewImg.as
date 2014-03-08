package view.preview
{
	import data.Config;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TransformGestureEvent;
	import flash.net.URLRequest;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.getTimer;
	
	import flashx.textLayout.elements.Configuration;
	
	import view.BaseButton;
	
	public class PreviewImg extends Sprite
	{
		private const _minScale:Number = 0.5;
		private const _maxScale:Number = 1.5;
		
		private var _bm:Bitmap;
		private var _bmCon:Sprite;
		private var _loader:Loader;
		private var _closeBtn:BaseButton;
		private var _downTime:Number;
		
		public function PreviewImg()
		{
			super();
			
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			
			_bmCon = new Sprite();
			addChild(_bmCon);
			_bm = new Bitmap();
			_bmCon.addChild(_bm);
			
			_closeBtn = new BaseButton(Config.CLOSE_IMG,false);
			addChild(_closeBtn);
			_closeBtn.visible = false;
			_closeBtn.x = Config.SCREEN_WIDTH - 60;
			_closeBtn.y = 60;
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onCompleteHandler);
			_closeBtn.addEventListener(MouseEvent.CLICK,onClickCloseHandler);
			_bmCon.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
			this.addEventListener(MouseEvent.MOUSE_UP,onMouseUpHandler);
			this.addEventListener(TransformGestureEvent.GESTURE_ZOOM, zoomHandler);
		}
		
		private function zoomHandler(event:TransformGestureEvent):void
		{
			var scale:Number = _bm.scaleX;
			scale *= event.scaleX;
			
			if(scale > _maxScale)scale = _maxScale;
			else if(scale < _minScale)scale = _minScale;
			_bm.scaleX = _bm.scaleY = scale;
		}
		
		protected function onClickCloseHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			clear();
		}
		
		protected function onMouseDownHandler(event:MouseEvent):void
		{
			_downTime = getTimer();
			_bmCon.startDrag(false);	
		}
		
		protected function onMouseUpHandler(event:MouseEvent):void
		{
			_bmCon.stopDrag();
			if(getTimer() - _downTime > 300)return;
			clear();			
		}
		
		protected function onCompleteHandler(event:Event):void
		{
			_bm.bitmapData = (_loader.content as Bitmap).bitmapData;
			_bm.scaleX = _bm.scaleY = _minScale;
			_bm.x = -_bm.width / 2;
			_bm.y = -_bm.height / 2;
			
			_bmCon.x = Config.SCREEN_WIDTH / 2;
			_bmCon.y = Config.SCREEN_HEIGHT / 2; 
		}
		
		public function load(path:String):void
		{
			clear();
			
			_closeBtn.visible = true;
			graphics.beginFill(0xffffff,0.6);
			graphics.drawRect(-1000,-1000,4000,4000);
			graphics.endFill();
			
			_loader.load(new URLRequest(path));
			mouseChildren = mouseEnabled = true;
		}
		
		public function clear():void
		{
			_closeBtn.visible = false;
			graphics.clear();
			_bm.bitmapData = null;
			mouseChildren = mouseEnabled = true;
		}
	}
}