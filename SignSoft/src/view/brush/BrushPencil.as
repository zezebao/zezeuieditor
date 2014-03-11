package view.brush 
{
	import flash.events.Event;
	
	import view.Controller;

	/**
	 * 带笔触的书写
	 */
	public class BrushPencil extends BaseBrush
	{
		public function BrushPencil(main:IApplication) 
		{
			super(main);
		}
		
		override protected  function onEnterFrameHandler(e:Event):Boolean 
		{
			if(!super.onEnterFrameHandler(e))return false;
			
			brushSp.graphics.lineTo(mouseX,mouseY);
			trace("lineto:",mouseX,mouseY);
			oldX = mouseX;
			oldY = mouseY;
			bmd.draw(brushSp);
			
			e["updateAfterEvent"]();
			
//			brushSp.graphics.clear();
			return true;
		}
		override protected function onMouseDownHandler(e:Event):void 
		{
			super.onMouseDownHandler(e);
			if (canNotDraw) 
			{
				var lineStyle:Number = 1 + 20 * (Controller.brushSize / (6 * 3));
				brushSp.graphics.lineStyle(lineStyle,Controller.brushColor);
				brushSp.graphics.moveTo(mouseX,mouseY);
				
				addChild(brushSp);
			}
		}
		
		protected override function onMouseUpHandler(e:Event):void
		{
			super.onMouseUpHandler(e);
			brushSp.graphics.clear();
		}
	}
	
}