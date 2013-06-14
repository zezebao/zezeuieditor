package uidata
{
	public class UIClassInfoList
	{
		public var classList:Vector.<UIClassInfo> = new Vector.<UIClassInfo>();
		
		public function UIClassInfoList()
		{
		}
		
		public function parseXML(data:XML):void
		{
//			var temp:XMLList = data.classes.className.(@className=='Test1');
//			trace(temp.children().length());
//			data.classes.className[0] = <className name='Test999'>
//		<BAR var='' x='1' y='1'></BAR>
//	</className>;
//			trace(data);
//			data.className.length();
		}
		
		public function get xml():XML
		{
			var content:String = "<rss>\n";
			content += "<classes>\n";
			for (var i:int = 0; i < classList.length; i++) 
			{
				content += classList[i].xml.toString() + "\n";
			}
			content += "</classes>\n";
			content += "</rss>";
			return XML(content);
		}
	}
}