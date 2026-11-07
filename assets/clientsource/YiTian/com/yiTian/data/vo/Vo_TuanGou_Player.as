package com.yiTian.data.vo
{
   public class Vo_TuanGou_Player
   {
      
      public var name:String;
      
      public var goodName:String;
      
      public var goodCount:int;
      
      public var awards:String = "终极大奖";
      
      public function Vo_TuanGou_Player()
      {
         super();
      }
      
      public function changelStr(num:int) : String
      {
         var str:String = null;
         if(num == 1)
         {
            str = "终极大奖";
         }
         else if(num == 2)
         {
            str = "二等奖";
         }
         else if(num == 3)
         {
            str = "三等奖";
         }
         else
         {
            str = "";
         }
         return str;
      }
   }
}

