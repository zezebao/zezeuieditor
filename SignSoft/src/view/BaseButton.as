package view
{
	import Util.Utils;
	
	import caurina.transitions.Tweener;
	
	import data.Config;
	import data.MyEvent;
	
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
	import flash.utils.getTimer;
	
	public class BaseButton extends Sprite
	{
		public var clickCallback:Function;
		
		protected var _btnImg:Bitmap;
		protected var _imgLoader:Loader;
		private var _isVisible:Boolean = true;
		private var _position:Point;
		private var _posPerertyName:String;
		private var _downTime:Number;
		private var _canMove:Boolean;
		
		public function BaseButton(posPerertyName:String,canMove:Boolean=true)
		{
			super();
			
			_imgLoader = new Loader();
			_canMove = canMove;
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
			replaceHandler();
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
			Utils.addEventListener(MyEvent.REPLACE,replaceHandler);
		}
		
		private function replaceHandler(evt:Event=null):void
		{
			var pos:Point = Config.defaultPos[_posPerertyName];
			if(pos)
			{
				this.x = pos.x;
				this.y = pos.y;
			}				
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
			event.stopImmediatePropagation();
			_downTime = getTimer();
			var ts:Number = 1.05;
			Tweener.addTween(this,{scaleX:ts,scaleY:ts,time:0.1});
			if(_canMove)
			{
//				this.startDrag(false,new Rectangle(0,0,stage.stageWidth - _btnImg.width,stage.stageHeight - _btnImg.height));
				this.startDrag(false);				
			}
		}
		
		protected function onMouseUpHandler(event:MouseEvent):void
		{
			Tweener.addTween(this,{scaleX:1,scaleY:1,time:0.1});
			this.stopDrag();
		}
		
		protected function onClickHandler(event:MouseEvent):void
		{
			if(getTimer() - _downTime > 300)return;
			if(clickCallback != null)
				clickCallback(this);
		}
		
		protected function onErrorHandler(event:IOErrorEvent):void
		{
			trace("load error:",event.text);	
		}
		
		protected function onImgCompleteHandler(event:Event):void
		{
			var bitmap:Bitmap = _imgLoader.content as Bitmap;
			_btnImg.bitmapData = bitmap.bitmapData;
			_btnImg.x = -_btnImg.width/2;
			_btnImg.y = -_btnImg.height/2;
			_imgLoader.unloadAndStop();
		}
		
		protected function onResizeHandler(event:Event=null):void
		{

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