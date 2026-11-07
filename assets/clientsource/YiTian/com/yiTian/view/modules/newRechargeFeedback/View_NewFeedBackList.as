package com.yiTian.view.modules.newRechargeFeedback
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class View_NewFeedBackList extends Sprite
   {
      
      private const LEN:int = 7;
      
      private var gridVec:Vector.<View_Grid>;
      
      private var bmp:Bitmap;
      
      private var titleBmp:Bitmap;
      
      private var effVec:Vector.<Effect> = new Vector.<Effect>();
      
      public function View_NewFeedBackList()
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
         this.titleBmp = new Bitmap();
         addChild(this.titleBmp);
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
               "y":25 + 8
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
      
      private function resetEff() : void
      {
         var i:int = 0;
         while(i < this.effVec.length)
         {
            EffectManager.removeEffect(this.effVec[i]);
            i++;
         }
      }
      
      private function upGrid(list:Array) : void
      {
         var grid:View_Grid = null;
         var vo:Vo_item = null;
         var vo2:Vo_equip = null;
         var type:int = 0;
         var ef:Effect = null;
         this.resetEff();
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
               if([46281,44736,41303,41304,41314,41315,41005,41325,41326,41015,41025,41085].indexOf(vo.id) != -1)
               {
                  ef = EffectManager.addEffect("35180",grid,1000,43,43,true);
                  ef.scaleX = 0.5;
                  ef.scaleY = 0.5;
                  this.effVec.push(ef);
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
         this.bmp.bitmapData = ComponentUtil.getBitmapData("JiaZhi_Img0" + type,Global.NewHuiKui_Imgsdm);
         this.titleBmp.bitmapData = ComponentUtil.getBitmapData("Text_CZ0" + type,Global.NewHuiKui_Imgsdm);
         this.titleBmp.x = (View_NewRechargeFeedback.instance.width - this.titleBmp.width) / 2 - this.x;
      }
   }
}

