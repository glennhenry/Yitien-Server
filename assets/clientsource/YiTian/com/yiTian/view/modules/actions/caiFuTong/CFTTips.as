package com.yiTian.view.modules.actions.caiFuTong
{
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ActionsCGMessage;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class CFTTips
   {
      
      private static var tipBtn:MainUIBtn;
      
      public function CFTTips()
      {
         super();
      }
      
      public static function showTip(value:Boolean) : void
      {
         if(!value)
         {
            return;
         }
         if(GameUnitManager.hero.level >= 30)
         {
            if(Global.isShowCaiFuTong)
            {
               if(!tipBtn)
               {
                  tipBtn = new MainUIBtn("resource/image/caiFuTong/caiFT.png");
                  UIManager.mainUiBtnContainer.addBTN(tipBtn);
                  tipBtn.addEventListener(MouseEvent.CLICK,function():void
                  {
                     ActionsCGMessage.CG_CLICK_CAIFUTONG();
                     UIManager.mainUiBtnContainer.removeBTN(tipBtn);
                     tipBtn = null;
                     navigateToURL(new URLRequest("http://yi.qq.com/cp/a20130318yi/"),"_blank");
                  });
               }
            }
         }
      }
   }
}

