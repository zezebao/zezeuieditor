package commands.menu
{
	import commands.Command;
	
	public class SaveCommand extends Command
	{
		public function SaveCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			App.xmlParser.save();
		}
		
		override public function undo():void
		{
			
		}
	}
}