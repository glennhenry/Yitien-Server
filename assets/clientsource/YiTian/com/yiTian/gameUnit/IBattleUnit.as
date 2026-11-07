package com.yiTian.gameUnit
{
   import flash.display.Sprite;
   
   public class IBattleUnit extends Sprite
   {
      
      public var id:Number;
      
      public var type:int;
      
      public function IBattleUnit()
      {
         super();
      }
      
      public function show() : void
      {
      }
      
      public function update(now:int) : void
      {
      }
      
      public function dispose() : void
      {
         if(!visible)
         {
            visible = true;
         }
      }
   }
}

