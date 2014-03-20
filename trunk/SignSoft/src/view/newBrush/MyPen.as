package view.newBrush
{
	import data.Config;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import view.Controller;
	import view.newBrush.TargetPoint;
	
	public class MyPen extends Sprite
	{
		private var i_mincount:int;
		private var oldpoint:TargetPoint;
		private var old_width:Number;
		private var i_endr:Number;
		private var i_cwidth:Number;
		private var nextpoint:TargetPoint;
		private var i_end:Number;
//		private myImage myimg;
		private var myimg:Bitmap;
		private var i_minwidth:int
		private var n_list:Vector.<TargetPoint>;
		private var pen_color:uint;
		private var bmd:BitmapData;
		
		private var brushCon:Sprite;
		private var bf:BlurFilter=new BlurFilter(2,2,5);
		
		///////////////////////////////////////////
		private var prePos:Point = new Point();
		/**前一个是否该补全*/
		private var isPreDraw:Boolean = false;
		private var preScale:Number = 1;
		private var sizeFactor:Number = 0.02;
		
		public function MyPen()
		{
			this.i_mincount = 4;
			this.oldpoint = null;
			this.i_endr = 0.0;
			this.i_cwidth = 0.0;
			this.nextpoint = null;
			this.i_end = 0.0;
			this.myimg = null;
			this.i_minwidth = Config.SIZE_CHANGE;//7;
			this.n_list = new Vector.<TargetPoint>();
			this.pen_color = 0x000000;
			myimg = new Bitmap(new BitmapData(24,20));
			myimg.width = 40;
			myimg.height = 5;
			brushCon = new Sprite();
			addChild(brushCon);
		}
		
		public function setBmd(bmd:BitmapData):void
		{
			this.bmd = bmd;
		}

		public function getpoint():TargetPoint
		{
			var tagFPOINT:TargetPoint = new TargetPoint();
			tagFPOINT.setx(0);
			tagFPOINT.sety(0);
			tagFPOINT.settime2(0.0);
			tagFPOINT.settime(0.0);
			var tagFPOINT2:TargetPoint = tagFPOINT;
			var num:int = Math.min(this.i_mincount, this.n_list.length);
			var result:TargetPoint;
			if (num == 0)
			{
				result = null;
			}
			else
			{
				for (var i:int = 1; i < num + 1; i++)
				{
					var tagFPOINT3:TargetPoint = this.n_list[this.n_list.length - i];
					tagFPOINT2.setx(tagFPOINT2.getx() + tagFPOINT3.getx());
					tagFPOINT2.sety(tagFPOINT2.gety() + tagFPOINT3.gety());
					tagFPOINT2.settime(tagFPOINT2.gettime() + tagFPOINT3.gettime());
					tagFPOINT2.settime2(tagFPOINT2.gettime2() + tagFPOINT3.gettime2());
				}
				tagFPOINT2.setx(tagFPOINT2.getx() / num);
				tagFPOINT2.sety(tagFPOINT2.gety() / num);
				tagFPOINT2.settime(tagFPOINT2.gettime() / Number(num));
				tagFPOINT2.settime2(tagFPOINT2.gettime2() / Number(num));
				result = tagFPOINT2;
			}
			return result;
		}
		public function setcolor(value:uint):void
		{
			this.pen_color = value;
			//tmp
//			this.myimg.setcolor(this.pen_color);
		}
		public function push(val:TargetPoint):void
		{
			this.n_list.push(val);
		}
		public function drawpen(A_0:Boolean,isFrount:Boolean):void
		{
			var tagFPOINT:TargetPoint = this.getpoint();
			if (tagFPOINT != null)
			{
				if (this.oldpoint == null)
				{
					this.oldpoint = tagFPOINT;
				}
				var val:Number = tagFPOINT.gettime() - this.oldpoint.gettime();
				var num:Number= this.cale_width(tagFPOINT, this.oldpoint);
				var num2:Number = num / Math.max(1.0, val);
				var num3:Number = (this.i_endr == 0.0) ? 0.0 : (num2 / this.i_endr);
				var num4:Number = Number(this.myimg.width) - Math.min(this.myimg.width - this.myimg.height, Math.max(0.0, num2 * 12.0));
				num4 = Math.max(this.myimg.height, this.cale_width2(num2, this.myimg.width, -this.myimg.width - this.myimg.height, this.i_minwidth));
				if (tagFPOINT.gettime2() > 0.0)
				{
					num4 = Math.max(this.myimg.height, this.myimg.width * tagFPOINT.gettime2());
				}
				tagFPOINT.settime3(num4);
				this.draw_pen(this.oldpoint, tagFPOINT, num4, num,isFrount);
				this.i_end = num3;
				this.nextpoint = this.cale_point(this.oldpoint, tagFPOINT, 1.0 + this.i_end);
				this.oldpoint = tagFPOINT;
				this.old_width = num4;
				this.i_endr = num2;
				this.i_cwidth = num;
			}
		}
		public function cale_width(val:TargetPoint, val2:TargetPoint):Number
		{
			var num:int = (val2.getx() - val.getx()) * (val2.getx() - val.getx()) + (val2.gety() - val.gety()) * (val2.gety() - val.gety());
			return (num == 0) ? (num) : Math.sqrt(num);
		}
		private function cale_point(val:TargetPoint,val2:TargetPoint,A_2:Number):TargetPoint
		{
			var tagFPOINT:TargetPoint = new TargetPoint();
			var num:Number = val.getx() + (val2.getx() - val.getx()) * A_2;
			var num2:Number = val.gety() + (val2.gety() - val.gety()) * A_2;
			tagFPOINT.setx(int(num));
			tagFPOINT.sety(int(num2));
			return tagFPOINT;
		}
		
		private function draw_pen(A_0:TargetPoint,A_1:TargetPoint, A_2:Number, A_3:Number,isFround:Boolean):void
		{
			var num:Number = 0.0;
			var num2:Number = A_2 - this.old_width;
			
			var scale:Number;
			var brush:BrushAsset;
			var len:int = Math.ceil(A_3);
			var i:int;
			for (i = 0; i < len; i++) 
			{
				var num3:Number = Math.min(this.old_width + num2 * num, this.myimg.width);
				if(num3 > 0)
				{
					var tagFPOINT:TargetPoint = this.cale_point(A_0, A_1, num);
					var num4:int = ((Math.random() > 0.5) ? 1 : -1) * int(Math.random() * 1.2);
					var num5:Number = tagFPOINT.getx() - num3 / 2.0 + num4;
					var num6:Number = tagFPOINT.gety() - num3 / 2.0 + num4;
					
					var minScale:Number = 0.15;
					if(isFround)minScale = Config.FIRST_MIN_SCALE;
					scale = num3 / myimg.width;
					scale = Math.max(minScale,scale);
					scale *= (Controller.brushSize / 6) * 3;
					
					brush = new BrushAsset();
					brush.gotoAndStop(2);
					brush.filters = [bf];
					brushCon.addChild(brush);
					
					var trans:ColorTransform = new ColorTransform();
					trans.color = Controller.brushColor;
					brush.transform.colorTransform = trans;
					brush.scaleX = brush.scaleY = scale;
					
					brush.x= num5 + 15;
					brush.y= num6 + 15;
				}
				
				num += 1.0 / A_3;
			}
			
			if(isPreDraw)
			{
				drawPre();	
			}
			isPreDraw = false;
			
			//trace("delta:",Math.abs(preScale - scale),"--------------",preScale,scale);
			//差距太大，补笔
			if(Math.abs(preScale - scale) > 0.2)
			{
				//isPreDraw = true; 
				//drawPre();
			}
			
			function drawPre():void
			{
				trace("drawPew::::::::::::::::::::::::::::::::::::::::::::::");
				len = 100
				for (i = 1; i < len; i++)
				{
					brush = new BrushAsset();
					brush.gotoAndStop(3);
					brush.filters = [bf];
					brush.alpha = 0.3;
					brushCon.addChild(brush);
					
					var trans:ColorTransform = new ColorTransform();
					trans.color = Controller.brushColor;
//					trans.color = 0xff0000;
					brush.transform.colorTransform = trans;
					brush.scaleX = brush.scaleY = scale;
					
					brush.x= prePos.x + (A_0.getx() - prePos.x) * i / len;
					brush.y= prePos.y + (A_0.gety() - prePos.y) * i / len;
				}
			}
			
			prePos.x = A_0.getx();
			prePos.y = A_0.gety();
			preScale = scale;
				
			bmd.draw(brushCon);
			while (brushCon.numChildren>0) { brushCon.removeChildAt(0); }
		}
		
		private function cale_width2(A_0:Number,A_1:int, A_2:int, A_3:int):Number
		{
			return A_2 * A_0 / A_3 + A_1;
		}
		
//		public function getimg(Image img, Color A_1, int A_2, int A_3):Image
//		{
//			return img;
//		}
		
		public function drawstart():void
		{
			this.n_list = new Vector.<TargetPoint>();
			this.oldpoint = null;
			this.old_width = 0.0;
			this.i_endr = 0.0;
			this.i_cwidth = 0.0;
			this.nextpoint = null;
			this.i_end = 0.0;
			
			this.preScale = 1.0;
			prePos.x = stage.mouseX;
			prePos.y = stage.mouseY;
			isPreDraw = false;
		}
		
		public function drawend():void
		{
			isPreDraw = false;
			if (this.i_end > 1.0)
			{
				var tagFPOINT:TargetPoint = new TargetPoint();
				tagFPOINT.setx(this.nextpoint.getx());
				tagFPOINT.sety(this.nextpoint.gety());
				tagFPOINT.settime(this.i_end / (this.i_cwidth * this.i_endr) + this.oldpoint.gettime());
				tagFPOINT.settime2(this.oldpoint.gettime2() * Math.min((this.i_end / (this.i_cwidth * this.i_endr), 1.0)));
				var item:TargetPoint = tagFPOINT;
				var i:int = 0;
				var num:int = this.i_mincount;
				while (i < num)
				{
					this.n_list.push(item);
					i++;
				}
				this.drawpen(true,false);
			}
		}
	}
}