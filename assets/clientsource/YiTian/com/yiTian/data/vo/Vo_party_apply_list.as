package com.yiTian.data.vo
{
   public class Vo_party_apply_list
   {
      
      public static var APPLY_ID:int = 0;
      
      public static var NAME:int = 1;
      
      public static var LEVEL:int = 2;
      
      public static var JOB:int = 3;
      
      public var apply_id:Number;
      
      public var name:String;
      
      public var level:int;
      
      public var job:int;
      
      public function Vo_party_apply_list()
      {
         super();
      }
      
      public function init(arr:Array) : void
      {
         this.apply_id = arr[APPLY_ID];
         this.name = arr[NAME];
         this.level = arr[LEVEL];
         this.job = arr[JOB];
      }
   }
}

