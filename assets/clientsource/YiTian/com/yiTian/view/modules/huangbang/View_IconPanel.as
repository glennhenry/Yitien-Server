package com.yiTian.view.modules.huangbang
{
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class View_IconPanel extends Panel
   {
      
      public var leaveBtn:MainUIBtn;
      
      public function View_IconPanel()
      {
         super();
         init();
      }
      
      public static function get instance() : View_IconPanel
      {
         return Singleton.getInstance(View_IconPanel);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.leaveBtn = new MainUIBtn("resource/image/pata/Exit_Icon.png");
         this.leaveBtn.name = "leaveBtn";
         this.leaveBtn.addEventListener(MouseEvent.CLICK,this.clickBtnHandler);
         this.leaveBtn.transform.colorTransform = Util.colorNomal;
         this.leaveBtn.mouseEnabled = true;
         this.leaveBtn.visible = true;
         this.leaveBtn.filters = [];
         addChild(this.leaveBtn);
         bAutoRemove = false;
      }
      
      protected function clickBtnHandler(event:MouseEvent) : void
      {
         if(Model_Huangbang.canClickShake == false)
         {
            return;
         }
         View_HuangbangInfoPanel.instance.leaveCb();
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - 386;
         y = 30;
      }
   }
}

