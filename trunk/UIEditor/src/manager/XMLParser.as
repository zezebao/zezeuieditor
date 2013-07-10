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
	import uidata.UIClassInfoList;
	import uidata.UIElementBaseInfo;
	
	import view.HotRectControl;

	
	/**存取、发布数据*/
	public class XMLParser
	{
		private var _xml:XML;
		
		public function XMLParser()
		{
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
			
			var uiClassList:UIClassInfoList;
			for each (uiClassList in App.xmlClassList) 
			{
				var file:File = new File(Config.outputXMLPath + "//" + uiClassList.fileName + ".xml");
				var fileSteam:FileStream = new FileStream();
				fileSteam.open(file,FileMode.WRITE);
				
				var byte:ByteArray = new ByteArray(); 
				uiClassList.saveWrite(byte);
				fileSteam.writeBytes(byte);
				fileSteam.close();
			}
			
			if(showAlert)Alert.show("保存xml文件成功");
		}
		
		public function backup():void
		{
			App.layerManager.stagePanel.save();
			var uiClassList:UIClassInfoList;
			var date:Date = new Date();
			var backVersionString:String = date.fullYear + "_" + (date.month + 1) + "_" + date.date + "_" + date.hours;
			for each (uiClassList in App.xmlClassList) 
			{
				var file:File = new File(Config.outputXMLPath + backVersionString + "//" + uiClassList.fileName + ".xml");
				var fileSteam:FileStream = new FileStream();
				fileSteam.open(file,FileMode.WRITE);
				
				var byte:ByteArray = new ByteArray(); 
				uiClassList.saveWrite(byte);
				fileSteam.writeBytes(byte);
				fileSteam.close();
			}
			
			Alert.show("备份xml文件成功");
		}
		
		private function publishWrite(byte:ByteArray):void
		{
			var classLength:int = 0;
			var uiClassList:UIClassInfoList;
			for each (uiClassList in App.xmlClassList) 
			{
				classLength += uiClassList.classLen;
			}
			byte.writeInt(classLength);
			for each (uiClassList in App.xmlClassList) 
			{
				var classList:Dictionary = uiClassList.classList;
				for each (var info:UIClassInfo in classList) 
				{ 
					var vec:Vector.<UIElementBaseInfo> = info.publishInfoList;
					var len:int = vec.length
					byte.writeUTF(info.className);
					byte.writeInt(len);
					for (var i:int = 0; i < len; i++)
					{
						vec[i].writeData(byte);
					}
				}
			}
		}
	}
}