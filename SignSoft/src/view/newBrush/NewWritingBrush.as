package view.newBrush
{
	import data.Config;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.utils.getTimer;
	
	import view.Controller;
	import view.brush.BaseBrush;
	
	public class NewWritingBrush extends BaseBrush
	{
		private var i_time:int;
		private var b_down:Boolean;
		private var g:Graphics;
//		private Image img;
		private var img:BitmapData;
		private var bmp:Bitmap;
		private var myPen:MyPen;
		private var components:Sprite;
		private var pic:Sprite;
		
		private var _downCount:int = 0;
		
		public function NewWritingBrush(main:IApplication)
		{
			super(main);
			b_down = false;
		}
		
		override protected function init(evt:Event=null):void
		{
			super.init(evt);
			pic = new Sprite();
			addChild(pic);
			
			components = new Sprite();
			addChild(components);
			
//			this.bmp = new Bitmap(1024,768);
//			this.g = Graphics.FromImage(this.bmp);
//			this.img = Image.FromFile(Environment.CurrentDirectory + ebjl5iduDGjiB8jAyt.eh1msj65w(20));
//			this.pic.Image = this.bmp;
			this.myPen = new MyPen();
			addChild(myPen);
			myPen.setBmd(bmd);
		}
		
		override public function clear():void
		{
			super.clear();
			myPen.setBmd(bmd);
		}
		
		protected override function onEnterFrameHandler(e:Event):Boolean 
		{
			if(!super.onEnterFrameHandler(e))return false;
			if (this.b_down)
			{
				_downCount ++;
				
				var tagFPOINT:TargetPoint = new TargetPoint();
				tagFPOINT.setx(stage.mouseX);
				tagFPOINT.sety(stage.mouseY);
				tagFPOINT.settime((getTimer() - this.i_time));
				var val:TargetPoint = tagFPOINT;
				this.myPen.push(val);
				this.myPen.drawpen(true,_downCount <= Config.FIRST_DELAY);
//				this.pic.Image = this.bmp;
			}
			if(e && e.hasOwnProperty("updateAfterEvent"))e["updateAfterEvent"]();
			return true;
		}
		protected override function onMouseDownHandler(e:Event):void 
		{
			super.onMouseDownHandler(e);
			_downCount = 0;
			this.b_down = true;
			this.i_time = getTimer();
			this.myPen.drawstart();
		}
		
		protected override function onMouseUpHandler(e:Event):void
		{
			super.onMouseUpHandler(e);
			if(b_down)
			{
				this.myPen.drawend();	
			}
			this.b_down = false;
		}
	}
}