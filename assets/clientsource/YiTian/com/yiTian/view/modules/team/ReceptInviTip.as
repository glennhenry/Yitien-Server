package com.yiTian.view.modules.team
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.TeamCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class ReceptInviTip extends Panel
   {
      
      public static var receptTimes:Array = [];
      
      private static var pool:Array = [];
      
      public static var recept_data:Dictionary = new Dictionary();
      
      private var Button_OK:Button;
      
      private var Button_Cancel:Button;
      
      private var DaoJiShi_text:MyTextField;
      
      private var TeamLeader_text:MyTextField;
      
      private var _teamId:int;
      
      private var titleBmp:Bitmap;
      
      private var askZone:int = 0;
      
      private var _otherRoleId:Number;
      
      private var lastTime:int;
      
      private var totalTime:int;
      
      private var isLock:Boolean;
      
      public function ReceptInviTip()
      {
         super();
      }
      
      public static function getTip() : ReceptInviTip
      {
         var rtf:ReceptInviTip = null;
         if(Boolean(pool.length))
         {
            rtf = pool.pop();
            GameScene.popupLayer.addChild(rtf);
            rtf.init();
            rtf.visible = false;
            return rtf;
         }
         rtf = new ReceptInviTip();
         GameScene.popupLayer.addChild(rtf);
         rtf.init();
         return rtf;
      }
      
      public function dispose() : void
      {
         this.parent.removeChild(this);
         pool.push(this);
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
         this.titleBmp = ComponentUtil.getBitmap("Title_WXPrompt",this,{
            "x":70,
            "y":5
         },Global.Img_Cdm);
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
         this.TeamLeader_text = ComponentUtil.getTextField("",this,{
            "x":26,
            "y":65,
            "color":16773818
         });
         this.TeamLeader_text.realWidth = 247;
         this.TeamLeader_text.align = TextFormatAlign.CENTER;
         this.Button_OK.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.Button_Cancel.addEventListener(MouseEvent.CLICK,this.cliHandle);
      }
      
      private function cliHandle(e:MouseEvent) : void
      {
         if(e.target.label == LangConfig.getWord("10125",1))
         {
            TeamCGMessage.CG_DIRECT_TEAM(this._otherRoleId,1,this.askZone);
            ReceptInviTip.receptTimes.shift();
            if(Boolean(ReceptInviTip.receptTimes.length))
            {
               ReceptInviTip.receptTimes[0].visible = true;
            }
         }
         else if(e.target.label == LangConfig.getWord("10146",1))
         {
            TeamCGMessage.CG_DIRECT_TEAM(this._otherRoleId,0);
            ReceptInviTip.receptTimes.shift();
            if(Boolean(ReceptInviTip.receptTimes.length))
            {
               ReceptInviTip.receptTimes[0].visible = true;
            }
         }
         this.dispose();
      }
      
      public function addMessage(teamCaptain:String, teamId:int, zone:int = 0) : void
      {
         this._teamId = teamId;
         this.askZone = zone;
         teamCaptain = Model_heFu.repNameByHero(teamCaptain);
         this.TeamLeader_text.htmlText = "<b><font color=\'#F4CD31\'>" + teamCaptain + "</font></b>  " + LangConfig.getWord("10153",1);
      }
      
      public function get tipId() : Number
      {
         return this._otherRoleId;
      }
      
      public function countDown(otherRoleId:Number) : void
      {
         this._otherRoleId = otherRoleId;
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
         trace("team countDown");
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

