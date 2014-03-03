package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Rectangle;
	/**
	 * 带笔触的书写
	 * @author ...http://www.dream798.com
	 */
	public class  FangMaoBi extends MovieClip
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
		private const tof:int = 2;//笔触
		private var defaultScale:Number = 0.8;//默认笔触的大小
		private var oldScale:Number;
		private var cx:Number = 0.06;// .02;//粗细变化参数
		private var brushMin:Number = 0.12;//.08;//最细笔触限制
		private var brushAlpha:Number = 0.65;//笔刷浓度
		private var bf:BlurFilter=new BlurFilter(2,2,1);
		
		public function FangMaoBi() {
			stage.scaleMode = "showAll";
			stage.displayState = "fullScreen";
			bmd = new BitmapData(1920, 1080,true,0x0);
			bm = new Bitmap(bmd);
			brush_mc = new Sprite();
			b_mc = new Sprite();
			addChildAt(b_mc, 0);
			b_mc.addChild(bm);
			addEventListener(MouseEvent.MOUSE_DOWN,_down);
			addEventListener(MouseEvent.MOUSE_UP, _up);
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
		
		private function _enterframe(e:MouseEvent) {
			if (! isDown) {
				return;
			}
			if (! isNaN(oldX)) {
				//为防止鼠标移动速度过快，计算老坐标和新坐标直接的距离，在两个坐标中间填充若干笔触
				const disX:Number=mouseX-oldX;
				const disY:Number=mouseY-oldY;
				const dis:Number = Math.sqrt(disX * disX + disY * disY);
				var scale:Number = defaultScale - dis * cx;
				//改变笔触的大小,越快越小
                if (dis > 0.12) { 
                    if (scale > 1) scale = 1;
					else if (scale < brushMin) scale = brushMin;
					scale = (oldScale + scale) * 0.52;//0.5
                }
				const count:int = dis * brushAlpha;
				const scaleBili:Number = (oldScale-scale) / count;
				var brush:MovieClip, i:int;
				for (i=0; i<count; i++) {
					brush = new Brush();
					brush.gotoAndStop(tof);
					brush_mc.addChild(brush);
					//brush.filters = [bf];
					brush.alpha = 0.6;
                    brush.scaleX = brush.scaleY = oldScale-i * scaleBili; 
					brush.x=(disX/count)*(i+1)+oldX;
					brush.y=(disY/count)*(i+1)+oldY;
				}
				oldX = mouseX;
				oldY = mouseY;
				oldScale = scale;
				bmd.draw(brush_mc);
				e.updateAfterEvent();
				//删除填充的笔触
				while (brush_mc.numChildren>0) {
					brush_mc.removeChildAt(0);
				}
			}
		}
		private function _down(e:MouseEvent) {
			if (canNotDraw) {
				//addEventListener(Event.ENTER_FRAME, _enterframe);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, _enterframe);
				isDown = true;
				oldX = mouseX;
				oldY = mouseY;
				oldScale = 1;
			}
			
		}

		private function _up(e:MouseEvent) {
			//removeEventListener(Event.ENTER_FRAME, _enterframe);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, _enterframe);
			isDown = false;
			oldX = NaN;
			stopDrag();
		}
	}
	
}