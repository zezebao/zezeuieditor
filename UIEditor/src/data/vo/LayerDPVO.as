package data.vo
{
	import flash.utils.getQualifiedClassName;
	
	import ghostcat.ui.Focus;
	
	import manager.LanguageManager;
	
	import mx.controls.List;
	
	import uidata.UIElementBaseInfo;
	
	import view.HotRectControl;
	import view.item.RenderItemIcon;

	public class LayerDPVO
	{
		//{"label": i + ":" + getLockStr() + label,"layer":i,"type":1,"info":item.uiInfo,"icon":RenderItemIcon}
		public var label:String;
		private var _layer:int;
		public var type:int;
		public var info:UIElementBaseInfo;
		public var icon:Class;
		
		private var _item:HotRectControl;
		private var _updateCallBack:Function;
		
		public function LayerDPVO(item:HotRectControl,updateCallBack:Function)
		{
			_item = item;
			_updateCallBack = updateCallBack;
			
			info = _item.uiInfo;
			type = 1;
			icon = RenderItemIcon; 
		}
		
		public function get layer():int
		{
			return _layer;
		}

		public function set layer(value:int):void
		{
			_layer = value;
			
			var layerName:String = info.layerName;
			if(layerName == "")layerName = getQualifiedClassName(_item.content);
			else
			{
				layerName = LanguageManager.getWord(layerName);
				if(layerName == "")
				{
					layerName = info.layerName;
				}
				else if(layerName.length >= 10)
				{
					layerName = layerName.substr(0,10);
				}
			}
			
			label = _layer + ":" + getLockStr() + layerName;
		}

		public function update():void
		{
			_layer = layer;
			if(_updateCallBack != null)_updateCallBack();
		}
		
		private function getLockStr():String
		{
			return info.locked ? "[锁]" : "";
		}
	}
}