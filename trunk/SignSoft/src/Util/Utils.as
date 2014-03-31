package Util
{
	import external.Client;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;

	public class Utils
	{
		public function Utils()
		{
		}
		
		public static var client:Client;
		
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
		
		public static function scaleBitmapData(bmpData:BitmapData, scaleX:Number, scaleY:Number):BitmapData
		{
			var matrix:Matrix = new Matrix();
			matrix.scale(scaleX, scaleY);
			var bmpData_:BitmapData = new BitmapData(scaleX * bmpData.width, scaleY * bmpData.height, true, 0);
			bmpData_.draw(bmpData, matrix);
			return bmpData_;
		}
		
		private static var _dispatcher:EventDispatcher = new EventDispatcher();
		public static function addEventListener(type:String,listener:Function):void
		{
			_dispatcher.addEventListener(type,listener);
		}
		public static function dispath(event:Event):void
		{
			_dispatcher.dispatchEvent(event);
		}
	}
}