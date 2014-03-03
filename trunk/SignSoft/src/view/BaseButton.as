package view
{
	import caurina.transitions.Tweener;
	
	import data.Config;
	import data.ShareObjectManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	public class BaseButton extends Sprite
	{
		public var clickCallback:Function;
		
		protected var _btnImg:Bitmap;
		protected var _imgLoader:Loader;
		private var _isVisible:Boolean = true;
		private var _position:Point;
		private var _posPerertyName:String;
		
		public function BaseButton(posPerertyName:String)
		{
			super();
			_imgLoader = new Loader();
			_posPerertyName = posPerertyName;
			_btnImg = new Bitmap();
			addChild(_btnImg);
			
			initEvent();
			
			if(stage)addToStageHandler(null);
			else this.addEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
		}
		
		protected function addToStageHandler(event:Event):void
		{
			load();
			stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUpHandler);
			stage.addEventListener(Event.RESIZE,onResizeHandler);
			onResizeHandler();
		}
		
		private function load():void
		{
			var url:String = Config.UI_PATH + Config.getBtnPath(_posPerertyName);
			_imgLoader.load(new URLRequest(url));
		}
		
		protected function initEvent():void
		{
			_imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,onImgCompleteHandler);
			_imgLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onErrorHandler);
			this.addEventListener(MouseEvent.CLICK,onClickHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN,onMosueDownHandler);
		}
		
		protected function removeEvent():void
		{
			_imgLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onImgCompleteHandler);
			_imgLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onErrorHandler);
			this.removeEventListener(MouseEvent.CLICK,onClickHandler);
			this.removeEventListener(MouseEvent.MOUSE_DOWN,onMosueDownHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUpHandler);
			stage.removeEventListener(Event.RESIZE,onResizeHandler);
		}
		
		protected function onMosueDownHandler(event:MouseEvent):void
		{
			this.startDrag(false,new Rectangle(0,0,stage.stageWidth - _btnImg.width,stage.stageHeight - _btnImg.height));
		}
		
		protected function onMouseUpHandler(event:MouseEvent):void
		{
			this.stopDrag();
			ShareObjectManager.getInstance().setProperty(_posPerertyName,new Point(stage.stageWidth - this.x,this.y));
		}
		
		protected function onClickHandler(event:MouseEvent):void
		{
			if(clickCallback != null)
				clickCallback();
		}
		
		protected function onErrorHandler(event:IOErrorEvent):void
		{
			trace("load error:",event.text);	
		}
		
		protected function onImgCompleteHandler(event:Event):void
		{
			var bitmap:Bitmap = _imgLoader.content as Bitmap;
			_btnImg.bitmapData = bitmap.bitmapData;
			_imgLoader.unloadAndStop();
			
			trace("loaded");
		}
		
		protected function onResizeHandler(event:Event=null):void
		{
			var pos:Object = ShareObjectManager.getInstance().getProperty(_posPerertyName);
			this.x = stage.stageWidth - pos["x"];
			this.y = pos["y"];
		}
		
		public function get position():Point
		{
			return _position;
		}

		public function set position(value:Point):void
		{
			_position = value;
			this.x = _position.x;
			this.y = _position.y;
		}

		public function get isVisible():Boolean
		{
			return _isVisible;
		}

		public function set isVisible(value:Boolean):void
		{
			_isVisible = value;
			visible = _isVisible;
		}

		public function dispose():void
		{
			removeEvent();
			if(parent)
			{
				parent.removeChild(this);
			}
		}
			
	}
}