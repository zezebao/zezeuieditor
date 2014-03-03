package
{
	import data.Config;
	import data.ShareObjectManager;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import view.Background;
	import view.BaseButton;
	
	[SWF(frameRate="60",width="1024",height="600")]
	public class Main extends Sprite
	{
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
			
			var bg:Background = new Background();
			addChild(bg);
			
			var btn:BaseButton;
			btn = new BaseButton(Config.POS_PHOTO);
			addChild(btn);
			btn = new BaseButton(Config.POS_SAVE);
			addChild(btn);
			btn = new BaseButton(Config.POS_SIGN);
			addChild(btn);
			btn = new BaseButton(Config.POS_PREVIEW);
			addChild(btn);
			btn = new BaseButton(Config.POS_PRINT);
			addChild(btn);
		}
	}
}