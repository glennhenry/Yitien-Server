package com.yiTian.view.modules.FeiXingQi
{
   import flash.events.Event;
   
   public class TouZiEvent extends Event
   {
      
      public static const COMPLETE:String = "tou_zi_complete";
      
      private var _num:int;
      
      public function TouZiEvent(type:String, result:int, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
         this._num = result;
      }
      
      public function get result() : int
      {
         return this._num;
      }
   }
}

