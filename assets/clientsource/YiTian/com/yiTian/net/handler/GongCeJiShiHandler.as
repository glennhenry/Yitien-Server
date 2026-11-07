package com.yiTian.net.handler
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.gongcehuodong.View_GongCejishi;
   
   public class GongCeJiShiHandler
   {
      
      public function GongCeJiShiHandler()
      {
         super();
      }
      
      public static function GC_GCJS_SHOWPANEL(arr:Array) : void
      {
         if(Boolean(arr.length))
         {
            View_GongCejishi.instance.updateData(arr);
         }
      }
      
      public static function GC_GCJS_AWARD(flag:int, time:int) : void
      {
         if(flag == 1)
         {
            UIManager.centerBroadcast.addMsg("兑换成功",1);
            View_GongCejishi.instance.getAward(View_GongCejishi.CURINDEX,time);
         }
         else if(flag == 0)
         {
            UIManager.centerBroadcast.addMsg("兑换失败",1);
         }
         else if(flag == 2)
         {
            UIManager.centerBroadcast.addMsg("兑换次数达到上限 ",1);
         }
         else if(flag == 3)
         {
            UIManager.centerBroadcast.addMsg("兑换材料不足",1);
         }
      }
   }
}

