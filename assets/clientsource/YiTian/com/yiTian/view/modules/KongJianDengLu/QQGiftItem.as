package com.yiTian.view.modules.KongJianDengLu
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   
   public class QQGiftItem extends Sprite
   {
      
      public var dayIndex:MyTextField;
      
      public var vo:Vo_item;
      
      public var vo2:Vo_item;
      
      public var vo3:Vo_item;
      
      public var grid:View_Grid;
      
      public var grid2:View_Grid;
      
      public var grid3:View_Grid;
      
      public function QQGiftItem()
      {
         super();
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":0,
            "y":44,
            "width":452,
            "height":2
         },Global.Img_Cdm);
         this.dayIndex = ComponentUtil.getTextField("",this,{
            "x":27,
            "y":13,
            "color":14662240,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Grid_Open",this,{
            "x":150,
            "y":2
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Grid_Open",this,{
            "x":199,
            "y":2
         },Global.Img_Cdm);
         this.grid = new View_Grid();
         this.grid.type = Enum_type_grid.NO_DRAG;
         this.grid.set_tf_count(true,true,true);
         this.grid.set_bmp_bg();
         this.grid.set_bmp_select();
         this.grid.set_bmp_over();
         addChild(this.grid);
         this.grid.y = 4;
         this.grid.x = 152;
         this.vo = new Vo_item();
         this.grid2 = new View_Grid();
         this.grid2.type = Enum_type_grid.NO_DRAG;
         this.grid2.set_tf_count(true,true,true);
         this.grid2.set_bmp_bg();
         this.grid2.set_bmp_select();
         this.grid2.set_bmp_over();
         addChild(this.grid2);
         this.grid2.y = 4;
         this.grid2.x = 201;
         if(Global.pf == Enum_SPStr.QQ3366)
         {
            this.grid3 = new View_Grid();
            this.grid3.type = Enum_type_grid.NO_DRAG;
            this.grid3.set_tf_count(true,true,true);
            this.grid3.set_bmp_bg();
            this.grid3.set_bmp_select();
            this.grid3.set_bmp_over();
            addChild(this.grid3);
            this.grid3.y = 4;
            this.grid3.x = 250;
            this.vo3 = new Vo_item();
         }
         this.vo2 = new Vo_item();
      }
   }
}

