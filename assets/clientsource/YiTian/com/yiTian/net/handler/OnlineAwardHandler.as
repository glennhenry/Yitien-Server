package com.yiTian.net.handler
{
   import com.yiTian.data.model.Model_PCU;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.PCU.View_online_award;
   import com.yiTian.view.modules.PCU.View_online_award_btn;
   
   public class OnlineAwardHandler
   {
      
      public function OnlineAwardHandler()
      {
         super();
      }
      
      public static function GC_PCU_START(status0:int, status1:int, status2:int, status3:int, status4:int, status5:int, status6:int, status7:int, status8:int, status9:int) : void
      {
         trace("GC_PCU_START");
         Model_PCU.onlineData = [status0,status1,status2,status3,status4];
         Model_PCU.banghuiData = [status5,status6,status7,status8,status9];
         View_online_award.updateAllStatus("end");
         if(!UIManager.mainUiBtnContainer.hasBTN(View_online_award_btn.instance))
         {
            UIManager.mainUiBtnContainer.addBTN(View_online_award_btn.instance);
         }
      }
      
      public static function GC_PCU_UPDATE_STATUS(id:int, status:int) : void
      {
         trace("GC_PCU_UPDATE_STATUS",id,status);
         if(id < 5)
         {
            Model_PCU.onlineData[id] = status;
         }
         else
         {
            Model_PCU.banghuiData[id - 5] = status;
         }
         View_online_award.updateStatus(id,status);
      }
      
      public static function GC_PCU_SHOW_ICON(status:int) : void
      {
         var i:int = 0;
         trace("GC_PCU_SHOW_ICON",status);
         if(status == 1)
         {
            if(!UIManager.mainUiBtnContainer.hasBTN(View_online_award_btn.instance))
            {
               UIManager.mainUiBtnContainer.addBTN(View_online_award_btn.instance);
            }
            View_online_award_btn.instance.effectBegin();
            i = 0;
            while(i < 5)
            {
               if(View_online_award.instance.receive_btns[i].status == 0)
               {
                  View_online_award.instance.receive_btns[i].startCount();
                  break;
               }
               i++;
            }
         }
         else if(status != 2)
         {
            if(status == 3)
            {
               if(!UIManager.mainUiBtnContainer.hasBTN(View_online_award_btn.instance))
               {
                  UIManager.mainUiBtnContainer.addBTN(View_online_award_btn.instance);
               }
               View_online_award_btn.instance.effectBegin();
               View_online_award.updateAllStatus("end");
            }
            else if(status == 4)
            {
               if(!UIManager.mainUiBtnContainer.hasBTN(View_online_award_btn.instance))
               {
                  UIManager.mainUiBtnContainer.addBTN(View_online_award_btn.instance);
               }
               Model_PCU.onlineData = [0,0,0,0,0];
               Model_PCU.banghuiData = [0,0,0,0,0];
               View_online_award.updateAllStatus("end");
               View_online_award_btn.instance.effectEnd();
            }
         }
      }
   }
}

