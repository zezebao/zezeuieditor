package view
{
	import data.Config;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.FrameLabel;
	import flash.display.Sprite;
	import flash.events.ActivityEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.text.TextField;
	import flash.utils.getTimer;

	public class VideoArea extends Sprite
	{
		private var _ms:MaskSp;
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
			this.filters = [new GlowFilter(0x333333,1,6,6,6)];
			
			_video = new Video(Config.CAMERA_WIDTH,Config.CAMERA_HEIGHT);
			addChild(_video); 
			
			_bm = new Bitmap(new BitmapData(Config.CAMERA_WIDTH,Config.CAMERA_HEIGHT,true,0x00000000));
			addChild(_bm);
			_bm.visible = false;
			
			_ms = new MaskSp();
			_ms.scaleX = _ms.scaleY = Config.CAMERA_WIDTH / 400;
			_ms.gotoAndStop(1);
			addChild(_ms);
			_video.mask = _ms;
			_bm.mask = _ms;
			
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
			addChild(_okBtn);
			_okBtn.x = Config.CAMERA_WIDTH/2;
			_okBtn.y = Config.CAMERA_HEIGHT - 50;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
			this.addEventListener(MouseEvent.CLICK,onClickHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUpHandler);
			_okBtn.addEventListener(MouseEvent.CLICK,onMouseClickHandler);
		}
		
		protected function onMouseClickHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			
			_okBtn.visible = false; 
			_bm.bitmapData = new BitmapData(Config.CAMERA_WIDTH,Config.CAMERA_HEIGHT);
			var matrix:Matrix = new Matrix();
			_bm.bitmapData.draw(_video,matrix);
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
		}
		
		protected function onMouseUpHandler(event:MouseEvent):void
		{
			this.stopDrag();
		}
		
		protected function onMouseDownHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			_downTime = getTimer();
			this.startDrag(false,new Rectangle(0,0,stage.stageWidth - Config.CAMERA_WIDTH,stage.stageHeight - Config.CAMERA_HEIGHT));			
		}
		
		private function activityHandler(e:ActivityEvent):void
		{
			trace("activityHandler:"+e);
		}
	}
}