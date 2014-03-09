package
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.LocalConnection;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.text.TextField;
	
	[SWF(width="1920",height="1080")]
	public class SignSoftClient extends Sprite
	{
		private var _loader:Loader;
		private var _bitmap:Bitmap;
		
		private var conn:LocalConnection;
		public function SignSoftClient()
		{
			conn = new LocalConnection();
			conn.allowDomain("*");
			conn.client=this;
			try {
				conn.connect("_signSoftConnect");
			} catch (error:ArgumentError) {
				trace("不能创建连接，名字已被占用");
				var tf:TextField = new TextField();
				tf.wordWrap = true;
				addChild(tf);
				tf.text = "不能创建连接，名字已被占用,重启两个软件重新打开"; 
			}
			trace("connected");
			
			if(stage)init();
			else this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(evt:Event=null):void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.EXACT_FIT;
			
			_bitmap = new Bitmap();
			addChild(_bitmap);
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onCompleteHandler);
			stage.addEventListener(Event.RESIZE,onResizeHandler);
			stage.doubleClickEnabled = true;
			stage.addEventListener(MouseEvent.DOUBLE_CLICK,onDoubleClickHandler);
		}
		
		protected function onDoubleClickHandler(event:MouseEvent):void
		{
			if(stage.displayState == StageDisplayState.NORMAL)
			{
				stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;			
			}else
			{
				stage.displayState = StageDisplayState.NORMAL;
			}
		}
		
		protected function onResizeHandler(event:Event=null):void
		{
			if(_bitmap.width > 0 && _bitmap.height > 0)
			{
				var scale:Number;
				if(_bitmap.width / _bitmap.height > stage.stageWidth / stage.stageHeight)
				{
					scale = stage.stageHeight / _bitmap.height;
					_bitmap.height = stage.stageHeight;
					_bitmap.width = _bitmap.width * scale;
				}else
				{
					scale = stage.stageWidth / _bitmap.width;
					_bitmap.width = stage.stageWidth;
					_bitmap.height = _bitmap.height * scale;
				}
			}
		}
		
		public function receiveMessage(content:String):void
		{
			var data:Object = JSON.parse(content);
			if(data.hasOwnProperty("path"))
			{
				_loader.load(new URLRequest(String(data["path"])));
			}
		}
		
		protected function onCompleteHandler(event:Event):void
		{
			var bm:Bitmap = _loader.content as Bitmap;
			_bitmap.bitmapData = bm.bitmapData;
			onResizeHandler();
		}
	}
}