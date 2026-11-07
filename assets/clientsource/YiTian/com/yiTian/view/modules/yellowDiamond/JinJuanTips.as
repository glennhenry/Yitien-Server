package com.yiTian.view.modules.yellowDiamond
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class JinJuanTips
   {
      
      private static var _ins:JinJuanTips;
      
      public var tipBtn:MainUIBtn;
      
      public function JinJuanTips()
      {
         super();
      }
      
      public static function get instance() : JinJuanTips
      {
         if(!_ins)
         {
            _ins = new JinJuanTips();
         }
         return _ins;
      }
      
      public function showJinJuanTip() : void
      {
         if(!this.tipBtn)
         {
            this.tipBtn = new MainUIBtn("resource/image/jinJunStore/jinJuanStore.png",{
               "x":(65 - 54) / 2,
               "y":(70 - 54) / 2
            });
            UIManager.mainUiBtnContainer.addBTN(this.tipBtn);
            this.tipBtn.addEventListener(MouseEvent.CLICK,this.cliHd);
         }
      }
      
      private function cliHd(e:MouseEvent = null) : void
      {
         navigateToURL(new URLRequest("http://rc.qzone.qq.com/appstore/dailycoupon/mall?from=20121211_100621282"),"_blank");
      }
   }
}

