package com.event
{
   import com.utils.ComponentUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Button_h extends Sprite
   {
      
      private var _enabled:Boolean;
      
      private var tf_label:TextField_h;
      
      private var bmp:Bitmap;
      
      private var bmpd_up:BitmapData;
      
      private var bmpd_down:BitmapData;
      
      private var bmpd_over:BitmapData;
      
      private var bmpd_disabled:BitmapData;
      
      public function Button_h()
      {
         super();
      }
      
      public function Init(str_url:String, bDisabled:Boolean, bOver:Boolean, bListen:Boolean) : void
      {
         buttonMode = true;
         this._enabled = true;
         this.bmpd_up = ComponentUtil.getBitmapData(str_url + "_up");
         this.bmpd_down = ComponentUtil.getBitmapData(str_url + "_down");
         if(bOver)
         {
            this.bmpd_over = ComponentUtil.getBitmapData(str_url + "_over");
         }
         if(bDisabled)
         {
            this.bmpd_disabled = ComponentUtil.getBitmapData(str_url + "_disabled");
         }
         this.bmp = new Bitmap();
         addChild(this.bmp);
         this.bmp.bitmapData = this.bmpd_up;
         if(bListen)
         {
            addEventListener(MouseEvent.MOUSE_DOWN,this.MOUSE_DOWN);
            addEventListener(MouseEvent.MOUSE_UP,this.MOUSE_UP);
            if(bOver)
            {
               addEventListener(MouseEvent.MOUSE_OVER,this.MOUSE_OVER);
               addEventListener(MouseEvent.MOUSE_OUT,this.MOUSE_UP);
            }
         }
      }
      
      public function Init_tf_label(str:String = "") : void
      {
         if(this.tf_label == null)
         {
            this.tf_label = new TextField_h();
            addChild(this.tf_label);
            if(str != "")
            {
               this.set_htmlText(str);
            }
         }
      }
      
      public function set enabled(value:Boolean) : void
      {
         if(this._enabled != value)
         {
            this._enabled = value;
            if(value)
            {
               this.bmp.bitmapData = this.bmpd_up;
            }
            else
            {
               this.bmp.bitmapData = this.bmpd_disabled;
            }
         }
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      public function set_htmlText(str:String) : void
      {
         this.tf_label.htmlText = str;
         this.tf_label.x = (this.bmp.width - this.tf_label.width) / 2;
         this.tf_label.y = (this.bmp.height - this.tf_label.height) / 2;
      }
      
      public function set txtColor(value:uint) : void
      {
         if(Boolean(this.tf_label))
         {
            this.tf_label.textColor = value;
         }
      }
      
      public function get btnLabel() : String
      {
         return this.tf_label.text;
      }
      
      public function MOUSE_DOWN(e:MouseEvent = null) : void
      {
         if(this._enabled)
         {
            this.bmp.bitmapData = this.bmpd_down;
         }
      }
      
      public function MOUSE_OVER(e:MouseEvent = null) : void
      {
         if(this._enabled)
         {
            this.bmp.bitmapData = this.bmpd_over;
         }
      }
      
      public function MOUSE_UP(e:MouseEvent = null) : void
      {
         if(this._enabled)
         {
            this.bmp.bitmapData = this.bmpd_up;
         }
      }
   }
}

