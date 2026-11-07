package com.yiTian.data.vo
{
   public class Vo_bangMem
   {
      
      public static var HERO_ID:int = 0;
      
      public static var NAME:int = 1;
      
      public static var POSITION:int = 2;
      
      public static var JOB:int = 3;
      
      public static var LVL:int = 4;
      
      public static var SELF_GONG:int = 5;
      
      public static var MEM_GONG:int = 6;
      
      public static var IS_ONLINE:int = 7;
      
      public var heroId:Number = 0;
      
      public var name:String;
      
      public var position:int;
      
      public var job:int;
      
      public var lvl:int;
      
      public var self_gong:int;
      
      public var mem_gong:int;
      
      public var is_online:int;
      
      public function Vo_bangMem()
      {
         super();
      }
      
      public function init(arr:Array) : void
      {
         this.heroId = arr[HERO_ID];
         this.name = arr[NAME];
         this.position = arr[POSITION];
         this.job = arr[JOB];
         this.lvl = arr[LVL];
         this.self_gong = arr[SELF_GONG];
         this.mem_gong = arr[MEM_GONG];
         this.is_online = arr[IS_ONLINE];
      }
   }
}

