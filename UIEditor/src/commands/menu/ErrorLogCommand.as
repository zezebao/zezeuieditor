package commands.menu
{
	import commands.Command;
	
	public class ErrorLogCommand extends Command
	{
		public function ErrorLogCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			App.log.toggle();
		}
		
	}
}