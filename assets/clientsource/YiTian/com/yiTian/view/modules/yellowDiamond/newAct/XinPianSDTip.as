package com.yiTian.view.modules.yellowDiamond.newAct
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class XinPianSDTip
   {
      
      private static var _instance:XinPianSDTip;
      
      private var tipBtn:MainUIBtn;
      
      public function XinPianSDTip()
      {
         super();
      }
      
      public static function get instance() : XinPianSDTip
      {
         if(!_instance)
         {
            _instance = new XinPianSDTip();
         }
         return _instance;
      }
      
      public function show() : void
      {
      }
      
      private function jump(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("http://yi.qq.com/act/a20130111xdjz/index.htm"),"_blank");
         this.remove();
      }
      
      public function remove() : void
      {
         if(UIManager.mainUiBtnContainer.hasBTN(this.tipBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(this.tipBtn);
         }
      }
   }
}

