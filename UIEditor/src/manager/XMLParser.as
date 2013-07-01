package manager
{
	import data.Config;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.UIComponent;
	
	import uidata.UIClassInfo;
	import uidata.UIElementBaseInfo;
	
	import view.HotRectControl;

	
	/**存取、发布数据*/
	public class XMLParser
	{
		private var _xml:XML;
		
		public function XMLParser()
		{
		}
		
		public function parseData(data:*):void
		{
//			var temp:XMLList = _xml.classes.className.(@className=='Test1');
//			trace(temp.children().length());
			App.classInfoList.parseXML(XML(data));
		}
		
		public function publish():void
		{
			save(false);
			
			var file:File = new File(Config.outputPath);
			var fileSteam:FileStream = new FileStream();
			fileSteam.open(file,FileMode.WRITE);
			var byte:ByteArray = new ByteArray(); 
			publishWrite(byte);
			fileSteam.writeBytes(byte);
			fileSteam.close();
			
			Alert.show("发布成功");
		}
		
		public function save(showAlert:Boolean=true):void
		{
			App.layerManager.stagePanel.save();
			
			var file:File = new File(Config.outputXMLPath);
			var fileSteam:FileStream = new FileStream();
			fileSteam.open(file,FileMode.WRITE);
			var copyContent:String = "";
			try
			{
				copyContent = fileSteam.readUTFBytes(fileSteam.bytesAvailable);	
			} 
			catch(error:Error){}; 
			
			var byte:ByteArray = new ByteArray(); 
			saveWrite(byte);
			fileSteam.writeBytes(byte);
			fileSteam.close();
			
			//保存副本============
			var dateStr:String = new Date().fullYear + ".bak_" + (new Date().month + 1) + "_" + new Date().date;
			var copyFile:File = new File(Config.outputXMLPath + "_" + dateStr);
			var copyFileSteam:FileStream = new FileStream();
			copyFileSteam.open(copyFile,FileMode.WRITE);
			var copyByte:ByteArray = new ByteArray();
			copyByte.writeUTFBytes(copyContent);
			copyFileSteam.writeBytes(copyByte);
			copyFileSteam.close();
			
			if(showAlert)Alert.show("保存xml文件成功");
		}
		
		private function publishWrite(byte:ByteArray):void
		{
			byte.writeInt(App.classInfoList.classLen);
			var classList:Dictionary = App.classInfoList.classList;
			for each (var info:UIClassInfo in classList) 
			{ 
				var vec:Vector.<UIElementBaseInfo> = info.publishInfoList;
				var len:int = vec.length
				byte.writeUTF(info.className);
				byte.writeInt(len);
				for (var i:int = 0; i < len; i++)
				{
					vec[i].writeData(byte);
					trace(vec[i]);
				}
			}
		}
		
		private function saveWrite(byte:ByteArray):void
		{
			trace("save:",App.classInfoList.xmlStr);
			var content:String = App.classInfoList.xmlStr;
			byte.writeUTFBytes(content);
		}
	}
}