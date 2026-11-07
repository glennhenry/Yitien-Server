package com.yiTian.view.modules.paoku.userCom.state
{
   import com.utils.ResObj;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.ResourceManager;
   import com.yiTian.net.message.cg.KuPaoCGMessage;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.view.modules.paoku.core.state.IState;
   import com.yiTian.view.modules.paoku.view.Child_StartMenu;
   import com.yiTian.view.modules.paoku.view.View_kuPaoPnl;
   
   public class KuPaoStartMenuState implements IState
   {
      
      public function KuPaoStartMenuState()
      {
         super();
      }
      
      public function enter(param:*) : void
      {
         KuPaoCGMessage.CG_KP_FRIENDSRANK();
         Child_StartMenu.instance.visible = true;
         View_kuPaoPnl.instance.addToContainer(Child_StartMenu.instance);
         var baseResUrl:String = GameUnitManager.hero.sex == 1 ? "modelRes/body/role/run/80101.swf" : "modelRes/body/role/run/80102.swf";
         var resObj:ResObj = ResourceManager.resourceIndex[baseResUrl];
         if(resObj == null || resObj.isLoad == false)
         {
            ResourceManager.load(baseResUrl,MassLoader.LEVEL4);
            ResourceManager.addCount(baseResUrl);
         }
      }
      
      public function exit(param:*) : void
      {
         Child_StartMenu.instance.visible = false;
         View_kuPaoPnl.instance.removeFromContainer(Child_StartMenu.instance);
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

