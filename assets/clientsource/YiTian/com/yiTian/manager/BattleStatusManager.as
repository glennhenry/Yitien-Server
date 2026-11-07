package com.yiTian.manager
{
   import com.yiTian.gameUnit.role.Role;
   import com.yiTian.net.message.cg.BattleCGMessage;
   import com.yiTian.scene.GameScene;
   import flash.utils.Dictionary;
   
   public class BattleStatusManager
   {
      
      private static var isRunning:Boolean;
      
      private static var battleSta:Sta;
      
      private static var list:Dictionary = new Dictionary();
      
      public function BattleStatusManager()
      {
         super();
      }
      
      public static function addUnit(id:Number, type:Number, leftTime:int) : void
      {
         var role:Role = GameUnitManager.findUnit(id,type) as Role;
         if(Boolean(role))
         {
            if(!leftTime)
            {
               removeUnit(role);
               return;
            }
            if(!list[role])
            {
               role.addBattleEff();
               list[role] = 1;
            }
         }
      }
      
      public static function removeUnit(role:Role) : void
      {
         if(Boolean(role) && Boolean(list[role]))
         {
            role.removeBattleEff();
            list[role] = null;
            delete list[role];
         }
      }
      
      public static function setSelfBattleRun(battleTime:int) : void
      {
         if(!battleTime)
         {
            return;
         }
         battleSta = new Sta(battleTime);
         GameUnitManager.hero.addBattleEff();
         if(!isRunning)
         {
            GameScene.instance.addFrameCallBack(selfRun);
            isRunning = true;
         }
      }
      
      private static function selfRun() : void
      {
         if(battleSta.timeOver())
         {
            GameScene.instance.removeFrameCallBack(selfRun);
            isRunning = false;
            battleSta = null;
            GameUnitManager.hero.removeBattleEff();
            BattleCGMessage.CG_BATTLE_FINISH();
         }
      }
   }
}

import flash.utils.getTimer;

class Sta
{
   
   private var _beginTime:int;
   
   private var _leftTime:int;
   
   public function Sta(leftTime:int)
   {
      super();
      this._beginTime = getTimer();
      this._leftTime = leftTime * 1000;
   }
   
   public function timeOver() : Boolean
   {
      var now:int = getTimer();
      if(now - this._beginTime >= this._leftTime)
      {
         return true;
      }
      return false;
   }
}
