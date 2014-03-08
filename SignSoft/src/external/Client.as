package external
{
	import com.adobe.serialization.json.JSONII;
	
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
			_conn.allowDomain("localhost");
			_conn.allowInsecureDomain("localhost");
			_conn.addEventListener(StatusEvent.STATUS,onStatus);
//			try 
//			{
//				_conn.connect(Config.CONN_NAME);
//			} catch (error:ArgumentError) {
//				trace("不能创建连接，名字已被占用");
//			}
		}
		
		public function sendMessage(data:Object):void
		{
			var content:String = JSONII.encode(data);
			_conn.send(Config.CONN_NAME,"receiveMessage",content);
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