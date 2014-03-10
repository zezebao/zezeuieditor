package
{
	import Util.Utils;
	
	import com.adobe.images.JPGEncoder;
	
	import data.Config;
	import data.MyEvent;
	
	import external.Client;
	import external.ProtocolType;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.ActivityEvent;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Point;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.net.FileReference;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.printing.PrintJob;
	import flash.printing.PrintJobOptions;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	
	import view.Background;
	import view.BaseButton;
	import view.Canvas;
	import view.Controller;
	import view.VideoArea;
	import view.brush.BaseBrush;
	import view.brush.BrushPen;
	import view.brush.BrushPencil;
	import view.brush.WritingBrush;
	import view.preview.Preview;
	
	[SWF(frameRate="60",width="1920",height="1080")]
	public class SignSoft extends Sprite implements IApplication
	{
		protected var _drawCon:Sprite;
		protected var _brushs:Vector.<BaseBrush> = new Vector.<BaseBrush>();
		protected var _videoArea:VideoArea;
		protected var _controller:Controller;
		protected var _preview:Preview;
		
		private var _tipLabel:TextField;
		private var _tipCount:int;
		
		public function SignSoft()
		{
			Utils.client = new Client();
			loadConfig();
		}
		
		private function loadConfig():void
		{
			var configLoader:URLLoader = new URLLoader();
			configLoader.addEventListener(Event.COMPLETE,onCompleteHandler);
			configLoader.load(new URLRequest("Config.xml"));
			
			var loader:Loader = new Loader();
			loader.load(new URLRequest("images/mask.swf"),new LoaderContext(false,ApplicationDomain.currentDomain));
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
			stage.scaleMode = StageScaleMode.EXACT_FIT;
			
			stage.nativeWindow.width = Config.SCREEN_WIDTH;
//			stage.nativeWindow.height = 500;
			
//			stage.stageWidth = 500;
			stage.stageHeight = Config.SCREEN_HEIGHT;
			
			_drawCon = new Sprite();
			addChild(_drawCon);
			var bg:Background = new Background();
			_drawCon.addChild(bg);
			
			_drawCon.addChild(Canvas.bitmap);
			
			_brushs.push(null);
			var brush:BaseBrush;
			brush= new WritingBrush(this);
			_brushs.push(brush);
			brush = new BrushPen(this);
			_brushs.push(brush);
			brush = new BrushPencil(this);
			_brushs.push(brush);
			
			for (var i:int = 0; i < _brushs.length; i++) 
			{
				if(_brushs[i])
				{
					_drawCon.addChild(_brushs[i]);
					_brushs[i].mouseChildren = _brushs[i].mouseEnabled = false;
				}
			}
			
			_controller = new Controller(this);
			addChild(_controller);
			_controller.visible = false;
			_controller.x = Config.defaultPos[Config.POS_CONTROLLER].x;
			_controller.y = Config.defaultPos[Config.POS_CONTROLLER].y;
			
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
			
			btn = new BaseButton(Config.REPLACE_IMG,false);
			btn.clickCallback = replaceHandler;
			btn.x = 130;
			btn.y = Config.SCREEN_HEIGHT - 50;
//			addChild(btn);
			
			_tipLabel = new TextField();
			_tipLabel.defaultTextFormat = new TextFormat("微软雅黑",80);
			_tipLabel.width = 1000;
			_tipLabel.mouseEnabled = _tipLabel.mouseWheelEnabled = false;
			addChild(_tipLabel);
			
			this.addEventListener(Event.ENTER_FRAME,onETHandler);
			
			var tf:TextField = new TextField();
			tf.defaultTextFormat = new TextFormat("",50);
			tf.width = 1000;
			_drawCon.addChild(tf);
			tf.mouseEnabled = tf.mouseWheelEnabled = false;
			tf.text = "制作中........";
		}
		
		private function replaceHandler(target:BaseButton):void
		{
			Utils.dispath(new MyEvent(MyEvent.REPLACE));
		}
		
		protected var count:int = 0;
		
		protected function onETHandler(event:Event):void
		{
			count ++;
			if(count % 50 == 0)
			{
				//Utils.client.sendMessage(ProtocolType.MOUSE_MOVE,new Point(stage.mouseX,stage.mouseY));
			}
		}
		
		private function photoClickHandler(target:BaseButton):void
		{
			if(_videoArea == null)
			{
				_videoArea = new VideoArea();
				_drawCon.addChild(_videoArea);
				_videoArea.x = Config.CAMERA_X;
				_videoArea.y = Config.CAMERA_Y;
				_videoArea.show();
			}else
			{
				_videoArea.dispose();
				_videoArea = null;
			}
			
//			_videoArea.show();
		}
		private function signClickHandler(target:BaseButton):void
		{
			_controller.visible = !_controller.visible;
			changeType();
		}
		
		public function reset():void
		{
			if(_videoArea)_videoArea.hide();
			clear();
		}
		
		public function clear():void
		{
			for (var i:int = 0; i < _brushs.length; i++) 
			{
				if(_brushs[i])
				{
					_brushs[i].clear();
				}
			}
		}
		
		public function erase():void
		{
			for (var i:int = 0; i < _brushs.length; i++) 
			{
				if(_brushs[i])
				{
					_brushs[i].erase();
				}
			}
		}
		
		public function changeType():void
		{
			for (var i:int = 0; i < _brushs.length; i++) 
			{
				if(_brushs[i])
				{
					_brushs[i].mouseChildren = _brushs[i].mouseEnabled = false;
				}
			}
			if(Controller.brushType != 4)
			{
				_brushs[Controller.brushType].mouseChildren = _brushs[Controller.brushType].mouseEnabled = _controller.visible; 
			}else
			{
				_brushs[3].mouseChildren = _brushs[3].mouseEnabled = true;
			}
		}
		
		private function saveClickHandler(target:BaseButton):void
		{
			_tipCount = 0;
			_tipLabel.x = Config.SCREEN_WIDTH/2 - 100;
			_tipLabel.y = Config.SCREEN_HEIGHT/2;
			_tipLabel.text = "保存中...";
			this.addEventListener(Event.ENTER_FRAME,drawFrame);
		}
		
		protected function drawFrame(event:Event):void
		{
			if(_tipCount == 5)
			{
				var jpgenc:JPGEncoder = new JPGEncoder(80);
				var bmd:BitmapData = new BitmapData(1920,1080);
				bmd.draw(_drawCon);
				var imgByteArray:ByteArray = jpgenc.encode(bmd);
				
//				var smallBmd:BitmapData = Util.Util.scaleBitmapData(bmd,0.2,0.2);
//				var smallImgByteArray:ByteArray = jpgenc.encode(smallBmd);
				var date:Date = new Date();
				var picName:String = date.fullYear.toString() + "_" + (date.month + 1).toString() 
					+ "_" + date.date.toString() + "_" + date.hours.toString() 
					+ "_" + date.minutes.toString() + "_" + date.seconds.toString();
				
				var path:String = File.applicationDirectory.nativePath + "/output/" + picName + ".jpg";
				savePic(path,imgByteArray)
//				savePic(File.applicationDirectory.nativePath + "/output/big/" + picName + ".jpg",imgByteArray)
//				savePic(File.applicationDirectory.nativePath + "/output/small/" + picName + ".jpg",smallImgByteArray)
				
				_tipLabel.text = "保存成功";
				
				Utils.client.sendMessage({"path":path});
				//重置画布
				reset();
			}
			_tipCount ++;
			if(_tipCount >= 50)
			{
				_tipLabel.text = "";
				this.removeEventListener(Event.ENTER_FRAME,drawFrame);	
			}
		}
		
		private function savePic(path:String,data:ByteArray):void
		{
			var fl:File = new File(path);
			var fs:FileStream = new FileStream();
			try{
				fs.open(fl,FileMode.WRITE);
				fs.writeBytes(data);
				fs.close();
			}catch(e:Error){
				trace(e.message);
				return;
			}
		}
		
		private function previewClickHandler(target:BaseButton):void
		{
			if(_preview == null)
			{
				_preview = new Preview();
			}
			addChild(_preview);
			reset();
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