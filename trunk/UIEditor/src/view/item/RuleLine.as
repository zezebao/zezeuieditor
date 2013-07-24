package view.item
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import ghostcat.display.GSprite;
	
	public class RuleLine extends GSprite
	{
		private var _direction:int;
		private var _hitArea:Sprite;
		/**
		 * @param direction 0：横线  1：竖线
		 */		
		public function RuleLine(direction:int)
		{
			super();
			_direction = direction;
			buttonMode = true;
			
			_hitArea = new Sprite();
			addChild(_hitArea);
			
			graphics.lineStyle(1,0x00ffff);
			_hitArea.graphics.beginFill(0,0);
			if(direction == 0)
			{
				graphics.moveTo(-300,0);
				graphics.lineTo(3000,0);
				_hitArea.graphics.drawRect(-300,-2,3000,4);
				
			}else if(direction == 1)
			{
				graphics.moveTo(0,-300);
				graphics.lineTo(0,3000);
				_hitArea.graphics.drawRect(-2,-300,4,3000);
			}
			graphics.endFill();
			
			this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
		}

		override public function startDrag(lockCenter:Boolean=false, bounds:Rectangle=null):void
		{
			if(bounds == null)
			{
				var rect:Rectangle = new Rectangle();
				if(_direction == 0)
				{
					rect.y = -300;
					rect.height = 3000; 
				}else if(_direction == 1)
				{
					rect.x = -300;
					rect.width = 3000;
				}
				super.startDrag(lockCenter, rect);
			}else
			{
				super.startDrag(lockCenter, bounds);
			}
		}
		
		protected function onMouseDownHandler(evt:MouseEvent):void
		{
			evt.stopImmediatePropagation();
			startDrag();		
		}
		
		public function get isOut():Boolean
		{
			if(_direction == 0)
			{
				if(this.y < 0)
				{
					return true;
				}
			}else if(_direction == 1)
			{
				if(this.x < 0)
				{
					return true;
				}
			}
			return false;	
		}
		
		public function dispose():void
		{
			this.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
			if(parent)
			{
				parent.removeChild(this);
			}
		}
	}
}