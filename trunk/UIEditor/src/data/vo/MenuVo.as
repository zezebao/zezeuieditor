package data.vo
{
	import commands.ICommand;

	public class MenuVo
	{
		public var title:String;
		public var command:ICommand;
		
		public function MenuVo(title:String,command:ICommand)
		{
			this.title = title;
			this.command = command;
		}
	}
}