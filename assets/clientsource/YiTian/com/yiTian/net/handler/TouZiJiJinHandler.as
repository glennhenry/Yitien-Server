package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.touzijijin.View_TZJJPanel;
   import com.yiTian.view.modules.touzijijin.View_TouZiJiJin_Icon;
   
   public class TouZiJiJinHandler
   {
      
      public function TouZiJiJinHandler()
      {
         super();
      }
      
      public static function GC_TouZiJiJin_SHOWICON(type:int) : void
      {
         if(type == 0)
         {
            UIManager.mainUiBtnContainer.removeBTN(View_TouZiJiJin_Icon.instance);
            View_TZJJPanel.instance.visible = false;
            if(Global.control.hasCallBack(Enum_MsgType.MSG_LV_UP_2,showBtn))
            {
               Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,showBtn);
            }
         }
         else if(type == 1)
         {
            if(GameUnitManager.hero.level >= 35)
            {
               UIManager.mainUiBtnContainer.addBTN(View_TouZiJiJin_Icon.instance);
               View_TouZiJiJin_Icon.instance.effectEnd();
            }
            else
            {
               Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,showBtn);
            }
         }
         else if(type == 2)
         {
            UIManager.mainUiBtnContainer.addBTN(View_TouZiJiJin_Icon.instance);
            View_TouZiJiJin_Icon.instance.effectBegin();
         }
      }
      
      private static function showBtn() : void
      {
         if(GameUnitManager.hero.level >= 35)
         {
            UIManager.mainUiBtnContainer.addBTN(View_TouZiJiJin_Icon.instance);
            View_TouZiJiJin_Icon.instance.effectEnd();
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,showBtn);
         }
      }
      
      public static function GC_TouZiJiJin_SHOWPANEL(arr:Array) : void
      {
         View_TZJJPanel.instance.update(arr);
      }
      
      public static function GC_TouZiJiJin_RENGOU(result:int) : void
      {
         if(result == 0)
         {
            UIManager.centerBroadcast.addMsg("无法认购基金",1);
         }
         else if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("购买成功",1);
            View_TZJJPanel.instance.updateHaveBuyNum();
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("元宝不足，请充值",1);
         }
      }
      
      public static function GC_TouZiJiJin_GETAWARD(result:int) : void
      {
         if(result == 0)
         {
            UIManager.centerBroadcast.addMsg("不在返利期无法领取",1);
         }
         else if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("领取成功",1);
            View_TZJJPanel.instance.getAward();
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("已领取奖励",1);
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg("背包格子不够,请清理",1);
         }
      }
   }
}

