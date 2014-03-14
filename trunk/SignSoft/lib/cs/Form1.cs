using eokTQcMGCo4EXkLuPW;
using eZGOhwHsUbVjUNjdZQ;
using System;
using System.ComponentModel;
using System.Drawing;
using System.Drawing.Imaging;
using System.Runtime.CompilerServices;
using System.Windows.Forms;
namespace Drawmaobi
{
	public class Form1 : Form
	{
		private int i_time;
		private bool b_down;
		private Graphics g;
		private Image img;
		private Bitmap bmp;
		private MyPen m_pen;
		private IContainer components;
		private PictureBox pic;
		private Button but_save;
		private Button but_clear;
		private Button button1;
		private Button button2;
		[MethodImpl(MethodImplOptions.NoInlining)]
		public Form1()
		{
			eBY7bi7YwxKvLu4W5N.CxqgSlQzFtivJ();
			this.b_down = false;
			this.components = null;
			base..ctor();
			this.InitializeComponent();
		}
		[MethodImpl(MethodImplOptions.NoInlining)]
		private void Form1_Load(object sender, EventArgs e)
		{
			base.Size = new Size(1024, 768);
			this.bmp = new Bitmap(base.Width, base.Height);
			this.g = Graphics.FromImage(this.bmp);
			this.img = Image.FromFile(Environment.CurrentDirectory + ebjl5iduDGjiB8jAyt.eh1msj65w(20));
			this.pic.Image = this.bmp;
			this.m_pen = new MyPen(base.Width, base.Height, this.g);
			this.but_clear_Click(null, null);
		}
		[MethodImpl(MethodImplOptions.NoInlining)]
		private void Form1_Resize(object sender, EventArgs e)
		{
			if (this.img != null)
			{
				Bitmap image = this.bmp;
				this.bmp = new Bitmap(base.Width, base.Height);
				this.g = Graphics.FromImage(this.bmp);
				this.img = Image.FromFile(Environment.CurrentDirectory + ebjl5iduDGjiB8jAyt.eh1msj65w(38));
				this.pic.Image = this.bmp;
				this.m_pen = new MyPen(base.Width, base.Height, this.g);
				this.g.DrawImage(image, 0, 0, this.bmp.Width, this.bmp.Height);
			}
		}
		[MethodImpl(MethodImplOptions.NoInlining)]
		private void Form1_MouseDown(object sender, MouseEventArgs e)
		{
			this.b_down = true;
			this.i_time = Environment.TickCount;
			this.m_pen.drawstart();
		}
		[MethodImpl(MethodImplOptions.NoInlining)]
		private void Form1_MouseUp(object sender, MouseEventArgs e)
		{
			this.m_pen.drawend();
			this.b_down = false;
		}
		[MethodImpl(MethodImplOptions.NoInlining)]
		private void Form1_MouseMove(object sender, MouseEventArgs e)
		{
			if (this.b_down)
			{
				tagFPOINT tagFPOINT = new tagFPOINT();
				tagFPOINT.setx(e.X);
				tagFPOINT.sety(e.Y);
				tagFPOINT.settime((double)(Environment.TickCount - this.i_time));
				tagFPOINT val = tagFPOINT;
				this.m_pen.push(val);
				this.m_pen.drawpen(true);
				this.pic.Image = this.bmp;
			}
		}
		[MethodImpl(MethodImplOptions.NoInlining)]
		private void Form1_Paint(object sender, PaintEventArgs e)
		{
		}
		[MethodImpl(MethodImplOptions.NoInlining)]
		private void but_clear_Click(object sender, EventArgs e)
		{
			this.g.DrawImage(this.img, 0, 0, this.pic.Width, this.pic.Height);
			this.pic.Image = this.bmp;
		}
		[MethodImpl(MethodImplOptions.NoInlining)]
		private void but_save_Click(object sender, EventArgs e)
		{
			string filename = string.Format(ebjl5iduDGjiB8jAyt.eh1msj65w(56), Environment.CurrentDirectory, DateTime.Now.ToFileTime().ToString());
			this.bmp.Save(filename, ImageFormat.Png);
			this.g.DrawImage(this.img, 0, 0, this.pic.Width, this.pic.Height);
			this.pic.Image = this.bmp;
		}
		[MethodImpl(MethodImplOptions.NoInlining)]
		private void button1_Click(object sender, EventArgs e)
		{
			this.m_pen.setcolor(Color.Red);
		}
		[MethodImpl(MethodImplOptions.NoInlining)]
		private void button2_Click(object sender, EventArgs e)
		{
			this.m_pen.setcolor(Color.Blue);
		}
		[MethodImpl(MethodImplOptions.NoInlining)]
		protected override void Dispose(bool disposing)
		{
			if (disposing && this.components != null)
			{
				this.components.Dispose();
			}
			base.Dispose(disposing);
		}
		[MethodImpl(MethodImplOptions.NoInlining)]
		private void InitializeComponent()
		{
			this.pic = new PictureBox();
			this.but_save = new Button();
			this.but_clear = new Button();
			this.button1 = new Button();
			this.button2 = new Button();
			((ISupportInitialize)this.pic).BeginInit();
			base.SuspendLayout();
			this.pic.Dock = DockStyle.Fill;
			this.pic.Location = new Point(0, 0);
			this.pic.Name = ebjl5iduDGjiB8jAyt.eh1msj65w(92);
			this.pic.Size = new Size(616, 323);
			this.pic.TabIndex = 2;
			this.pic.TabStop = false;
			this.pic.MouseMove += new MouseEventHandler(this.Form1_MouseMove);
			this.pic.MouseDown += new MouseEventHandler(this.Form1_MouseDown);
			this.pic.MouseUp += new MouseEventHandler(this.Form1_MouseUp);
			this.but_save.Location = new Point(99, 12);
			this.but_save.Name = ebjl5iduDGjiB8jAyt.eh1msj65w(102);
			this.but_save.Size = new Size(75, 23);
			this.but_save.TabIndex = 4;
			this.but_save.Text = ebjl5iduDGjiB8jAyt.eh1msj65w(122);
			this.but_save.UseVisualStyleBackColor = true;
			this.but_save.Click += new EventHandler(this.but_save_Click);
			this.but_clear.Location = new Point(17, 12);
			this.but_clear.Name = ebjl5iduDGjiB8jAyt.eh1msj65w(130);
			this.but_clear.Size = new Size(75, 23);
			this.but_clear.TabIndex = 3;
			this.but_clear.Text = ebjl5iduDGjiB8jAyt.eh1msj65w(152);
			this.but_clear.UseVisualStyleBackColor = true;
			this.but_clear.Click += new EventHandler(this.but_clear_Click);
			this.button1.Location = new Point(180, 12);
			this.button1.Name = ebjl5iduDGjiB8jAyt.eh1msj65w(160);
			this.button1.Size = new Size(75, 23);
			this.button1.TabIndex = 5;
			this.button1.Text = ebjl5iduDGjiB8jAyt.eh1msj65w(178);
			this.button1.UseVisualStyleBackColor = true;
			this.button1.Click += new EventHandler(this.button1_Click);
			this.button2.Location = new Point(261, 12);
			this.button2.Name = ebjl5iduDGjiB8jAyt.eh1msj65w(188);
			this.button2.Size = new Size(75, 23);
			this.button2.TabIndex = 6;
			this.button2.Text = ebjl5iduDGjiB8jAyt.eh1msj65w(206);
			this.button2.UseVisualStyleBackColor = true;
			this.button2.Click += new EventHandler(this.button2_Click);
			base.AutoScaleDimensions = new SizeF(6f, 12f);
			base.AutoScaleMode = AutoScaleMode.Font;
			base.ClientSize = new Size(616, 323);
			base.Controls.Add(this.button2);
			base.Controls.Add(this.button1);
			base.Controls.Add(this.but_save);
			base.Controls.Add(this.but_clear);
			base.Controls.Add(this.pic);
			base.Name = ebjl5iduDGjiB8jAyt.eh1msj65w(218);
			this.Text = ebjl5iduDGjiB8jAyt.eh1msj65w(232);
			base.Load += new EventHandler(this.Form1_Load);
			base.Resize += new EventHandler(this.Form1_Resize);
			base.Paint += new PaintEventHandler(this.Form1_Paint);
			((ISupportInitialize)this.pic).EndInit();
			base.ResumeLayout(false);
		}
	}
}
