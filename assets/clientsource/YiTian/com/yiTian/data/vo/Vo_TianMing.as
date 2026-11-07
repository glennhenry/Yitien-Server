package com.yiTian.data.vo
{
   public class Vo_TianMing extends Vo_item
   {
      
      public var exp:int;
      
      public var level:int;
      
      public var value:int;
      
      public var lock:Boolean;
      
      public var eat_lock:Boolean;
      
      public function Vo_TianMing()
      {
         super();
      }
      
      override public function Init_sever_bag(dto:Array) : void
      {
         id_server = dto[0];
         id = dto[1];
         this.level = dto[2];
         this.exp = dto[3];
         this.value = dto[4];
         if(dto[5] == 1)
         {
            this.eat_lock = true;
         }
         else
         {
            this.eat_lock = false;
         }
         Init_lib();
      }
   }
}

