package data
{
	public class MenuType
	{
		public static var MEAN_TYPES:Vector.<int> = 
		
		private static var _menubarXML:XMLList;

		public static function get menubarXML():XMLList
		{
			if(!_menubarXML)
			{
				_menubarXML = 
//				<>
//					<test label="Menu1" data="top">
//						<item label="MenuItem 1-A" data="1A"/>
//						<item label="MenuItem 1-B" data="1B"/>
//					</test>
//					<menuitem2 label="Menu2" data="top">
//						<menuitem label="MenuItem 2-A" type="check" data="2A"/>
//						<menuitem type="separator"/>
//						<menuitem label="MenuItem 2-B" >
//							<menuitem label="SubMenuItem 3-A" type="radio"
//								groupName="one" data="3A"/>
//							<menuitem label="SubMenuItem 3-B" type="radio"
//								groupName="one" data="3B"/>
//						</menuitem>
//					</menuitem2>
//				</>;
			}
			return _menubarXML.children();
		}
		
	}
}