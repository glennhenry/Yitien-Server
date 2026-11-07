package com.yiTian.view.modules.paoku.userCom.role.state
{
   import com.yiTian.view.modules.paoku.core.state.IState;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntity;
   
   public class StateStand implements IState
   {
      
      private var _target:KuPaoEntity;
      
      public function StateStand()
      {
         super();
      }
      
      public function enter(param:*) : void
      {
         this._target = param;
      }
      
      public function exit(param:*) : void
      {
      }
      
      public function update(param:*) : void
      {
      }
      
      public function askExit(nextState:int) : Boolean
      {
         return true;
      }
   }
}

