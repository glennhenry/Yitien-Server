package com.yiTian.view.modules.team
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.TeamCGMessage;
   import com.yiTian.view.Panel;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFormatAlign;
   import flash.utils.getTimer;
   
   public class CapReqFollowTip extends Panel
   {
      
      private var Button_OK:Button;
      
      private var Button_Cancel:Button;
      
      private var TeamLeader_text:MyTextField;
      
      private var lastTime:int;
      
      private var totalTime:int;
      
      private var DaoJiShi_text:MyTextField;
      
      private var _roleId:int;
      
      private var _teamId:int;
      
      private var isLock:Boolean;
      
      public function CapReqFollowTip()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var back:DisplayObject = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":300,
            "height":145
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":252,
            "height":95
         },Global.Img_Cdm);
         move = new Rectangle(0,0,back.width,35);
         ComponentUtil.getTextField(LangConfig.getWord("10148",1),this,{
            "x":105,
            "y":80
         });
         this.Button_OK = ComponentUtil.getButton(LangConfig.getWord("10125",1),"Button_Two",this,{
            "x":78,
            "y":103,
            "textColor":16773818
         },Global.Img_Cdm);
         this.Button_Cancel = ComponentUtil.getButton(LangConfig.getWord("10146",1),"Button_Two",this,{
            "x":175,
            "y":103,
            "textColor":16773818
         },Global.Img_Cdm);
         this.DaoJiShi_text = ComponentUtil.getTextField("30",this,{
            "x":145,
            "y":53
         });
         this.DaoJiShi_text.textColor = 16383744;
         this.DaoJiShi_text.align = TextFormatAlign.CENTER;
         this.Button_OK.addEventListener(MouseEvent.CLICK,this.clickHandler);
         this.Button_Cancel.addEventListener(MouseEvent.CLICK,this.clickHandler);
      }
      
      public function countDown() : void
      {
         this.addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         this.totalTime = 10;
         this.lastTime = getTimer();
         this.isLock = false;
      }
      
      protected function clickHandler(event:MouseEvent) : void
      {
         var tlp:TeamListPanel = null;
         if(event.target.label == LangConfig.getWord("10125",1))
         {
            tlp = TeamListPanel.data[Model_team.team_id];
            if(Boolean(tlp))
            {
               tlp.genSuiHandle();
            }
            else
            {
               TeamCGMessage.CG_FOLLOW_CAP(1,Model_team.team_id);
            }
         }
         else if(event.target.label == LangConfig.getWord("10146",1))
         {
            this.isLock = true;
            TeamCGMessage.CG_FOLLOW_CAP(0,Model_team.team_id);
         }
         this.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         this.visible = false;
      }
      
      protected function enterFrameHandler(event:Event) : void
      {
         var now:int = getTimer();
         this.DaoJiShi_text.text = (this.totalTime - Math.ceil((now - this.lastTime) / 1000)).toString();
         if(this.totalTime - Math.ceil((now - this.lastTime) / 1000) <= 0)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
            this.Button_OK.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         else if(this.isLock)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

