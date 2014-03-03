package view
{
	import data.Config;
	
	import flash.display.FrameLabel;
	import flash.display.Sprite;
	import flash.events.ActivityEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.text.TextField;
	import flash.utils.getTimer;

	public class VideoArea extends Sprite
	{
		private var _ms:MaskSp;
		private var _downTime:Number;
		
		public function VideoArea()
		{
			if(stage)init();
			else this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(evt:Event=null):void
		{
			var camera:Camera = Camera.getCamera();
			if(camera!=null)
			{
				camera.setMode(Config.CAMERA_WIDTH/2,Config.CAMERA_HEIGHT/2,60);
				camera.setQuality(0,100);
				camera.addEventListener(ActivityEvent.ACTIVITY,activityHandler);
				var video:Video = new Video(camera.width*2,camera.height*2);
				video.attachCamera(camera);
				addChild(video);     
				
				_ms = new MaskSp();
				_ms.scaleX = _ms.scaleY = Config.CAMERA_WIDTH / 400;
				_ms.gotoAndStop(1);
				addChild(_ms);
				
				video.mask = _ms;
			}
			else
			{
				trace("机器上没有安装摄像头！");
				var tf:TextField = new TextField();
				addChild(tf);
				tf.textColor = 0xff0000;
				tf.text = "机器上未检测到可用摄像头";
			}
			
			this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
			this.addEventListener(MouseEvent.CLICK,onClickHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUpHandler);
		}
		
		protected function onClickHandler(event:MouseEvent):void
		{
			if(getTimer() - _downTime > 300)return;
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