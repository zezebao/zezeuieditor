package utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.utils.getDefinitionByName;
	
	import uidata.vo.UIClassVo;

	public class UICreater
	{
		public function UICreater()
		{
		}
		
		public static function create(classVo:UIClassVo):DisplayObject
		{
			var objClass:Class = getDefinitionByName(classVo.className) as Class;
			if(!objClass) return null;
			var childObj:Object;
			switch(classVo.parms.length)
			{
				case 0:
					childObj = new objClass();
					break;
				case 1:
					childObj = new objClass(classVo.parms[0]);
					break;
				case 2:
					childObj = new objClass(classVo.parms[0],classVo.parms[1]);
					break;
				case 3:
					childObj = new objClass(classVo.parms[0],classVo.parms[1],classVo.parms[2]);
					break;
				case 4:
					childObj = new objClass(classVo.parms[0],classVo.parms[1],classVo.parms[2],classVo.parms[3]);
					break;
			}
			if(childObj is DisplayObject)
			{
				return childObj as DisplayObject;
			}else if(childObj is BitmapData)
			{
				var bm:Bitmap = new Bitmap(childObj as BitmapData);
				return bm;
			}
			return null;
		}
	}
}