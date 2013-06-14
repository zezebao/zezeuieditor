package data
{
	public class Config
	{
		public static var swcsPath:String = "E:/ys_client/asset/asset_swfs";
		
		//暂时写死，正常情况应该支持项目切换
		public static var outputPath:String = "E:/zezeUIEditor/UIEditor/output/ys_ui.txt";
		public static var outputXMLPath:String = "E:/zezeUIEditor/UIEditor/output/ys_ui.xml";
		public static var languePath:String = "http://192.168.6.201:3620/languageC.txt?rnd=" + Math.random();
	}
}