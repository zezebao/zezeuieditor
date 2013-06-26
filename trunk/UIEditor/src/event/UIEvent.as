package event
{
	import flash.events.Event;
	
	public class UIEvent extends Event
	{
		/**外部库资源加载完成*/
		public static const RSL_LOAD_COMPLETE:String = "RSLLibsLoadComplete";
		/**
		 * 选中库元件</br>
		 * [数据：全限定类名]
		 */		
		public static const LIBRARY_SELECT_ITEM:String = "librarySelectItem";
		/**
		 * 是否选中切换（层级面板通知舞台刷新）</br>
		 * [数据，选中索引数组，根据子级层级索引]
		 */
		public static const LAYERS_SELECT_UPDATE:String = "layersSelectUpdate";
		/**
		 * 是否选中切换（舞台通知层级面板刷新）</br>
		 * [数据，选中索引数组，根据子级层级索引]
		 */
		public static const STAGE_SELECT_UPDATE:String = "layersSelectUpdate";
		
		/**info更新,舞台触发[数据：无]*/
		public static const INFO_UPDATE_STAGE:String = "infoUpdateStage";
		/**info更新,属性面板触发[数据：Boolean，是否重新获取外形]*/
		public static const INFO_UPDATE_PROPERTY:String = "infoUpdateProperty";
		
		/**添加一个新类 [数据：类名]*/
		public static const CLASS_UPDATE:String = "classUpdate";		
		
		/**选中一个类 [数据：全限定类名]*/
		public static const SELECT_A_CLASS:String = "selectAClass";
		
		/**放大缩小*/
		public static const STAGE_ENLARGE:String = "stageEnlarge";
		public static const STAGE_LESSON:String = "stageLesson";
		public static const STAGE_NO_SCALE:String = "stageNoScale";
		
		/**property focus chage [data:PropertyItemView]*/
		public static const PRPPERTY_FOCUS_CHANGE:String = "propertyFocusChange";
		
		/**alt copy [data:Vector.<UIElementBaseInfo>]*/
		public static const ALT_COPY_INFOS:String = "altCopyInfos";
		
		/**层级辅助类更新[数据：无]*/
		public static const HELP_CLASS_UPDATE:String = "helpClassUpdate";
		/**辅助层级选中[数据：选中类名]*/
		public static const HELP_CLASS_SELECTED:String = "helpClassSelected";
		
		
		public var data:Object;
		
		public function UIEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.data = data;
			super(type, bubbles, cancelable);
		}
	}
}