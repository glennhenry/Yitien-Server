package com.yiTian.view.modules.ChongChuJiangHu
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   
   public class ChongChuJiangHu_itemList extends Sprite
   {
      
      private var id:int;
      
      private var flyArr:Array;
      
      private var grid_0:View_Grid;
      
      private var grid_1:View_Grid;
      
      private var grid_2:View_Grid;
      
      private var grid_3:View_Grid;
      
      private var grid_4:View_Grid;
      
      private var grid_5:View_Grid;
      
      public function ChongChuJiangHu_itemList(index:int)
      {
         super();
         this.id = index;
         this.flyArr = [];
         this.init();
      }
      
      private function init() : void
      {
         var i:int = 0;
         var arr:Array = null;
         var itemInfo:Array = null;
         var vo:Vo_valuable = null;
         var effArr:Array = null;
         var id_eff:* = undefined;
         i = 0;
         while(i < 6)
         {
            this["grid_" + i] = new View_Grid();
            View_Grid(this["grid_" + i]).set_tf_count();
            View_Grid(this["grid_" + i]).set_bmp_over();
            View_Grid(this["grid_" + i]).set_bmp_bg();
            View_Grid(this["grid_" + i]).isAutoLoad = true;
            this.addChild(this["grid_" + i]);
            this["grid_" + i].y = 220 - 44 * i;
            arr = String(Data_lib.ChongChuJiangHu[this.id + 1][1]).split(",");
            if(Boolean(arr[i]))
            {
               itemInfo = arr[i].split("_");
               if(itemInfo[0] == 1)
               {
                  vo = new Vo_item();
               }
               else if(itemInfo[0] == 2)
               {
                  vo = new Vo_equip();
               }
               vo.id = itemInfo[1];
               if(vo is Vo_item)
               {
                  (vo as Vo_item).Init_lib();
               }
               else if(vo is Vo_equip)
               {
                  (vo as Vo_equip).Init_lib();
               }
               vo.count = itemInfo[2];
               View_Grid(this["grid_" + i]).vo = vo;
               View_Grid(this["grid_" + i]).visible = true;
               this.flyArr.push(this["grid_" + i]);
               effArr = String(Data_lib.ChongChuJiangHu[this.id + 1][2]).split(",");
               for(id_eff in effArr)
               {
                  if(effArr[id_eff] == -1)
                  {
                     break;
                  }
                  this.addEff(this["grid_" + (int(effArr[id_eff]) - 1)]);
               }
            }
            else
            {
               View_Grid(this["grid_" + i]).visible = false;
            }
            i++;
         }
      }
      
      private function addEff(dis:Sprite) : void
      {
         var ef:Effect = null;
         ef = EffectManager.addEffect("35180",dis,1000,42,42,true);
         ef.scaleX = 0.5;
         ef.scaleY = 0.5;
      }
      
      public function FlyToBag() : void
      {
         var i:* = undefined;
         for(i in this.flyArr)
         {
            ComboTweenStep.toBag(this.flyArr[i]);
         }
      }
   }
}

