package uidata
{
	import uidata.vo.PropertyVo;

	public class UIElementBorderInfo extends UIElementBaseInfo
	{
		public var borderType:int;
		
		public function UIElementBorderInfo()
		{
			type = UIClassType.UIDEFAULTBORDER;
		}
		
		override public function getPropertys():Vector.<PropertyVo>
		{
			var vec:Vector.<PropertyVo> = new Vector.<PropertyVo>();
			vec.push(new PropertyVo("borderType","border",Number,this.borderType,[1,2,5]));
			return vec.concat(super.getPropertys());
		}
		
		
	}
}