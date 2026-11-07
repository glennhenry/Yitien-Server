package com.yiTian.view.modules.paoku.userCom.state
{
   import com.yiTian.view.modules.paoku.core.state.IState;
   import com.yiTian.view.modules.paoku.userCom.KuPaoMgr;
   import com.yiTian.view.modules.paoku.view.Child_DieMenu;
   import com.yiTian.view.modules.paoku.view.View_kuPaoPnl;
   
   public class KuPaoLogoState implements IState
   {
      
      public function KuPaoLogoState()
      {
         super();
      }
      
      public function enter(param:*) : void
      {
         View_kuPaoPnl.instance.addToContainer(Child_DieMenu.instance);
         Child_DieMenu.instance.visible = true;
      }
      
      public function exit(param:*) : void
      {
         Child_DieMenu.instance.visible = false;
         View_kuPaoPnl.instance.removeFromContainer(Child_DieMenu.instance);
      }
      
      public function update(param:*) : void
      {
      }
      
      public function askExit(nextState:int) : Boolean
      {
         return true;
      }
      
      private function onFadeInComplete() : void
      {
         KuPaoMgr.instance.paokuGlobalSM.changeState(KuPaoMgr.GST_STARTMENU);
      }
   }
}

