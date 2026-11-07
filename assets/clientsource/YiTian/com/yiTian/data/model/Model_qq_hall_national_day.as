package com.yiTian.data.model
{
   public class Model_qq_hall_national_day
   {
      
      private static var _instace:Model_qq_hall_national_day;
      
      public var isMonthBlueDia:Boolean;
      
      public var canGetMonthGift:Boolean;
      
      public var isYearBuleDia:Boolean;
      
      public var canGetYearGift:Boolean;
      
      public function Model_qq_hall_national_day()
      {
         super();
      }
      
      public static function get instace() : Model_qq_hall_national_day
      {
         if(!_instace)
         {
            _instace = new Model_qq_hall_national_day();
         }
         return _instace;
      }
   }
}

