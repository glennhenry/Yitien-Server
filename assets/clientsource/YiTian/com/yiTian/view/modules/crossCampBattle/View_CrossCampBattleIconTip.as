package com.yiTian.view.modules.crossCampBattle
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CrossCampBattleCGMessage;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class View_CrossCampBattleIconTip
   {
      
      private static var eff:Effect;
      
      public static var tipBtn:MainUIBtn;
      
      public function View_CrossCampBattleIconTip()
      {
         super();
      }
      
      public static function showTip() : void
      {
         if(GameUnitManager.hero.level < Enum_CrossCampBattle.ICON_SHOW_LV)
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
         if(GameUnitManager.hero.level < Enum_CrossCampBattle.ICON_SHOW_LV)
         {
            return;
         }
         Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,realShowTip);
         if(!tipBtn)
         {
            tipBtn = new MainUIBtn("resource/image/crossCampBattle/crossCampBattle.png");
            eff = EffectManager.addEffect("35343",tipBtn,1000,32,29,true);
            UIManager.mainUiBtnContainer.addBTN(tipBtn);
            tipBtn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
            {
               if(SceneConfig.getSceneType() == SceneConfig.COMMON)
               {
                  showAlert();
               }
               else
               {
                  UIManager.centerBroadcast.addMsg("请在主城内进入皇城争霸！");
               }
            });
         }
      }
      
      public static function showAlert() : void
      {
         CrossCampBattleCGMessage.CG_CLICK_CAMP_ICON();
      }
      
      public static function hide() : void
      {
         if(Boolean(tipBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(tipBtn);
            tipBtn = null;
         }
         if(Boolean(eff))
         {
            EffectManager.removeEffect(eff);
            eff = null;
         }
      }
   }
}

