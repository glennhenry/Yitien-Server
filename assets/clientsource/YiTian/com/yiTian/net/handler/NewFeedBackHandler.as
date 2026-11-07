package com.yiTian.net.handler
{
   import com.yiTian.data.model.Model_NewRechargeFeedback;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.newRechargeFeedback.View_NewRechargeFeedback;
   
   public class NewFeedBackHandler
   {
      
      public function NewFeedBackHandler()
      {
         super();
      }
      
      public static function openNewFeedBack() : void
      {
         if(Model_NewRechargeFeedback.inTime)
         {
            View_NewRechargeFeedback.instance.visible = !View_NewRechargeFeedback.instance.visible;
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80194",8));
         }
      }
   }
}

