package data
{
	import flash.events.Event;
	
	public class MyEvent extends Event
	{
		public static const REPLACE:String = "replace";
		
		public function MyEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}