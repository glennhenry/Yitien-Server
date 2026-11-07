package com.yiTian.gameUnit.role
{
   import com.yiTian.gameUnit.magic.Magic;
   
   public class Door extends Magic
   {
      
      public static var targerID:int;
      
      public static var toX:int;
      
      public static var toY:int;
      
      public static const CITY:int = 1;
      
      public static const FUBEN:int = 2;
      
      public static var pool:Array = [];
      
      public static var list:Array = [];
      
      public var linkID:int;
      
      public var toX:int;
      
      public var toY:int;
      
      public var door_type:int;
      
      public function Door()
      {
         super();
      }
      
      override public function show() : void
      {
         super.show();
         list[id] = this;
      }
      
      override public function get check() : Boolean
      {
         return true;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         delete list[id];
         pool.push(this);
      }
   }
}

