package com.yiTian.view.modules.rechargeFeedback
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class View_FeedBackList extends Sprite
   {
      
      private const LEN:int = 7;
      
      private var gridVec:Vector.<View_Grid>;
      
      private var bmp:Bitmap;
      
      private var typeTF:MyTextField;
      
      private var textInf:Bitmap;
      
      public function View_FeedBackList()
      {
         super();
         this.init();
      }
      
      public function flyToBag() : void
      {
         var grid:View_Grid = null;
         for each(grid in this.gridVec)
         {
            if(!grid.vo)
            {
               break;
            }
            Tween.gridToBagBezierFuncDef(grid);
         }
      }
      
      private function init() : void
      {
         this.typeTF = ComponentUtil.getTextField("0000000",this,{
            "y":1,
            "color":15702016,
            "size":16,
            "leading":0
         });
         this.textInf = ComponentUtil.getBitmap("Text_Inf",this,{
            "x":67,
            "y":0
         },Global.HuiKui_Imgsdm);
         this.bmp = new Bitmap();
         addChild(this.bmp);
         ComponentUtil.setPropertie(this.bmp,{"x":448});
         this.creatGrid();
      }
      
      private function creatGrid() : void
      {
         var grid:View_Grid = null;
         this.gridVec = new Vector.<View_Grid>(this.LEN);
         var i:int = 0;
         while(i < this.LEN)
         {
            grid = new View_Grid();
            grid.set_bmp_bg();
            grid.set_bmp_over();
            grid.set_tf_count(true,false,true);
            addChild(grid);
            ComponentUtil.setPropertie(grid,{
               "x":53 * i + 7,
               "y":25 + 19
            });
            this.gridVec[i] = grid;
            i++;
         }
      }
      
      public function upData(type:int, list:Array) : void
      {
         this.upGrid(list);
         this.upBmp(type);
      }
      
      private function upGrid(list:Array) : void
      {
         var grid:View_Grid = null;
         var vo:Vo_item = null;
         var vo2:Vo_equip = null;
         var type:int = 0;
         var i:int = 0;
         while(i < this.LEN)
         {
            grid = this.gridVec[i];
            if(list[i] != undefined)
            {
               type = int(list[i][0]);
               if(type == 1)
               {
                  vo = new Vo_item();
                  vo.id = list[i][1];
                  vo.Init_lib();
                  vo.count = list[i][2];
                  grid.vo = vo;
               }
               else
               {
                  vo2 = new Vo_equip();
                  vo2.id = list[i][1];
                  vo2.Init_lib();
                  vo2.count = list[i][2];
                  grid.vo = vo;
               }
               grid.visible = true;
            }
            else
            {
               vo = null;
               vo2 = null;
               grid.vo = null;
               grid.visible = false;
            }
            i++;
         }
      }
      
      private function upBmp(type:int) : void
      {
         this.bmp.bitmapData = ComponentUtil.getBitmapData("JiaZhi_Img0" + type,Global.HuiKui_Imgsdm);
         this.typeTF.text = Data_lib.czfk[type][0];
         this.textInf.x = this.typeTF.x + this.typeTF.width;
      }
   }
}

