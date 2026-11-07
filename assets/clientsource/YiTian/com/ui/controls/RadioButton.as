package com.ui.controls
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   
   public class RadioButton extends CheckBox
   {
      
      public static var SELECTED:String = "RB_selectedevent";
      
      private var _value:Object;
      
      public function RadioButton(text:String, style:String, dm:ApplicationDomain, selected:Boolean = false)
      {
         super(text,style,dm,selected);
      }
      
      override protected function click(evt:MouseEvent) : void
      {
         if(selected == true)
         {
            return;
         }
         this.dispatchEvent(new Event(SELECTED));
      }
      
      public function set value(va:Object) : void
      {
         this._value = va;
      }
      
      public function get value() : Object
      {
         return this._value;
      }
   }
}

