package com.yiTian.view.modules.boatChall
{
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.view.modules.ship.Ship;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   
   public class BoatBuff extends Ship
   {
      
      public static var list:Dictionary = new Dictionary();
      
      public static var pool:Array = [];
      
      public static var boatPosDic:Dictionary = new Dictionary();
      
      public var sysId:int;
      
      private var _buffWay:int;
      
      public function BoatBuff()
      {
         super();
      }
      
      public function init_buff(sysId:int, global_x:int, global_y:int, itemId:int) : void
      {
         this.sysId = sysId;
         this.global_x = global_x;
         this.global_y = global_y;
         this.id = itemId;
         boatPosDic[sysId] = [this,sysId,itemId];
         this.action = Action.STAND;
         this.showBody();
      }
      
      override public function show() : void
      {
         align();
         list[this.sysId] = this;
      }
      
      private function showBody() : void
      {
         parts.setPart(id,0);
         parts.reset();
      }
      
      override public function set way(value:int) : void
      {
         this._buffWay = value;
         if(value > 0 && value < 6)
         {
            parts.scaleX = 1;
         }
         else
         {
            parts.scaleX = -1;
         }
      }
      
      override public function get way() : int
      {
         return this._buffWay;
      }
      
      override public function update(now:int) : void
      {
         parts.update(now);
      }
      
      public function getPart() : Bitmap
      {
         return parts.getPart(0);
      }
      
      override public function dispose() : void
      {
         pool.push(this);
         this._buffWay = 0;
         delete list[id];
         delete boatPosDic[this.sysId];
      }
   }
}

