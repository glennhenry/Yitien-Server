package com.yiTian.view.modules.xiaoxiaole
{
   import com.utils.ComponentUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   
   public class Effect_Strenth
   {
      
      private static var isLoading:Boolean;
      
      public static var pool:Vector.<Bitmap>;
      
      public static var bmpdList:Vector.<BitmapData> = new Vector.<BitmapData>();
      
      private static var waitList:Array = [];
      
      private static var counts:int = 0;
      
      public function Effect_Strenth()
      {
         super();
      }
      
      private static function init() : void
      {
         var arr:Array = null;
         pool = new Vector.<Bitmap>();
         var urlList:Array = ["SZ_Ling","SZ_Yi","SZ_Er","SZ_San","SZ_Si","SZ_Wu","SZ_Liu","SZ_Qi","SZ_Ba","SZ_Jiu"];
         var i:int = 0;
         while(i < 10)
         {
            bmpdList.push(ComponentUtil.getBitmapData(urlList[i]));
            i++;
         }
         if(Boolean(waitList.length))
         {
            arr = waitList.shift();
            setValue(arr[0],arr[1]);
         }
      }
      
      public static function setValue(value:int, con:Sprite) : void
      {
         var arr:Array = null;
         if(!con)
         {
            return;
         }
         if(!bmpdList.length)
         {
            waitList.push([value,con]);
            init();
            return;
         }
         while(Boolean(waitList.length))
         {
            arr = waitList.shift();
            setValue(arr[0],arr[1]);
         }
         if(!con.numChildren)
         {
            con.addChild(new SimpleNum());
         }
         (con.getChildAt(0) as SimpleNum).setValue(value);
      }
   }
}

import com.utils.ComponentUtil;
import com.yiTian.scene.GameScene;
import com.yiTian.view.modules.xiaoxiaole.Effect_Strenth;
import flash.display.Bitmap;
import flash.display.Sprite;

class SimpleNum extends Sprite
{
   
   private var bmp:Bitmap;
   
   public var isRunning:Boolean;
   
   private var _Num:int;
   
   private var bmpPool:Array = [];
   
   private var lastValue:int;
   
   private var count:int;
   
   private var add:int;
   
   private var currentValue:int;
   
   private var _value:int;
   
   private var isPlaying:Boolean;
   
   private var maxCount:int;
   
   public function SimpleNum()
   {
      super();
   }
   
   public function setValue(value:int) : void
   {
      this._value = value;
      if(this.isPlaying)
      {
         this.endFunction();
      }
      if(value <= this.lastValue)
      {
         this.lastValue = value;
         this.endFunction();
         return;
      }
      this.count = 0;
      this.currentValue = this.lastValue;
      this.add = (value - this.lastValue) / 50;
      this.maxCount = this.add == 0 ? int(value - this.lastValue) : 50;
      if(this.add == 0)
      {
         this.add = 1;
      }
      this.lastValue = value;
      GameScene.instance.addFrameCallBack(this.play);
   }
   
   private function play() : void
   {
      this.isPlaying = true;
      this.currentValue += this.add;
      this.Num = this.currentValue;
      ++this.count;
      if(this.count >= this.maxCount || this.count == this._value - this.lastValue)
      {
         this.endFunction();
      }
   }
   
   private function endFunction() : void
   {
      this.isPlaying = false;
      this.count = 0;
      this.Num = this.lastValue;
      this.add = 0;
      GameScene.instance.removeFrameCallBack(this.play);
   }
   
   public function set Num(value:int) : void
   {
      var btm:Bitmap = null;
      var bm:Bitmap = null;
      var index:int = 0;
      this._Num = value;
      var len:int = String(value).length;
      if(this.bmpPool.length > len)
      {
         while(this.bmpPool.length > len)
         {
            btm = this.bmpPool[this.bmpPool.length - 1];
            btm.parent.removeChild(btm);
            btm.bitmapData = null;
            Effect_Strenth.pool.push(btm);
            this.bmpPool.pop();
         }
      }
      while(this.bmpPool.length < len)
      {
         this.bmp = Boolean(Effect_Strenth.pool.length) ? Effect_Strenth.pool.shift() : new Bitmap();
         this.bmp.bitmapData = null;
         this.addChild(this.bmp);
         this.bmpPool.push(this.bmp);
      }
      var i:int = 0;
      while(i < len)
      {
         bm = this.bmpPool[i];
         index = int(String(value).charAt(i));
         bm.bitmapData = Effect_Strenth.bmpdList[index].clone();
         i++;
      }
      this.algin();
   }
   
   public function algin() : void
   {
      var bbb:Bitmap = null;
      var j:uint = 0;
      while(j < this.bmpPool.length)
      {
         bbb = this.bmpPool[j];
         ComponentUtil.setPropertie(bbb,{
            "x":11 * j,
            "y":0
         });
         j++;
      }
   }
}
