package manager
{
	import data.Direction;
	
	import ghostcat.events.DragEvent;
	import ghostcat.manager.DragManager;
	
	import view.HotRectControl;

	public class HotRectManager
	{
		public function HotRectManager()
		{
		}
		
		private var _selectedRects:Vector.<HotRectControl> = new Vector.<HotRectControl>();

		/*** 选择的对象数组 */
		public function get selectedRects():Vector.<HotRectControl>
		{
			return _selectedRects;
		}
		/**
		 * @private
		 */
		public function set selectedRects(value:Vector.<HotRectControl>):void
		{
			_selectedRects = value;
		}

		/**取消全部选择*/
		public function unSelectAll():void
		{
			for (var i:int = selectedRects.length - 1;i>=0;i--)
			{
				var rect:HotRectControl = selectedRects[i];
				rect.selected = false;
			}
			selectedRects = new Vector.<HotRectControl>();
		}
		
		/**开始拖动*/
		public function startDrag():void
		{
			for each (var rect:HotRectControl in selectedRects)
			{
				DragManager.startDrag(rect,null,null,stopDargHandler);
			}
		}
		
		private function stopDargHandler(evt:DragEvent):void
		{
			evt;
//			trace("当前位置：",this.x,this.y);
		}
		
		/***八向位图数据* @param direction    00000000 */		
		public function moveDir(direction:int):void
		{
			for (var i:int = selectedRects.length - 1;i>=0;i--)
			{
				var rect:HotRectControl = selectedRects[i];
				var vec:Vector.<int> = Direction.getDirect(direction);
				for (var j:int = 0; j < vec.length; j++) 
				{
					switch(vec[j])
					{
						case Direction.UP:
							rect.y -= 1;
							break;
						case Direction.DOWN:
							rect.y += 1;
							break;
						case Direction.LEFT:
							rect.x -= 1;
							break;
						case Direction.RIGHT:
							rect.x += 1;
							break;
					}
				}
			}
		}
	}
}