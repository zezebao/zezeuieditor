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
		/**属性tip*/
		public var toolTip:String;
		/**属性值类型*/
		public var propertyType:uint;
		public var value:Object;
		public var isCanEdit:Boolean;
		public var dataProvider:ArrayCollection;
		/**改变此属性是否会刷新视图*/
		public var isChangeView:Boolean;
		/**
		 * @param pname   属性名
		 * @param type    值类型
		 * @param value   值
		 * @param data    数组类型，如果为二维数组，则数组子项数组格式应该为[label,data]
		 * @param labels
		 * @param canEdit 该值是否可编辑
		 * @param isChangeView 改变值时是否重新刷新视图
		 * </br>注：判断优先级、类型、值型，
		 * 1.若类型为Boolean，则不考虑其他参数，值为true跟false，
		 * 2.若dataProvider不为空，则使用下拉列表值
		 * 3.如类型为Number，则手动赋值
		 * 4.如类型为String 
		 */				
		public function PropertyVo(pname:String,tip:String,proType:uint,pvalue:Object,datas:Array=null,canEdit:Boolean=true,isChangeView:Boolean=false)
		{
			proterty = pname;
			toolTip = tip;
			propertyType = proType;
			value = pvalue;
			isCanEdit = canEdit;
			this.isChangeView = isChangeView;
			if(datas != null)
			{
				dataProvider = new ArrayCollection();
				var len:int = datas.length;
				for (var i:int = 0; i < len; i++) 
				{
					if(datas[i] is Array)
					{
						dataProvider.addItem({"label":datas[i][0],"data":datas[i][1]});
					}else
					{
						dataProvider.addItem({"label":datas[i],"data":datas[i]});
					}
				}
			}
		}
	}
}