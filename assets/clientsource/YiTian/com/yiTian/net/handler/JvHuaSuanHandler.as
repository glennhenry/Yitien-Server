package com.yiTian.net.handler
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.activityGuide.Enum_ActivityGuide;
   import com.yiTian.view.modules.activityGuide.View_ActivityGuidePanel;
   import com.yiTian.view.modules.juhuasuan.View_JvHuaSuanPanel;
   import com.yiTian.view.modules.juhuasuan.Vo_JuHuaSuan;
   
   public class JvHuaSuanHandler
   {
      
      public function JvHuaSuanHandler()
      {
         super();
      }
      
      public static function GC_JHS_OPEN(vo:Vo_JuHuaSuan) : void
      {
         View_JvHuaSuanPanel.instance.updateData(vo);
      }
      
      public static function GC_JHS_BUY(result:int, id:int = -1) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("购买成功，请领取奖励",1);
            View_JvHuaSuanPanel.ID_INDEX = id;
            View_JvHuaSuanPanel.instance.getBuyResult();
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("购买失败",1);
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg("元宝不足，无法购买礼包",1);
         }
      }
      
      public static function GC_JHS_GETAWARD(result:int, id:int = -1) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("领取成功",1);
            View_JvHuaSuanPanel.ID_INDEX = id;
            View_JvHuaSuanPanel.instance.getAward();
         }
         else if(result == 0)
         {
            UIManager.centerBroadcast.addMsg("领取失败",1);
         }
      }
      
      public static function GC_JHS_HIGHLIGHT(type:int) : void
      {
         View_ActivityGuidePanel.instance.setBtnEff(Enum_ActivityGuide.JVHUASUAN,type);
      }
   }
}

