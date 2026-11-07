package com.yiTian.view.modules.Card
{
   import com.yiTian.data.Data_lib;
   
   public class Vo_card
   {
      
      private var _id:int;
      
      private var _color:int;
      
      private var _type:int;
      
      public var star:int;
      
      public var level:int;
      
      public var exp:int;
      
      public var lock:int;
      
      public function Vo_card()
      {
         super();
      }
      
      public function get color() : int
      {
         return this._color;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function set id(value:int) : void
      {
         this._id = value;
         if(value > 0)
         {
            this._color = Data_lib.card[this.id][4];
            this._type = Data_lib.card[this.id][0];
         }
         else
         {
            this._color = 0;
            this._type = 0;
         }
      }
      
      public function clone() : Vo_card
      {
         var vo:Vo_card = new Vo_card();
         vo.id = this.id;
         vo._color = this._color;
         vo.star = this.star;
         vo.level = this.level;
         vo.exp = this.exp;
         vo.lock = this.lock;
         return vo;
      }
      
      public function get type() : int
      {
         return this._type;
      }
   }
}

