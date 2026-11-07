package com.ui.controls
{
   import com.utils.ComponentUtil;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.system.ApplicationDomain;
   import flash.system.IME;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   
   public class TextInput extends Sprite
   {
      
      private var _back:DisplayObject;
      
      private var _tf:MyTextField;
      
      private var _enabled:Boolean = true;
      
      public function TextInput(width:int, height:int, size:int, color:uint, style:String, dm:ApplicationDomain)
      {
         super();
         this._tf = ComponentUtil.getTextField("",this,{
            "width":width - 4,
            "height":height - 4,
            "x":2,
            "y":2,
            "size":size,
            "color":color,
            "type":TextFieldType.INPUT
         },TextFieldAutoSize.NONE);
         this._tf.addEventListener(FocusEvent.FOCUS_IN,this.focusIn);
         this._tf.addEventListener(FocusEvent.FOCUS_OUT,this.focusOut);
      }
      
      private function focusIn(e:FocusEvent) : void
      {
         IME.enabled = true;
      }
      
      private function focusOut(e:FocusEvent) : void
      {
         IME.enabled = false;
      }
      
      public function set text(value:String) : void
      {
         this._tf.text = value;
      }
      
      public function get text() : String
      {
         return this._tf.text;
      }
      
      public function set type(value:String) : void
      {
         this._tf.type = value;
      }
      
      public function set selectable(value:Boolean) : void
      {
         this._tf.selectable = value;
      }
      
      override public function set mouseEnabled(enabled:Boolean) : void
      {
         this._tf.mouseEnabled = enabled;
      }
      
      public function get textField() : MyTextField
      {
         return this._tf;
      }
      
      public function get caretIndex() : Number
      {
         return this._tf.caretIndex;
      }
      
      public function replaceText(beginIndex:int, endIndex:int, newText:String) : void
      {
         this._tf.replaceText(beginIndex,endIndex,newText);
      }
      
      public function set restrict(str:String) : void
      {
         this._tf.restrict = str;
      }
      
      public function get restrict() : String
      {
         return this._tf.restrict;
      }
      
      public function set maxChars(max:int) : void
      {
         this._tf.maxChars = max;
      }
      
      public function get maxChars() : int
      {
         return this._tf.maxChars;
      }
      
      public function set displayAsPassword(value:Boolean) : void
      {
         if(value != this.displayAsPassword)
         {
            this._tf.displayAsPassword = value;
         }
      }
      
      public function get displayAsPassword() : Boolean
      {
         return this._tf.displayAsPassword;
      }
      
      public function set enabled(value:Boolean) : void
      {
         this._enabled = value;
         this.mouseEnabled = mouseChildren = value;
         this._tf.tabEnabled = value;
         this._tf.mouseEnabled = value;
         if(value)
         {
            this._tf.type = TextFieldType.INPUT;
         }
         else
         {
            this._tf.type = TextFieldType.DYNAMIC;
         }
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         this._tf.addEventListener(type,listener,useCapture,priority,useWeakReference);
      }
      
      override public function dispatchEvent(event:Event) : Boolean
      {
         return this._tf.dispatchEvent(event);
      }
      
      public function setSelection(beginIndex:int, endIndex:int) : void
      {
         this._tf.setSelection(beginIndex,endIndex);
      }
      
      public function get focus() : TextField
      {
         return this._tf;
      }
   }
}

