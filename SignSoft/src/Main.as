package
{
	import data.Config;
	import data.ShareObjectManager;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.ActivityEvent;
	import flash.events.Event;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.printing.PrintJob;
	import flash.printing.PrintJobOptions;
	
	import view.Background;
	import view.BaseButton;
	import view.Brush;
	import view.VideoArea;
	
	[SWF(frameRate="60",width="1024",height="600")]
	public class Main extends Sprite
	{
		
		private var _drawCon:Sprite;
		private var _brush:Brush;
		private var _videoArea:VideoArea;
		
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
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			_drawCon = new Sprite();
			addChild(_drawCon);
			var bg:Background = new Background();
			_drawCon.addChild(bg);
			
			_brush = new Brush();
			_drawCon.addChild(_brush);
			
			_videoArea = new VideoArea();
			_drawCon.addChild(_videoArea);
			
			
			
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
			
			
		}
		
		private function photoClickHandler(target:BaseButton):void
		{
			
		}
		private function signClickHandler(target:BaseButton):void
		{
			
		}
		private function saveClickHandler(target:BaseButton):void
		{
			
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