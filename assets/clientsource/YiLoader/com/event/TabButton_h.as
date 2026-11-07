package com.event
{
   import com.utils.ComponentUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TabButton_h extends Sprite
   {
      
      private var _bDown:Boolean;
      
      private var tf_label:TextField_h;
      
      private var bmp:Bitmap;
      
      private var bmpd_up:BitmapData;
      
      private var bmpd_down:BitmapData;
      
      private var bmpd_over:BitmapData;
      
      private var _textChooseColor:uint = 16777215;
      
      private var _normalColor:uint;
      
      public function TabButton_h()
      {
         super();
      }
      
      public function Init(str_url:String, bOver:Boolean, bListen:Boolean) : void
      {
         buttonMode = true;
         this.bmpd_up = ComponentUtil.getBitmapData(str_url + "_up");
         this.bmpd_down = ComponentUtil.getBitmapData(str_url + "_down");
         if(bOver)
         {
            this.bmpd_over = ComponentUtil.getBitmapData(str_url + "_over");
         }
         this.bmp = new Bitmap();
         addChild(this.bmp);
         this.bmp.bitmapData = this.bmpd_up;
         if(bListen && bOver)
         {
            addEventListener(MouseEvent.MOUSE_OVER,this.MOUSE_OVER);
            addEventListener(MouseEvent.MOUSE_OUT,this.MOUSE_OUT);
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
      
      public function set labelChooseColor(value:uint) : void
      {
         this._textChooseColor = value;
      }
      
      public function get labelChooseColor() : uint
      {
         return this._textChooseColor;
      }
      
      public function set normalColor(value:uint) : void
      {
         this._normalColor = value;
         this.tf_label.textColor = this._normalColor;
      }
      
      public function get normalColor() : uint
      {
         return this._normalColor;
      }
      
      public function set_htmlText(str:String) : void
      {
         this.tf_label.htmlText = str;
         this.tf_label.x = (this.bmp.width - this.tf_label.width) / 2;
         this.tf_label.y = (this.bmp.height - this.tf_label.height) / 2;
      }
      
      public function get bDown() : Boolean
      {
         return this._bDown;
      }
      
      public function set bDown(value:Boolean) : void
      {
         this._bDown = value;
         if(value)
         {
            this.bmp.bitmapData = this.bmpd_down;
            if(Boolean(this.tf_label))
            {
               this.tf_label.textColor = this._textChooseColor;
            }
         }
         else
         {
            this.bmp.bitmapData = this.bmpd_up;
            if(Boolean(this.tf_label))
            {
               this.tf_label.textColor = this._normalColor;
            }
         }
      }
      
      public function MOUSE_OVER(e:MouseEvent = null) : void
      {
         if(!this._bDown)
         {
            this.bmp.bitmapData = this.bmpd_over;
         }
      }
      
      public function MOUSE_OUT(e:MouseEvent = null) : void
      {
         if(this._bDown)
         {
            this.bmp.bitmapData = this.bmpd_down;
         }
         else
         {
            this.bmp.bitmapData = this.bmpd_up;
         }
      }
   }
}

