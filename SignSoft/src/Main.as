package
{
	
	import com.adobe.images.JPGEncoder;
	
	import data.Config;
	import data.ShareObjectManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.ActivityEvent;
	import flash.events.Event;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.net.FileReference;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.printing.PrintJob;
	import flash.printing.PrintJobOptions;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	
	import view.Background;
	import view.BaseButton;
	import view.Brush;
	import view.BrushPen;
	import view.Canvas;
	import view.Controller;
	import view.VideoArea;
	
	[SWF(frameRate="60",width="1920",height="1080")]
	public class Main extends Sprite
	{
		
		private var _drawCon:Sprite;
		private var _brush:Brush;
		private var _videoArea:VideoArea;
		private var _controller:Controller;
		private var _client:Client = new Client();
		
		public function Main()
		{
			ShareObjectManager.getInstance();
			loadConfig();
		}
		
		private function loadConfig():void
		{
			var configLoader:URLLoader = new URLLoader();
			configLoader.addEventListener(Event.COMPLETE,onCompleteHandler);
			configLoader.load(new URLRequest("Config.xml"));
		}
		
		protected function onCompleteHandler(event:Event):void
		{
			var xml:XML = XML((event.target as URLLoader).data);
			Config.initConfig(xml);
			
			initView();
		}
		
		private function initView():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_BORDER;
			
			_drawCon = new Sprite();
			addChild(_drawCon);
			var bg:Background = new Background();
			_drawCon.addChild(bg);
			
			_drawCon.addChild(Canvas.bitmap);
			
			_brush = new Brush();
			_drawCon.addChild(_brush);
			_brush.mouseEnabled = _brush.mouseChildren = false;
			
//			var tmp:BrushPen = new BrushPen();
//			addChild(tmp);
			
			_videoArea = new VideoArea();
			_drawCon.addChild(_videoArea);
			_videoArea.hide();
			
			_controller = new Controller();
			addChild(_controller);
			_controller.visible = false;
			
			var btn:BaseButton;
			btn = new BaseButton(Config.POS_PHOTO);
			btn.clickCallback = photoClickHandler;
			addChild(btn);
			btn = new BaseButton(Config.POS_SAVE);
			btn.clickCallback = saveClickHandler;
			addChild(btn);
			btn = new BaseButton(Config.POS_SIGN);
			btn.clickCallback = signClickHandler;
			addChild(btn);
			btn = new BaseButton(Config.POS_PREVIEW);
			btn.clickCallback = previewClickHandler;
			addChild(btn);
			btn = new BaseButton(Config.POS_PRINT);
			btn.clickCallback = printClickHandler;
			addChild(btn);
			
			
			this.addEventListener(Event.ENTER_FRAME,onETHandler);
			
			var tf:TextField = new TextField();
			tf.defaultTextFormat = new TextFormat("",50);
			tf.width = 1000;
			_drawCon.addChild(tf);
			tf.mouseEnabled = tf.mouseWheelEnabled = false;
			tf.text = "制作中........";
		}
			
		protected var count:int = 0;
		
		protected function onETHandler(event:Event):void
		{
			/*
			count ++;
			if(count % 50 == 0)
			{
				var jpgenc:JPGEncoder = new JPGEncoder(80);
				var bmd:BitmapData = new BitmapData(300,300);
				bmd.draw(_drawCon);
				var imgByteArray:ByteArray = jpgenc.encode(bmd);
				_client.send(imgByteArray);
//				_client.sendBD(bmd);
			}
			*/
		}
		
		private function photoClickHandler(target:BaseButton):void
		{
			_videoArea.show();
		}
		private function signClickHandler(target:BaseButton):void
		{
			_controller.visible = !_controller.visible;
			_brush.mouseEnabled = _brush.mouseChildren = _controller.visible;
		}
		private function saveClickHandler(target:BaseButton):void
		{
			var jpgenc:JPGEncoder = new JPGEncoder(80);
			var bmd:BitmapData = new BitmapData(1920,1080);
			bmd.draw(_drawCon);
			var imgByteArray:ByteArray = jpgenc.encode(bmd);
			var file:FileReference = new FileReference();
			file.save(imgByteArray,"test.jpg");
			imgByteArray.clear();
		}
		private function previewClickHandler(target:BaseButton):void
		{
			
		}
		private function printClickHandler(target:BaseButton):void
		{
			var myPrintJob:PrintJob = new PrintJob(); 
			var options:PrintJobOptions = new PrintJobOptions(); 
			options.printAsBitmap = true; 
			myPrintJob.start();
			try { 
				if (myPrintJob.start()) {
					myPrintJob.addPage(_drawCon, null, options); 
				}
			}
			catch(e:Error) { 
				trace ("Had problem adding the page to print job: " + e); 
			}
			try {
				myPrintJob.send()();
			} 
			catch (e:Error) { 
				trace ("Had problem printing: " + e);
			} 
		}
	}
}