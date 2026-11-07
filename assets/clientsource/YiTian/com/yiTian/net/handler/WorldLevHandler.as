package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_worldLevel;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import com.yiTian.view.modules.worldLevel.View_wlRewardBtn;
   
   public class WorldLevHandler
   {
      
      public function WorldLevHandler()
      {
         super();
      }
      
      public static function GC_WORLD_LEVEL(level:int) : void
      {
         Model_worldLevel.worldLev = level;
      }
      
      public static function GC_WL_REWARD(rewards:Array) : void
      {
         var isShowBtn:Boolean = handle(rewards);
         if(isShowBtn)
         {
            if(!UIManager.mainUiBtnContainer.hasBTN(View_wlRewardBtn.instance))
            {
               UIManager.mainUiBtnContainer.addBTN(View_wlRewardBtn.instance);
            }
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.ShiJieFuLi,1]);
         }
         else
         {
            if(UIManager.mainUiBtnContainer.hasBTN(View_wlRewardBtn.instance))
            {
               UIManager.mainUiBtnContainer.removeBTN(View_wlRewardBtn.instance);
            }
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.ShiJieFuLi,2]);
            if(UIManager.worldLevReward.visible)
            {
               UIManager.worldLevReward.visible = false;
            }
         }
         Model_worldLevel.rewardData = rewards;
      }
      
      private static function handle(_arr:Array) : Boolean
      {
         var status:int = 0;
         if(!_arr.length)
         {
            return false;
         }
         var data:Array = [];
         var i:int = 0;
         while(i < _arr.length)
         {
            data = _arr[i];
            status = int(data[2]);
            if(status == 1)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public static function GC_WL_REWARD_FAILURE(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("元宝不够");
         }
      }
   }
}

