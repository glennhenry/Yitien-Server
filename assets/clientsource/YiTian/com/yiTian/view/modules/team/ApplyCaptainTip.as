package com.yiTian.view.modules.team
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.TeamCGMessage;
   import com.yiTian.view.Panel;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFormatAlign;
   import flash.utils.getTimer;
   
   public class ApplyCaptainTip extends Panel
   {
      
      private var Button_OK:Button;
      
      private var Button_Cancel:Button;
      
      private var TeamLeader_text:MyTextField;
      
      private var _txt:MyTextField;
      
      private var lastTime:int;
      
      private var totalTime:int;
      
      private var DaoJiShi_text:MyTextField;
      
      private var _roleId:Number;
      
      private var _teamId:int;
      
      private var isLock:Boolean;
      
      public function ApplyCaptainTip()
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
            "x":139,
            "y":48,
            "color":16764206,
            "size":18
         });
         this.DaoJiShi_text.bold = true;
         this.TeamLeader_text = ComponentUtil.getTextField("",this,{
            "x":62,
            "y":75,
            "color":16773818
         });
         this.TeamLeader_text.realWidth = 175;
         this.TeamLeader_text.align = TextFormatAlign.CENTER;
         this.Button_OK.addEventListener(MouseEvent.CLICK,this.clickHandler);
         this.Button_Cancel.addEventListener(MouseEvent.CLICK,this.clickHandler);
      }
      
      public function countDown(teamId:int, roleId:Number, applyRoleName:String) : void
      {
         this._roleId = roleId;
         this._teamId = teamId;
         this.TeamLeader_text.htmlText = "<b><font color=\'#F4CD31\'>" + applyRoleName + "</font></b>  " + LangConfig.getWord("10147",1);
         this.addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         this.totalTime = 30;
         this.lastTime = getTimer();
         this.isLock = false;
      }
      
      protected function clickHandler(event:MouseEvent) : void
      {
         if(event.target.label == LangConfig.getWord("10125",1))
         {
            TeamCGMessage.CG_CAP_RETURN(1,this._roleId);
         }
         else if(event.target.label == LangConfig.getWord("10146",1))
         {
            this.isLock = true;
            TeamCGMessage.CG_CAP_RETURN(0,this._roleId);
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
            if(Global.isPata)
            {
               this.Button_OK.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            else
            {
               this.Button_Cancel.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
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

