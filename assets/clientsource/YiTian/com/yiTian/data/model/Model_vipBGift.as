package com.yiTian.data.model
{
   public class Model_vipBGift
   {
      
      public static var curIndex:int;
      
      public static var data_Gift:Array = new Array();
      
      public static var data_GiftNum:Array = new Array();
      
      private static var _curDate:int = 0;
      
      public function Model_vipBGift()
      {
         super();
      }
      
      public static function get curDate() : int
      {
         return _curDate;
      }
      
      public static function set curDate(value:int) : void
      {
         _curDate = value;
      }
      
      public static function updataGiftNum() : void
      {
      }
   }
}

