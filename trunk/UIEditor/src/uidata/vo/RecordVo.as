package uidata.vo
{
	public class RecordVo
	{
		public var x:int;
		public var y:int;
		public var width:int;
		public var height:int;
		
		public function RecordVo()
		{
		}
		
		/**判断两次记录值是否一致*/
		public function equal(value:RecordVo):Boolean
		{
			return(
				   this.x == value.x
				&& this.y == value.y
				&& this.width == value.width
				&& this.height == value.height
				);
		}
	}
}