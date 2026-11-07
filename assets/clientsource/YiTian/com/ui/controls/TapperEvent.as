package com.ui.controls
{
   import flash.events.Event;
   
   public class TapperEvent extends Event
   {
      
      public static const CHANGE:String = "tapper_change";
      
      public static const ADD:String = "tapper_add";
      
      public var param:*;
      
      public function TapperEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}

