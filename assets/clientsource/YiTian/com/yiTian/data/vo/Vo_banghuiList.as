package com.yiTian.data.vo
{
   public class Vo_banghuiList
   {
      
      public static var BANG_ID:int = 0;
      
      public static var PAIMING:int = 1;
      
      public static var BANG_NAME:int = 2;
      
      public static var BANG_HOST:int = 3;
      
      public static var BANG_LEVEL:int = 4;
      
      public static var BANG_MEMBERS:int = 5;
      
      public static var BANG_MEMBERS_LIM:int = 6;
      
      public var bang_id:Number;
      
      public var paiming:int;
      
      public var bang_name:String;
      
      public var bang_host:String;
      
      public var bang_level:int;
      
      public var bang_members:int;
      
      public var bang_members_lim:int;
      
      public function Vo_banghuiList()
      {
         super();
      }
      
      public function init_bang_list(arr:Array) : void
      {
         this.bang_id = arr[BANG_ID];
         this.paiming = arr[PAIMING];
         this.bang_name = arr[BANG_NAME];
         this.bang_host = arr[BANG_HOST];
         this.bang_level = arr[BANG_LEVEL];
         this.bang_members = arr[BANG_MEMBERS];
         this.bang_members_lim = arr[BANG_MEMBERS_LIM];
      }
   }
}

