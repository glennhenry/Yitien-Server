package com.yiTian.net.handler
{
   import com.yiTian.data.model.Model_Olympic;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.olympic.View_OlympicPanel;
   
   public class OlympicHandler
   {
      
      public function OlympicHandler()
      {
         super();
      }
      
      public static function GC_OLYMPIC_TIME(result:int) : void
      {
         Model_Olympic.setTime(result);
         View_OlympicPanel.instance.resultHd(result);
      }
      
      public static function GC_OLYMPIC_REWARD(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("领取成功");
            View_OlympicPanel.instance.visible = false;
            View_OlympicPanel.instance.remove_olym_btn();
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("此激活码已被领取过");
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg("激活码不存在");
         }
         else
         {
            Utils.print("领取异常");
         }
      }
      
      public static function GC_DAYS_OLM_REWARD(res:int) : void
      {
         if(res == 1)
         {
            UIManager.centerBroadcast.addMsg("恭喜您成功获取了兑换礼包");
         }
         else if(res == 2)
         {
            UIManager.centerBroadcast.addMsg("激活码不存在");
         }
         else if(res == 3)
         {
            UIManager.centerBroadcast.addMsg("此激活码已被领取过");
         }
         else if(res == 4)
         {
            UIManager.centerBroadcast.addMsg("今日已领取过，请明日再来");
         }
         else
         {
            Utils.print("领取异常");
         }
      }
   }
}

