package com.yiTian.view.modules.actions.sheNianLibao
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class SheNianGiftTip
   {
      
      private static var _instance:SheNianGiftTip;
      
      private var btnTip:MainUIBtn;
      
      public function SheNianGiftTip()
      {
         super();
      }
      
      public static function get instance() : SheNianGiftTip
      {
         if(!_instance)
         {
            _instance = new SheNianGiftTip();
         }
         return _instance;
      }
      
      public function show() : void
      {
         if(!this.btnTip)
         {
            this.btnTip = new MainUIBtn("resource/image/sheNianTip/sheNianGift.png");
            UIManager.mainUiBtnContainer.addBTN(this.btnTip);
            this.btnTip.addEventListener(MouseEvent.CLICK,this.cliHd);
         }
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("http://yi.qq.com/webplat/info/news_version3/4814/4815/4818/m3317/201303/193680.shtml"),"_blank");
      }
      
      public function remove() : void
      {
         if(UIManager.mainUiBtnContainer.hasBTN(this.btnTip))
         {
            UIManager.mainUiBtnContainer.removeBTN(this.btnTip);
         }
      }
   }
}

