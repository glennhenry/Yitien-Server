package com.yiTian.view.modules.paoku.userCom.role.state
{
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.view.modules.paoku.core.state.IState;
   import com.yiTian.view.modules.paoku.model.Model_KuPao;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntity;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntityMsgConst;
   import com.yiTian.view.modules.paoku.userCom.KuPaoMgr;
   
   public class StateRun implements IState
   {
      
      private var _target:KuPaoEntity;
      
      public function StateRun()
      {
         super();
      }
      
      public function enter(param:*) : void
      {
         this._target = param;
         this._target.moveData.xSpeed = Math.min(40,8 * Model_KuPao.speedMul);
         this._target.moveData.ySpeed = 0;
         this._target.addMsg(KuPaoEntityMsgConst.CHANGE_ACTIONVIEW,{
            "action":Action.RUN,
            "frameInterval":60
         });
      }
      
      public function exit(param:*) : void
      {
      }
      
      public function update(param:*) : void
      {
         this._target.moveData.ySpeed = 0;
         var bottomType:int = KuPaoMgr.instance.getType(this._target.moveData.xPos,this._target.moveData.yPos - 2);
         if(bottomType != 1)
         {
            this._target.addMsg(KuPaoEntityMsgConst.CHANGE_STATE,{"state":KuPaoRoleStates.ST_JUMP});
         }
      }
      
      public function askExit(nextState:int) : Boolean
      {
         return true;
      }
   }
}

