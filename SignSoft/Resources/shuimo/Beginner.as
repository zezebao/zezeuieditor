package {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	public class Beginner extends Sprite {
		/**          * Overwrite this update function.          * Every frame the function is invoked with two bitmaps.          * First one contains reference to the stage bitmap.          * Second one contains static copy of stage.          */
		public var canvas:BitmapData;
		public var drawHere:BitmapData;
		public var mat:Matrix;
		private const FADE:ColorTransform=new ColorTransform(1,1,1,1,2,2,2,0);
		private const BLUR:BlurFilter=new BlurFilter(2,2,BitmapFilterQuality.LOW);
		private var ballCanvas:Shape=new Shape  ;
		private var radian:Number=0;
		private var ballBuideX:Number=240;
		private var ballBuideY:Number=240;
		private var vX:Number=0;
		private var vY:Number=0;
		private const SPRING:Number=0.012;
		private const FRICTION:Number=0.89;
		private var hFlg:Number=0;
		public function update():void {
			hFlg=- stage.mouseX-240/240;
			fadeStep();
			drawStep();
			transformStep();
			renderStep();
		}
		public function drawStep():void {
			calcPoint();
			drawBall();
			drawHere.draw(ballCanvas);
		}
		private function calcPoint():void {
			var nowX:Number=stage.mouseX;
			var nowY:Number=stage.mouseY;
			vX+=((nowX-ballBuideX)*SPRING);
			vY+=((nowY-ballBuideY)*SPRING);
			vX*=FRICTION;
			vY*=FRICTION;
			ballBuideX+=vX;
			ballBuideY+=vY;
		}
		private function drawBall():void {
			var radiusOffset:Number=Math.sqrt(((vX*vX)+vY*vY));
			var radius:Number=Math.min(40,360/radiusOffset);
			ballCanvas.graphics.clear();
			ballCanvas.graphics.beginFill(0x000000);
			ballCanvas.graphics.drawCircle(ballBuideX,ballBuideY,radius);
			ballCanvas.graphics.endFill();
		}
		public function transformStep():void {
			mat=new Matrix  ;
			mat.translate(-240,-240);
			mat.scale(1.005,1.005);
			mat.rotate(Math.PI/180*hFlg);
			mat.translate(240,240);
		}
		public function renderStep():void {
			canvas.draw(drawHere,mat);
		}
		public function fadeStep():void {
			drawHere.colorTransform(drawHere.rect,FADE);
			drawHere.applyFilter(drawHere,drawHere.rect,new Point  ,BLUR);
		}
		/**          * ---------------------------------------          * DO NOT CHANGE FOLLOWING CODES          * DO NOT ACCESS FOLLOWING PROPERTIES DIRECTLY          * ---------------------------------------         */
		private var bitmap:Bitmap;
		public function Beginner() {
			canvas=new BitmapData(480,480,false,0x000000);
			bitmap=new Bitmap(canvas);
			addChild(bitmap);
			addEventListener(Event.ENTER_FRAME,_update);
		}
		public function _update(e:Event):void {
			if (drawHere) {
				drawHere.dispose();
			}
			drawHere=canvas.clone();
			update();
		}
	}
}