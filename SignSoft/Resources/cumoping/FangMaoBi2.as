package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Rectangle;
	import flash.ui.Multitouch;
	/**
	 * 带笔触的书写
	 * @author 触摸屏版
	 */
	public class  FangMaoBi2 extends MovieClip
	{
		private var bmd:BitmapData;
		private var bm:Bitmap;
		private var oldX:Number;
		private var oldY:Number;
		private var isDown:Boolean = false;
		private var brush_mc:Sprite;
		private var b_mc:Sprite ;
		private var canNotDraw:Boolean = true;
		public var forDraw_mc:MovieClip;//清屏对象
		private const tof:int = 1;//笔触
		private var defaultScale:Number = 0.8;//默认笔触的大小
		private var oldScale:Number;
		private var cx:Number = 0.03;// 粗细变化参数,建议值(0.02~0.12),值越小，笔画越均匀
		private var brushMin:Number = 0.12;//.08;//最细笔触限制
		private var brushAlpha:Number = 0.65;//笔刷浓度
		
		public function FangMaoBi2() {
			stage.scaleMode = "showAll";
			//stage.displayState = "fullScreen";
			Multitouch.inputMode = "touchPoint";
			bmd = new BitmapData(1920, 1080,true,0x0);
			bm = new Bitmap(bmd);
			brush_mc = new Sprite();
			b_mc = new Sprite();
			addChildAt(b_mc, 0);
			b_mc.addChild(bm);
			addEventListener(TouchEvent.TOUCH_BEGIN, _down);
			addEventListener(TouchEvent.TOUCH_END, _up);
			clear_mc.buttonMode = true;
			clear_mc.stop();
			clear_mc.addEventListener(MouseEvent.CLICK, doClick);
			clear_mc.addEventListener(MouseEvent.ROLL_OVER, doOver);
			clear_mc.addEventListener(MouseEvent.ROLL_OUT , doOut);
			
			forDraw_mc.visible = false;
		}
		private function doClick(e) {
			bmd.draw(forDraw_mc);
		}
		private function doOver(e) {
			canNotDraw = false;
			clear_mc.gotoAndStop(2);
		}
		private function doOut(e) {
			canNotDraw = true;
			clear_mc.gotoAndStop(1);
		}
		private function _enterframe(e:TouchEvent) {
			//if (! isNaN(oldX)) {
				//为防止鼠标移动速度过快，计算老坐标和新坐标直接的距离，在两个坐标中间填充若干笔触
				const disX:Number=e.stageX-oldX;
				const disY:Number=e.stageY-oldY;
				const dis:Number = Math.sqrt(disX * disX + disY * disY);
				//改变笔触的大小,越快越小
				var scale:Number = defaultScale - dis * cx;
				//if(dis>0.12){
				if (scale > 1) scale = 1;
				else if (scale < brushMin) scale = brushMin;
				scale = (oldScale + scale) * 0.52;//这个参数可调节笔触的粗细,建议值(0.3~0.82),值越大，笔画越粗
				//}
				const count:int = dis * brushAlpha;
				const scaleBili:Number = (oldScale-scale) / count;
				var brush:MovieClip, i:int;
				for (i=0; i<count; i++) {
					brush = new Brush();
					//brush.gotoAndStop(tof);
					brush_mc.addChild(brush);
                    brush.scaleX = brush.scaleY = oldScale-i * scaleBili; 
					brush.x=(disX/count)*(i+1)+oldX;
					brush.y=(disY/count)*(i+1)+oldY;
				}
				oldX = e.stageX;//mouseX;
				oldY = e.stageY;//mouseY;
				oldScale = scale;
				bmd.draw(brush_mc);
				e.updateAfterEvent();
			//}
		}
		private function _down(e:TouchEvent) {
			if (canNotDraw) {
				stage.addEventListener(TouchEvent.TOUCH_MOVE, _enterframe);
				isDown = true; 
				oldX = e.stageX;// mouseX;
				oldY = e.stageY;// mouseY;
				oldScale = 1;
			}
		}

		private function _up(e:TouchEvent) {
			stage.removeEventListener(TouchEvent.TOUCH_MOVE, _enterframe);
			isDown = false;
			oldX = NaN;
			while (brush_mc.numChildren>0) {
				brush_mc.removeChildAt(0);
			}
		}
	}
	
}