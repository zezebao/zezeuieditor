package commands
{
	public interface ICommand
	{
		function execute():void;
		function undo():void;
	}
}