package com.ui.controls
{
   import com.utils.BitmapUtils;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.geom.Rectangle;
   
   public class ScaleBitmap extends Shape
   {
      
      protected var _originalBitmap:BitmapData;
      
      protected var _scale9Grid:Rectangle = null;
      
      protected var _w:Number;
      
      protected var _h:Number;
      
      public function ScaleBitmap(bmpData:BitmapData = null)
      {
         super();
         this._originalBitmap = bmpData;
      }
      
      public function set bitmapData(bmpData:BitmapData) : void
      {
         this._originalBitmap = bmpData;
         if(this._scale9Grid != null)
         {
            if(!this.validGrid(this._scale9Grid))
            {
               this._scale9Grid = null;
            }
            this.setSize(bmpData.width,bmpData.height);
         }
      }
      
      public function get bitmapData() : BitmapData
      {
         return this._originalBitmap;
      }
      
      override public function set width(w:Number) : void
      {
         if(w != width)
         {
            this.setSize(w,height);
         }
      }
      
      override public function set height(h:Number) : void
      {
         if(h != height)
         {
            this.setSize(width,h);
         }
      }
      
      public function setScale9Grid(r:Rectangle) : void
      {
         if(Boolean(r))
         {
            if(!this.validGrid(r))
            {
               throw new Error("#001 - 当前scale9Grid" + r.toString() + "参数设置和位图数据[w=" + this._originalBitmap.width + ",h=" + this._originalBitmap.height + "]不匹配，请重设！");
            }
            this._scale9Grid = r.clone();
         }
      }
      
      override public function set scale9Grid(r:Rectangle) : void
      {
         var currentWidth:Number = NaN;
         var currentHeight:Number = NaN;
         if(this._scale9Grid == null && r != null || this._scale9Grid != null && !this._scale9Grid.equals(r))
         {
            if(r == null)
            {
               currentWidth = width;
               currentHeight = height;
               this._scale9Grid = null;
               this.setSize(currentWidth,currentHeight);
            }
            else
            {
               if(!this.validGrid(r))
               {
                  throw new Error("#001 - 当前scale9Grid" + r.toString() + "参数设置和位图数据[w=" + this._originalBitmap.width + ",h=" + this._originalBitmap.height + "]不匹配，请重设！");
               }
               this._scale9Grid = r.clone();
               this.resizeBitmap(width,height);
            }
         }
      }
      
      private function validGrid(r:Rectangle) : Boolean
      {
         return r.right <= this._originalBitmap.width && r.bottom <= this._originalBitmap.height;
      }
      
      override public function get scale9Grid() : Rectangle
      {
         return this._scale9Grid;
      }
      
      public function setSize(w:Number, h:Number) : void
      {
         if(w == this._w && this._h == h)
         {
            return;
         }
         if(this._scale9Grid != null)
         {
            w = Math.max(w,this._originalBitmap.width - this._scale9Grid.width);
            h = Math.max(h,this._originalBitmap.height - this._scale9Grid.height);
         }
         this._w = w;
         this._h = h;
         this.resizeBitmap(w,h);
      }
      
      public function getOriginalBitmapData() : BitmapData
      {
         return this._originalBitmap;
      }
      
      protected function resizeBitmap(w:Number, h:Number) : void
      {
         graphics.clear();
         if(Boolean(this.scale9Grid))
         {
            BitmapUtils.scale9Fill(graphics,this._originalBitmap,this.scale9Grid.top,this._scale9Grid.right,this.scale9Grid.left,this.scale9Grid.bottom,0,0,w,h);
         }
         else
         {
            w = Math.max(this._originalBitmap.width,w);
            h = Math.max(this._originalBitmap.height,h);
            BitmapUtils.fillBitmapData(graphics,this._originalBitmap,0,0,w,h);
         }
      }
   }
}

