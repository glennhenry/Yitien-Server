package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.ChunJieQianDao.View_ChunJieQianDao_menu;
   
   public class ChunJieQianDaoHandler
   {
      
      public function ChunJieQianDaoHandler()
      {
         super();
      }
      
      public static function GC_ChunJieQianDao_ICON(flag:int) : void
      {
         if(Boolean(flag))
         {
            Global.delegate.dosomething(View_ChunJieQianDao_menu.instance,function():void
            {
            });
         }
         else if(Boolean(Global.CJQDdm))
         {
            View_ChunJieQianDao_menu.instance.visible = false;
         }
      }
      
      public static function GC_ChunJieQianDao_Fresh(signArr:Array, today:int, count:int, btnStatus:int) : void
      {
         if(Boolean(Global.CJQDdm))
         {
            View_ChunJieQianDao_menu.instance.setDate(signArr,today,count,btnStatus);
         }
      }
      
      public static function GC_ChunJieQianDao_SIGN(flag:int) : void
      {
         UIManager.centerBroadcast.addMsg(flag == 1 ? "签到成功" : "签到失败");
      }
      
      public static function GC_ChunJieQianDao_GET_PRIZE(flag:int) : void
      {
         UIManager.centerBroadcast.addMsg(flag == 1 ? "领取成功" : "领取失败");
      }
   }
}

