package data
{
	import flash.filesystem.File;

	public class PreviewSortItem
	{
		public var time:Number;
		public var file:File;
		public var date:Date;
		
		public function PreviewSortItem(file:File)
		{
			this.file = file;
			date = new Date(1970,0,0,0,0,0,0);
			var timeStr:String = file.nativePath.substring(file.nativePath.lastIndexOf("\\") + 1,file.nativePath.lastIndexOf("."));
			
			var tmp:Array = timeStr.split("_");
			if(tmp.length > 0)date.fullYear = int(tmp[0]);
			if(tmp.length > 1)date.month = int(tmp[1]);
			if(tmp.length > 2)date.date = int(tmp[2]);
			if(tmp.length > 3)date.hours = int(tmp[3]);
			if(tmp.length > 4)date.minutes = int(tmp[4]);
			if(tmp.length > 5)date.seconds = int(tmp[5]);
			
			time = date.getTime();
			trace(timeStr,time,date);
		}
	}
}