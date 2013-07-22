package commands.menu
{
	import commands.Command;
	
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.filesystem.File;
	
	public class UpdateLogCommand extends Command
	{
		public function UpdateLogCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			try
			{
				showUpdateLog();
			} 
			catch(error:Error) 
			{
				App.log.warn(error.message);
			}
		}
		
		private function showUpdateLog():void
		{
			var file:File = new File("C:\\Windows\\notepad.exe"); 
			var nativeProcessStartupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();//AIR2.0的新类, 创建进程信息对象
			nativeProcessStartupInfo.executable = file;// 将file指定为可执行文件
			var process:NativeProcess = new NativeProcess();// 创建一个本地进程
			nativeProcessStartupInfo.arguments = Vector.<String>([
				File.applicationDirectory.nativePath + "\\log.txt",
			]);
			process.start(nativeProcessStartupInfo);// 运行本地进程
		}
	}
}