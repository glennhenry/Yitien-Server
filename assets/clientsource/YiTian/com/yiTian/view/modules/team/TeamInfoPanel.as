package com.yiTian.view.modules.team
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.TeamCGMessage;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextFieldType;
   import flash.text.TextFormatAlign;
   
   public class TeamInfoPanel extends Sprite
   {
      
      public static const COLOR:Array = ["","D75B43","5AA8BF","87BF38","BF65B4"];
      
      private var Button_Join01:Button;
      
      private var Button_View01:Button;
      
      private var TeamName_text01:MyTextField;
      
      private var Number_text01:MyTextField;
      
      private var ZhenXing_text01:MyTextField;
      
      private var Lever_text01:MyTextField;
      
      private var _arr:Array = new Array();
      
      private var _teamId:int;
      
      public function TeamInfoPanel()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         var back:DisplayObject = ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":0,
            "y":31,
            "width":470,
            "height":2
         },Global.Img_Cdm);
         this.Button_Join01 = ComponentUtil.getButton(LangConfig.getWord("10154",1),"Button_Two",this,{
            "x":419,
            "y":6,
            "textColor":16773818,
            "visible":false
         },Global.Img_Cdm);
         this.Button_View01 = ComponentUtil.getButton(LangConfig.getWord("10155",1),"Button_Two",this,{
            "x":366,
            "y":6,
            "textColor":16773818,
            "visible":false
         },Global.Img_Cdm);
         this.TeamName_text01 = ComponentUtil.getTextField("",this,{
            "x":15,
            "y":6,
            "color":16773818,
            "size":12,
            "leading":0
         });
         this.TeamName_text01.align = TextFormatAlign.CENTER;
         this.TeamName_text01.type = TextFieldType.INPUT;
         this.TeamName_text01.selectable = false;
         this.TeamName_text01.restrict = "";
         this.TeamName_text01.addEventListener(TextEvent.LINK,this.linkEvent);
         this.Number_text01 = ComponentUtil.getTextField("",this,{
            "x":116,
            "y":6,
            "color":16773818,
            "size":12,
            "leading":0
         });
         this.Number_text01.realWidth = 22.3;
         this.Number_text01.align = TextFormatAlign.CENTER;
         this.ZhenXing_text01 = ComponentUtil.getTextField("",this,{
            "x":190,
            "y":6,
            "color":16773818,
            "size":12,
            "leading":0
         });
         this.ZhenXing_text01.realWidth = 52.2;
         this.ZhenXing_text01.align = TextFormatAlign.CENTER;
         this.Lever_text01 = ComponentUtil.getTextField("",this,{
            "x":280,
            "y":6,
            "color":16773818,
            "size":12,
            "leading":0
         });
         this.Lever_text01.realWidth = 50.8;
         this.Lever_text01.align = TextFormatAlign.CENTER;
         this.Button_View01.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.Button_Join01.addEventListener(MouseEvent.CLICK,this.joinTeamHandle);
      }
      
      protected function linkEvent(e:TextEvent) : void
      {
         Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,int(e.text));
      }
      
      private function joinTeamHandle(e:MouseEvent) : void
      {
         TeamCGMessage.CG_APPLY_TEAM(this._teamId);
      }
      
      private function cliHandle(e:MouseEvent) : void
      {
         TeamCGMessage.CG_CHECK_TEAM(this._teamId);
         ChaKanTeam._teamId = this._teamId;
      }
      
      public function update(arr:Array, teamId:int) : void
      {
         this._teamId = teamId;
         this.Button_Join01.visible = true;
         this.Button_View01.visible = true;
         this.TeamName_text01.text = "";
         this.Number_text01.text = "";
         this.ZhenXing_text01.text = "";
         this.Lever_text01.text = "";
         arr[1] = Model_heFu.repNameByHero(arr[1]);
         this.TeamName_text01.htmlText = "<u><a href=\"event:" + arr[7] + "\"><font color=\'#" + COLOR[arr[8]] + "\'>" + arr[1] + "</font></a></u>";
         this.Number_text01.text = String(arr[2]) + "/" + String(arr[3]);
         if(Boolean(arr[4]))
         {
            this.ZhenXing_text01.text = LangConfig.getWord("10156",1);
         }
         else
         {
            this.ZhenXing_text01.text = LangConfig.getWord("10157",1);
         }
         this.Lever_text01.text = String(arr[5]) + "-" + String(arr[6]);
      }
      
      public function reset() : void
      {
         this.TeamName_text01.text = "";
         this.Number_text01.text = "";
         this.ZhenXing_text01.text = "";
         this.Lever_text01.text = "";
         this.Button_Join01.visible = false;
         this.Button_View01.visible = false;
      }
   }
}

