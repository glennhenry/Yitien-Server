package com.yiTian.data.model
{
   public class Model_WuLinMiXin
   {
      
      private static var _statusArray:Array;
      
      private static var _freeOpenTimes:int;
      
      private static var _haveOpenTimes:int;
      
      public function Model_WuLinMiXin()
      {
         super();
      }
      
      public static function get statusArray() : Array
      {
         if(!_statusArray)
         {
            _statusArray = [];
         }
         return _statusArray;
      }
      
      public static function set statusArray(value:Array) : void
      {
         _statusArray = value;
      }
      
      public static function get freeOpenTimes() : int
      {
         return _freeOpenTimes;
      }
      
      public static function set freeOpenTimes(value:int) : void
      {
         _freeOpenTimes = value;
      }
      
      public static function get haveOpenTimes() : int
      {
         return _haveOpenTimes;
      }
      
      public static function set haveOpenTimes(value:int) : void
      {
         _haveOpenTimes = value;
      }
   }
}

