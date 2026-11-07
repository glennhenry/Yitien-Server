package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.FangXinHuiJia.View_FangXinHuiJia_menu;
   
   public class FangXinHuiJiaHandler
   {
      
      public function FangXinHuiJiaHandler()
      {
         super();
      }
      
      public static function GC_FangXinHuiJia_ICON(result:int) : void
      {
         if(Boolean(result))
         {
         }
      }
      
      public static function GC_FangXinHuiJia_Fresh(show1:int, show2:int, day:int, btnStatus:int) : void
      {
         Global.delegate.dosomething(View_FangXinHuiJia_menu.instance,function():void
         {
            View_FangXinHuiJia_menu.instance.setData(show1,show2,day,btnStatus);
         });
      }
      
      public static function GC_FangXinHuiJia_GET_PRIZE(flag:int) : void
      {
         UIManager.centerBroadcast.addMsg(flag == 1 ? "领取成功" : "领取失败");
      }
   }
}

