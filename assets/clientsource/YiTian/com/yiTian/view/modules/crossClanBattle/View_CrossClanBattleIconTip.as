package com.yiTian.view.modules.crossClanBattle
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class View_CrossClanBattleIconTip
   {
      
      private static var eff:Effect;
      
      public static var tipBtn:MainUIBtn;
      
      public function View_CrossClanBattleIconTip()
      {
         super();
      }
      
      public static function showTip() : void
      {
         if(GameUnitManager.hero.level < Enum_CrossClanBattle.ICON_SHOW_LV)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,realShowTip);
         }
         else
         {
            realShowTip();
         }
      }
      
      public static function realShowTip() : void
      {
         if(GameUnitManager.hero.level < Enum_CrossClanBattle.ICON_SHOW_LV)
         {
            return;
         }
         Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,realShowTip);
         if(!tipBtn)
         {
            tipBtn = new MainUIBtn("resource/image/kuafubangzhan/xiongbatianxia.png");
            UIManager.mainUiBtnContainer.addBTN(tipBtn);
            tipBtn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
            {
               showAlert();
            });
         }
      }
      
      public static function showAlert() : void
      {
         Global.delegate.dosomething(View_AllCityPanel.instance,View_AllCityPanel.instance.show);
      }
      
      public static function hide() : void
      {
         if(Boolean(tipBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(tipBtn);
            tipBtn = null;
         }
      }
   }
}

