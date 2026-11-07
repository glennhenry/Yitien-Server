package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.activity.kaifuItem.KaiFuModuleMgr;
   import com.yiTian.view.modules.activity.kaifuItem.Model_KaiFuGem;
   import com.yiTian.view.modules.activity.kaifuItem.View_kaiFuDiscountPnl;
   
   public class KaiFuDiscountHandler
   {
      
      public function KaiFuDiscountHandler()
      {
         super();
      }
      
      public static function GC_KAIFU_DISCOUNT(openFlag:int) : void
      {
         Model_KaiFuGem.gemActState = openFlag;
         if(openFlag == 1)
         {
            KaiFuModuleMgr.instance.setState(17,101);
            KaiFuModuleMgr.instance.setState(18,102);
            KaiFuModuleMgr.instance.setState(19,103);
         }
         else
         {
            KaiFuModuleMgr.instance.setState(17,0);
            KaiFuModuleMgr.instance.setState(18,0);
            KaiFuModuleMgr.instance.setState(19,0);
         }
      }
      
      public static function GC_KAIFU_GEM(counts:Array, states:Array) : void
      {
         Model_KaiFuGem.updateMyState(counts,states);
      }
      
      public static function GC_KAIFU_GIFT(counts:Array) : void
      {
         Model_KaiFuGem.updatePurchasRemain(counts);
      }
      
      public static function GC_KAIFU_GEM_REST(moduleType:int, rest:int, index:int) : void
      {
         var tip:String = null;
         if(moduleType == 2)
         {
            if(rest == 1)
            {
               tip = "领取成功";
            }
         }
         else if(rest == 1)
         {
            tip = "购买成功";
         }
         else if(rest == 2)
         {
            tip = "元宝不足，请及时充值";
         }
         else if(rest == 3)
         {
            tip = "背包容量不足";
         }
         else if(rest == 4)
         {
            tip = "该道具已经过期";
         }
         Global.control.sendNotification(Model_KaiFuGem.GET_KAI_FU_GEM_REWARD,{
            "moduleType":moduleType,
            "rest":rest,
            "index":index
         });
         if(tip != null)
         {
            UIManager.centerBroadcast.addMsg(tip);
         }
      }
      
      public static function GC_OPEN_DISCOUNT_VIEW(rest:int) : void
      {
         if(rest == 1)
         {
            View_kaiFuDiscountPnl.instance.show(Model_KaiFuGem._id,Model_KaiFuGem._gridIndex);
         }
         else
         {
            UIManager.centerBroadcast.addMsg("此活动已过期");
         }
      }
   }
}

