package com.yiTian.effects
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class Effect_attribute extends Bitmap
   {
      
      public static const POWER:String = "power";
      
      public static const ATT:String = "att";
      
      public static const DEF:String = "def";
      
      public static const HP:String = "hp";
      
      public static const MP:String = "mp";
      
      private static var lib:Dictionary = new Dictionary();
      
      private static var rect:Rectangle = new Rectangle(0,0,35,35);
      
      private static var pool:Array = [];
      
      private var list:Array;
      
      private var _width:int;
      
      public function Effect_attribute(type:String, num:int)
      {
         super();
         this.init(type,num);
      }
      
      public static function pop(type:String, num:int) : Effect_attribute
      {
         var o:Effect_attribute = null;
         if(Boolean(pool.length))
         {
            o = pool.pop();
            o.init(type,num);
         }
         else
         {
            o = new Effect_attribute(type,num);
         }
         return o;
      }
      
      private function init(type:String, num:int) : void
      {
         this.list = [];
         this.decode(Math.abs(int(num)));
         bitmapData = new BitmapData(210,31,true,0);
         if(!lib[type])
         {
            lib[type] = ComponentUtil.getBitmapData(type,Global.effectWord);
         }
         Utils.point.x = 0;
         Utils.point.y = 0;
         rect.width = lib[type].width;
         rect.height = 31;
         bitmapData.copyPixels(lib[type],rect,Utils.point,null,null,true);
         Utils.point.x += rect.width;
         if(!lib["+"])
         {
            lib["+"] = ComponentUtil.getBitmapData("+",Global.effectWord);
         }
         rect.width = lib["+"].width;
         bitmapData.copyPixels(lib["+"],rect,Utils.point,null,null,true);
         Utils.point.x += rect.width - 5;
         rect.width = 22;
         var j:int = this.list.length - 1;
         while(j >= 0)
         {
            if(!lib["_" + this.list[j]])
            {
               lib["_" + this.list[j]] = ComponentUtil.getBitmapData("_" + this.list[j],Global.effectWord);
            }
            bitmapData.copyPixels(lib["_" + this.list[j]],rect,Utils.point,null,null,true);
            Utils.point.x += rect.width - 6;
            j--;
         }
         this._width = Utils.point.x;
      }
      
      private function decode(number:int) : void
      {
         if(number == 0)
         {
            return;
         }
         this.list.push(number % 10);
         this.decode(int(number / 10));
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      public function dispose() : void
      {
         if(Boolean(bitmapData))
         {
            bitmapData.dispose();
            bitmapData = null;
         }
         pool.push(this);
      }
   }
}

