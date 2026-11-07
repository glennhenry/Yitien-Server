package com.yiTian.view.modules.paihang
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   
   public class TxtTabButton extends Sprite
   {
      
      private var _normalState:TextFormat;
      
      private var _selectedState:TextFormat;
      
      private var _currentState:TextFormat;
      
      private var _label:MyTextField;
      
      private var back:Sprite;
      
      private var _isChoose:Boolean;
      
      private var _index:int;
      
      public function TxtTabButton(text:String)
      {
         super();
         mouseChildren = false;
         buttonMode = true;
         this._label = ComponentUtil.getTextField("");
         addChild(this._label);
         this._selectedState = new TextFormat();
         this._selectedState.color = 16184781;
         this._selectedState.underline = false;
         this._normalState = new TextFormat();
         this._normalState.color = 12232795;
         this._normalState.underline = true;
         this.label = text;
         this._label.setTextFormat(this._normalState);
      }
      
      public function set choose(value:Boolean) : void
      {
         if(value)
         {
            this._label.setTextFormat(this._selectedState);
         }
         else
         {
            this._label.setTextFormat(this._normalState);
         }
         this._isChoose = value;
      }
      
      public function get isChoose() : Boolean
      {
         return this._isChoose;
      }
      
      public function set label(value:String) : void
      {
         this._label.text = value;
         if(Boolean(this._label))
         {
            if(this._isChoose)
            {
               this._label.setTextFormat(this._selectedState);
            }
            else
            {
               this._label.setTextFormat(this._normalState);
            }
         }
      }
      
      public function get label() : String
      {
         return this._label.text;
      }
      
      public function set index(value:int) : void
      {
         this._index = value;
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      private function getSprite() : Sprite
      {
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,1);
         sp.graphics.drawRect(0,0,28,18);
         sp.graphics.endFill();
         return sp;
      }
   }
}

