package com.utils
{
   import flash.display.Stage;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class Util
   {
      
      public static var stage:Stage;
      
      public static var isOnUI:Boolean;
      
      public static var talk_words:Array;
      
      public static const WHILE_BODER:Array = [new GlowFilter(16777215,1,10,10,10)];
      
      public static var glowFFFFFF:Array = [new GlowFilter(16777215,1,2,2,10)];
      
      public static var glowFF0000:Array = [new GlowFilter(16711680,1,2,2,10)];
      
      public static var glow000000:Array = [new GlowFilter(0,1,2,2,10)];
      
      public static var glowBig000000:Array = [new GlowFilter(0,0.6,10,10,8,1)];
      
      public static var glowBigFFff00:Array = [new GlowFilter(16776960,0.6,10,10,8,1)];
      
      public static var glowFFFF00:Array = [new GlowFilter(16776960,0.8,15,15,2,1)];
      
      public static var glowde45c7:Array = [new GlowFilter(14566855,0.8,3,3,2,1)];
      
      public static var glowFFff00:Array = [new GlowFilter(16776960,0.8,3,3,2,1)];
      
      public static var dark:Array = [new ColorMatrixFilter([0.3,0,0,0,0,0,0.3,0,0,0,0,0,0.3,0,0,0,0,0,1,0])];
      
      public static var disabled:Array = [new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0])];
      
      public static var disabledb:Array = [new ColorMatrixFilter([0.1886,0.3694,0.082,0,0,0.1886,0.3694,0.082,0,0,0.1886,0.3694,0.082,0,0,0,0,0,1,0])];
      
      public static var colorGlow:ColorTransform = new ColorTransform(1,1,1,1,50,50,50,0);
      
      public static var colorNomal:ColorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
      
      public static var colorWhite:ColorTransform = new ColorTransform(1,1,1,1,200,200,200,0);
      
      public static var colorWhite2:ColorTransform = new ColorTransform(1,1,1,1,50,50,50,0);
      
      public static var qhtz0:ColorTransform = new ColorTransform(0,0,0,1,128,128,128,0);
      
      public static var qhtz1:ColorTransform = new ColorTransform(0,0,0,1,80,255,0,0);
      
      public static var qhtz2:ColorTransform = new ColorTransform(0,0,0,1,0,135,255,0);
      
      public static var qhtz3:ColorTransform = new ColorTransform(0,0,0,1,255,0,255,0);
      
      public static var yellow:ColorTransform = new ColorTransform(0.3,0.3,0.3,1,256,256,0,0);
      
      public static var red:ColorTransform = new ColorTransform(0.3,0.3,0.3,1,256,0,0,0);
      
      public static var blue:ColorTransform = new ColorTransform(0.3,0.3,0.3,1,0,255,255,0);
      
      public static var green:ColorTransform = new ColorTransform(0.3,0.3,0.3,1,0,255,0,0);
      
      public static var cyan:ColorTransform = new ColorTransform(0.3,0.3,0.3,1,255,0,255,0);
      
      public static var matrix:Matrix = new Matrix();
      
      public static var point:Point = new Point();
      
      public static var rect:Rectangle = new Rectangle();
      
      public static var bmdPool:Dictionary = new Dictionary();
      
      public static var resourcePool:Dictionary = new Dictionary();
      
      public function Util()
      {
         super();
      }
      
      public static function rnd(min:Number, max:Number) : Number
      {
         return Math.floor(Math.random() * (max - min + 1)) + min;
      }
      
      public static function dist(x1:int, y1:int, x2:int, y2:int) : int
      {
         return (y2 - y1) * (y2 - y1) + (x2 - x1) * (x2 - x1);
      }
      
      public static function getWay(x0:int, y0:int, x:int, y:int) : int
      {
         var a:Number = Math.atan2(y - y0,x - x0);
         return int((a + Math.PI * 3.625) % (Math.PI * 2) / (Math.PI / 4));
      }
      
      public static function splicObj(src:String, splics:String) : Object
      {
         var remainStr:String = null;
         var tmpStr:String = null;
         var tmpArr:Array = null;
         var result:Object = null;
         var s:String = null;
         if(splics.length > 0)
         {
            tmpStr = splics.charAt(0);
            remainStr = splics.slice(1);
            tmpArr = src.split(tmpStr);
            result = [];
            for each(s in tmpArr)
            {
               (result as Array).push(splicObj(s,remainStr));
            }
         }
         else
         {
            result = src;
         }
         return result;
      }
      
      public static function rep(src:String, ... param) : String
      {
         var rg:String = null;
         var d:String = null;
         var len:int = int(param.length);
         var i:int = 0;
         if(param is String)
         {
            rg = "[{{]" + i.toString() + "[}}]";
            src.replace(rg,param);
         }
         else if(param is Array)
         {
            if(len == 0)
            {
               return src;
            }
            while(i < len)
            {
               rg = "[{{]" + i.toString() + "[}}]";
               d = param[i];
               src = src.replace(new RegExp(rg,"g"),d);
               i += 1;
            }
         }
         return src;
      }
      
      public static function clone(value:Object) : Object
      {
         var bytes:ByteArray = new ByteArray();
         bytes.writeObject(value);
         bytes.position = 0;
         return bytes.readObject();
      }
   }
}

