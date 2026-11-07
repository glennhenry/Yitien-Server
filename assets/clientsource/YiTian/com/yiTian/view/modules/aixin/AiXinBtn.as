package com.yiTian.view.modules.aixin
{
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class AiXinBtn
   {
      
      private static var axBtn:MainUIBtn;
      
      public function AiXinBtn()
      {
         super();
      }
      
      public static function show() : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            return;
         }
         axBtn = new MainUIBtn("resource/image/aixin/aixinBtn.png",{
            "x":(65 - 92) / 2,
            "y":(70 - 92) / 2
         });
         UIManager.mainUiBtnContainer.addBTN(axBtn);
         axBtn.addEventListener(MouseEvent.CLICK,axBtnClick);
      }
      
      public static function remove() : void
      {
         if(!axBtn)
         {
            return;
         }
         if(UIManager.mainUiBtnContainer.hasBTN(axBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(axBtn);
            axBtn.removeEventListener(MouseEvent.CLICK,axBtnClick);
         }
      }
      
      private static function axBtnClick(e:MouseEvent) : void
      {
         UIManager.mainUiBtnContainer.removeBTN(axBtn);
         axBtn.removeEventListener(MouseEvent.CLICK,axBtnClick);
         navigateToURL(new URLRequest("http://yi.qq.com/cp/a20130418gongyi/"),"_blank");
      }
   }
}

