package com.yiTian.net.handler
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.blueDiamondFuLi.BlueDiamondFuLi_Panel;
   
   public class BlueDiamondFuliHandle
   {
      
      public function BlueDiamondFuliHandle()
      {
         super();
      }
      
      public static function GC_BLUEDIAMOND_OPEN(time:int, arr:Array) : void
      {
         BlueDiamondFuLi_Panel.instance.update(time,arr);
      }
      
      public static function GC_BLUEDIAMOND_GETAWARD(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("领取成功");
            BlueDiamondFuLi_Panel.instance.getPanelItem();
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("领取失败");
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg("非活动时间");
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg("不存在这个奖励");
         }
         else if(result == 5)
         {
            UIManager.centerBroadcast.addMsg("已领取");
         }
         else if(result == 6)
         {
            UIManager.centerBroadcast.addMsg("续费次数不足");
         }
         else if(result == 7)
         {
            UIManager.centerBroadcast.addMsg("该平台不能领取奖励");
         }
      }
   }
}

