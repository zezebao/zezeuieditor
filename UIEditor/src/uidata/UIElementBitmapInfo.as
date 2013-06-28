package uidata
{
	import data.Config;
	import data.PropertyType;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.IDataOutput;
	
	import mhqy.ui.UIType;
	
	import uidata.vo.PropertyVo;

	public class UIElementBitmapInfo extends UIElementBaseInfo
	{
		private var _className:String;
		public var isBitmapButton:Boolean;
		public var label:String="";
		public var isOutside:Boolean;
		
		private var _bitmap:Bitmap;
		private var _bitmapData:BitmapData;
		private var _imgLoader:Loader;
		
		public function UIElementBitmapInfo(className:String="",isOutside:Boolean=false)
		{
			_bitmap = new Bitmap();
			bitmapData = new BitmapData(100,100);

			this.isOutside = isOutside;
			_className = className;
			type = UIType.BITMAP;
			
			getProperty("width").isCanEdit = false;
			getProperty("height").isCanEdit = false;
			
			_imgLoader = new Loader();
			_imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,onImgCompleteHandler);
			_imgLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onErrorHandler);
		}
		
		public function set bitmapData(value:BitmapData):void
		{
			_bitmapData = value;
			_bitmap.bitmapData = _bitmapData;
		}

		protected function onImgCompleteHandler(event:Event):void
		{
			var bitmap:Bitmap = _imgLoader.content as Bitmap;
			bitmapData = bitmap.bitmapData;
			
			App.outsideImages[_className] = _bitmapData;
		}
		
		protected function onErrorHandler(event:IOErrorEvent):void
		{
			_bitmapData = new BitmapData(100,100);
			var tf:TextField = new TextField();
			tf.width = 100;
			tf.wordWrap = true;
			tf.textColor = 0xff0000;
			tf.text = _className + "不存在";
			_bitmapData.draw(tf);
			bitmapData = _bitmapData;
		}
		/**具体类映射,如果是外部图片，则为图片名*/
		public function get className():String
		{
			return _className;
		}
		/**
		 * @private
		 */
		public function set className(value:String):void
		{
			_className = value;
			if(isOutside)
			{
				if(App.outsideImages[_className])
				{
					bitmapData = App.outsideImages[_className];
				}else
				{
					_imgLoader.load(new URLRequest(Config.site + _className));
				}
			}
		}
		
		public function get bitmap():Bitmap
		{
			className = _className;
			return _bitmap;	
		}

		override public function get type():int
		{
			if(isBitmapButton)return UIType.BITMAP_BTN;
			return _type;
		}
		
		override public function readXML(xml:XML):void
		{
			super.readXML(xml);
			className = xml.@className;
			isBitmapButton = xml.@isBitmapButton == "true";
			label = xml.@label;
			isOutside = xml.@isOutside == "true";
		}
		
		override public function writeData(source:IDataOutput):void
		{
			super.writeData(source);
			source.writeByte(0);
			source.writeUTF(className);
			source.writeBoolean(isOutside);
			if(isBitmapButton)
			{
				source.writeUTF(label);
			}
		}
		
		override public function getPropertys():Vector.<PropertyVo>
		{
			var vec:Vector.<PropertyVo> = new Vector.<PropertyVo>();
			vec.push(new PropertyVo("isOutside","是否外部图片",PropertyType.STRING,this.isOutside,null,false));
			vec.push(new PropertyVo("isBitmapButton","是否是按钮",PropertyType.DATAPROVIDER,this.isBitmapButton,[true,false],true,true));
			vec.push(new PropertyVo("className","反射类名",PropertyType.STRING,this.className,null,true,true));
			vec.push(new PropertyVo("label","如果是BITMAP_BUTTON，则设置此参数",PropertyType.STRING,this.label));
			return vec.concat(super.getPropertys());
		}
		
		override public function clone():*
		{
			var info:UIElementBitmapInfo = super.clone() as UIElementBitmapInfo;
			info.isOutside = isOutside;
			info.className = className;
			info.isBitmapButton = isBitmapButton;
			info.label = label;
			return info;
		}
		
		override public function toString():String
		{
			var arr:Array = [
				["className",className],
				["isBitmapButton",isBitmapButton],
				["label",label],
				["isOutside",isOutside]
			];
			return creatContent(arr) + super.toString();
		}
	}
}