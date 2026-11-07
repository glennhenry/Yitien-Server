package com.yiTian.view.modules.crossCampBattle
{
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.net.message.cg.CrossCampBattleCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class View_ExitPanel extends Panel
   {
      
      public var leaveBtn:MainUIBtn;
      
      public var ruleBtn:MainUIBtn;
      
      public function View_ExitPanel()
      {
         super();
         init();
      }
      
      public static function get instance() : View_ExitPanel
      {
         return Singleton.getInstance(View_ExitPanel);
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
         this.ruleBtn = new MainUIBtn("resource/image/kuafubangzhan/help.png");
         this.ruleBtn.name = "ruleBtn";
         this.ruleBtn.addEventListener(MouseEvent.CLICK,this.clickBtnHandler);
         this.ruleBtn.transform.colorTransform = Util.colorNomal;
         this.ruleBtn.mouseEnabled = true;
         this.ruleBtn.visible = true;
         this.ruleBtn.filters = [];
         addChild(this.ruleBtn);
         this.ruleBtn.x = this.leaveBtn.x + 80;
         this.leaveBtn.addEventListener(MouseEvent.ROLL_OVER,this.overBtnHandler);
         this.leaveBtn.addEventListener(MouseEvent.ROLL_OUT,this.outBtnHandler);
         this.ruleBtn.addEventListener(MouseEvent.ROLL_OVER,this.overBtnHandler);
         this.ruleBtn.addEventListener(MouseEvent.ROLL_OUT,this.outBtnHandler);
         bAutoRemove = false;
      }
      
      protected function clickBtnHandler(e:MouseEvent) : void
      {
         switch((e.currentTarget as MainUIBtn).name)
         {
            case "leaveBtn":
               CrossCampBattleCGMessage.CG_EXIT_CAMP_SCENE();
               break;
            case "ruleBtn":
               View_CrossCampBattleRulePanel.instance.visible = !View_CrossCampBattleRulePanel.instance.visible;
         }
      }
      
      private function overBtnHandler(e:MouseEvent) : void
      {
         e.currentTarget.transform.colorTransform = Util.colorWhite2;
      }
      
      private function outBtnHandler(e:MouseEvent) : void
      {
         e.currentTarget.transform.colorTransform = Util.colorNomal;
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - 400;
         y = 30;
      }
   }
}

