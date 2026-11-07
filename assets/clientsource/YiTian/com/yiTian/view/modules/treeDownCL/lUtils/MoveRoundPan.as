package com.yiTian.view.modules.treeDownCL.lUtils
{
   import com.yiTian.utils.Tween;
   import flash.display.Sprite;
   
   public class MoveRoundPan extends Sprite
   {
      
      public static const MOVE_IN:int = 0;
      
      public static const MOVE_OUT:int = 1;
      
      public static const LEFT_MOVE:int = 0;
      
      public static const RIGHT_MOVE:int = 1;
      
      public static const UP_MOVE:int = 2;
      
      public static const DOWN_MOVE:int = 3;
      
      protected var property:Array = [];
      
      public var _width:int;
      
      public var _height:int;
      
      private var _time:int = 300;
      
      public var outDt:Object;
      
      public function MoveRoundPan()
      {
         super();
      }
      
      public static function reverse(moveType:int) : int
      {
         if(moveType == LEFT_MOVE)
         {
            return RIGHT_MOVE;
         }
         if(moveType == RIGHT_MOVE)
         {
            return LEFT_MOVE;
         }
         if(moveType == UP_MOVE)
         {
            return DOWN_MOVE;
         }
         if(moveType == DOWN_MOVE)
         {
            return UP_MOVE;
         }
         return LEFT_MOVE;
      }
      
      public function setProperty(wid:int, hei:int) : void
      {
         this._width = wid;
         this._height = hei;
      }
      
      protected function getMoveStype(value:int, inOrOut:int) : Object
      {
         if(!parent)
         {
            return null;
         }
         if(!this.property.length)
         {
            this.property = [[{"x":[-this._width,0]},{"x":[this._width,0]},{"y":[-this._height,0]},{"y":[this._height,0]}],[{"x":[0,-this._width]},{"x":[0,this._width]},{"y":[0,-this._height]},{"y":[0,this._height]}]];
         }
         return this.property[inOrOut][value];
      }
      
      public function set delayTime(value:int) : void
      {
         this._time = value;
      }
      
      public function moveIn(movetype:int) : void
      {
         var obj:Object = this.getMoveStype(movetype,0);
         Tween.to(this,this._time,obj,this.complete,this.inGuoCheng);
      }
      
      public function dispose() : void
      {
      }
      
      public function moveOut(movetype:int, data:Object = null) : void
      {
         var obj:Object = this.getMoveStype(movetype,1);
         this.outDt = data;
         Tween.to(this,this._time,obj,this.dispose,this.outGuoCheng);
      }
      
      public function inGuoCheng() : void
      {
      }
      
      public function complete() : void
      {
      }
      
      public function outGuoCheng() : void
      {
      }
      
      public function update(data:Object = null) : void
      {
      }
   }
}

