package data
{
	import flash.geom.Point;
	import flash.utils.Dictionary;

	public class Config
	{
		public static function get CONN_NAME():String
		{
			return "_signSoftConnect";
		}
		
		public static var USE_TOUCH:Boolean = true;
		
		public static var defaultPos:Dictionary = new Dictionary();
		
		public static const POS_CONTROLLER:String = "posController";
		public static const POS_PHOTO:String = "posPhoto";
		public static const POS_SIGN:String = "posSign";
		public static const POS_SAVE:String = "posSave";
		public static const POS_PREVIEW:String = "posPreview";
		public static const POS_PRINT:String = "posPrint";
		
		public static const PHOTO_IMG:String = "photo.png";
		public static const SIGN_IMG:String = "sign.png";
		public static const SAVE_IMG:String = "save.png";
		public static const PREVIEW_IMG:String = "preview.png";
		public static const PRINT_IMG:String = "print.png";
		public static const OK_IMG:String = "okBtn.png";
		public static const HOME_IMG:String = "home.png";
		public static const CLOSE_IMG:String = "closeBtn.png";
		public static const REPLACE_IMG:String = "replace.png";
		public static const RESIGN_IMG:String = "resign.png";
		
		public static var PHOTO_TOGGLE:Boolean = true;
		public static var SIGN_TOGGLE:Boolean = true;
		public static var SAVE_TOGGLE:Boolean = true;
		public static var PREVIEW_TOGGLE:Boolean = true;
		public static var PRINT_TOGGLE:Boolean = true;
		
		public static var CAMERA_WIDTH:int = 400;
		public static var CAMERA_HEIGHT:int = 400;
		public static var CAMERA_X:int = 300;
		public static var CAMERA_Y:int = 300;
		public static var CAMERA_ROTATION:int = 0;
		
		public static var PREVIEW_X:int = 120;
		public static var PREVIEW_Y:int = 300;
		
		public static var SCREEN_WIDTH:int = 1920;
		public static var SCREEN_HEIGHT:int = 1080;
		
		public static var UI_PATH:String;
		public static var BGSND_PATH:String;
		public static var BG_IMGS:Vector.<String> = new Vector.<String>();
		
		public function Config()
		{
		}
		
		public static function initConfig(xml:XML):void
		{
			UI_PATH = String(xml.UI_PATH);
			if(UI_PATH.charAt(UI_PATH.length - 1) != '/')UI_PATH += "/";
			BGSND_PATH = String(xml.BG_SOUND);
			
			CAMERA_WIDTH = int(xml.CAMERA.@width);
			CAMERA_HEIGHT = int(xml.CAMERA.@height);
			CAMERA_X = int(xml.CAMERA.@x);
			CAMERA_Y = int(xml.CAMERA.@y);
			CAMERA_ROTATION = int(xml.CAMERA.@rotation);;
			
			PREVIEW_X = int(xml.PREVIEW.@x);
			PREVIEW_Y = int(xml.PREVIEW.@y);
			
			SCREEN_WIDTH = int(xml.SCREEN.WIDTH);
			SCREEN_HEIGHT = int(xml.SCREEN.HEIGHT); 
			
			USE_TOUCH = (String(xml.USE_TOUCH) =='true');
			
			PHOTO_TOGGLE = (xml.FUNCTIONS.PHOTO.@toggle=='true');
			SIGN_TOGGLE = (xml.FUNCTIONS.SIGN.@toggle=='true');
			SAVE_TOGGLE = (xml.FUNCTIONS.SAVE.@toggle=='true');
			PREVIEW_TOGGLE = (xml.FUNCTIONS.PREVIEW.@toggle=='true');
			PRINT_TOGGLE = (xml.FUNCTIONS.PRINT.@toggle=='true');
			
			defaultPos[POS_PHOTO] = new Point(xml.FUNCTIONS.PHOTO.@x,xml.FUNCTIONS.PHOTO.@y);
			defaultPos[POS_SAVE] = new Point(xml.FUNCTIONS.SIGN.@x,xml.FUNCTIONS.SIGN.@y);
			defaultPos[POS_SIGN] = new Point(xml.FUNCTIONS.SAVE.@x,xml.FUNCTIONS.SAVE.@y);
			defaultPos[POS_PREVIEW] = new Point(xml.FUNCTIONS.PREVIEW.@x,xml.FUNCTIONS.PREVIEW.@y);
			defaultPos[POS_PRINT] = new Point(xml.FUNCTIONS.PRINT.@x,xml.FUNCTIONS.PRINT.@y);
			defaultPos[POS_CONTROLLER] = new Point(xml.FUNCTIONS.CONTOLLER.@x,xml.FUNCTIONS.CONTOLLER.@y);
			
			var len:int = xml.BACKGROUND.IMG.length();
			for (var i:int = 0; i < len; i++) 
			{
				BG_IMGS.push(String(xml.BACKGROUND.IMG[i]));
			}
		}
		
		public static function getBtnPath(property:String):String
		{
			switch(property)
			{
				case POS_PHOTO:return PHOTO_IMG;
				case POS_SIGN:return SIGN_IMG;
				case POS_SAVE:return SAVE_IMG;
				case POS_PREVIEW:return PREVIEW_IMG;
				case POS_PRINT:return PRINT_IMG;
				case OK_IMG:return OK_IMG;
				case HOME_IMG:return HOME_IMG;
				case CLOSE_IMG:return CLOSE_IMG;
				case REPLACE_IMG:return REPLACE_IMG;
				case RESIGN_IMG:return RESIGN_IMG;
			}
			return "";
		}
	}
}