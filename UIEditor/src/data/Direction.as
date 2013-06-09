package data
{
	public class Direction
	{
		public static const UP:int = 0x0001;
		public static const DOWN:int = 0x0002;
		public static const LEFT:int = 0x0004;
		public static const RIGHT:int = 0x0008;
		
		public function Direction()
		{
		}
		
		public static function getDirect(value:int):Vector.<int>
		{
			var vec:Vector.<int> = new Vector.<int>();
			if(value & UP)vec.push(UP);
			if(value & DOWN)vec.push(DOWN);
			if(value & LEFT)vec.push(LEFT);
			if(value & RIGHT)vec.push(RIGHT);
			return vec;
		}
	}
}