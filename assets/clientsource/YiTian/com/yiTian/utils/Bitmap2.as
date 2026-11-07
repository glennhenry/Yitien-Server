package com.yiTian.utils
{
   import com.utils.Util;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class Bitmap2 extends Bitmap
   {
      
      private var _counter:int = 0;
      
      private var _complete:Function;
      
      public function Bitmap2(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false)
      {
         super(bitmapData,pixelSnapping,smoothing);
      }
      
      public function load(url:String, lv:int = 1, complete:Function = null) : void
      {
         this._counter += 1;
         if(url == "" || url == null)
         {
            bitmapData = null;
            return;
         }
         if(Boolean(Util.bmdPool[url]))
         {
            bitmapData = Util.bmdPool[url] as BitmapData;
            if(complete != null)
            {
               complete(null);
            }
         }
         else
         {
            MassLoader.add(url,this.onMassLoaderComplete,null,lv,this._counter);
            this._complete = complete;
         }
      }
      
      private function onMassLoaderComplete(info:Object) : void
      {
         var counter:int = int(info.obj);
         var bm:Bitmap = info.content as Bitmap;
         if(Boolean(bm))
         {
            Util.bmdPool[info.url] = bm.bitmapData;
         }
         if(counter == this._counter)
         {
            if(Boolean(bm))
            {
               bitmapData = bm.bitmapData;
            }
         }
         if(this._complete != null)
         {
            this._complete(info);
         }
         this._complete = null;
      }
      
      public function set complete(value:Function) : void
      {
         this._complete = value;
      }
   }
}

