package com.yiTian.data.model
{
   import flash.utils.getTimer;
   
   public class Model_little_system
   {
      
      public static const COUNT_CHIP:int = 7;
      
      private var _sever_time_start:Number;
      
      private var time_start:int;
      
      public function Model_little_system()
      {
         super();
      }
      
      public function get sever_time_start() : Number
      {
         return this._sever_time_start;
      }
      
      public function Init_serverTime(severTime:int) : void
      {
         this._sever_time_start = severTime * 1000;
         this.time_start = getTimer();
      }
      
      public function get_serverTime() : Date
      {
         var interval:int = getTimer() - this.time_start;
         var date:Date = new Date();
         date.setTime(this._sever_time_start + interval);
         return date;
      }
   }
}

