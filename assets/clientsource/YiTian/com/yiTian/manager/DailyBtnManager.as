package com.yiTian.manager
{
   import com.yiTian.view.modules.FeiXingQi.Model_FeiXingQi;
   import com.yiTian.view.modules.qiJu.QiJu_Btn;
   
   public class DailyBtnManager
   {
      
      public static const JJC:int = 1;
      
      public static const ZHANG_MEN_REN:int = 2;
      
      public static const TTF:int = 3;
      
      public static const LIN_QI:int = 4;
      
      public static const WAN_AN:int = 5;
      
      public static const CG:int = 6;
      
      public static const QI_JU:int = 7;
      
      public static const MUTI_JJC:int = 8;
      
      public static const PAO_BIAO:int = 9;
      
      private static var data:Array = [];
      
      public function DailyBtnManager()
      {
         super();
      }
      
      public static function setCount(sysId:int, count:int) : void
      {
         data[sysId] = count;
         if(sysId == JJC)
         {
            UIManager.jjc_panel.set_jjc_count(count);
            return;
         }
         if(sysId == ZHANG_MEN_REN)
         {
            UIManager.tianTiPanel.updateBtnCount(count);
            return;
         }
         if(sysId == TTF)
         {
            UIManager.mainUiBtnContainer.updateTTFCount(count);
            return;
         }
         if(sysId == LIN_QI)
         {
            UIManager.lingQiWuHunPanel.updateBtnCount(count);
            return;
         }
         if(sysId == WAN_AN)
         {
            UIManager.wanAnSiPanel.updateIconCount(count);
            return;
         }
         if(sysId == CG)
         {
            Model_FeiXingQi.updateBtnCount(count);
            return;
         }
         if(sysId == QI_JU)
         {
            if(QiJu_Btn.isInit)
            {
               QiJu_Btn.instance.updateCount(count);
            }
            return;
         }
         if(sysId == MUTI_JJC)
         {
            UIManager.kuafuBtn.updateBtnCount(count);
            return;
         }
         if(sysId == PAO_BIAO)
         {
            UIManager.paoBiaoPanel.updateIconCount(count);
            return;
         }
      }
      
      public static function getCount(sysId:int) : int
      {
         return data[sysId];
      }
   }
}

