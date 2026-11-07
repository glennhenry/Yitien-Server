package com.yiTian.net.handler
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.DAU.Model_DAU;
   
   public class DAUHandle
   {
      
      public function DAUHandle()
      {
         super();
      }
      
      public static function GC_DAU_ACT_REWARD(info:Array) : void
      {
         Model_DAU.updateInfo(info);
      }
      
      public static function GC_DAU_GET_REWARD(result:int) : void
      {
         var msg:String = null;
         if(result == 1)
         {
            msg = "该奖励已领取";
         }
         else if(result == 2)
         {
            msg = "未达条件，无法领取";
         }
         else if(result == 3)
         {
            msg = "背包已满，请及时清理";
         }
         else if(result == 4)
         {
            msg = "领取成功";
         }
         if(Boolean(msg))
         {
            UIManager.centerBroadcast.addMsg(msg);
         }
      }
   }
}

