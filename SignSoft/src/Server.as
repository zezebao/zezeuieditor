package 
{
	import com.adobe.images.JPGEncoder;
	
	import data.Config;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.LocalConnection;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	
	public class Server extends MovieClip
	{
		private var conn:LocalConnection;
		private var _bm:Bitmap;
		private var _loader:Loader = new Loader();
		
		public function Server()
		{
			stage.scaleMode = StageScaleMode.NO_BORDER;
			stage.align = StageAlign.TOP_LEFT;
			
			conn = new LocalConnection();
			conn.client=this;
			try {
				conn.connect(Config.CONN_NAME);
			} catch (error:ArgumentError) {
				trace("不能创建连接，名字已被占用");
				var tf:TextField = new TextField();
				tf.wordWrap = true;
				addChild(tf);
				tf.text = "不能创建连接，名字已被占用,重启两个软件重新打开"; 
			}
			trace("connected");
			
			_bm = new Bitmap();
			addChild(_bm);
			
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onCompleteHandler);
		}
		
		protected function onCompleteHandler(event:Event):void
		{
			var bm:Bitmap = _loader.content as Bitmap;
			trace(bm.width,bm.height);
			if(bm == null)return;
			_bm.bitmapData = bm.bitmapData;			
		}
		
		public function showImg(imgByteArray:ByteArray):void
		{
			_loader.loadBytes(imgByteArray);			
		}
		
		public function showBD(bd:BitmapData):void
		{
//			_bm.bitmapData = bd;
		}
	}
}