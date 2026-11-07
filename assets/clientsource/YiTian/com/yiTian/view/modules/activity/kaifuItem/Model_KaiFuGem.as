package com.yiTian.view.modules.activity.kaifuItem
{
   import com.yiTian.Global;
   import com.yiTian.net.message.cg.BagCGMessage;
   
   public class Model_KaiFuGem
   {
      
      public static var myGemCounts:Array;
      
      public static var myGemStates:Array;
      
      public static var purchasRemain:Array;
      
      public static var _id:int;
      
      public static var _gridIndex:int;
      
      public static const MY_STATE_CHANGE:String = "msg_g_a_s_change";
      
      public static const PURCHAS_CHANGE:String = "msg_g_a_p_change";
      
      public static const GET_KAI_FU_GEM_REWARD:String = "msg_get_kai_fu_gem_reward";
      
      public static var gemActState:int = 0;
      
      public function Model_KaiFuGem()
      {
         super();
      }
      
      public static function updateMyState(counts:Array, states:Array) : void
      {
         var state:int = 0;
         myGemCounts = counts;
         myGemStates = states;
         Global.control.sendNotification(Model_KaiFuGem.MY_STATE_CHANGE,null);
         var bGemLight:Boolean = false;
         for each(state in states)
         {
            if(state == 1)
            {
               bGemLight = true;
            }
         }
         KaiFuModuleMgr.instance.setBtnEffect(KaiFuModuleMgr.GEM_REWARD,bGemLight ? 1 : 0);
      }
      
      public static function updatePurchasRemain(info:Array) : void
      {
         purchasRemain = info;
         Global.control.sendNotification(Model_KaiFuGem.PURCHAS_CHANGE,null);
      }
      
      public static function askOpenDiscountView(id:int, gridIndex:int) : void
      {
         _id = id;
         _gridIndex = gridIndex;
         BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,_gridIndex,1);
      }
   }
}

