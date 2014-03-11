package view.preview
{
	import data.Config;
	
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
	
	import view.BaseButton;
	
	public class PreviewItemView extends Sprite
	{
		public var bitmapData:BitmapData;
		public var bigPicPath:String;
		
		private var _bm:Bitmap;
		private var _loader:Loader;
		private var _delBtn:BaseButton;	
		private var _preview:Preview;
		
		public function PreviewItemView(preview:Preview)
		{
			super();
			_preview = preview;
			
			_bm = new Bitmap();
			//_bm.scaleX = _bm.scaleY = 320 / 1920;
			_bm.filters = [new GlowFilter(0,1,2,2,100)];
			addChild(_bm);
			
			_delBtn = new BaseButton(Config.CLOSE_IMG,false,0.5);
			_delBtn.clickCallback = delClickBack;
			_delBtn.alpha = 0.4;
			addChild(_delBtn);
			_delBtn.x = 300;
			_delBtn.y = 20;
			_delBtn.visible = false;
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onCompleteHandler);
		}
		
		private function delClickBack(target:BaseButton):void
		{
			_preview.delItem(this);		
		}
		
		public function load(path:String):void
		{
			hideDelBtn();
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
		
		public function showDelBtn():void
		{
			_delBtn.visible = !_delBtn.visible;
		}
		
		public function hideDelBtn():void
		{
			_delBtn.visible = false;
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
			_bm.width = 320;
			_bm.height = 180;
		}
	}
}