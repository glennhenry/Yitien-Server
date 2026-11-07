package com.yiTian.net.handler
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.gongcehuodong.View_WanJiaZhaoHui;
   
   public class WanJiaZhaoHuiHandle
   {
      
      public function WanJiaZhaoHuiHandle()
      {
         super();
      }
      
      public static function GC_WJZH_SHOWPANEL(statusArr:Array, num:int) : void
      {
         View_WanJiaZhaoHui.instance.update(statusArr,num);
      }
      
      public static function GC_WJZH_AWARD(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("领取成功",1);
            View_WanJiaZhaoHui.instance.getAward(View_WanJiaZhaoHui.BTN_INDEX);
         }
         else if(result == 0)
         {
            UIManager.centerBroadcast.addMsg("领取失败",1);
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("已领取",1);
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg("背包格子不够",1);
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg("邀请人数不够3人",1);
         }
         else if(result == 5)
         {
            UIManager.centerBroadcast.addMsg("全服回归人数未达标或已领取",1);
         }
      }
   }
}

