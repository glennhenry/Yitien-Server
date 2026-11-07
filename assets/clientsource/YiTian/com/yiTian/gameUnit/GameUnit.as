package com.yiTian.gameUnit
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.role.NameBar;
   import com.yiTian.utils.AStar;
   import com.yiTian.utils.Tween;
   import flash.display.Sprite;
   
   public class GameUnit extends Sprite
   {
      
      public var id:Number = 0;
      
      public var type:int;
      
      private var _global_x:int;
      
      private var _global_y:int;
      
      private var _state:int;
      
      private var _reOrder:int = 9;
      
      public var nameBar:NameBar;
      
      public function GameUnit()
      {
         super();
      }
      
      public function get global_x() : int
      {
         return this._global_x;
      }
      
      public function set global_x(value:int) : void
      {
         this._global_x = value;
      }
      
      public function get global_y() : int
      {
         return this._global_y;
      }
      
      public function set global_y(value:int) : void
      {
         this._global_y = value;
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      public function set state(value:int) : void
      {
         this._state = value;
      }
      
      public function set reOrder(value:int) : void
      {
         this._reOrder = value;
      }
      
      public function get reOrder() : int
      {
         return this._reOrder;
      }
      
      public function show() : void
      {
         this.align();
      }
      
      public function align() : void
      {
         x = this.global_x;
         y = this.global_y;
         if(AStar.getAlpha(this.global_x,this.global_y))
         {
            alpha = 0.5;
         }
         else
         {
            alpha = 1;
         }
      }
      
      public function update(now:int) : void
      {
      }
      
      public function interaction(mode:int = 0) : void
      {
      }
      
      public function mouseOver() : void
      {
      }
      
      public function mouseOut() : void
      {
      }
      
      public function get check() : Boolean
      {
         return false;
      }
      
      public function dispose() : void
      {
         Global.control.sendNotification(Enum_MsgType.GAMEUNIT_DISPOSE,this);
         if(!visible)
         {
            visible = true;
         }
         Tween.stop(this);
      }
   }
}

