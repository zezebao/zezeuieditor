package uidata
{
	import uidata.vo.PropertyVo;

	public class UIElementBorderInfo extends UIElementBaseInfo
	{
		public var borderType:int = 1;
		
		public function UIElementBorderInfo()
		{
			type = UIClassType.UIDEFAULTBORDER;
			canScale = true;
			width = 100;
			height = 50;
		}
		
		override public function getPropertys():Vector.<PropertyVo>
		{
			var vec:Vector.<PropertyVo> = new Vector.<PropertyVo>();
			vec.push(new PropertyVo("borderType",Number,this.borderType,[1,2,4,5,6,7,8,9],null,true,true));
			return vec.concat(super.getPropertys());
		}
		
		
	}
}