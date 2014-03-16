package view.preview
{
	import data.Config;
	import data.PreviewSortItem;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TransformGestureEvent;
	import flash.filesystem.File;
	import flash.filters.GlowFilter;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.getTimer;
	
	import flashx.textLayout.elements.Configuration;
	
	import org.gestouch.events.GestureEvent;
	import org.gestouch.gestures.SwipeGesture;
	
	import view.Background;
	import view.BaseButton;
	
	public class Preview extends Sprite
	{
		private const pageCount:int = 5;
		
		private var _homeBtn:BaseButton;
		private var _imgItems:Vector.<PreviewItemView> = new Vector.<PreviewItemView>();
		private var _itemCon:Sprite;
		private var _bg:Background;	
		private var _downX:Number = NaN;
		private var _currentPage:int = 1;
		private var _totalPage:int = 1;
		private var _imgList:Array = [];
		private var _pageTf:TextField;
		private var _imgView:PreviewImg;
		private var _main:IApplication;
		
		public function Preview(main:IApplication)
		{
			super();
			_main = main;
			initView();
			if(stage)init();
			else this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function initView():void
		{
			_bg = new Background(1);
			addChild(_bg);
			
			_itemCon = new Sprite();
			addChild(_itemCon);
			_itemCon.y = 150;
			
			_homeBtn = new BaseButton(Config.HOME_IMG,false);
			addChild(_homeBtn);
			
			_pageTf = new TextField();
			_pageTf.defaultTextFormat = new TextFormat("微软雅黑",80);
			_pageTf.width = 1000;
			_pageTf.textColor = 0xffffff;
			_pageTf.filters = [new GlowFilter(0)];
			_pageTf.mouseEnabled = _pageTf.mouseWheelEnabled = false;
			addChild(_pageTf);
			
			initPreviewItems();
			
			_imgView = new PreviewImg();
			addChild(_imgView);
			
			graphics.beginFill(0xffffff);
//			graphics.drawRect(
			graphics.endFill();
		}
		
		private function initPreviewItems():void
		{
			for (var i:int = 0; i < pageCount; i++) 
			{
				var item:PreviewItemView = new PreviewItemView(this);
				item.doubleClickEnabled = true;
				item.addEventListener(MouseEvent.MOUSE_DOWN,onClickItemHandler);
				item.addEventListener(MouseEvent.DOUBLE_CLICK,onItemDoubleClickHandler);
				_itemCon.addChild(item);
				
				var scale:Number = 0.16;
				item.x = Config.SCREEN_WIDTH * 0.05 + int(i % pageCount) * (Config.SCREEN_WIDTH * 0.18);
//				item.x = Config.PREVIEW_X + (i % pageCount) * (320 + 25);
				item.y = Config.PREVIEW_Y;
				
				_imgItems.push(item);
			}
		}
		
		private function init(evt:Event=null):void
		{
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			stage.addEventListener(Event.RESIZE,onResizeHandler);
			
			_homeBtn.addEventListener(MouseEvent.CLICK,onClickHandler);
			_bg.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUpHandler);
			
			updatePages();
			onResizeHandler(null);
		}
		
		private function updatePages():void
		{
			//var file:File = new File(File.applicationDirectory.nativePath + "/output/small/");
			var file:File = new File(File.applicationDirectory.nativePath + "/output/");
			if(file.exists)
			{
				var tmp:Array = file.getDirectoryListing();
				var sortArr:Array = [];
				for (var i:int = 0; i < tmp.length; i++) 
				{
					var sortItem:PreviewSortItem = new PreviewSortItem(tmp[i] as File);
					sortArr.push(sortItem);
				}
				sortArr = sortArr.sortOn("time",Array.DESCENDING);
				_imgList = [];
				for (var j:int = 0; j < sortArr.length; j++) 
				{
					_imgList[j] = sortArr[j].file;
				}
				_totalPage = Math.ceil(_imgList.length / pageCount);
			}
			setPage();
		}
		
		protected function onMouseUpHandler(event:MouseEvent):void
		{
			if(!stage)return;
			if(_downX == 0)return;
			
			var offsetX:Number = 150;
			var dis:Number = mouseX - _downX;
			if(dis > offsetX)
			{
				prePage();
			}else if(dis < -offsetX)
			{
				nextPage();	
			}
			_downX = 0;
		}
		
		protected function onMouseDownHandler(event:MouseEvent):void
		{
			_downX = stage.mouseX;
		}
		
		public function delItem(item:PreviewItemView):void
		{
			
			var file:File=new File(); 
			file.nativePath=item.bigPicPath;
			if(file.exists)
			{
				file.deleteFile();	
			}
			updatePages();
		}
		
		public function nextPage():void
		{
			trace("nextPage");
			if(_totalPage <= 1)return;
			_currentPage ++;
			if(_currentPage > _totalPage)
			{
				_currentPage = 1;
			}
			setPage();
		}
		
		public function prePage():void
		{
			trace("prePage");
			if(_totalPage <= 1)return;
			_currentPage --;	
			if(_currentPage < 1)
			{
				_currentPage = _totalPage;
			}
			setPage();
		}
		
		private function setPage():void
		{
			_pageTf.text = _currentPage + "/" + _totalPage;
			
			var arr:Vector.<String> = new Vector.<String>();
			var len:int = _currentPage * pageCount;
			if(_currentPage * pageCount > _imgList.length)len = _imgList.length;
			for (var j:int = (_currentPage-1)*pageCount; j < len; j++) 
			{
				var file:File = _imgList[j] as File;
				var path:String = file.nativePath;
//				path = path.replace("small","big"); 
				arr.push(path);
			}
			for (var i:int = 0; i < _imgItems.length; i++) 
			{
				if(arr.length > i)
				{
					_imgItems[i].load(arr[i]);	
				}else
				{
					_imgItems[i].clear();
				}
			}
		}
		
		protected function onItemDoubleClickHandler(event:MouseEvent):void
		{
			var item:PreviewItemView = event.currentTarget as PreviewItemView;
			if(item.bigPicPath != "")
			{
				_imgView.load(item.bigPicPath);
			}
		}
		
		protected function onClickItemHandler(event:MouseEvent):void
		{
			var item:PreviewItemView = event.currentTarget as PreviewItemView;
			item.showDelBtn();
		}
		
		protected function onClickHandler(event:MouseEvent):void
		{
			if(parent)
			{
				parent.removeChild(this);
				System.gc();
			}
		}
		
		protected function onResizeHandler(event:Event):void
		{
			_homeBtn.x = 100;
			_homeBtn.y = Config.SCREEN_HEIGHT - 100;
			
			_pageTf.x = Config.SCREEN_WIDTH / 2;
			_pageTf.y = Config.SCREEN_HEIGHT - 130;
		}
	}
}