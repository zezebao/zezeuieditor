using eokTQcMGCo4EXkLuPW;
using eZGOhwHsUbVjUNjdZQ;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Resources;
using System.Runtime.CompilerServices;
namespace Drawmaobi
{
	internal class MyPen
	{
		private int iwidth;
		private int iheight;
		private Graphics gr;
		private int i_mincount;
		private tagFPOINT oldpoint;
		private double old_width;
		private double i_endr;
		private double i_cwidth;
		private tagFPOINT nextpoint;
		private double i_end;
		private myImage myimg;
		private int i_minwidth;
		private List<tagFPOINT> n_list;
		private Random r_guid;
		private Color pen_color;
		[MethodImpl(MethodImplOptions.NoInlining)]
		public MyPen(int width, int height, Graphics g)
		{
			eBY7bi7YwxKvLu4W5N.CxqgSlQzFtivJ();
			this.i_mincount = 4;
			this.oldpoint = null;
			this.i_endr = 0.0;
			this.i_cwidth = 0.0;
			this.nextpoint = null;
			this.i_end = 0.0;
			this.myimg = null;
			this.i_minwidth = 5;
			this.n_list = new List<tagFPOINT>();
			this.pen_color = Color.Black;
			base..ctor();
			this.r_guid = new Random(default(Guid).GetHashCode());
			this.iwidth = width;
			this.iheight = height;
			this.gr = g;
			myImage myImage = new myImage();
			myImage.setwidth(40);
			myImage.sety(90);
			myImage.setheight(5);
			myImage.setx(90);
			ResourceManager resourceManager = new ResourceManager(typeof(Resource1));
			myImage.setimg((Bitmap)resourceManager.GetObject(ebjl5iduDGjiB8jAyt.eh1msj65w(10)));
			this.myimg = myImage;
		}
		[MethodImpl(MethodImplOptions.NoInlining)]
		public tagFPOINT getpoint()
		{
			tagFPOINT tagFPOINT = new tagFPOINT();
			tagFPOINT.setx(0);
			tagFPOINT.sety(0);
			tagFPOINT.settime2(0.0);
			tagFPOINT.settime(0.0);
			tagFPOINT tagFPOINT2 = tagFPOINT;
			int num = Math.Min(this.i_mincount, this.n_list.Count);
			tagFPOINT result;
			if (num == 0)
			{
				result = null;
			}
			else
			{
				for (int i = 1; i < num + 1; i++)
				{
					tagFPOINT tagFPOINT3 = this.n_list[this.n_list.Count - i];
					tagFPOINT2.setx(tagFPOINT2.getx() + tagFPOINT3.getx());
					tagFPOINT2.sety(tagFPOINT2.gety() + tagFPOINT3.gety());
					tagFPOINT2.settime(tagFPOINT2.gettime() + tagFPOINT3.gettime());
					tagFPOINT2.settime2(tagFPOINT2.gettime2() + tagFPOINT3.gettime2());
				}
				tagFPOINT2.setx(tagFPOINT2.getx() / num);
				tagFPOINT2.sety(tagFPOINT2.gety() / num);
				tagFPOINT2.settime(tagFPOINT2.gettime() / (double)num);
				tagFPOINT2.settime2(tagFPOINT2.gettime2() / (double)num);
				result = tagFPOINT2;
			}
			return result;
		}
		[MethodImpl(MethodImplOptions.NoInlining)]
		public void setcolor(Color value)
		{
			this.pen_color = value;
			this.myimg.setcolor(this.pen_color);
		}
		[MethodImpl(MethodImplOptions.NoInlining)]
		public void push(tagFPOINT val)
		{
			this.n_list.Add(val);
		}
		[MethodImpl(MethodImplOptions.NoInlining)]
		public void drawpen(bool A_0)
		{
			tagFPOINT tagFPOINT = this.getpoint();
			if (tagFPOINT != null)
			{
				if (this.oldpoint == null)
				{
					this.oldpoint = tagFPOINT;
				}
				double val = tagFPOINT.gettime() - this.oldpoint.gettime();
				double num = this.cale_width(tagFPOINT, this.oldpoint);
				double num2 = num / Math.Max(1.0, val);
				double num3 = (this.i_endr == 0.0) ? 0.0 : (num2 / this.i_endr);
				double num4 = (double)this.myimg.getwidth() - Math.Min((double)(this.myimg.getwidth() - this.myimg.getheight()), Math.Max(0.0, num2 * 12.0));
				num4 = Math.Max((double)this.myimg.getheight(), this.cale_width2(num2, this.myimg.getwidth(), -this.myimg.getwidth() - this.myimg.getheight(), this.i_minwidth));
				if (tagFPOINT.gettime2() > 0.0)
				{
					num4 = Math.Max((double)this.myimg.getheight(), (double)this.myimg.getwidth() * tagFPOINT.gettime2());
				}
				tagFPOINT.settime3(num4);
				this.draw_pen(this.oldpoint, tagFPOINT, num4, num);
				this.i_end = num3;
				this.nextpoint = this.cale_point(this.oldpoint, tagFPOINT, 1.0 + this.i_end);
				this.oldpoint = tagFPOINT;
				this.old_width = num4;
				this.i_endr = num2;
				this.i_cwidth = num;
			}
		}
		[MethodImpl(MethodImplOptions.NoInlining)]
		public double cale_width(tagFPOINT val, tagFPOINT val2)
		{
			int num = (val2.getx() - val.getx()) * (val2.getx() - val.getx()) + (val2.gety() - val.gety()) * (val2.gety() - val.gety());
			return (num == 0) ? ((double)num) : Math.Sqrt((double)num);
		}
		[MethodImpl(MethodImplOptions.NoInlining)]
		private tagFPOINT cale_point(tagFPOINT val, tagFPOINT val2, double A_2)
		{
			tagFPOINT tagFPOINT = new tagFPOINT();
			double num = (double)val.getx() + (double)(val2.getx() - val.getx()) * A_2;
			double num2 = (double)val.gety() + (double)(val2.gety() - val.gety()) * A_2;
			tagFPOINT.setx((int)num);
			tagFPOINT.sety((int)num2);
			return tagFPOINT;
		}
		[MethodImpl(MethodImplOptions.NoInlining)]
		private void draw_pen(tagFPOINT A_0, tagFPOINT A_1, double A_2, double A_3)
		{
			double num = 0.0;
			double num2 = A_2 - this.old_width;
			while (num < 1.0)
			{
				double num3 = Math.Min(this.old_width + num2 * num, (double)this.myimg.getwidth());
				tagFPOINT tagFPOINT = this.cale_point(A_0, A_1, num);
				if ((double)this.r_guid.Next(1000000) * 1E-06 > 0.2)
				{
					int num4 = (((double)this.r_guid.Next(1000000) * 1E-06 > 0.5) ? 1 : -1) * Convert.ToInt32((double)this.r_guid.Next(1000000) * 1E-06 * 1.2);
					double num5 = (double)tagFPOINT.getx() - num3 / 2.0 + (double)num4;
					double num6 = (double)tagFPOINT.gety() - num3 / 2.0 + (double)num4;
					this.gr.DrawImage(this.myimg.getimg(), (float)num5, (float)num6, (float)num3, (float)num3);
				}
				num += 1.0 / A_3;
			}
		}
		[MethodImpl(MethodImplOptions.NoInlining)]
		private double cale_width2(double A_0, int A_1, int A_2, int A_3)
		{
			return (double)A_2 * A_0 / (double)A_3 + (double)A_1;
		}
		[MethodImpl(MethodImplOptions.NoInlining)]
		public Image getimg(Image img, Color A_1, int A_2, int A_3)
		{
			return img;
		}
		[MethodImpl(MethodImplOptions.NoInlining)]
		public void drawstart()
		{
			this.n_list.Clear();
			this.oldpoint = null;
			this.old_width = 0.0;
			this.i_endr = 0.0;
			this.i_cwidth = 0.0;
			this.nextpoint = null;
			this.i_end = 0.0;
		}
		[MethodImpl(MethodImplOptions.NoInlining)]
		public void drawend()
		{
			if (this.i_end > 1.0)
			{
				tagFPOINT tagFPOINT = new tagFPOINT();
				tagFPOINT.setx(this.nextpoint.getx());
				tagFPOINT.sety(this.nextpoint.gety());
				tagFPOINT.settime(this.i_end / (this.i_cwidth * this.i_endr) + this.oldpoint.gettime());
				tagFPOINT.settime2(this.oldpoint.gettime2() * Math.Min(this.i_end / (this.i_cwidth * this.i_endr), 1.0));
				tagFPOINT item = tagFPOINT;
				int i = 0;
				int num = this.i_mincount;
				while (i < num)
				{
					this.n_list.Add(item);
					i++;
				}
				this.drawpen(true);
			}
		}
	}
}
