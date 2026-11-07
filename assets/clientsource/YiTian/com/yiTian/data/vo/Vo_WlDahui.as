package com.yiTian.data.vo
{
   public class Vo_WlDahui
   {
      
      public static var PAIMING:int = 0;
      
      public static var ROLE_ID:int = 1;
      
      public static var ROLE_NAME:int = 2;
      
      public static var ROLE_JIFEN:int = 3;
      
      public var paiming:int;
      
      public var role_id:int;
      
      public var role_name:String;
      
      public var role_jifen:int;
      
      public function Vo_WlDahui()
      {
         super();
      }
      
      public function init(arr:Array) : void
      {
         this.paiming = arr[0];
         this.role_id = arr[1];
         this.role_name = arr[2];
         this.role_jifen = arr[3];
      }
   }
}

