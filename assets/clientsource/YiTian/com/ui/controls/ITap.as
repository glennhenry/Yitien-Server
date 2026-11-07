package com.ui.controls
{
   import flash.events.IEventDispatcher;
   
   public interface ITap extends IEventDispatcher
   {
      
      function set tappIndex(param1:int) : void;
      
      function get tappIndex() : int;
      
      function set tChoose(param1:Boolean) : void;
      
      function get tChoose() : Boolean;
   }
}

