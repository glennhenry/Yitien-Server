package com.ui.controls
{
   import com.utils.ComponentUtil;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class MaskProgressBar extends Sprite
   {
      
      protected var _bg:DisplayObject;
      
      protected var _bar:DisplayObject;
      
      protected var _persent:Number;
      
      protected var _mask:Shape;
      
      private var _container:Sprite = new Sprite();
      
      private var _realWidth:Number;
      
      private var _realHeight:Number = 20;
      
      public function MaskProgressBar()
      {
         addChild(this._container);
         super();
      }
      
      public function init() : void
      {
         this._mask = ComponentUtil.getShape(100,20,255,0.3);
         addChild(this._mask);
         this._container.mask = this._mask;
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
      
      public function set realWidth(value:Number) : void
      {
         this._realWidth = value;
      }
      
      public function get realWidth() : Number
      {
         return this._realWidth;
      }
      
      public function get bg() : DisplayObject
      {
         return this._bg;
      }
      
      public function set bar(value:DisplayObject) : void
      {
         if(Boolean(this.bar))
         {
            this._container.removeChild(this.bar);
         }
         if(Boolean(value))
         {
            this._container.addChild(value);
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
      
      public function get container() : Sprite
      {
         return this._container;
      }
   }
}

