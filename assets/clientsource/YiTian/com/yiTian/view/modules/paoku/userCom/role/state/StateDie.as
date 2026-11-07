package com.yiTian.view.modules.paoku.userCom.role.state
{
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.view.modules.kupao.KPMap;
   import com.yiTian.view.modules.paoku.core.state.IState;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntity;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntityMsgConst;
   import com.yiTian.view.modules.paoku.userCom.KuPaoMgr;
   import com.yiTian.view.modules.paoku.userCom.input.KuPaoInput;
   import flash.utils.getTimer;
   
   public class StateDie implements IState
   {
      
      private var _target:KuPaoEntity;
      
      private var _enterTime:int;
      
      public function StateDie()
      {
         super();
      }
      
      public function enter(param:*) : void
      {
         this._target = param;
         this._target.moveData.limitInScreen = false;
         this._target.moveData.xSpeed = Math.max(0,this._target.moveData.xSpeed - 20);
         this._target.moveData.ySpeed = -7;
         this._enterTime = getTimer();
         this._target.acceptMsg(KuPaoEntityMsgConst.CHANGE_STATE);
         this._target.addMsg(KuPaoEntityMsgConst.CHANGE_ACTIONVIEW,{
            "action":Action.RUN,
            "frameInterval":20000
         });
         KuPaoInput.instance.pause();
         KPMap.instance.shake();
      }
      
      public function exit(param:*) : void
      {
         this._target.moveData.limitInScreen = true;
         this._target = null;
      }
      
      public function update(param:*) : void
      {
         var now:int = getTimer();
         if(now - this._enterTime > 1000)
         {
            this._target.acceptMsg(KuPaoEntityMsgConst.CHANGE_STATE);
            KuPaoMgr.instance.paokuGlobalSM.changeState(KuPaoMgr.GST_GAMEOVER,null);
         }
      }
      
      public function askExit(nextState:int) : Boolean
      {
         if(nextState == KuPaoRoleStates.ST_RUN)
         {
            return true;
         }
         return false;
      }
   }
}

