package view.brush 
{
	import data.Config;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	
	import view.Controller;

	/**
	 * 带笔触的书写
	 */
	public class WritingBrushII extends BaseBrush
	{
		private var tof:int = 2;//笔触
		private var defaultScale:Number = 0.8;//默认笔触的大小
		private var oldScale:Number;
		private var cx:Number = 0.06;// .02;//粗细变化参数
		private var brushMin:Number = 0.12;//.08;//最细笔触限制
		private var brushAlpha:Number = 0.65;//笔刷浓度
		private var bf:BlurFilter=new BlurFilter(2,2,1);
		
		public function WritingBrushII(main:IApplication) 
		{
			super(main);
		}
		
		protected override function onEnterFrameHandler(e:Event):Boolean 
		{
			if (! isDown)
				return false; 
			
			if(Controller.brushType == 4)
			{
				_main.erase();
				return false;
			}
			if (isNaN(oldX)) return false;
			moveSpeed.x = mouseX - oldX;
			moveSpeed.y = mouseY - oldY;
			
			//为防止鼠标移动速度过快，计算老坐标和新坐标直接的距离，在两个坐标中间填充若干笔触
			const disX:Number=mouseX-oldX;
			const disY:Number=mouseY-oldY;
			const dis:Number = Math.sqrt(disX * disX + disY * disY) * 1;
			
			var scale:Number = (defaultScale - dis * cx * 0.5) + 0.45;
				//改变笔触的大小,越快越小
//			if (dis > 0.06)
			if (1)
			{
//                    if (scale > 1) scale = 1;
//					else if (scale < brushMin) scale = brushMin;
				if (scale < brushMin) scale = brushMin;
				scale = (oldScale + scale) * 0.4;//0.5
	            
				var count:int = dis * brushAlpha;
				const scaleBili:Number = (oldScale-scale) / count;
				var brush:MovieClip, i:int;
				for (i=0; i<count; i++) {
					brush = new BrushAsset();
					brush.gotoAndStop(tof);
					brushSp.addChild(brush);
					
					var trans:ColorTransform = new ColorTransform();
					trans.color = Controller.brushColor;
					brush.transform.colorTransform = trans;
					
					brush.filters = [bf];
					brush.alpha = 0.5;
					brush.scaleX = brush.scaleY = (oldScale - i * scaleBili);
	                
					brush.x=(disX/count)*(i+1)+oldX;
					brush.y=(disY/count)*(i+1)+oldY;
				}
				oldX = mouseX;
				oldY = mouseY;
				oldScale = scale;
				bmd.draw(brushSp);
				if(e && e.hasOwnProperty("updateAfterEvent"))e["updateAfterEvent"]();
				//删除填充的笔触
				while (brushSp.numChildren>0) { brushSp.removeChildAt(0); }
			}
			return true;
		}
		protected override function onMouseDownHandler(e:Event):void 
		{
			if (canNotDraw) 
			{
				if(Config.USE_TOUCH)
				{
					stage.addEventListener(TouchEvent.TOUCH_MOVE, onEnterFrameHandler);	
				}else
				{
					stage.addEventListener(MouseEvent.MOUSE_MOVE, onEnterFrameHandler);	
				}
//				this.addEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
				isDown = true;
				oldX = mouseX;
				oldY = mouseY;
				moveSpeed.x = moveSpeed.y = 0;
				
				/////////////////////////////////
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
			if(Config.USE_TOUCH)
			{
				stage.removeEventListener(TouchEvent.TOUCH_MOVE, onEnterFrameHandler);	
			}else
			{
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, onEnterFrameHandler);	
			}
			this.removeEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
			
			var count:int = 100;
			var scale:Number = 0.03;
			var max:Number = 80;
			
			var disX:Number = moveSpeed.x * 5;
			var disY:Number = moveSpeed.y * 5;
			if(Math.abs(disX) > max) disX = (disX > 0) ? max : -max;
			if(Math.abs(disY) > max) disY = (disY > 0) ? max : -max;
			trace("upSpeed,",moveSpeed);
			
			const scaleBili:Number = (oldScale-scale) / count;
			var brush:MovieClip, i:int;
			for (i=0; i<count; i++) {
				brush = new BrushAsset();
				brush.gotoAndStop(tof);
				brushSp.addChild(brush);
				
				var trans:ColorTransform = new ColorTransform();
				trans.color = Controller.brushColor;
				brush.transform.colorTransform = trans;
				
				brush.alpha = 0.5;
				brush.scaleX = brush.scaleY = (oldScale - i * scaleBili);
				
				brush.x=(disX/count)*(i+1)+oldX;
				brush.y=(disY/count)*(i+1)+oldY;
			}
			bmd.draw(brushSp);
			while (brushSp.numChildren>0) { brushSp.removeChildAt(0); }
			
			
			isDown = false;
			oldX = NaN;
			stopDrag();
		}
	}
	
}