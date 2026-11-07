package com.yiTian.data.config
{
   public class Enum_vipBGift
   {
      
      public static const TYPE_5W:int = 0;
      
      public static const STATE_CAN:int = 1;
      
      public static const STATE_NO:int = 0;
      
      public static const STATE_HAS:int = 2;
      
      public static const isTrue:int = 1;
      
      public static const isFalse:int = 0;
      
      public static const SHOW_ICON:int = 1;
      
      public static const HIDE_ICON:int = 0;
      
      private static const arr:Array = [0,1,2,3,5,7];
      
      public static const TTURL:Array = ["Text_YiTian","Text_ErTian","Text_SanTian","Text_WuTian","Text_QiTian"];
      
      public static const PRICE:Array = [0,5000,5000,5000];
      
      public static const PRICE1:Array = [0,4000,4000,4000];
      
      public static const DGLIST:Array = [44485,44485,44485,44485,44485,44485,44485];
      
      public static const JJLIST:Array = [44485,44485,44485,44485];
      
      public function Enum_vipBGift()
      {
         super();
      }
      
      public static function getButtonLabel(state:int, date:int, index:int) : String
      {
         if(state == STATE_HAS)
         {
            return "已领取";
         }
         if(state == STATE_CAN)
         {
            return "可领取";
         }
         return Math.abs(date - arr[index]) + "天后可领取";
      }
   }
}

