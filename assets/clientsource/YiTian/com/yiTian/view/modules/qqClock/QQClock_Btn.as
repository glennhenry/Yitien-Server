package com.yiTian.view.modules.qqClock
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.QQClockCGMessage;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   
   public class QQClock_Btn
   {
      
      private static var _instance:QQClock_Btn;
      
      private var clockBtn:MainUIBtn;
      
      public function QQClock_Btn()
      {
         super();
      }
      
      public static function get instance() : QQClock_Btn
      {
         if(!_instance)
         {
            _instance = new QQClock_Btn();
         }
         return _instance;
      }
      
      private function init() : void
      {
         this.clockBtn = new MainUIBtn("resource/image/qqClock/qqClock.png");
      }
      
      public function show() : void
      {
         if(!this.clockBtn)
         {
            this.init();
         }
         UIManager.mainUiBtnContainer.addBTN(this.clockBtn);
         this.clockBtn.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      public function hide() : void
      {
         if(!this.clockBtn)
         {
            return;
         }
         UIManager.mainUiBtnContainer.removeBTN(this.clockBtn);
         this.clockBtn.removeEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      public function onClick(event:MouseEvent = null) : void
      {
         ExternalInterface.call("loadClockFrame","");
         this.hide();
         QQClockCGMessage.CG_QQCLOCK_ACTION();
      }
   }
}

