package manager
{
	import data.LayoutAlignType;
	import data.Direction;
	
	import event.UIEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	
	import ghostcat.events.DragEvent;
	import ghostcat.manager.DragManager;
	
	import view.HotRectControl;

	public class HotRectManager
	{
		public function HotRectManager()
		{
		}
		
		private var _selectedRects:Vector.<HotRectControl> = new Vector.<HotRectControl>();

		/*** 选择的对象数组(已根据子项的) */
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
		public function startDrag(bounds:Rectangle=null, startHandler:Function=null, stopHandler:Function=null, onHandler:Function=null, type:String="direct", lockCenter:Boolean=false, upWhenLeave:Boolean=false, collideByRect:Boolean=false):void
		{
			for each (var rect:HotRectControl in selectedRects)
			{
				DragManager.startDrag(rect,bounds,startHandler,stopHandler,onHandler,type,lockCenter,upWhenLeave);
			}
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
				rect.updatePos();
			}
		}
		
		//对齐
		public function autoAlign(type:int):void
		{
			if(selectedRects.length <= 0)return;
			var tx:Number = selectedRects[0].x;
			var ty:Number = selectedRects[0].y;
			var targetIndex:int = 0;
			var i:int;
			switch(type)
			{
				case LayoutAlignType.LEFT:
					for (i = 0; i < selectedRects.length; i++) 
					{
						if(tx > selectedRects[i].x)
						{
							tx = selectedRects[i].x;
							targetIndex = i;
						}
					}
					break;
				case LayoutAlignType.RIGHT:
					for (i = 0; i < selectedRects.length; i++) 
					{
						if(tx < selectedRects[i].x)
						{
							tx = selectedRects[i].x;
							targetIndex = i;
						}
					}
					break;
				case LayoutAlignType.UP:
					for (i = 0; i < selectedRects.length; i++) 
					{
						if(ty > selectedRects[i].y)
						{
							ty = selectedRects[i].y;
							targetIndex = i;
						}
					}
					break;
				case LayoutAlignType.DOWN:
					for (i = 0; i < selectedRects.length; i++) 
					{
						if(ty < selectedRects[i].y)
						{
							ty = selectedRects[i].y;
							targetIndex = i;
						}
					}
					break;
			}
			
			switch(type)
			{
				case LayoutAlignType.LEFT:
					for (i = 0; i < selectedRects.length; i++) 
					{
						selectedRects[i].x = tx;
					}
					break;
				case LayoutAlignType.RIGHT:
					for (i = 0; i < selectedRects.length; i++) 
					{
						selectedRects[i].x = selectedRects[targetIndex].x + selectedRects[targetIndex].width - selectedRects[i].width;
					}
					break;
				case LayoutAlignType.UP:
					for (i = 0; i < selectedRects.length; i++) 
					{
						selectedRects[i].y = ty;
					}
					break;
				case LayoutAlignType.DOWN:
					for (i = 0; i < selectedRects.length; i++) 
					{
						selectedRects[i].y = selectedRects[targetIndex].y + selectedRects[targetIndex].height - selectedRects[i].height;
					}
					break;
				case LayoutAlignType.CENTER_H:
					for (i = 0; i < selectedRects.length; i++) 
					{
						selectedRects[i].x = selectedRects[targetIndex].x + selectedRects[targetIndex].width / 2 - selectedRects[i].width / 2;
					}
					break;
				case LayoutAlignType.CENTER_V:
					for (i = 0; i < selectedRects.length; i++) 
					{
						selectedRects[i].y = selectedRects[targetIndex].y + selectedRects[targetIndex].height / 2 - selectedRects[i].height / 2;
					}
					break;
			}
		}
	}
}