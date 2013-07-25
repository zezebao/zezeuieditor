package manager
{
	import commands.ChangeUndoCommand;
	
	import data.Direction;
	import data.LayoutAlignType;
	
	import flash.geom.Rectangle;
	
	import ghostcat.manager.DragManager;
	
	import uidata.UIElementBaseInfo;
	
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
			var vec:Vector.<UIElementBaseInfo> = App.hotRectManager.getMoveVec();
			if(vec.length > 0)
			{
				if(App.classInfo)App.classInfo.addCommand(new ChangeUndoCommand(vec));
			}
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
//				rect.updatePos();
			}
		}
		
		//移动开始，记录
		public function getMoveVec():Vector.<UIElementBaseInfo>
		{
			var vec:Vector.<UIElementBaseInfo> = new Vector.<UIElementBaseInfo>();
			for (var i:int = selectedRects.length - 1;i>=0;i--)
			{
				var rect:HotRectControl = selectedRects[i];
				if(rect.uiInfo)
				{
					var flag:Boolean = rect.uiInfo.record();
					vec.push(rect.uiInfo);
//					if(flag)vec.push(rect.uiInfo);
				}
			}
			return vec;
		}
		
		//移动结束，根据视图改变属性
		public function moveOver():void
		{
			for (var i:int = selectedRects.length - 1;i>=0;i--)
			{
				var rect:HotRectControl = selectedRects[i];
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
			
			for (var j:int = 0; j < selectedRects.length; j++) 
			{
				selectedRects[j].updatePos();
			}
			
		}
		
		/**锁定选中的HotRect*/
		public function lock():void
		{
			for (var i:int = 0; i < selectedRects.length; i++) 
			{
				var hotRect:HotRectControl = selectedRects[i]; 
				hotRect.uiInfo.locked = !hotRect.locked;
				hotRect.locked = hotRect.uiInfo.locked;
			}
		}
	}
}