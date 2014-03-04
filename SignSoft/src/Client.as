package
{
	import data.Config;
	
	import flash.display.BitmapData;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	import flash.utils.ByteArray;
	
	public class Client
	{
		private var _conn:LocalConnection;
		
		public function Client()
		{
			super();
			_conn = new LocalConnection();
			_conn.addEventListener(StatusEvent.STATUS,onStatus);
		}
		
		public function send(bd:ByteArray):void
		{
			_conn.send(Config.CONN_NAME,"showImg",bd);
		}
		
		public function sendBD(bd:BitmapData):void
		{
			_conn.send(Config.CONN_NAME,"showBD",bd);
		}
		
		protected function onStatus(event:StatusEvent):void
		{
			switch (event.level) {
				case "status" :
					trace("发送成功");
					break;
				case "error" :
					trace(" 发送失败");
					break;
			}
		}
	}
}