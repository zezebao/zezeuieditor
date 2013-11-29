package
{
	import data.ShareObjManger;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	
	import help.ResourceTxtLoader;
	
	import manager.HotRectManager;
	import manager.LayerManager;
	import manager.LogManager;
	import manager.XMLParser;
	
	import mhqy.ui.UIManager;
	
	import mhsm.moviewrapper.MovieManager;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	import uidata.UIClassInfo;
	import uidata.UIClassInfoList;
	import uidata.UIData;
	import uidata.UIElementBaseInfo;
	import uidata.UIElementMultipleSelectInfo;

	public class App
	{
		//当前域
		private static var _currentDomain:ApplicationDomain;
		//已有域
		public static var hasDomain:Vector.<ApplicationDomain> = new Vector.<ApplicationDomain>();
		
		/**当前操作类的类名*/
		public static var currentClass:String;
		public static var rslLoaded:Boolean;
		public static var stage:Stage;
		public static var uiData:UIData;
		public static var configXML:XML;
		public static var multipleSelectInfo:UIElementMultipleSelectInfo = new UIElementMultipleSelectInfo();
		
		/**外部加载图片缓存[键值：图片名]*/
		public static var outsideImages:Dictionary = new Dictionary();
		
		public static function get currentDomain():ApplicationDomain
		{
			return _currentDomain;
		}

		public static function set currentDomain(value:ApplicationDomain):void
		{
			_currentDomain = value;
			if(value != null && hasDomain.indexOf(value) != -1)
			{
				hasDomain.push(value);
			}
		}

		public static function initStage(appStage:Stage):void
		{
			stage = appStage;
		}
		/**外部库资源加载完成之后，调用此方法*/
		public static function setup(app:ZeZeUIEditor):void
		{
			UIManager.setup(stage,movieManager,null,null,"");
			
			//initDatas
			uiData = new UIData();
			stage.addChild(log);
		}
		
		//------------库元件复制数据--------------------
		public static var copyInfos:Vector.<UIElementBaseInfo>;
		//====================================================================================
		//====================================================================================
		//-----------类数据--------------------------
		//====================================================================================
		public static var xmlLoaded:Boolean;
//		public static var classInfoList:UIClassInfoList = new UIClassInfoList();
		/**UI XML列表【键值:UIClassInfoList.fileName,值：UIClassInfoList】*/
		public static var xmlClassList:Dictionary = new Dictionary();
		public static function addClassList(data:*,fileName:String):void
		{
			var classList:UIClassInfoList = new UIClassInfoList(fileName);
			classList.parseXML(XML(data));
			xmlClassList[classList.fileName] = classList;
		}
		public static function hasClass(value:String):Boolean
		{
			for each (var classList:UIClassInfoList in xmlClassList) 
			{
				if(classList.hasClass(value))
				{
					return true;
				}
			}
			return false;
		}
		public static function getClassInfo(value:String):UIClassInfo
		{
			for each (var classList:UIClassInfoList in xmlClassList) 
			{
				if(classList.hasClass(value))
				{
					return classList.getClassInfo(value);
				}
			}
			return null;
		}
		public static function getChildList():ArrayCollection
		{
			var array:ArrayCollection = new ArrayCollection();
			for each (var classList:UIClassInfoList in xmlClassList) 
			{
				array.addItem({label:classList.fileName,"value":classList.fileName,children:classList.getChildList()});
			}
			return array;
		}
		public static function addClass(className:String,fileName:String):void
		{
			var classList:UIClassInfoList = xmlClassList[fileName];
			if(classList == null)
			{
				classList = new UIClassInfoList(fileName);
				xmlClassList[fileName] = classList;
			}
			classList.addClass(className);
			
			App.log.echo("新建类：---",fileName,"--->",className);
		}
		public static function delClass(delClassName:String):void
		{
			for each (var classList:UIClassInfoList in xmlClassList) 
			{
				if(classList.hasClass(delClassName))
				{
					classList.delClass(delClassName);
					Alert.show("删除成功","",4,layerManager.stagePanel);
					App.log.echo("删除类：",delClassName);
					return;
				}
			}
		}
		public static function saveRange(className:String):void
		{
			for each (var classList:UIClassInfoList in xmlClassList) 
			{
				if(classList.hasClass(className))
				{
					classList.isChange = true;
				}
			}
		}
		
		/**活动当前正在编辑的类*/
		public static function get classInfo():UIClassInfo
		{
			return getClassInfo(currentClass);
		}
		//====================================================================================
		//====================================================================================
		//====================================================================================
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