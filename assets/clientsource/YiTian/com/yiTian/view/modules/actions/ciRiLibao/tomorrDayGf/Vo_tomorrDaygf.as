package com.yiTian.view.modules.actions.ciRiLibao.tomorrDayGf
{
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.data.vo.Vo_item;
   import flash.utils.Dictionary;
   
   public class Vo_tomorrDaygf
   {
      
      public static var statusDic:Dictionary = new Dictionary();
      
      public static var data:Dictionary = new Dictionary();
      
      public var dataVec:Vector.<Vo_grid> = new Vector.<Vo_grid>();
      
      public var day:int;
      
      public var extral_vo:Vo_grid;
      
      public function Vo_tomorrDaygf()
      {
         super();
      }
      
      public function init(dt:String) : void
      {
         var tems:String = null;
         var dataA:Array = null;
         var type:int = 0;
         var voI:Vo_item = null;
         var voE:Vo_equip = null;
         var darr:Array = dt.split(",");
         var i:int = 0;
         while(i < darr.length)
         {
            tems = darr[i];
            dataA = tems.split("_");
            type = int(dataA[0]);
            if(type == 1)
            {
               voI = new Vo_item();
               voI.id = dataA[1];
               voI.count = dataA[2];
               voI.Init_lib();
               this.dataVec.push(voI as Vo_grid);
            }
            else if(type == 2)
            {
               voE = new Vo_equip();
               voE.id = dataA[1];
               voE.count = dataA[2];
               voE.Init_lib();
               this.dataVec.push(voE as Vo_grid);
            }
            i++;
         }
         data[this.day] = this;
      }
   }
}

