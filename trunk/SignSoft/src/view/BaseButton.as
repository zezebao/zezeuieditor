package view
{
	import caurina.transitions.Tweener;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class BaseButton extends Sprite
	{
		protected var _btnImg:Bitmap;
		protected var _imgLoader:Loader;
		private var _isVisible:Boolean = true;
		private var _position:Point;
		
		public function BaseButton()
		{
			super();
		}

		public function get position():Point
		{
			return _position;
		}

		public function set position(value:Point):void
		{
			_position = value;
			this.x = _position.x;
			this.y = _position.y;
		}

		public function get isVisible():Boolean
		{
			return _isVisible;
		}

		public function set isVisible(value:Boolean):void
		{
			_isVisible = value;
			visible = _isVisible;
		}

	}
}