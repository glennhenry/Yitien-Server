package com.yiTian.view.modules.tianTi
{
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class Child_xinFaSB extends Bitmap
   {
      
      private static var vecStr:Vector.<String> = new <String>["Gold","Fire","Water","Earth","Wood"];
      
      private var _type:int;
      
      public function Child_xinFaSB(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false)
      {
         super(bitmapData,pixelSnapping,smoothing);
      }
      
      public function set type(value:uint) : void
      {
         this._type = value;
         Utils.loadTitle("lang/ch/Challenge_Imgs.swf",vecStr[value - 1],this,null,null);
      }
      
      public function get type() : uint
      {
         return this._type;
      }
   }
}

