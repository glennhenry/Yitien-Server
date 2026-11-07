package com.yiTian.view.modules.activityGuide
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class WuYueTip
   {
      
      private static var eff:Effect;
      
      private static var tipBtn:MainUIBtn;
      
      public function WuYueTip()
      {
         super();
      }
      
      public static function showTip() : void
      {
         if(GameUnitManager.hero.level < 30)
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
         if(GameUnitManager.hero.level < 30 || !Model_ActivityGuide.isShowIcon || !Global.activityGuide)
         {
            return;
         }
         Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,realShowTip);
         if(!tipBtn)
         {
            tipBtn = new MainUIBtn("resource/image/activityGuide/wuYue.png");
            eff = EffectManager.addEffect("35343",tipBtn,1000,32,29,true);
            UIManager.mainUiBtnContainer.addBTN(tipBtn);
            tipBtn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
            {
               if(Boolean(eff))
               {
                  EffectManager.removeEffect(eff);
                  eff = null;
               }
               showAlert();
            });
         }
      }
      
      public static function showAlert() : void
      {
         View_ActivityGuidePanel.instance.visible = true;
      }
      
      public static function hide() : void
      {
         if(Boolean(tipBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(tipBtn);
         }
         if(Boolean(eff))
         {
            EffectManager.removeEffect(eff);
            eff = null;
         }
      }
   }
}

