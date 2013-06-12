/**--------------------------2012-8-24-------------------------------**/
package uidata.vo
{
	import mx.collections.ArrayCollection;

	/**
	 *  ProtertyVo.as 
	 *  @author feilong
	 *  
	 */
	public class PropertyVo
	{
		/**属性名*/
		public var proterty:String;
		/**属性值类型*/
		public var proClass:Class;
		public var value:Object;
		public var isCanEdit:Boolean;
		public var dataProvider:ArrayCollection;
		/**改变此属性是否会刷新视图*/
		public var isChangeView:Boolean;
		/**
		 * @param pname   属性名
		 * @param type    值类型
		 * @param value   值
		 * @param data   
		 * @param labels
		 * @param canEdit 该值是否可编辑
		 * </br>注：判断优先级、类型、值型，
		 * 1.若类型为Boolean，则不考虑其他参数，值为true跟false，
		 * 2.若dataProvider不为空，则使用下拉列表值
		 * 3.如类型为Number，则手动赋值
		 * 4.如类型为String 
		 */				
		public function PropertyVo(pname:String,type:Class,pvalue:Object,datas:Array=null,labels:Array=null,canEdit:Boolean=true,isChangeView:Boolean=false)
		{
			proterty = pname;		
			proClass = type;
			value = pvalue;
			isCanEdit = canEdit;
			this.isChangeView = isChangeView;
			if(datas != null)
			{
				dataProvider = new ArrayCollection();
				var len:int = datas.length;
				for (var i:int = 0; i < len; i++) 
				{
					if(labels)dataProvider.addItem({"label":labels[i],"data":datas[i]});
					else dataProvider.addItem({"label":datas[i],"data":datas[i]});
				}
			}
		}
	}
}