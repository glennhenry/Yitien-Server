package com.yiTian.view.modules.fund
{
   import com.yiTian.Global;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FundCGMessage;
   import com.yiTian.view.modules.actions.jiJin.FundMter;
   import com.yiTian.view.modules.guaji.BitmapBtn;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import flash.events.MouseEvent;
   
   public class FundConfig
   {
      
      private static var _mainBtn:BitmapBtn;
      
      private static var eff:Effect;
      
      private static var waiteEff:Boolean = false;
      
      public function FundConfig()
      {
         super();
      }
      
      public static function init() : void
      {
         if(!mainBtn)
         {
            _mainBtn = new BitmapBtn(true);
            mainBtn.init();
            mainBtn.mouseEnabled = true;
            mainBtn.buttonMode = true;
            mainBtn.setBgDir("resource/image/fund/funcIcon.png");
            mainBtn.clickCallBack = mainBtnClickHd;
         }
         UIManager.mainUiBtnContainer.addBTN(mainBtn);
         Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.JiJin,1]);
         if(waiteEff)
         {
            addEff();
         }
      }
      
      public static function addEff() : void
      {
         if(!mainBtn)
         {
            waiteEff = true;
         }
         else
         {
            if(!eff)
            {
               eff = EffectManager.addEffect("35343",mainBtn,1000,32,29,true);
               Global.control.sendNotification(Enum_mainUIBtn_hide.ICON_EFFECT,[Enum_mainUIBtn_hide.JiJin,1]);
               Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.JiJin,1,1]);
            }
            waiteEff = false;
         }
      }
      
      public static function removeEff() : void
      {
         if(Boolean(eff))
         {
            EffectManager.removeEffect(eff);
            eff = null;
            Global.control.sendNotification(Enum_mainUIBtn_hide.ICON_EFFECT,[Enum_mainUIBtn_hide.JiJin,0]);
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.JiJin,1,0]);
         }
      }
      
      private static function mainBtnClickHd(e:MouseEvent) : void
      {
         FundMter.isOpenPan = true;
         FundCGMessage.CG_FUND();
      }
      
      public static function get mainBtn() : BitmapBtn
      {
         return _mainBtn;
      }
   }
}

