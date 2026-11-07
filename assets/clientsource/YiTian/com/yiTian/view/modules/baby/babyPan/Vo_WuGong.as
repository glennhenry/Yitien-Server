package com.yiTian.view.modules.baby.babyPan
{
   public class Vo_WuGong
   {
      
      public static var instance:Vo_WuGong = new Vo_WuGong();
      
      public var JY_wuGong:int;
      
      public var JZ_wuGong:int;
      
      public var Thirt_wuGong:int;
      
      public function Vo_WuGong()
      {
         super();
      }
      
      public function init(arr:Array) : void
      {
         this.JY_wuGong = arr[0];
         this.JZ_wuGong = arr[1];
         this.Thirt_wuGong = arr[2];
      }
   }
}

