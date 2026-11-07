package com.yiTian.view.modules.HeFuHuoDong
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   
   public class RankJLItem extends Sprite
   {
      
      public function RankJLItem(type:int, id:int)
      {
         var str:String = null;
         var arr:Array = null;
         var itemArr:Array = null;
         var vo:Vo_grid = null;
         var grid:View_Grid = null;
         super();
         ComponentUtil.getBitmap("List_Back",this,{
            "x":0,
            "y":0
         },Global.HeFu_Imgsdm);
         switch(id)
         {
            case 0:
               if(type == 3)
               {
                  str = String(Data_lib.jingjijuezhan[1][0]);
                  break;
               }
               if(type == 6)
               {
                  str = String(Data_lib.hefurenwu[1][0]);
                  break;
               }
               if(type == 7)
               {
                  str = String(Data_lib.hefuchongwu[1][0]);
               }
               break;
            case 1:
               if(type == 3)
               {
                  str = String(Data_lib.jingjijuezhan[2][0]);
                  break;
               }
               if(type == 6)
               {
                  str = String(Data_lib.hefurenwu[2][0]);
                  break;
               }
               if(type == 7)
               {
                  str = String(Data_lib.hefuchongwu[2][0]);
               }
               break;
            case 2:
               if(type == 3)
               {
                  str = String(Data_lib.jingjijuezhan[3][0]);
                  break;
               }
               if(type == 6)
               {
                  str = String(Data_lib.hefurenwu[3][0]);
                  break;
               }
               if(type == 7)
               {
                  str = String(Data_lib.hefuchongwu[3][0]);
               }
               break;
            case 3:
               if(type == 3)
               {
                  str = String(Data_lib.jingjijuezhan[4][0]);
                  break;
               }
               if(type == 6)
               {
                  str = String(Data_lib.hefurenwu[4][0]);
                  break;
               }
               if(type == 7)
               {
                  str = String(Data_lib.hefuchongwu[4][0]);
               }
         }
         var PaiMingArray:Array = str.split("_");
         if(PaiMingArray.length > 1)
         {
            ComponentUtil.getBitmap("Rank_two",this,{
               "x":50,
               "y":15
            },Global.HeFu_Imgsdm);
            ComponentUtil.getTextField(PaiMingArray[0],this,{
               "x":83,
               "y":15,
               "size":20,
               "leading":0,
               "color":16710164
            },"center");
            ComponentUtil.getTextField(PaiMingArray[1],this,{
               "x":130,
               "y":15,
               "size":20,
               "leading":0,
               "color":16710164
            },"center");
         }
         else
         {
            ComponentUtil.getBitmap("Rank_one",this,{
               "x":50,
               "y":15
            },Global.HeFu_Imgsdm);
            ComponentUtil.getTextField(PaiMingArray[0],this,{
               "x":83,
               "y":15,
               "size":20,
               "leading":0,
               "color":16710164
            },"center");
         }
         if(type == 3)
         {
            arr = Data_lib.jingjijuezhan[id + 1][1].split(",");
         }
         else if(type == 6)
         {
            arr = Data_lib.hefurenwu[id + 1][1].split(",");
         }
         else if(type == 7)
         {
            arr = Data_lib.hefuchongwu[id + 1][1].split(",");
         }
         var i:int = 0;
         while(i < arr.length)
         {
            itemArr = arr[i].split("_");
            if(itemArr[0] == 1)
            {
               vo = new Vo_item();
               vo.id = itemArr[1];
               (vo as Vo_item).Init_lib();
            }
            else if(itemArr[0] == 2)
            {
               vo = new Vo_equip();
               vo.id = itemArr[1];
               (vo as Vo_equip).Init_lib();
            }
            grid = new View_Grid();
            grid.vo = vo;
            grid.set_bmp_bg();
            grid.set_bmp_over();
            grid.set_tf_count();
            grid.count = itemArr[2];
            grid.x = 350 + i * 45;
            grid.y = 10;
            addChild(grid);
            i++;
         }
      }
   }
}

