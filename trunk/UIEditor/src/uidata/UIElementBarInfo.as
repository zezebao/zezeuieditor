package uidata
{
	import uidata.vo.PropertyVo;

	public class UIElementBarInfo extends UIElementBaseInfo
	{
		public var barType:int = 1;
		
		public function UIElementBarInfo()
		{
			type = UIClassType.UIDEFAULTBAR;
			canScale = true;
			width = 100;
			height = 20;
		}
		
		override public function getPropertys():Vector.<PropertyVo>
		{
			var vec:Vector.<PropertyVo> = new Vector.<PropertyVo>();
			vec.push(new PropertyVo("barType",Number,this.barType,[1,3,6,7,8],null,true,true));
			return vec.concat(super.getPropertys());
		}
		
		
	}
}