package data
{
	import flash.filesystem.File;

	public class Config
	{
		public static var swfsPath:String = "E:/ys_client/asset/asset_swfs";
		public static var outputPath:String = "E:/zezeUIEditor/UIEditor/output/ys_ui.txt";
		public static var outputXMLPath:String = "E:/zezeUIEditor/UIEditor/output/ys_ui.xml";
		public static var languagePath:String = "http://192.168.6.201:3620/languageC.txt?rnd=" + Math.random();
		
		//swcs
		public static var swcsLibsPath:String = File.applicationDirectory.nativePath + "\\rslLibs";
	}
}