package view.preview
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.filters.GlowFilter;
	import flash.utils.ByteArray;
	
	public class PreviewItemView extends Sprite
	{
		public var bitmapData:BitmapData;
		private var _bm:Bitmap;
		private var _loader:Loader;
		public var bigPicPath:String;
		
		public function PreviewItemView()
		{
			super();
			_bm = new Bitmap();
			_bm.scaleX = _bm.scaleY = 0.2;
			_bm.filters = [new GlowFilter(0xffffff,1,20,20,100)];
			addChild(_bm);
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onCompleteHandler);
		}
		
		public function load(path:String):void
		{
			bigPicPath = path.replace("small","big");
			var file:File = new File(path);
			if(file.exists)
			{
				var fileStream:FileStream = new FileStream();
				fileStream.open(file,FileMode.READ);
				var bytes:ByteArray = new ByteArray();
				fileStream.readBytes(bytes);
				_loader.loadBytes(bytes);
			}
		}
		
		public function clear():void
		{
			_bm.bitmapData = null;
			bigPicPath = "";
		}
		
		protected function onCompleteHandler(event:Event):void
		{
			var bm:Bitmap = _loader.content as Bitmap;			
			bitmapData = bm.bitmapData;
			_bm.bitmapData = bitmapData;
		}
	}
}