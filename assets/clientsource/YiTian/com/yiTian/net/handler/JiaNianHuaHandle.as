package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.JiaNianHua.View_JiaNianHua_panel;
   import com.yiTian.view.modules.JiaNianHua.View_JiaNianHua_panel_2;
   
   public class JiaNianHuaHandle
   {
      
      private static var result:int;
      
      private static var time:int;
      
      private static var result_2:int;
      
      private static var time_2:int;
      
      public function JiaNianHuaHandle()
      {
         super();
      }
      
      public static function GC_JiaNianHua_ICON(result:int, time:int) : void
      {
         if(GameUnitManager.hero.level < 28)
         {
            JiaNianHuaHandle.result = result;
            JiaNianHuaHandle.time = time;
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,onLevelUpShow);
         }
         else
         {
            View_JiaNianHua_panel.instance.showIcon(result,time);
         }
      }
      
      private static function onLevelUpShow() : void
      {
         Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,onLevelUpShow);
         View_JiaNianHua_panel.instance.showIcon(result,time);
      }
      
      public static function GC_JiaNianHua_OPEN(money:int, btnStatus:int) : void
      {
         Global.delegate.dosomething(View_JiaNianHua_panel.instance,function():void
         {
            View_JiaNianHua_panel.instance.setData(money,btnStatus);
            View_JiaNianHua_panel.instance.visible = !View_JiaNianHua_panel.instance.visible;
         });
      }
      
      public static function GC_JiaNianHua_GET(flag:int) : void
      {
         if(flag == 1)
         {
            UIManager.centerBroadcast.addMsg("领取成功");
            View_JiaNianHua_panel.instance.getBtn.enabled = false;
            View_JiaNianHua_panel.instance.icon.effectEnd();
            View_JiaNianHua_panel.instance.flyToBag();
         }
         else
         {
            UIManager.centerBroadcast.addMsg("背包已满");
         }
      }
      
      public static function GC_JiaNianHua_ICON_2(result:int, time:int) : void
      {
         if(GameUnitManager.hero.level < 28)
         {
            JiaNianHuaHandle.result_2 = result;
            JiaNianHuaHandle.time_2 = time;
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,onLevelUpShow_2);
         }
         else
         {
            View_JiaNianHua_panel_2.instance.showIcon(result,time);
         }
      }
      
      private static function onLevelUpShow_2() : void
      {
         Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,onLevelUpShow_2);
         View_JiaNianHua_panel_2.instance.showIcon(result,time);
      }
      
      public static function GC_JiaNianHua_OPEN_2(money:int, btnStatus:int) : void
      {
         Global.delegate.dosomething(View_JiaNianHua_panel_2.instance,function():void
         {
            View_JiaNianHua_panel_2.instance.setData(money,btnStatus);
            View_JiaNianHua_panel_2.instance.visible = !View_JiaNianHua_panel_2.instance.visible;
         });
      }
      
      public static function GC_JiaNianHua_GET_2(flag:int) : void
      {
         if(flag == 1)
         {
            UIManager.centerBroadcast.addMsg("领取成功");
            View_JiaNianHua_panel_2.instance.getBtn.enabled = false;
            View_JiaNianHua_panel_2.instance.icon.effectEnd();
            View_JiaNianHua_panel_2.instance.flyToBag();
         }
         else
         {
            UIManager.centerBroadcast.addMsg("背包已满");
         }
      }
   }
}

