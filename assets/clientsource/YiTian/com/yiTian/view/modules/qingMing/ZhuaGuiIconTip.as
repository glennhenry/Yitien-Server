package com.yiTian.view.modules.qingMing
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class ZhuaGuiIconTip
   {
      
      private static var eff:Effect;
      
      private static var tipBtn:MainUIBtn;
      
      public function ZhuaGuiIconTip()
      {
         super();
      }
      
      public static function showTip() : void
      {
         if(GameUnitManager.hero.level < Msg_QingMing.ICON_SHOW_LV)
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
         if(GameUnitManager.hero.level < Msg_QingMing.ICON_SHOW_LV)
         {
            return;
         }
         Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,realShowTip);
         if(!tipBtn)
         {
            tipBtn = new MainUIBtn("resource/image/qingMing/zhuaGuiIcon.png");
            eff = EffectManager.addEffect("35343",tipBtn,1000,32,29,true);
            UIManager.mainUiBtnContainer.addBTN(tipBtn);
            tipBtn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
            {
               if(Boolean(eff))
               {
                  EffectManager.removeEffect(eff);
                  eff = null;
               }
               UIManager.mainUiBtnContainer.removeBTN(tipBtn);
               showAlert();
            });
         }
      }
      
      public static function showAlert() : void
      {
         Global.delegate.dosomething(ZhuaGuiTip.instance,ZhuaGuiTip.instance.show);
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

