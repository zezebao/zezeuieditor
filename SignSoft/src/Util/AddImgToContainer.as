package Util
{
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class AddImgToContainer
	{
		public var container:DisplayObjectContainer;
		public var url:String;
		
		private var _loader:Loader;
		
		public function AddImgToContainer(url:String,con:DisplayObjectContainer)
		{
			this.url = url;
			this.container = con;
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onCompleteHandler);
			_loader.load(new URLRequest(url));
		}
		
		protected function onCompleteHandler(event:Event):void
		{
			container.addChild(_loader.content);
		}
	}
}