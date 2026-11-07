package com.event
{
   import flash.events.Event;
   
   public class ResizeEvent extends Event
   {
      
      public static const RESIZE:String = "m_resize";
      
      public function ResizeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         return new ResizeEvent(type,bubbles,cancelable);
      }
   }
}

