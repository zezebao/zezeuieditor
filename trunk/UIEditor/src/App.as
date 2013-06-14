package
{
	import data.ShareObjManger;
	import uidata.UIClassInfoList;
	import data.vo.LibraryDragVo;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import help.ResourceTxtLoader;
	
	import manager.HotRectManager;
	import manager.LayerManager;
	import manager.XMLParser;
	
	import mhqy.ui.UIManager;
	
	import mhsm.core.manager.LanguageManager;
	import mhsm.moviewrapper.MovieManager;
	
	import uidata.UIData;

	public class App
	{
		public static var stage:Stage;
		
		public static var classInfoList:UIClassInfoList = new UIClassInfoList();
		
		public static var soManger:ShareObjManger = new ShareObjManger();;
		public static var hotRectManager:HotRectManager = new HotRectManager();
		public static var layerManager:LayerManager = new LayerManager();
		public static var movieManager:MovieManager = new MovieManager();
		public static var xmlParser:XMLParser = new XMLParser();
		
		public static var uiData:UIData = new UIData();
		
		public static function setup(appStage:Stage,app:ZeZeUIEditor):void
		{
			stage = appStage;
			UIManager.setup(stage,movieManager,null,null);
			new ResourceTxtLoader();
		}
		
		//------------库元件拖动数据--------------------
		public static var dragVo:LibraryDragVo = new LibraryDragVo();
		
		//------------事件收发---------------------------		
		private static var _dispatcher:EventDispatcher = new EventDispatcher();
		public static function dispathEvent(evt:Event):void 
		{
			_dispatcher.dispatchEvent(evt);
		}
		public static function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			_dispatcher.addEventListener(type,listener,useCapture,priority,useWeakReference);
		}
		public static function removeEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			_dispatcher.removeEventListener(type,listener,useCapture);
		}
	}
}