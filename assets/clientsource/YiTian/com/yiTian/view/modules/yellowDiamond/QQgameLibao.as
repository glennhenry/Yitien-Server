package com.yiTian.view.modules.yellowDiamond
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class QQgameLibao
   {
      
      private static var _instance:QQgameLibao;
      
      public var tipBtn:MainUIBtn;
      
      public function QQgameLibao()
      {
         super();
      }
      
      public static function get instance() : QQgameLibao
      {
         if(!_instance)
         {
            _instance = new QQgameLibao();
         }
         return _instance;
      }
      
      public function showTip() : void
      {
         if(!this.tipBtn)
         {
            this.tipBtn = new MainUIBtn("resource/image/shouchong/qqGameGiftIcon.png",{
               "x":(65 - 54) / 2,
               "y":(70 - 54) / 2
            });
            this.tipBtn.addEventListener(MouseEvent.CLICK,this.cliHd);
            UIManager.mainUiBtnContainer.addBTN(this.tipBtn);
         }
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("http://qqgame.qq.com/act/a20121129yt/"),"_blank");
      }
   }
}

