package com.yiTian.view.modules.kuafujingjichang
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class DRKFlawItem extends Sprite
   {
      
      public var LawName:MyTextField;
      
      public var LawLevel:MyTextField;
      
      public var grid:View_Grid;
      
      public var img:Bitmap;
      
      public var zfId:int;
      
      private var _selected:Boolean = false;
      
      public function DRKFlawItem()
      {
         super();
         ComponentUtil.getBitmap("Back_ZhenFa",this,{
            "x":0,
            "y":0
         },Global.DuoRenKuaFu_Imgsdm);
         ComponentUtil.getBitmap("Grid_Open",this,{
            "x":4,
            "y":3
         },Global.Img_Cdm);
         this.grid = new View_Grid();
         this.grid.type = Enum_type_grid.NO_DRAG;
         this.grid.set_bmp_bg();
         this.grid.set_bmp_select();
         this.grid.set_bmp_over();
         this.grid.x = 6;
         this.grid.y = 5;
         this.grid.isAutoLoad = false;
         addChild(this.grid);
         this.img = new Bitmap();
         this.img.x = 5.8;
         this.img.y = 5.8;
         addChild(this.img);
         this.LawName = ComponentUtil.getTextField("",this,{
            "x":50,
            "y":5,
            "color":16184781,
            "size":12,
            "leading":0
         });
         this.LawLevel = ComponentUtil.getTextField("",this,{
            "x":54,
            "y":23,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.grid.addEventListener(MouseEvent.CLICK,this.gridClick);
      }
      
      public function set selected(v:Boolean) : void
      {
         if(this._selected != v)
         {
            if(v)
            {
               transform.colorTransform = Util.colorWhite2;
            }
            else
            {
               transform.colorTransform = Util.colorNomal;
            }
            this._selected = v;
         }
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      private function gridClick(e:MouseEvent) : void
      {
         DRKFlawPanel.instance.setSelZf(this);
      }
   }
}

