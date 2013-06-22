package
{
	import data.ShareObjManger;
	import data.vo.LibraryDragVo;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import help.ResourceTxtLoader;
	
	import manager.HotRectManager;
	import manager.LayerManager;
	import manager.LogManager;
	import manager.XMLParser;
	
	import mhqy.ui.UIManager;
	
	import mhsm.moviewrapper.MovieManager;
	
	import uidata.UIClassInfoList;
	import uidata.UIData;
	import uidata.UIElementBaseInfo;

	public class App
	{
		public static var rslLoaded:Boolean;
		public static var stage:Stage;
		public static var uiData:UIData;
		public static var configXML:XML;
		
		/**外部加载图片缓存[键值：图片名]*/
		public static var outsideImages:Dictionary = new Dictionary();
		
		/**外部库资源加载完成之后，调用此方法*/
		public static function setup(appStage:Stage,app:ZeZeUIEditor):void
		{
			stage = appStage;
			UIManager.setup(stage,movieManager,null,null);
			
			//initDatas
			uiData = new UIData();
		}
		
		//------------库元件拖动数据--------------------
		public static var dragVo:LibraryDragVo = new LibraryDragVo();
		//------------库元件复制数据--------------------
		public static var copyInfos:Vector.<UIElementBaseInfo>;
		//-----------类数据--------------------------
		public static var classInfoList:UIClassInfoList = new UIClassInfoList();
		
		//-----------managers----------------------------------------
		public static var soManger:ShareObjManger = new ShareObjManger();;
		public static var hotRectManager:HotRectManager = new HotRectManager();
		public static var layerManager:LayerManager = new LayerManager();
		public static var movieManager:MovieManager = new MovieManager();
		public static var log:LogManager = new LogManager();
		public static var xmlParser:XMLParser = new XMLParser();
		
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