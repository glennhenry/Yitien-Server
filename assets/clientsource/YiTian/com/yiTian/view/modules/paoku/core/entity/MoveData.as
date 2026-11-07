package com.yiTian.view.modules.paoku.core.entity
{
   public class MoveData
   {
      
      public var xSpeed:Number = 0;
      
      public var ySpeed:Number = 0;
      
      public var yPos:int = 0;
      
      public var xPos:int = 0;
      
      public var poseState:int;
      
      public var moveState:int;
      
      public var canCrossWall:Boolean = false;
      
      public var limitInScreen:Boolean = false;
      
      public var imbaTime:Boolean = false;
      
      public function MoveData()
      {
         super();
      }
   }
}

