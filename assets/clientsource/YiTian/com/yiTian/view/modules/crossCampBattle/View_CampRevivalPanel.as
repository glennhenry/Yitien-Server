package com.yiTian.view.modules.crossCampBattle
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CrossCampBattleCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.team.TeamListPanel;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   import flash.utils.getTimer;
   
   public class View_CampRevivalPanel extends Panel
   {
      
      private var bg:Sprite;
      
      private var txtTip:MyTextField;
      
      private var lastTime:uint;
      
      private var time:int = 30;
      
      public function View_CampRevivalPanel()
      {
         super();
         init();
      }
      
      public static function get instance() : View_CampRevivalPanel
      {
         return Singleton.getInstance(View_CampRevivalPanel);
      }
      
      override protected function initStaticView() : void
      {
         bAutoRemove = false;
         this.bg = new Sprite();
         this.bg.graphics.beginFill(0,0.5);
         this.bg.graphics.drawRect(0,0,Global.stage.stageWidth,Global.stage.stageHeight);
         this.bg.graphics.endFill();
         addChild(this.bg);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":(Global.stage.stageWidth - 348) / 2,
            "y":(Global.stage.stageHeight - 184) / 2,
            "width":348,
            "height":184
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":(Global.stage.stageWidth - 300) / 2,
            "y":(Global.stage.stageHeight - 134) / 2 + 13,
            "width":300,
            "height":134
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":(Global.stage.stageWidth - 250) / 2,
            "y":(Global.stage.stageHeight - 40) / 2 + 22,
            "width":250,
            "height":40
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_WXPrompt",this,{
            "x":(Global.stage.stageWidth - 348) / 2 + 92,
            "y":(Global.stage.stageHeight - 184) / 2 + 5
         },Global.Img_Cdm);
         var btn:Button = ComponentUtil.getButton("立即复活","Button_Four",this,{
            "x":(Global.stage.stageWidth - 348) / 2 + 137,
            "y":(Global.stage.stageHeight - 184) / 2 + 132,
            "textColor":16184781,
            "callBack":this.revive
         },Global.Img_Cdm);
         var txt:MyTextField = ComponentUtil.getTextField("",this,{
            "x":(Global.stage.stageWidth - 348) / 2 + 56,
            "y":(Global.stage.stageHeight - 184) / 2 + 65,
            "size":14
         });
         txt.htmlText = LangConfig.getWord("10646",1);
         this.txtTip = ComponentUtil.getTextField("",this,{
            "x":(Global.stage.stageWidth - 348) / 2 + 51,
            "y":(Global.stage.stageHeight - 184) / 2 + 100,
            "size":14
         });
         this.txtTip.realWidth = 218;
         this.txtTip.align = TextFormatAlign.CENTER;
         this.txtTip.multiline = true;
         TipManager.bind(btn,"需要消耗20元宝");
      }
      
      private function frameStep() : void
      {
         var now:uint = uint(getTimer());
         if(now - this.lastTime > 1000)
         {
            --this.time;
            this.txtTip.htmlText = "复活倒计时：" + this.time + "秒";
            this.lastTime = now;
            if(this.time <= 0)
            {
               CrossCampBattleCGMessage.CG_CAMP_REVIVE(Enum_CrossCampBattle.REVIVA,Model_CrossCampBattle.battleVersion);
               this.hide();
            }
         }
      }
      
      private function revive(e:MouseEvent) : void
      {
         CrossCampBattleCGMessage.CG_CAMP_REVIVE(Enum_CrossCampBattle.FEE_REVIVA,Model_CrossCampBattle.battleVersion);
      }
      
      public function show(time:int) : void
      {
         visible = true;
         Model_CrossCampBattle.hasDie = true;
         if(Boolean(TeamListPanel.data[Model_team.team_id]) && TeamListPanel.data[Model_team.team_id].visible == true)
         {
            TeamListPanel.data[Model_team.team_id].visible = false;
         }
         if(UIManager.teamSearchPanel.visible == true)
         {
            UIManager.teamSearchPanel.visible = false;
         }
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep);
         this.time = time;
         this.txtTip.htmlText = "复活倒计时：" + time + "秒";
         if(Boolean(this.parent))
         {
            this.parent.setChildIndex(this,this.parent.numChildren - 1);
         }
         Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,this.resetPosition);
      }
      
      public function hide() : void
      {
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep);
         Global.control.removeCallBack(Enum_MsgType.STAGE_RESIZE,this.resetPosition);
         visible = false;
         Model_CrossCampBattle.hasDie = false;
      }
      
      override public function resetPosition() : void
      {
         this.bg.width = Global.stage.stageWidth;
         this.bg.height = Global.stage.stageHeight;
         x = Global.stage.stageWidth - this.width >> 1;
         y = Global.stage.stageHeight - this.height >> 1;
      }
   }
}

