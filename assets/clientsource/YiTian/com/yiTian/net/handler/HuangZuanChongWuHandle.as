package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.huangzuanchongwu.View_HuangZuanChongWu_icon;
   import com.yiTian.view.modules.huangzuanchongwu.View_hzcwPanel;
   
   public class HuangZuanChongWuHandle
   {
      
      public function HuangZuanChongWuHandle()
      {
         super();
      }
      
      public static function GC_HZCW_SHOWICON(flag:int) : void
      {
         var on_HZCW_LevelUp:Function = null;
         if(flag == 1)
         {
            if(Global.pf == Enum_SPStr.QZONE || Global.pf == Enum_SPStr.PENGYOU || Enum_SPStr.isIwan(Global.pf))
            {
               if(GameUnitManager.hero.level >= 30)
               {
                  UIManager.mainUiBtnContainer.addBTN(View_HuangZuanChongWu_icon.instance);
               }
               else
               {
                  on_HZCW_LevelUp = function():void
                  {
                     if(GameUnitManager.hero.level >= 30)
                     {
                        Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,on_HZCW_LevelUp);
                        UIManager.mainUiBtnContainer.addBTN(View_HuangZuanChongWu_icon.instance);
                     }
                  };
                  Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,on_HZCW_LevelUp);
               }
            }
         }
         else if(flag == 0)
         {
            UIManager.mainUiBtnContainer.removeBTN(View_HuangZuanChongWu_icon.instance);
            if(Global.control.hasCallBack(Enum_MsgType.MSG_LV_UP_2,on_HZCW_LevelUp))
            {
               Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,on_HZCW_LevelUp);
            }
         }
      }
      
      public static function GC_HZCW_SHOWPANEL(availibleTimes:int, getedTimes:int, status:int, hasAwardStr:String) : void
      {
         View_hzcwPanel.instance.update(availibleTimes,getedTimes,status,hasAwardStr);
      }
      
      public static function GC_HZCW_CHOUJIANG(result:int, index:int) : void
      {
         var animateComplete:Function;
         if(result == 1)
         {
            animateComplete = function():void
            {
               View_hzcwPanel.instance.getAward();
            };
            UIManager.centerBroadcast.addMsg("抽取成功");
            View_hzcwPanel.instance.run(index,animateComplete);
         }
         else if(result == 0)
         {
            UIManager.centerBroadcast.addMsg("抽取失败");
         }
      }
      
      public static function GC_HZCW_DUIHUAN(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("兑换成功");
            View_hzcwPanel.instance.exchangeSucuess(2);
         }
         else
         {
            UIManager.centerBroadcast.addMsg("兑换失败");
         }
      }
   }
}

