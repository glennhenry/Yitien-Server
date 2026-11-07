package com.yiTian.manager
{
   public class DailyRemainManager
   {
      
      public static const JJC:int = 0;
      
      public static const DAILY_QUEST:int = 1;
      
      public static const LIN_QI:int = 2;
      
      public static const PA_TA:int = 3;
      
      public static const ZHANG_MEN_REN:int = 4;
      
      public static const CG:int = 5;
      
      public static const PAO_BIAO:int = 6;
      
      public static var dailyData:Array = [];
      
      public function DailyRemainManager()
      {
         super();
      }
      
      public static function setCount(module:int, leftCount:int) : void
      {
         dailyData[module] = leftCount;
      }
   }
}

