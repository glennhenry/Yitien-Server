package com.yiTian.utils.call
{
   import flash.events.Event;
   
   public class DelegateEvent extends Event
   {
      
      public static const T_T_COMPLETE:String = "t_t_complete";
      
      public var param:Object;
      
      public function DelegateEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}

