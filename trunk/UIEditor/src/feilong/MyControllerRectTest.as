package feilong
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.utils.setTimeout;
	
	import ghostcat.ui.CursorSprite;
	
	public class MyControllerRectTest extends Sprite
	{
		private var c1:UIControlRect;
		
		/**上下左右*/
		private var _direction:int;		
		
		public function MyControllerRectTest()
		{
			super();
			
			c1 = new UIControlRect();
			addChild(c1);
			c1.skin = TestRepeater;
			trace(c1.content);
			c1.lockY = true;
			c1.canChange = false;
			addChild(new UIControlRect(new TestRepeater()));
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN,onClickHandler);
			
			addChild(new CursorSprite());
			
//			setTimeout(test,2000);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUpHandler);
		}
		
		protected function onKeyDownHandler(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.A:
				case Keyboard.LEFT:
					_direction = _direction | Direction.LEFT;
					break;
				case Keyboard.D:
				case Keyboard.RIGHT:
					_direction = _direction | Direction.RIGHT;
					break;
				case Keyboard.W:
				case Keyboard.UP:
					_direction = _direction | Direction.UP;
					break;
				case Keyboard.S:
				case Keyboard.DOWN:
					_direction = _direction | Direction.DOWN;
					break;
				
			}
			if(_direction != 0)
			{
				this.addEventListener(Event.ENTER_FRAME,onETHandler);
			}
		}
		
		protected function onKeyUpHandler(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.A:
				case Keyboard.LEFT:
					_direction = _direction & 0;
					break;
				case Keyboard.S:
				case Keyboard.RIGHT:
					_direction = _direction & 0;
					break;
				case Keyboard.W:
				case Keyboard.UP:
					_direction = _direction & 0;
					break;
				case Keyboard.D:
				case Keyboard.DOWN:
					_direction = _direction & 0;
					break;
			}
			if(_direction == 0)
			{
				this.removeEventListener(Event.ENTER_FRAME,onETHandler);
			}
		}
		
		protected function onETHandler(event:Event):void
		{
			UIControlRect.moveDir(_direction);	
		}
		
		private function test():void
		{
			c1.skin = TestRepeater45;
		}
		
		protected function onClickHandler(event:MouseEvent):void
		{
			UIControlRect.unSelectAll();
			stage.focus = this;
		}
	}
}