package view.brush 
{
	import data.Config;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	import view.Controller;

	/**
	 * 带笔触的书写
	 */
	public class WritingBrush extends BaseBrush
	{
		private var tof:int = 2;//笔触
		private var defaultScale:Number = 0.8;//默认笔触的大小
		private var oldScale:Number;
		private var cx:Number = 0.06;// .02;//粗细变化参数
		private var brushMin:Number = 0.12;//.08;//最细笔触限制
		private var brushAlpha:Number = 0.65;//笔刷浓度
//		private var bf:BlurFilter=new BlurFilter(2,2,1);
		private var bf:BlurFilter=new BlurFilter(6,6,10);
		
		public function WritingBrush(main:IApplication) 
		{
			super(main);
		}
		
		protected override function onEnterFrameHandler(e:Event):Boolean 
		{
			if(!super.onEnterFrameHandler(e))return false;
			
			//为防止鼠标移动速度过快，计算老坐标和新坐标直接的距离，在两个坐标中间填充若干笔触
			const disX:Number=mouseX-oldX;
			const disY:Number=mouseY-oldY;
			const dis:Number = Math.sqrt(disX * disX + disY * disY);
			var scale:Number = (defaultScale - dis * cx) + 0.15;
				//改变笔触的大小,越快越小
//                if (dis > 0.12) { 
			if (dis > 0.06) 
			{
//                    if (scale > 1) scale = 1;
//					else if (scale < brushMin) scale = brushMin;
				if (scale < brushMin) scale = brushMin;
				scale = (oldScale + scale) * 0.5;//0.5
	            }
				const count:int = dis * brushAlpha;
				const scaleBili:Number = (oldScale-scale) / count;
				var brush:MovieClip, i:int;
				for (i=0; i<count; i++) {
					brush = new BrushAsset();
					brush.gotoAndStop(tof);
					brushSp.addChild(brush);
					
					var trans:ColorTransform = new ColorTransform();
					trans.color = Controller.brushColor;
					brush.transform.colorTransform = trans;
					
					//brush.filters = [bf];
					brush.alpha = 0.6;
					brush.scaleX = brush.scaleY = (oldScale-i * scaleBili);
	                 
					brush.x=(disX/count)*(i+1)+oldX;
					brush.y=(disY/count)*(i+1)+oldY;
				}
				oldX = mouseX;
				oldY = mouseY;
//				oldScale = scale - 0.15;
				oldScale = scale;
				bmd.draw(brushSp);
				e["updateAfterEvent"]();
				//删除填充的笔触
				while (brushSp.numChildren>0) {
					brushSp.removeChildAt(0);
			}
			return true;
		}
		protected override function onMouseDownHandler(e:Event):void 
		{
			super.onMouseDownHandler(e);
			if (canNotDraw) 
			{
				oldScale = 1;
				//计算笔触大小
				defaultScale = 2 * (Controller.brushSize / 6) * 2;
				//brushAlpha = 0.3 + (Controller.brushSize / 6) * 0.5;
				brushAlpha = 0.8;
				brushMin = 0.4 + (Controller.brushSize / 6) * 0.3;
				//bf = new BlurFilter(Controller.brushSize,Controller.brushSize,1);
			}
		}

		protected override function onMouseUpHandler(e:Event):void
		{
			super.onMouseUpHandler(e);
			
		}
	}
	
}