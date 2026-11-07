package com.ui.controls
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   
   public class CheckBox extends Sprite
   {
      
      private var _normalSkin:BitmapData;
      
      private var _selectedSkin:BitmapData;
      
      private var _curSkin:Bitmap;
      
      private var _tf:MyTextField;
      
      private var _clickFun:Function;
      
      private var _selected:Boolean;
      
      private var _enabled:Boolean = true;
      
      public function CheckBox(text:String, style:String, dm:ApplicationDomain = null, selected:Boolean = false)
      {
         super();
         this._curSkin = ComponentUtil.getBitmap("",this,null,dm);
         this._normalSkin = ComponentUtil.getBitmapData(style + "_normal",dm);
         this._selectedSkin = ComponentUtil.getBitmapData(style + "_selected",dm);
         this._curSkin.bitmapData = this._normalSkin;
         this._tf = ComponentUtil.getTextField("",this,{
            "x":this._normalSkin.width + 3,
            "y":-1
         });
         this._tf.htmlText = text;
         this.selected = selected;
         this.addEventListener(MouseEvent.CLICK,this.click);
         this.buttonMode = true;
         this.mouseChildren = false;
         this.useHandCursor = true;
      }
      
      protected function click(evt:MouseEvent) : void
      {
         this.selected = !this.selected;
         if(this._clickFun != null)
         {
            this._clickFun(this);
         }
      }
      
      public function set selected(value:Boolean) : void
      {
         if(value == this._selected)
         {
            return;
         }
         this._selected = value;
         if(this._selected)
         {
            this.curSkin = this._selectedSkin;
         }
         else
         {
            this.curSkin = this._normalSkin;
         }
      }
      
      public function set clickFun(fun:Function) : void
      {
         this._clickFun = fun;
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function set htmlText(value:String) : void
      {
         if(this._tf.htmlText == value)
         {
            return;
         }
         this._tf.htmlText = value;
      }
      
      public function get htmlText() : String
      {
         return this._tf.htmlText;
      }
      
      public function set text(value:String) : void
      {
         if(this._tf.htmlText == value)
         {
            return;
         }
         this._tf.text = value;
      }
      
      public function get text() : String
      {
         return this._tf.text;
      }
      
      public function set textColor(value:int) : void
      {
         this._tf.textColor = value;
      }
      
      public function set enabled(value:Boolean) : void
      {
         if(value == this._enabled)
         {
            return;
         }
         this._enabled = value;
         this.mouseChildren = this.mouseEnabled = value;
         if(value)
         {
            filters = null;
         }
         else
         {
            filters = Util.disabled;
         }
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      public function set color(value:uint) : void
      {
         this._tf.color = value;
      }
      
      public function set curSkin(bmd:BitmapData) : void
      {
         this._curSkin.bitmapData = bmd;
      }
      
      public function get curSkin() : BitmapData
      {
         return this._curSkin.bitmapData;
      }
      
      public function dispose() : void
      {
         super.removeEventListener(MouseEvent.CLICK,this.click);
         if(Boolean(this._tf))
         {
            removeChild(this._tf);
         }
         this._normalSkin.dispose();
         this._selectedSkin.dispose();
         if(Boolean(this._curSkin.bitmapData))
         {
            this._curSkin.bitmapData.dispose();
         }
         removeChild(this._curSkin);
      }
   }
}

