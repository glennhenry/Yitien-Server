package com.yiTian.view.modules.rechargeFeedback
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.RechargeFeedbackCGMessage;
   import com.yiTian.net.message.gc.RechargeFeedbackGCMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import com.yiTian.view.modules.rechargeFeedback.reChangeBack.View_chargeBackPan;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import flash.events.MouseEvent;
   
   public class FeedBack_Btn
   {
      
      private static var _instance:FeedBack_Btn;
      
      private var feedBack:MainUIBtn;
      
      public function FeedBack_Btn()
      {
         super();
      }
      
      public static function get instance() : FeedBack_Btn
      {
         if(!_instance)
         {
            _instance = new FeedBack_Btn();
         }
         return _instance;
      }
      
      private function init() : void
      {
         this.feedBack = new MainUIBtn("resource/image/rechargeFeedback/feedBack.png");
         this.feedBack.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      public function show() : void
      {
         if(!this.feedBack)
         {
            this.init();
         }
         UIManager.mainUiBtnContainer.addBTN(this.feedBack);
      }
      
      public function hide() : void
      {
         if(Boolean(this.feedBack) && Boolean(this.feedBack.parent))
         {
            UIManager.mainUiBtnContainer.removeBTN(this.feedBack);
         }
      }
      
      private function onClick(event:MouseEvent) : void
      {
         Utils.print("充值回馈---",View_RechargeFeedback.instance,event.target);
         if(!RechargeFeedbackGCMessage.isUsingNewReCharge)
         {
            View_RechargeFeedback.instance.visible = true;
         }
         else
         {
            WuXingMter.getPan(View_chargeBackPan,function(pan:View_chargeBackPan):void
            {
               RechargeFeedbackCGMessage.CG_OPEN_FEEDBACK();
               pan.visible = true;
            });
         }
      }
   }
}

