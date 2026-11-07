package com.ui.controls
{
   import flash.system.ApplicationDomain;
   
   public class TappButton extends TabButton implements ITap
   {
      
      protected var _tappIndex:int;
      
      private var _choose:Boolean = false;
      
      public function TappButton(text:String, skin:String = "tab", dm:ApplicationDomain = null)
      {
         super(text,skin,dm);
      }
      
      public function set tappIndex(v:int) : void
      {
         this._tappIndex = v;
      }
      
      public function get tappIndex() : int
      {
         return this._tappIndex;
      }
      
      public function set tChoose(v:Boolean) : void
      {
         super.choose = v;
         this._choose = v;
      }
      
      public function get tChoose() : Boolean
      {
         return this._choose;
      }
   }
}

