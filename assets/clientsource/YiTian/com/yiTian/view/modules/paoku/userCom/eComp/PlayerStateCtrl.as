package com.yiTian.view.modules.paoku.userCom.eComp
{
   import com.yiTian.view.modules.paoku.core.entity.Entity;
   import com.yiTian.view.modules.paoku.core.entity.eComponent.IEntityCtrl;
   import com.yiTian.view.modules.paoku.core.state.StateMachie;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntity;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntityMsgConst;
   import com.yiTian.view.modules.paoku.userCom.role.state.KuPaoRoleStates;
   import com.yiTian.view.modules.paoku.userCom.role.state.StateDie;
   import com.yiTian.view.modules.paoku.userCom.role.state.StateDieFloat;
   import com.yiTian.view.modules.paoku.userCom.role.state.StateFloat;
   import com.yiTian.view.modules.paoku.userCom.role.state.StateJump;
   import com.yiTian.view.modules.paoku.userCom.role.state.StateRun;
   import com.yiTian.view.modules.paoku.userCom.role.state.StateStand;
   
   public class PlayerStateCtrl implements IEntityCtrl
   {
      
      protected var sm:StateMachie;
      
      private var _target:KuPaoEntity;
      
      public function PlayerStateCtrl()
      {
         super();
         this.sm = new StateMachie();
      }
      
      public function setName(v:String) : void
      {
      }
      
      public function getName() : String
      {
         return null;
      }
      
      public function setSortIndex(v:int) : void
      {
      }
      
      public function getSortIndex() : int
      {
         return 2;
      }
      
      public function enter(entity:Entity) : void
      {
         this._target = entity as KuPaoEntity;
      }
      
      public function exit(entity:Entity) : void
      {
      }
      
      public function update(entity:Entity) : void
      {
         var info:Object = null;
         var changeInfo:Array = entity.getMsg(KuPaoEntityMsgConst.CHANGE_STATE);
         entity.deleteMsg(KuPaoEntityMsgConst.CHANGE_STATE);
         if(changeInfo != null)
         {
            for each(info in changeInfo)
            {
               if(this.sm.changeState(info.state,entity))
               {
                  if(Boolean(info.ySpeed))
                  {
                     this._target.moveData.ySpeed = info.ySpeed;
                  }
                  if(Boolean(info.xSpeed))
                  {
                     this._target.moveData.xSpeed = info.xSpeed;
                  }
               }
            }
         }
         this.sm.smUpdate(entity);
      }
      
      public function unActive(entity:Entity) : void
      {
      }
      
      public function active(entity:Entity) : void
      {
         this.sm.changeState(KuPaoRoleStates.ST_RUN,entity);
      }
      
      private function stateEnterFunc(stateName:String) : void
      {
         trace("进入状态" + KuPaoRoleStates.getStateName(int(stateName)));
      }
      
      private function stateExitFunc(stateName:String) : void
      {
         trace("退出状态" + KuPaoRoleStates.getStateName(int(stateName)));
      }
      
      public function configureHeroStates() : void
      {
         this.sm.setState(KuPaoRoleStates.ST_STAND,new StateStand());
         this.sm.setState(KuPaoRoleStates.ST_RUN,new StateRun());
         this.sm.setState(KuPaoRoleStates.ST_JUMP,new StateJump());
         this.sm.setState(KuPaoRoleStates.ST_FLOAT,new StateFloat());
         this.sm.setState(KuPaoRoleStates.ST_DIE,new StateDie());
         this.sm.setState(KuPaoRoleStates.ST_DIEFLOAT,new StateDieFloat());
      }
   }
}

