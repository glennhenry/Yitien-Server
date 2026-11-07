package com.ui.controls
{
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class MaskProgressBar2 extends Sprite
   {
      
      private var _bg:DisplayObject;
      
      private var _bar:DisplayObject;
      
      private var _persent:Number;
      
      private var _mask:Shape;
      
      private var _realWidth:Number;
      
      private var _realHeight:Number;
      
      public function MaskProgressBar2(progressBar:DisplayObject, backGround:DisplayObject = null)
      {
         super();
         if(Boolean(backGround))
         {
            this.bg = backGround;
            addChild(this.bg);
         }
         this.bar = progressBar;
         addChild(this.bar);
         this.realWidth = this.bar.width;
         this.realHeight = this.bar.height;
         this._mask = new Shape();
         this._mask.graphics.beginFill(0);
         this._mask.graphics.drawRect(0,0,1,1);
         this._mask.graphics.endFill();
         this._mask.x = this.bar.x;
         this._mask.y = this.bar.y;
         addChild(this._mask);
         this._bar.mask = this._mask;
         this.persent = 0;
      }
      
      public function set bg(value:DisplayObject) : void
      {
         if(Boolean(this.bg))
         {
            removeChild(this.bg);
         }
         if(Boolean(value))
         {
            addChildAt(value,0);
         }
         this._bg = value;
      }
      
      public function get bg() : DisplayObject
      {
         return this._bg;
      }
      
      public function set realWidth(value:Number) : void
      {
         this._realWidth = value;
      }
      
      public function get realWidth() : Number
      {
         return this._realWidth;
      }
      
      public function set realHeight(value:Number) : void
      {
         this._realHeight = value;
      }
      
      public function get realHeight() : Number
      {
         return this._realHeight;
      }
      
      public function set bar(value:DisplayObject) : void
      {
         if(Boolean(this.bar))
         {
            removeChild(this.bar);
         }
         if(Boolean(value))
         {
            addChild(value);
            this.realWidth = value.width;
            this.realHeight = value.height;
         }
         this._bar = value;
      }
      
      public function get bar() : DisplayObject
      {
         return this._bar;
      }
      
      public function align() : void
      {
         this._mask.width = this.realWidth * this.persent;
         this._mask.height = this.realHeight;
      }
      
      public function set persent(value:Number) : void
      {
         if(value < 0)
         {
            value = 0;
         }
         else if(value > 1)
         {
            value = 1;
         }
         this._persent = value;
         this.align();
      }
      
      public function get persent() : Number
      {
         return this._persent;
      }
   }
}

