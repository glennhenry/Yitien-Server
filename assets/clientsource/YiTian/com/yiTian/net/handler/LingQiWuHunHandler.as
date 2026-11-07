package com.yiTian.net.handler
{
   import com.yiTian.manager.DailyRemainManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.lingqiwuhun.LingQiWuHunVO;
   
   public class LingQiWuHunHandler
   {
      
      public function LingQiWuHunHandler()
      {
         super();
      }
      
      public static function GC_LINGQIWUHUN(result:int, curIntegral:int, maxIntegral:int, juanXianTimes:int) : void
      {
         var value:LingQiWuHunVO = new LingQiWuHunVO();
         value.curIntegral = curIntegral;
         value.maxIntegral = maxIntegral;
         value.juanXianTimes = juanXianTimes;
         UIManager.lingQiWuHunPanel.lingQiWuHunVO = value;
         DailyRemainManager.setCount(DailyRemainManager.LIN_QI,3 - juanXianTimes);
      }
      
      public static function GC_JUANXIAN_LINGQI(result:int, curIntegral:int, maxIntegral:int, juanXianTimes:int, jingYan:int) : void
      {
         var value:LingQiWuHunVO = new LingQiWuHunVO();
         value.curIntegral = curIntegral;
         value.maxIntegral = maxIntegral;
         value.juanXianTimes = juanXianTimes;
         UIManager.lingQiWuHunPanel.lingQiWuHunVO = value;
         UIManager.lingQiWuHunPanel.playEffect();
         var str:String = "<font color=\'#ffff00\'>" + LangConfig.getWord("10335",1,jingYan) + "</font>";
         UIManager.selfBroadcast.addMsg(str);
         DailyRemainManager.setCount(DailyRemainManager.LIN_QI,3 - juanXianTimes);
      }
      
      public static function GC_LINGQIWUHUN_START_END(status:int) : void
      {
         if(Boolean(status))
         {
            UIManager.lingQiWuHunPanel.showLingBtn();
         }
         else
         {
            UIManager.lingQiWuHunPanel.hideLingBtn();
            UIManager.lingQiWuHunPanel.visible = false;
         }
      }
   }
}

