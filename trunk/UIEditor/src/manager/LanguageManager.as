package manager
{
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import mhqy.ui.UIManager;
	
//	import mhsm.constData.CampType;
//	import mhsm.constData.CareerType;
//	import mhsm.constData.CategoryType;
//	import mhsm.constData.CommonConfig;
//	import mhsm.constData.PropertyType;
//	import mhsm.constData.VipType;
//	import mhsm.constData.WarType;
	
	public class LanguageManager
	{
		private static var _words:Dictionary = new Dictionary();
		
		public static function setup(data:String):void
		{
			var t:String = data;
			data = data.split("\\n").join("\n");
			data = data.split("\\t").join("\t");
			var list:Array = data.split("\r\n");
			var nnn:int = list.length;
			for(var i:int = 0; i < nnn; i++)
			{
				var s:String = list[i];
				if(s == "")continue;
				if(s.indexOf("//") == 0)continue;
				var n:int = s.indexOf(":");
				if(n != -1)
				{
					var name:String = s.substring(0,n);
					var value:String = s.substr(n + 1);
					_words[name] = value;
				}
			}			
//			CategoryType.setLanguage(getWord);
//			CampType.setLanguage(getWord);
//			CareerType.setLanguage(getWord);
//			VipType.setLanguage(getWord);
//			WarType.setLanguage(getWord);
//			PropertyType.setLanguage(getWord);
			UIManager.setLanguage(getWord);
		}
		
		public static function getWord(id:String,...args):String
		{
			var s:String = _words[id];
			if(s != null)
			{
				if(args.length > 0)
				{
					for(var i:int = 0; i < args.length; i++)
					{
						s = s.split("{" + (i + 1) + "}").join(args[i]);
					}
				}
				return s;
			}
			return "";
		}
		
		public static function getAlertTitle():String
		{
			return getWord("mhsm.common.AlertTitleAsset");
		}
		
		public static function getWordType():String
		{
			var type:String = getWord("mhsm.common.wordType");
			return type == "" ? "微软雅黑" : type;
		}
	}
}