package uidata
{
	import event.UIEvent;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	/**
	 * 一个承载一系列类的xml的数据 
	 * @author Administrator
	 */
	public class UIClassInfoList
	{
		public var fileName:String;
		public var isChange:Boolean;
		
		private var _classList:Dictionary = new Dictionary();
		
		/**回收的类*/
		private var _recycleList:Dictionary = new Dictionary();
		
		public function UIClassInfoList(fileName:String)
		{
			this.fileName = fileName;
		}
		
		public function get classList():Dictionary
		{
			return _classList;
		}
	
		public function get classLen():int
		{
			var count:int;
			for each (var i:UIClassInfo in _classList) 
			{
				count ++;
			}
			return count;
		}
		
		public function parseXML(xmlData:XML):void
		{
//			var temp:XMLList = data.classes.className.(@className=='Test1');
//			trace(temp.children().length());
//			data.classes.className[0] = <className name='Test999'>
//		<BAR var='' x='1' y='1'></BAR>
//	</className>;
//			trace(data);
//			data.className.length();
//			trace(xmlData.classes.className.length());
			var len:int = xmlData.classes.className.length();
			for (var i:int = 0; i < len; i++) 
			{
				xmlData.classes.className[i];
				var info:UIClassInfo = new UIClassInfo(xmlData.classes.className[i].@className);
				info.parseXML(XML(xmlData.classes.className[i]));
				_classList[info.className] = info;
			}
		}
		
		public function hasClass(className:String):Boolean
		{
			if(_classList[className] == null)
				return false;
			return true;
		}
		
		public function addClass(className:String):void
		{
			_classList[className] = new UIClassInfo(className);
			App.dispathEvent(new UIEvent(UIEvent.CLASS_UPDATE,className));
		}
		
		public function delClass(className:String):void
		{
			_recycleList[className] = _classList[className];
			delete _classList[className];
			App.dispathEvent(new UIEvent(UIEvent.CLASS_UPDATE,className));
		}
		
		public function getClassInfo(className:String):UIClassInfo
		{
			return _classList[className];
		}
		
		public function getChildList():ArrayCollection
		{
			var array:ArrayCollection = new ArrayCollection();
			var temp:Array = new Array();
			for each (var info:UIClassInfo in _classList) 
			{
				temp.push(info);
			}
			temp.sortOn("className",Array.CASEINSENSITIVE);
			for (var i:int = 0; i < temp.length; i++) 
			{
				array.addItem({"label":temp[i].className,"value":temp[i].className});
			}
//			for each (var info:UIClassInfo in _classList) 
//			{
//				array.addItem({"label":info.className,"value":info.className,"icon":"assets/systemIcons/fb_as_16x16.png"});
//				array.addItem({"label":info.className,"value":info.className});
//			}
			return array;
		}
		
		private function get xmlStr():String
		{
			var content:String = "<rss>\n";
			content += "<classes>\n";
			
			var array:ArrayCollection = new ArrayCollection();
			var temp:Array = new Array();
			for each (var info:UIClassInfo in _classList) 
			{
				temp.push(info);
			}
			temp.sortOn("className",Array.CASEINSENSITIVE);
			for (var i:int = 0; i < temp.length; i++) 
			{
				content += temp[i].xmlStr + "\n";
			}
			
//			for each (var info:UIClassInfo in _classList) 
//			{
//				content += info.xmlStr + "\n";
//			}
			content += "</classes>\n";
			content += "</rss>";
			return content;
		}
		
		public function saveWrite(byte:ByteArray):void
		{
			byte.writeUTFBytes(xmlStr);
		}
	}
}