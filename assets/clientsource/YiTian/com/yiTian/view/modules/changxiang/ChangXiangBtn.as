package com.yiTian.view.modules.changxiang
{
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class ChangXiangBtn
   {
      
      private static var cxBtn:MainUIBtn;
      
      public function ChangXiangBtn()
      {
         super();
      }
      
      public static function show() : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            return;
         }
         cxBtn = new MainUIBtn("resource/image/changXiang/cxBtn.png",{
            "x":(65 - 92) / 2,
            "y":(70 - 92) / 2
         });
         UIManager.mainUiBtnContainer.addBTN(cxBtn);
         cxBtn.addEventListener(MouseEvent.CLICK,cxBtnClick);
      }
      
      public static function remove() : void
      {
         if(!cxBtn)
         {
            return;
         }
         if(UIManager.mainUiBtnContainer.hasBTN(cxBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(cxBtn);
            cxBtn.removeEventListener(MouseEvent.CLICK,cxBtnClick);
         }
      }
      
      private static function cxBtnClick(e:MouseEvent) : void
      {
         UIManager.mainUiBtnContainer.removeBTN(cxBtn);
         cxBtn.removeEventListener(MouseEvent.CLICK,cxBtnClick);
         navigateToURL(new URLRequest("http://yi.qq.com/cp/a20130424voice/index.htm"),"_blank");
      }
   }
}

