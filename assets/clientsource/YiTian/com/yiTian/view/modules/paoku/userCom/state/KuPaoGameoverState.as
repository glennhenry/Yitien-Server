package com.yiTian.view.modules.paoku.userCom.state
{
   import com.yiTian.net.message.cg.KuPaoCGMessage;
   import com.yiTian.view.modules.kupao.KPMap;
   import com.yiTian.view.modules.paoku.core.state.IState;
   import com.yiTian.view.modules.paoku.model.Model_KuPao;
   import com.yiTian.view.modules.paoku.userCom.KuPaoMgr;
   import com.yiTian.view.modules.paoku.userCom.util.KuPaoUtil;
   import com.yiTian.view.modules.paoku.view.Child_DieMenu;
   import com.yiTian.view.modules.paoku.view.Child_GameingMenu;
   import com.yiTian.view.modules.paoku.view.View_kuPaoPnl;
   import flash.utils.getTimer;
   
   public class KuPaoGameoverState implements IState
   {
      
      private var _view:Child_DieMenu;
      
      private var _enterTime:int;
      
      public var ratio:int = 4;
      
      public var powerr:Number = 0.8;
      
      public function KuPaoGameoverState()
      {
         super();
         this._view = Child_DieMenu.instance;
      }
      
      public function enter(param:*) : void
      {
         this._enterTime = getTimer();
         var meter:int = Model_KuPao.getMeter();
         var coin:int = Model_KuPao.gameingCoin;
         var isDouble:int = 0;
         var useItemInfo:String = "";
         if(Model_KuPao.numFloatUse > 0)
         {
            useItemInfo += "1";
            Model_KuPao.updatePerItem(0,0);
         }
         else
         {
            useItemInfo += "0";
         }
         if(Model_KuPao.numDoubleUse > 0)
         {
            useItemInfo += "1";
            Model_KuPao.updatePerItem(1,0);
            isDouble = 1;
         }
         else
         {
            useItemInfo += "0";
         }
         if(Model_KuPao.numDieFLoatUse > 0)
         {
            useItemInfo += "1";
            Model_KuPao.updatePerItem(2,0);
         }
         else
         {
            useItemInfo += "0";
         }
         if(Model_KuPao.numShieldUse > 0)
         {
            useItemInfo += "1";
            Model_KuPao.updatePerItem(3,0);
         }
         else
         {
            useItemInfo += "0";
         }
         var validateScore:int = KuPaoUtil.computeValidateScore(coin,meter);
         KuPaoCGMessage.CG_KP_SUBMITSCORE(meter,coin,isDouble,useItemInfo,validateScore);
      }
      
      public function exit(param:*) : void
      {
         KPMap.instance.clear();
         KPMap.instance.deleteScene();
         View_kuPaoPnl.instance.removeFromContainer(Child_GameingMenu.instance);
         Child_GameingMenu.instance.visible = false;
      }
      
      public function update(param:*) : void
      {
         if(getTimer() - this._enterTime > 1)
         {
            KuPaoMgr.instance.paokuGlobalSM.changeState(KuPaoMgr.GST_STARTMENU,null);
         }
      }
      
      public function askExit(nextState:int) : Boolean
      {
         return true;
      }
      
      private function tFun(p:Number) : Number
      {
         var rate:Number = p * 3.1416 * this.ratio;
         return Math.pow(1 - Math.sin(rate) / rate,this.powerr);
      }
   }
}

