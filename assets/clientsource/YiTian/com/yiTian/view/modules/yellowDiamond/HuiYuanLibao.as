package com.yiTian.view.modules.yellowDiamond
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class HuiYuanLibao
   {
      
      private static var _instance:HuiYuanLibao;
      
      public var tipBtn:MainUIBtn;
      
      public function HuiYuanLibao()
      {
         super();
      }
      
      public static function get instance() : HuiYuanLibao
      {
         if(!_instance)
         {
            _instance = new HuiYuanLibao();
         }
         return _instance;
      }
      
      public function showTip() : void
      {
         if(!this.tipBtn)
         {
            this.tipBtn = new MainUIBtn("resource/image/shouchong/huiYuan.png",{
               "x":(65 - 54) / 2,
               "y":(70 - 54) / 2
            });
            this.tipBtn.addEventListener(MouseEvent.CLICK,this.cliHd);
            UIManager.mainUiBtnContainer.addBTN(this.tipBtn);
         }
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("http://yi.qq.com/webplat/info/news_version3/4814/4815/4818/m3317/201212/184133.shtml"),"_blank");
      }
   }
}

