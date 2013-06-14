package manager
{
	import flash.display.DisplayObjectContainer;
	
	import view.HotRectControl;
	import view.LayerPanel;
	import view.StagePanel;

	public class LayerManager
	{
		public static const UP:uint = 1;
		public static const DOWN:uint = 2;
		public static const TOP:uint = 3;
		public static const BOTTOM:uint = 4;
		public static const DEL:uint = 5;
		
		public var layerPanel:LayerPanel;
		public var stagePanel:StagePanel;
		
		public function LayerManager()
		{
		}
		
		/**
		 * 层级操作，上下顶底删 
		 * @param type
		 */		
		public function layerHandler(type:int):void
		{
			switch(type)
			{
				case UP:
					layerPanel.upHandler();
					break;
				case DOWN:
					layerPanel.downHandler();
					break;
				case TOP:
					layerPanel.topHandler();
					break;
				case BOTTOM:
					layerPanel.bottomHandler();
					break;
				case DEL:
					layerPanel.delHandler();
					break;
			}
		}
	}
}