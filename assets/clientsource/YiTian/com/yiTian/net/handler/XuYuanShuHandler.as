package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.xuyuanshu.View_XuYuanShuPanel;
   import com.yiTian.view.modules.xuyuanshu.View_XuYuanShu_Icon;
   
   public class XuYuanShuHandler
   {
      
      public function XuYuanShuHandler()
      {
         super();
      }
      
      public static function GC_XuYuanShu_SHOWICON(type:int) : void
      {
      }
      
      private static function showBtn() : void
      {
         if(GameUnitManager.hero.level >= 35)
         {
            UIManager.mainUiBtnContainer.addBTN(View_XuYuanShu_Icon.instance);
            View_XuYuanShu_Icon.instance.effectEnd();
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,showBtn);
         }
      }
      
      public static function GC_XuYuanShu_SHOWPANEL(arr:Array) : void
      {
         View_XuYuanShuPanel.instance.update(arr);
      }
      
      public static function GC_XuYuanShu_RENGOU(result:int) : void
      {
         if(result == 0)
         {
            UIManager.centerBroadcast.addMsg("无法许愿",1);
         }
         else if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("许愿成功",1);
            View_XuYuanShuPanel.instance.updateHaveBuyNum();
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("元宝不足，请充值",1);
         }
      }
      
      public static function GC_XuYuanShu_GETAWARD(result:int) : void
      {
         if(result == 0)
         {
            UIManager.centerBroadcast.addMsg("不在返利期无法领取",1);
         }
         else if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("领取成功",1);
            View_XuYuanShuPanel.instance.getAward();
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

