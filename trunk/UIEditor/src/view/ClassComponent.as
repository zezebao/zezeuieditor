package view
{
	import mx.core.UIComponent;
	
	public class ClassComponent extends UIComponent
	{
		private var _className:String;
		
		private var _acitive:Boolean;
		
		public function ClassComponent()
		{
			super();
		}
		
		public function get acitive():Boolean
		{
			return _acitive;
		}

		public function set acitive(value:Boolean):void
		{
			_acitive = value;
			this.mouseChildren = this.mouseEnabled = value;
			this.alpha = value ? 1 : 0.8;
		}

		override public function get className():String
		{
			return _className;
		}

		public function set className(value:String):void
		{
			_className = value;
		}

		public function clear():void
		{
			while(this.numChildren)
			{
				this.removeChildAt(0);
			}
			className = "";
		}
	}
}