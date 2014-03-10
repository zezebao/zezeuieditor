package view
{
	import data.Config;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.ActivityEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.system.ApplicationDomain;
	import flash.text.TextField;
	import flash.utils.getTimer;

	public class VideoArea extends Sprite
	{
		private var _ms:MovieClip;
		private var _msWidget:MovieClip;
		private var _downTime:Number;
		private var _video:Video;
		private var _okBtn:BaseButton;
		private var _bm:Bitmap;
		
		public function VideoArea()
		{
			this.x = this.y = 50;
			if(stage)init();
			else this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(evt:Event=null):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			
			this.filters = [new GlowFilter(0x333333,1,6,6,6)];
			
			//_video = new Video(Config.CAMERA_WIDTH,Config.CAMERA_HEIGHT);
			_video = new Video(1920,1080);
			addChild(_video); 
			
			_bm = new Bitmap(new BitmapData(Config.CAMERA_WIDTH,Config.CAMERA_HEIGHT,true,0x00000000));
			addChild(_bm);
			
			var flag:Boolean = ApplicationDomain.currentDomain.hasDefinition("view.MaskSp");
			if(flag)
			{
				var maskClass:Class = ApplicationDomain.currentDomain.getDefinition("view.MaskSp") as Class;
				var maskWidgetClass:Class = ApplicationDomain.currentDomain.getDefinition("view.MaskWidget") as Class;
				_ms = new maskClass() as MovieClip;
				_msWidget = new maskWidgetClass() as MovieClip;
			}else
			{
				_ms = new MaskSpBak();
				_msWidget = new MovieClip();
			}
			_ms.scaleX = _ms.scaleY = Config.CAMERA_WIDTH / 400;
			_ms.gotoAndStop(1);
			_msWidget.gotoAndStop(1);
			addChild(_ms);
			addChild(_msWidget);
			_video.mask = _ms;
			
			var camera:Camera = Camera.getCamera();
			if(camera!=null)
			{
				camera.setMode(Config.CAMERA_WIDTH/2,Config.CAMERA_HEIGHT/2,60);
				camera.setQuality(0,100);
				camera.addEventListener(ActivityEvent.ACTIVITY,activityHandler);
				
				_video.attachCamera(camera);
			}
			else
			{
				trace("机器上没有安装摄像头！");
				var tf:TextField = new TextField();
				addChild(tf);
				tf.textColor = 0xff0000;
				tf.wordWrap = true;
				tf.selectable = false;
				tf.text = "机器上未检测到可用摄像头";
			}
			
			_okBtn = new BaseButton(Config.OK_IMG);
//			addChild(_okBtn);
			_okBtn.x = Config.CAMERA_WIDTH/2;
			_okBtn.y = Config.CAMERA_HEIGHT - 50;
			
			initEvent();
		}
		
		private function initEvent():void
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
			this.addEventListener(MouseEvent.CLICK,onClickHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUpHandler);
			_okBtn.addEventListener(MouseEvent.CLICK,onMouseClickHandler);
		}
		
		private function removeEvent():void
		{
			this.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
			this.removeEventListener(MouseEvent.CLICK,onClickHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUpHandler);
			_okBtn.removeEventListener(MouseEvent.CLICK,onMouseClickHandler);
		}
		
		protected function onMouseClickHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			
			_okBtn.visible = false; 
			_bm.bitmapData = new BitmapData(Config.CAMERA_WIDTH,Config.CAMERA_HEIGHT,true,0xff0000);
			this.filters = [];
			_bm.bitmapData.draw(this);
			this.filters = [new GlowFilter(0x333333,1,6,6,6)];
			
			_bm.visible = true;
		}
		
		public function show():void
		{
			this.visible = true;
			_okBtn.visible = true;
			_bm.visible = false;
		}
		
		public function hide():void
		{
			this.visible = false;
		}
		
		protected function onClickHandler(event:MouseEvent):void
		{
			if(getTimer() - _downTime > 300)return;
			if(!_okBtn.visible)return;
			var frame:int = _ms.currentFrame;
			frame ++;
			if(frame > _ms.totalFrames)
			{
				frame = 1;
			}
			_ms.gotoAndStop(frame);
			_msWidget.gotoAndStop(frame);
		}
		
		protected function onMouseUpHandler(event:MouseEvent):void
		{
			this.stopDrag();
		}
		
		protected function onMouseDownHandler(event:MouseEvent):void
		{
			_downTime = getTimer();
//			this.startDrag(false);
			//this.startDrag(false,new Rectangle(0,0,stage.stageWidth - Config.CAMERA_WIDTH,stage.stageHeight - Config.CAMERA_HEIGHT));			
		}
		
		private function activityHandler(e:ActivityEvent):void
		{
			trace("activityHandler:"+e);
		}
		
		public function dispose():void
		{
			if(this.parent)parent.removeChild(this);
			_video.attachCamera(null);
			_video.attachNetStream(null);
			_video = null;
		}
	}
}