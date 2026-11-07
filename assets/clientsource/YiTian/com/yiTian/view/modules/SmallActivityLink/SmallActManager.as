package com.yiTian.view.modules.SmallActivityLink
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.QShow.ViewQShowSkin;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class SmallActManager
   {
      
      private static var _instance:SmallActManager;
      
      public var telChargeBtn:MainUIBtn;
      
      public var loveActBtn:MainUIBtn;
      
      public var showSkinBtn:MainUIBtn;
      
      public function SmallActManager()
      {
         super();
      }
      
      public static function get instance() : SmallActManager
      {
         if(!_instance)
         {
            _instance = new SmallActManager();
         }
         return _instance;
      }
      
      private function initBtn(url:String, link:String) : MainUIBtn
      {
         var btn:MainUIBtn = new MainUIBtn(url);
         btn.addEventListener(MouseEvent.CLICK,function(evt:MouseEvent):void
         {
            navigateToURL(new URLRequest(link),"_blank");
            addBtn(false,evt.target as MainUIBtn);
         });
         return btn;
      }
      
      private function addBtn(value:Boolean, btn:MainUIBtn) : void
      {
         if(value)
         {
            UIManager.mainUiBtnContainer.addBTN(btn);
         }
         else
         {
            UIManager.mainUiBtnContainer.removeBTN(btn);
         }
      }
      
      public function getTelActBtn() : void
      {
         if(!this.telChargeBtn)
         {
            this.telChargeBtn = this.initBtn(VoSmallAct.telChargeSourUrl,VoSmallAct.telChargeLink);
         }
         this.addBtn(true,this.telChargeBtn);
      }
      
      public function getLoveActBtn() : void
      {
         if(!this.loveActBtn)
         {
            this.loveActBtn = this.initBtn(VoSmallAct.loveActSourUrl,VoSmallAct.loveActLink);
         }
         this.addBtn(true,this.loveActBtn);
      }
      
      private function initCopyBtn(url:String, type:int, func:Function) : MainUIBtn
      {
         var btn:MainUIBtn = new MainUIBtn(url);
         btn.addEventListener(MouseEvent.CLICK,function(evt:MouseEvent):void
         {
            if(func != null)
            {
               func.call(null);
            }
            if(type == 1)
            {
               addBtn(false,evt.target as MainUIBtn);
            }
            else if(type == 2)
            {
               addCopyBtn(false,evt.target as MainUIBtn);
            }
         });
         return btn;
      }
      
      private function addCopyBtn(value:Boolean, btn:MainUIBtn) : void
      {
         if(value)
         {
            UIManager.newMainBtnContainer.addBtn(btn);
         }
         else
         {
            UIManager.newMainBtnContainer.removeBtn(btn);
         }
      }
      
      public function getShowSkinBtn() : void
      {
         if(!this.showSkinBtn)
         {
            this.showSkinBtn = this.initCopyBtn(VoSmallAct.showSkinSourUrl,2,this.showSkinHandle);
         }
         this.addCopyBtn(true,this.showSkinBtn);
      }
      
      private function showSkinHandle() : void
      {
         ViewQShowSkin.instance.visible = true;
      }
   }
}

