package com.yiTian.gameUnit.magic
{
   import com.utils.DisplayData;
   import com.utils.ResObj;
   import com.utils.Util;
   import com.yiTian.manager.ResourceManager;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.utils.getTimer;
   
   public class Effect extends Bitmap
   {
      
      private static var pool:Array = [];
      
      public var url:String;
      
      public var current:int;
      
      public var totalTime:int;
      
      public var beginTime:int;
      
      public var isLoop:Boolean;
      
      public var px:int;
      
      public var py:int;
      
      public var count:int;
      
      public var playedCount:int;
      
      public var endCallBack:Function;
      
      public var direct:int;
      
      public var invalidate:Boolean = false;
      
      private var useCount:int = 0;
      
      public function Effect()
      {
         super();
      }
      
      public static function getEffect() : Effect
      {
         return Boolean(pool.length) ? pool.pop() : new Effect();
      }
      
      public function init(sourceID:String, loadLevel:int = 5) : void
      {
         this.useCount += 1;
         this.current = -1;
         this.beginTime = getTimer();
         this.isLoop = false;
         this.url = "modelRes/magic/" + sourceID + ".swf";
         ResourceManager.load(this.url,loadLevel);
         this.playedCount = 0;
         this.count = -1;
         this.endCallBack = null;
      }
      
      public function update(past:int, total:int, way:int = 0) : void
      {
         var res:ResObj = null;
         var rate:Number = NaN;
         var index:int = 0;
         var now:int = 0;
         var data:DisplayData = null;
         var frameIndex:int = 0;
         if(past >= total)
         {
            visible = false;
         }
         else
         {
            res = ResourceManager.resourceIndex[this.url];
            if(res.isLoad)
            {
               if(!visible)
               {
                  visible = true;
               }
               rate = past / total;
               now = rate * res.actionFrame;
               if(res.isSpecial)
               {
                  frameIndex = int(res.f[now]);
                  if(frameIndex == -1)
                  {
                     bitmapData = null;
                     return;
                  }
                  if(res.f[now] == undefined)
                  {
                     bitmapData = null;
                     return;
                  }
                  if(res.way > 1)
                  {
                     index = res.rect.length / res.way * way + res.f[now];
                  }
                  else
                  {
                     index = int(res.f[now]);
                  }
               }
               else if(res.way > 1)
               {
                  index = way * res.actionFrame + now;
               }
               else
               {
                  index = now;
               }
               if(Boolean(index == this.current && bitmapData) && Boolean(this.url.indexOf("35040") == -1) && this.invalidate == false)
               {
                  return;
               }
               this.current = index;
               data = ResourceManager.find(res,index);
               bitmapData = data.p;
               x = data.x + this.px;
               y = data.y + this.py;
               this.invalidate = false;
            }
         }
      }
      
      public function dispose() : void
      {
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
         if(pool.indexOf(this) == -1)
         {
            this.useCount -= 1;
            if(this.useCount == 0)
            {
               pool.push(this);
            }
         }
         visible = true;
         this.isLoop = false;
         if(blendMode != BlendMode.NORMAL)
         {
            blendMode = BlendMode.NORMAL;
         }
         if(transform.colorTransform != Util.colorNomal)
         {
            transform.colorTransform = Util.colorNomal;
         }
         this.px = x = 0;
         this.py = y = 0;
         if(scaleX != 1)
         {
            scaleX = 1;
         }
         if(scaleY != 1)
         {
            scaleY = 1;
         }
         bitmapData = null;
         this.endCallBack = null;
      }
   }
}

