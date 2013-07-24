package view.item
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import ghostcat.display.GSprite;
	
	import mx.core.UIComponent;
	
	public class RuleView extends UIComponent
	{
		private var _upArea:GSprite;
		private var _leftArea:GSprite;
		
		private var _lineList:Vector.<RuleLine> = new Vector.<RuleLine>();
		
		public function RuleView()
		{
			super();
			mouseEnabled = false;
			drawBg(3000);
			initView();
			initEvent();
		}
		
		private function drawBg(len:int):void
		{
			graphics.lineStyle(1,0x22ff22,1);
			graphics.lineTo(0,len);
			graphics.moveTo(0,0);
			graphics.lineTo(len,0);
			
			var text:TextField;
			for (var i:int = 0; i < len; i++) 
			{
				if(i % 50 == 0)
				{
					text = new TextField();
					text.mouseEnabled = text.mouseWheelEnabled = false;
					addChild(text);
					text.text = i.toString();
					text.x = i;
					text.y = 0-text.textHeight;
					
					text = new TextField();
					text.mouseEnabled = text.mouseWheelEnabled = false;
					addChild(text);
					text.text = i.toString();
					text.x = 0-text.textWidth-2;
					text.y = i;
					
					graphics.moveTo(i,0);
					graphics.lineTo(i,-5);
					graphics.moveTo(0,i);
					graphics.lineTo(-5,i);
				}else if(i % 10 == 0)
				{
					graphics.moveTo(i,0);
					graphics.lineTo(i,-3);
					graphics.moveTo(0,i);
					graphics.lineTo(-3,i);
				}
			}
		}
		
		private function initView():void
		{
			_upArea = new GSprite();
			_upArea.graphics.beginFill(0,0);
			_upArea.graphics.drawRect(0,0,3000,-50);
			_upArea.graphics.endFill();
			addChild(_upArea);
			
			_leftArea = new GSprite();
			_leftArea.graphics.beginFill(0,0);
			_leftArea.graphics.drawRect(0,0,-50,3000);
			_leftArea.graphics.endFill();
			addChild(_leftArea);
		}
		
		private function initEvent():void
		{
			_upArea.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownUpHandler);
			_leftArea.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownLeftHandler);
			App.stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUpHandler);
		}
		
		protected function onMouseDownLeftHandler(evt:MouseEvent):void
		{
			evt.stopImmediatePropagation();
			var line:RuleLine = new RuleLine(1);
			line.startDrag();
			addChild(line);
			_lineList.push(line);
		}
		
		protected function onMouseDownUpHandler(evt:MouseEvent):void
		{
			evt.stopImmediatePropagation();
			var line:RuleLine = new RuleLine(0);
			line.startDrag();
			addChild(line);
			_lineList.push(line);
		}
		
		protected function onMouseUpHandler(evt:MouseEvent):void
		{
			for (var i:int = 0; i < _lineList.length; i++) 
			{
				_lineList[i].stopDrag();
				if(_lineList[i].isOut)
				{
					var line:RuleLine = _lineList[i];
					_lineList.splice(i,1);
					i --;
					line.dispose();
				}
			}
		}
	}
}