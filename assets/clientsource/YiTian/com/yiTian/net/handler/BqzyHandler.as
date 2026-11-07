package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_bqzy;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.view.modules.bianqiangzhiyin.View_bqzy;
   import com.yiTian.view.modules.bianqiangzhiyin.Vo_Bqzy;
   
   public class BqzyHandler
   {
      
      public function BqzyHandler()
      {
         super();
      }
      
      public static function GC_BQZY_GETDATE(arr:Vector.<Vo_Bqzy>) : void
      {
         Model_bqzy.data = arr;
         if(GameUnitManager.hero.level >= 33)
         {
            if(!Model_bqzy.Init)
            {
               View_bqzy.instance.init();
            }
            View_bqzy.instance.visible = true;
         }
         else
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,showBqView);
         }
      }
      
      private static function showBqView() : void
      {
         if(GameUnitManager.hero.level >= 33)
         {
            if(!Model_bqzy.Init)
            {
               View_bqzy.instance.init();
            }
            View_bqzy.instance.visible = true;
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,showBqView);
         }
      }
   }
}

