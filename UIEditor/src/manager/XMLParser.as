package manager
{
	import data.Config;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.UIComponent;
	
	import view.HotRectControl;

	public class XMLParser
	{
		private var _xml:XML;
		
		public function XMLParser()
		{
		}
		
		public function parseData(data:*):void
		{
			_xml = XML(data);
			var temp:XMLList = _xml.classes.className.(@className=='Test1');
			trace(temp.children().length());
			_xml.classes.className[0] = <className name='Test999'>
		<BAR var='' x='1' y='1'></BAR>
	</className>;
			trace(_xml);
		}
		
		public function canCreate(className:String):Boolean
		{
			if(!_xml)return false;
			var temp:XMLList = _xml.classes.className.(@className==className);
			if(temp.children().length() >= 1)
			{
				Alert.show("类名已经存在");
				return false;
			}
			return true;
		}
		
		public function getChildList():ArrayCollection
		{
			var array:ArrayCollection = new ArrayCollection();
			var len:int = _xml.classes.className.length();
			for (var i:int = 0; i < len; i++) 
			{
				array.addItem({"label":_xml.classes.className[i].@name,"icon":"assets/systemIcons/fb_as_16x16.png"});
			}
			return array;
		}
		
		public function publish():void
		{
			var file:File = new File(Config.outputPath);
			var fileSteam:FileStream = new FileStream();
			fileSteam.open(file,FileMode.WRITE);
			var byte:ByteArray = new ByteArray(); 
			tempWrite(byte);
			fileSteam.writeBytes(byte);
			fileSteam.close();
			
			save();
		}
		
		public function save():void
		{
			var file:File = new File(Config.outputXMLPath);
			var fileSteam:FileStream = new FileStream();
			fileSteam.open(file,FileMode.WRITE);
			var byte:ByteArray = new ByteArray(); 
			saveWrite(byte);
			fileSteam.writeBytes(byte);
			fileSteam.close();
		}
		
		private function tempWrite(byte:ByteArray):void
		{
			var container:UIComponent = App.layerManager.stagePanel.getContainer();
			var len:int = 1;
			byte.writeInt(len);
			for (var i:int = 0; i < len; i++) 
			{
				byte.writeUTF("testClassName");
				var len2:int = container.numChildren;
				byte.writeInt(len2);
				for (var j:int = 0; j < len2; j++) 
				{
					var hotRect:HotRectControl = container.getChildAt(j) as HotRectControl;
					if(hotRect && hotRect.uiInfo)
					{
						hotRect.uiInfo.writeData(byte);
						trace(hotRect.uiInfo.toString());
					}
				}
			}
			Alert.show("publish succ");
		}
		
		private function saveWrite(byte:ByteArray):void
		{
			var str:String = "";
			for (var i:int = 0; i < 200000; i++) 
			{
				str += "<item src='xxxx' x='123' y='123'/>\n";
			}
			byte.writeUTFBytes(str);
		}
	}
}