package com.yiTian.view.modules.question
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CheckCGMessage;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class QuestionTips
   {
      
      private static var _instance:QuestionTips;
      
      private var tipBtn:MainUIBtn;
      
      public function QuestionTips()
      {
         super();
      }
      
      public static function get instance() : QuestionTips
      {
         if(!_instance)
         {
            _instance = new QuestionTips();
         }
         return _instance;
      }
      
      public function showTip() : void
      {
         var source:String = "resource/image/questions/questionIcon.png";
         if(!this.tipBtn)
         {
            this.tipBtn = new MainUIBtn(source);
            UIManager.mainUiBtnContainer.addBTN(this.tipBtn);
            this.tipBtn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
            {
               CheckCGMessage.CG_SHOW_CHECK_PAN();
            });
         }
      }
      
      public function removeTip() : void
      {
         if(UIManager.mainUiBtnContainer.hasBTN(this.tipBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(this.tipBtn);
         }
      }
   }
}

