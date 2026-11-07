package com.yiTian.data.vo
{
   public class Vo_valuable extends Vo_grid
   {
      
      public var id_server:Number = 0;
      
      public var bDiscard:Boolean;
      
      public var bBind:Boolean;
      
      public var price:int;
      
      public var lv:int;
      
      public var color:int;
      
      public var job:int;
      
      public var lv_use:int;
      
      public var type:int;
      
      public var shopPrice:int;
      
      public function Vo_valuable()
      {
         super();
      }
      
      public function Init_lib() : void
      {
         throw new Error("抽象方法,子类实现");
      }
   }
}

