package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.duanwujie.View_babyGift;
   
   public class BabyGiftHandler
   {
      
      public function BabyGiftHandler()
      {
         super();
      }
      
      public static function GC_ETLB_OPEN(state:int) : void
      {
         if(state == 3)
         {
            UIManager.centerBroadcast.addMsg("不在活动时间内",1);
            return;
         }
         Global.delegate.dosomething(View_babyGift.instance,function():void
         {
            View_babyGift.instance.visible = true;
            View_babyGift.instance.status = state;
         });
      }
      
      public static function GC_ETLB_GETAWARD(result:int) : void
      {
         if(result == 0)
         {
            UIManager.centerBroadcast.addMsg("领取成功",1);
            View_babyGift.instance.visible = false;
         }
         else if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("已领取",1);
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("您还没有子女,不能领取礼包",1);
         }
      }
   }
}

