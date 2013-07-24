package commands
{
	import uidata.UIElementBaseInfo;

	/**
	 * 撤销改变Command，简单的撤销Command，只能针对x,y,width,height,做出的改变进行撤销操作 
	 * @author Administrator
	 * 
	 */	
	public class ChangeUndoCommand extends Command
	{
		private var _uiinfoVec:Vector.<UIElementBaseInfo>
		
		public function ChangeUndoCommand(vec:Vector.<UIElementBaseInfo>)
		{
			super();
			_uiinfoVec = vec;
			for (var i:int = 0; i < _uiinfoVec.length; i++) 
			{
				_uiinfoVec[i].record();
			}
		}
		
		override public function execute():void
		{
			for (var i:int = 0; i < _uiinfoVec.length; i++) 
			{
				_uiinfoVec[i].undo();
			}
		}
		
		override public function undo():void
		{
			
		}
	}
}