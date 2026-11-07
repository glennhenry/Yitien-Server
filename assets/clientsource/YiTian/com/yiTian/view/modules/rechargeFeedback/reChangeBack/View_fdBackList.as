package com.yiTian.view.modules.rechargeFeedback.reChangeBack
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class View_fdBackList extends Sprite
   {
      
      public static const LEN:int = 7;
      
      private var gridVec:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var bigGridArr:Array;
      
      private var bigGridEffArr:Array;
      
      private var prBmp:Bitmap;
      
      private var curSelectId:int;
      
      public function View_fdBackList()
      {
         var g:View_Grid = null;
         var bigGrid:View_Grid = null;
         super();
         this.prBmp = ComponentUtil.getBitmap("JiaZhi_Img01",this,{
            "x":600,
            "y":-19
         },Global.CZHKDLdm);
         var i:int = 0;
         while(i < 10)
         {
            g = new View_Grid();
            g.set_bmp_bg();
            g.set_bmp_over(true,null);
            g.set_tf_count(true,false,true);
            addChild(g);
            ComponentUtil.setPropertie(g,{
               "x":i * 55,
               "y":5
            });
            this.gridVec.push(g);
            g.visible = false;
            i++;
         }
         this.bigGridArr = [];
         var j:int = 0;
         while(j < 2)
         {
            bigGrid = new View_Grid(true);
            bigGrid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
            bigGrid.set_bmp_over(true,View_Grid.GRID_BIGGEST_OVER);
            bigGrid.set_tf_count();
            addChild(bigGrid);
            bigGrid.y = -12;
            this.bigGridArr.push(bigGrid);
            j++;
         }
         this.bigGridArr[0].visible = false;
         this.bigGridEffArr = [];
      }
      
      public function init(_type:int, list:Array) : void
      {
         this.curSelectId = _type;
         if(_type == 2)
         {
            this.prBmp.bitmapData = ComponentUtil.getBitmapData("JiaZhi_Img01",Global.CZHKDLdm);
         }
         else
         {
            this.prBmp.bitmapData = ComponentUtil.getBitmapData("JiaZhi_Img0" + _type,Global.CZHKDLdm);
         }
         this.upGrid(list);
      }
      
      private function upGrid(list:Array) : void
      {
         var grid:View_Grid = null;
         var vo:Vo_valuable = null;
         var type:int = 0;
         var len:int = int(list.length);
         if(Boolean(this.bigGridEffArr[0]))
         {
            EffectManager.removeEffect(this.bigGridEffArr[0]);
         }
         if(Boolean(this.bigGridEffArr[1]))
         {
            EffectManager.removeEffect(this.bigGridEffArr[1]);
         }
         if(this.curSelectId == 7)
         {
            this.bigGridArr[0].visible = true;
         }
         else
         {
            this.bigGridArr[0].visible = false;
         }
         var i:int = 0;
         while(i < 10)
         {
            grid = this.gridVec[i];
            if(list[i] != undefined)
            {
               type = int(list[i][0]);
               if(type == 1)
               {
                  vo = new Vo_item();
               }
               else
               {
                  vo = new Vo_equip();
               }
               vo.id = list[i][1];
               vo.count = list[i][2];
               vo.Init_lib();
               if(this.curSelectId == 7 && i == len - 2)
               {
                  this.bigGridArr[0].vo = vo;
                  this.bigGridArr[0].x = this.gridVec[i - 1].x + 60;
                  this.bigGridEffArr[0] = EffectManager.addEffect("35180",this.bigGridArr[0],1000,32,32,true);
                  grid.visible = false;
               }
               else if(i == len - 1)
               {
                  this.bigGridArr[1].vo = vo;
                  if(this.curSelectId == 7)
                  {
                     this.bigGridArr[1].x = this.gridVec[i - 2].x + 145;
                  }
                  else
                  {
                     this.bigGridArr[1].x = this.gridVec[i - 1].x + 65;
                  }
                  this.bigGridEffArr[1] = EffectManager.addEffect("35180",this.bigGridArr[1],1000,32,32,true);
                  grid.visible = false;
               }
               else
               {
                  grid.vo = vo;
                  grid.visible = true;
               }
            }
            else
            {
               vo = null;
               grid.vo = null;
               grid.visible = false;
            }
            i++;
         }
      }
      
      public function getAward() : void
      {
         var grid:View_Grid = null;
         for each(grid in this.gridVec)
         {
            if(grid.visible)
            {
               Tween.gridToBagBezierFuncDef(grid);
            }
         }
      }
   }
}

