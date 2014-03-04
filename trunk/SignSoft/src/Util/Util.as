package Util
{
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.filters.ColorMatrixFilter;

	public class Util extends EventDispatcher
	{
		public function Util()
		{
		}
		
		/**
		 * 灰度滤镜
		 */		
		public static var grayMatrix:ColorMatrixFilter = new ColorMatrixFilter([0.3086, 0.6094, 0.0820, 0, 0, 0.3086, 0.6094, 0.0820, 0, 0, 0.3086, 0.6094, 0.0820, 0, 0, 0, 0, 0, 1, 0]);
		
		
		public static const GREENMATRIX:ColorMatrixFilter = new ColorMatrixFilter([0,0,0,0,0,
			0,1,0,0,0,
			0,0,1,0,0,
			0,0,0,1,0]);
		public static const READMATRIX:ColorMatrixFilter = new ColorMatrixFilter([0.9,0,0,0,0,
			0,0.77,0,0,0,
			0,0,0.5,0,0,
			0,0,0,1,0]);
		public static const GRAYMATRIX:ColorMatrixFilter = new ColorMatrixFilter([0.5,0,0,0,0,
			0,0.62,0,0,0,
			0,0,0.7,0,0,
			0,0,0,1,0]);
		
		//置灰
		public static function setGrey(obj:DisplayObject):void
		{
			obj.filters = [grayMatrix];
		}
	}
}