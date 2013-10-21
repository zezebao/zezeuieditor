package uidata
{
	import data.PropertyType;
	
	import event.UIEvent;
	
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import uidata.vo.PropertyVo;

	/**
	 * 多选编辑类型，此类型仅让可编辑x,y属性,
	 * 使用：App存有它一个全局引用，每次选中、脱选，都应该更新它的数据
	 * 继承自UIElementBaseInfo 因为要使用属性面板操控，此类
	 * @author Administrator
	 */	
	public class UIElementMultipleSelectInfo extends UIElementBaseInfo
	{
		private var _vec:Vector.<UIElementBaseInfo>;
		private var _delayIndex:int = -1;
		
		public function UIElementMultipleSelectInfo()
		{
			type = 99;
			this.addEventListener(UIEvent.INFO_UPDATE_PROPERTY,infoUpdateHandler);
		}
		
		public function get vec():Vector.<UIElementBaseInfo>
		{
			return _vec;
		}

		protected function infoUpdateHandler(event:Event):void
		{
			updateProperty(0);
		}
		
		/**
		 * 
		 * @param type  类型0：从属性面板更新，应该计算属性差值来布局子元素坐标
		 * </br> 类型1：从Stage更新，位置已经更新，直接修改Info自身的x，y属性值
		 * 
		 */		
		private function updateProperty(type:int):void
		{
			if(_vec && _vec.length > 0)
			{
				var lowX:int = _vec[0].x;
				var lowY:int = _vec[0].y;
				var i:int;
				for (i = 1; i < _vec.length; i++) 
				{
					if(lowX > _vec[i].x)lowX = _vec[i].x;
					if(lowY > _vec[i].y)lowY = _vec[i].y;
				}
				switch(type)
				{
					case 0:
						var disX:int = this.x - lowX;
						var disY:int = this.y - lowY;
						for (i = 0; i < _vec.length; i++) 
						{
							_vec[i].x += disX;
							_vec[i].y += disY;
							_vec[i].update("");
						}
						break;
					case 1:
						this.x = lowX;
						this.y = lowY;
						break;
				}
			}
		}
		
		/**延迟更新*/
		public function delayUpdate():void
		{
			if(_delayIndex == -1)
			{
				_delayIndex = setTimeout(delayUpdateHandler,50);
			}
		}
		
		private function delayUpdateHandler():void
		{
			_delayIndex = -1;
			updateProperty(1);
			dispatchEvent(new UIEvent(UIEvent.INFO_UPDATE_STAGE));
		}
		
		public function hasMultiple():Boolean
		{
			return _vec && _vec.length > 1;
		}
		
		public function updateSelects(vec:Vector.<UIElementBaseInfo>):void
		{
			_vec = vec;
			updateProperty(1);
		}
		
		override public function getPropertys():Vector.<PropertyVo>
		{
			var vec:Vector.<PropertyVo> = new Vector.<PropertyVo>();
			vec.push(new PropertyVo("x","x坐标",PropertyType.NUMBER,this.x));
			vec.push(new PropertyVo("y","y坐标",PropertyType.NUMBER,this.y));
			return vec;
		}
	}
}