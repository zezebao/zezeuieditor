package external 
{
	import com.adobe.serialization.json.JSONII;
	
	import data.Config;
	
	import flash.display.Sprite;
	import flash.net.LocalConnection;
	import flash.system.Security;
	import flash.text.TextField;

	public class Server extends Sprite
	{
		private var conn:LocalConnection;
		
		public function Server()
		{
			Security.allowDomain("*");
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
		}
		var count:int = 0;
		public function receiveMessage(content:String):void
		{
			var data:Object = JSONII.decode(content);
			switch(data["type"])
			{
				case ProtocolType.MOUSE_MOVE:
					count ++;
//					data;
					trace("receive",count);
					break;
			}
		}
		
	}
}