package com.yiTian.utils
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   
   public class BitmapTF extends Sprite
   {
      
      private static var pool:Array = [];
      
      private var _text:String = "";
      
      private var _gap:int = 0;
      
      private var _bmd:BitmapData;
      
      private var _len:int;
      
      private var _bms:Array = [];
      
      private var getBmdFunc:Function;
      
      public function BitmapTF()
      {
         super();
      }
      
      public function setGetBmdFunc(func:Function) : void
      {
         this.getBmdFunc = func;
      }
      
      public function set text(value:String) : void
      {
         if(this._text != value)
         {
            this._text = value;
            this.redraw();
         }
      }
      
      public function set gap(value:Number) : void
      {
         this._gap = value;
      }
      
      public function redraw() : void
      {
         var i:int = 0;
         var bm:Bitmap = null;
         var nextPosx:int = 0;
         var char:String = null;
         var bmd:BitmapData = null;
         var len:int = this._text.length;
         if(len > this._len)
         {
            i = this._len;
            while(i < len)
            {
               bm = Boolean(pool.length) ? pool.pop() : new Bitmap();
               addChild(bm);
               this._bms.push(bm);
               i++;
            }
         }
         else if(len < this._len)
         {
            while(this._bms.length > len)
            {
               bm = this._bms.pop();
               bm.bitmapData = null;
               bm.x = 0;
               pool.push(bm);
               removeChild(bm);
            }
         }
         this._len = len;
         nextPosx = 0;
         i = 0;
         while(i < len)
         {
            char = this._text.charAt(i);
            bmd = this.getBmdFunc(char);
            bm = this._bms[i];
            bm.x = nextPosx;
            bm.bitmapData = bmd;
            nextPosx = nextPosx + bmd.width + this._gap;
            i++;
         }
      }
   }
}

