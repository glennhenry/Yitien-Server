package com.yiTian.view.comp
{
   import com.event.TextField_h;
   import com.yiTian.data.Const_png;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class View_DragObj extends Sprite
   {
      
      private var iconBg:Bitmap;
      
      private var icon:Bitmap;
      
      private var tf_count:TextField_h;
      
      private var _grid:View_Grid;
      
      public function View_DragObj()
      {
         super();
         mouseChildren = false;
         mouseEnabled = false;
         this.iconBg = new Bitmap();
         addChild(this.iconBg);
         this.icon = new Bitmap();
         addChild(this.icon);
         this.tf_count = new TextField_h();
         addChild(this.tf_count);
      }
      
      public function set grid($grid:View_Grid) : void
      {
         this._grid = $grid;
         this.iconBg.bitmapData = this._grid.get_iconBg_Bitmapdata();
         this.icon.bitmapData = this._grid.get_icon_BitmapData();
         if(this._grid.vo.count > 1)
         {
            this.tf_count.text = this._grid.vo.count.toString();
         }
         else
         {
            this.tf_count.text = "";
         }
         this.tf_count.x = Const_png.SIZE_GRID - this.tf_count.textWidth - 5;
         this.tf_count.y = Const_png.SIZE_GRID - 17;
      }
      
      public function get grid() : View_Grid
      {
         return this._grid;
      }
   }
}

