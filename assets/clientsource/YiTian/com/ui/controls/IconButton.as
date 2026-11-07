package com.ui.controls
{
   import flash.display.Bitmap;
   import flash.system.ApplicationDomain;
   
   public class IconButton extends Button
   {
      
      private var _icon:Bitmap;
      
      private var _px:Number;
      
      private var _py:Number;
      
      public function IconButton(label:String, style:String, dm:ApplicationDomain)
      {
         super(label,style,dm);
      }
      
      override public function set label(txt:String) : void
      {
         _label = txt;
         _textField.htmlText = txt;
         LabelResize((_bmp.width + this._px - _textField.width) / 2,(_bmp.height + this._py - _textField.height) / 2);
      }
      
      public function setLabelOffset(px:Number, py:Number) : void
      {
         this._px = px;
         this._py = py;
      }
      
      public function set icon(value:Bitmap) : void
      {
         if(Boolean(this.icon))
         {
            removeChild(this.icon);
         }
         if(Boolean(value))
         {
            addChild(value);
         }
         this._icon = value;
      }
      
      public function get icon() : Bitmap
      {
         return this._icon;
      }
   }
}

