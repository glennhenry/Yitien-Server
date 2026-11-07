package com.yiTian.view.modules.vipServer
{
   import com.yiTian.Global;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class VipServerIcon
   {
      
      private static var eff:Effect;
      
      private static var tipBtn:MainUIBtn;
      
      public function VipServerIcon()
      {
         super();
      }
      
      public static function realShowTip() : void
      {
         if(!tipBtn)
         {
            tipBtn = new MainUIBtn("resource/image/vip/vipServer.png");
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
         Global.delegate.dosomething(VipServerPanel.instance,VipServerPanel.instance.show);
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

