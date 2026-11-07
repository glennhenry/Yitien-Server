package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.ShouChongTiaoZheng.View_ShouChongTiaoZheng_menu;
   
   public class ShouChongTiaoZhengHandler
   {
      
      public function ShouChongTiaoZhengHandler()
      {
         super();
      }
      
      public static function GC_ShouChongTiaoZheng_ICON(result:int, tableId:int, time:int, day:int) : void
      {
         Global.delegate.dosomething(View_ShouChongTiaoZheng_menu.instance,function():void
         {
            View_ShouChongTiaoZheng_menu.instance.iconType = result;
            View_ShouChongTiaoZheng_menu.instance.tableId = tableId;
            View_ShouChongTiaoZheng_menu.instance.day = day;
            UIManager.mainUiBtnContainer.addBTN(View_ShouChongTiaoZheng_menu.instance.btn);
            View_ShouChongTiaoZheng_menu.instance.setTime(time);
         });
      }
      
      public static function GC_ShouChongTiaoZheng_GET_PRIZE(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("领取成功");
            View_ShouChongTiaoZheng_menu.instance.getPrize();
         }
         else if(result == 0)
         {
            UIManager.centerBroadcast.addMsg("领取失败");
         }
      }
      
      public static function GC_ShouChongTiaoZheng_LINK(tableId:int, time:int) : void
      {
         Global.delegate.dosomething(View_ShouChongTiaoZheng_menu.instance,function():void
         {
            View_ShouChongTiaoZheng_menu.instance.tableId = tableId;
            View_ShouChongTiaoZheng_menu.instance.setTime(time);
            View_ShouChongTiaoZheng_menu.instance.visible = true;
         });
      }
   }
}

