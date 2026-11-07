package com.yiTian.view.modules.ShengDan
{
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ShengDanCGMessage;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class ShengDanBtn
   {
      
      private var yellowBtn:MainUIBtn;
      
      public function ShengDanBtn()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.yellowBtn = new MainUIBtn("resource/image/Diamond/huang.png");
      }
      
      public function get shengDanYll() : MainUIBtn
      {
         return this.yellowBtn;
      }
      
      public function show() : void
      {
         if(ShengDanVO.see == 1)
         {
            UIManager.mainUiBtnContainer.addBTN(this.yellowBtn);
            this.yellowBtn.addEventListener(MouseEvent.CLICK,this.yellowBtnClick);
         }
         else if(ShengDanVO.see == 0)
         {
            UIManager.mainUiBtnContainer.removeBTN(this.yellowBtn);
            this.yellowBtn.removeEventListener(MouseEvent.CLICK,this.yellowBtnClick);
         }
      }
      
      private function yellowBtnClick(e:MouseEvent) : void
      {
         ShengDanCGMessage.CG_SHENGDAN_CILCK();
      }
   }
}

