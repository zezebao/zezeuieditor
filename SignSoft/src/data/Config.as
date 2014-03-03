package data
{
	public class Config
	{
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
		
		public static var PHOTO_TOGGLE:Boolean = true;
		public static var SIGN_TOGGLE:Boolean = true;
		public static var SAVE_TOGGLE:Boolean = true;
		public static var PREVIEW_TOGGLE:Boolean = true;
		public static var PRINT_TOGGLE:Boolean = true;
		
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
			
			PHOTO_TOGGLE = (xml.FUNCTIONS.PHOTO.@toggle=='true');
			SIGN_TOGGLE = (xml.FUNCTIONS.SIGN.@toggle=='true');
			SAVE_TOGGLE = (xml.FUNCTIONS.SAVE.@toggle=='true');
			PREVIEW_TOGGLE = (xml.FUNCTIONS.PREVIEW.@toggle=='true');
			PRINT_TOGGLE = (xml.FUNCTIONS.PRINT.@toggle=='true');
			
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
			}
			return "";
		}
	}
}