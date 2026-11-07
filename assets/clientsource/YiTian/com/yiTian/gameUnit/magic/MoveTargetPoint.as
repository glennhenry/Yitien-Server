package com.yiTian.gameUnit.magic
{
   import com.yiTian.Global;
   import com.yiTian.gameUnit.GameUnit;
   import com.yiTian.manager.CameraManager;
   import flash.utils.getTimer;
   
   public class MoveTargetPoint extends GameUnit
   {
      
      private var beginTime:int;
      
      private var totalTime:int = 800;
      
      private var effect:Effect;
      
      private var isFirst:Boolean = true;
      
      public function MoveTargetPoint()
      {
         super();
         this.effect = Effect.getEffect();
         this.effect.init("35002");
         addChild(this.effect);
      }
      
      override public function show() : void
      {
         global_x = CameraManager.sightX + Global.stage.mouseX;
         global_y = CameraManager.sightY + Global.stage.mouseY;
         if(this.isFirst)
         {
            this.isFirst = false;
         }
         else
         {
            super.show();
            this.beginTime = getTimer();
            visible = true;
         }
      }
      
      override public function update(now:int) : void
      {
         if(!visible)
         {
            return;
         }
         if(now - this.beginTime > this.totalTime)
         {
            visible = false;
         }
         this.effect.update(now - this.beginTime,this.totalTime);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.isFirst = true;
      }
   }
}

