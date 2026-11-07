package com.yiTian.view.modules.team
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.TeamCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   
   public class InviteTip extends Panel
   {
      
      private var defaultTxt:String;
      
      private var Button_OK:Button;
      
      private var Button_Cancel:Button;
      
      private var SeachName_text:MyTextField;
      
      private var f:Boolean = true;
      
      public function InviteTip()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         super.initStaticView();
         this.defaultTxt = LangConfig.getWord("10151",1);
         var back:DisplayObject = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":300,
            "height":170
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":252,
            "height":120
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":74,
            "y":85,
            "width":153,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60295",6),this,{
            "x":89,
            "y":54,
            "color":16773818,
            "size":12,
            "leading":0
         });
         move = new Rectangle(0,0,back.width,35);
         this.Button_OK = ComponentUtil.getButton(LangConfig.getWord("10125",1),"Button_Two",this,{
            "x":78,
            "y":120,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Cancel = ComponentUtil.getButton(LangConfig.getWord("10146",1),"Button_Two",this,{
            "x":175,
            "y":120,
            "textColor":16184781
         },Global.Img_Cdm);
         this.SeachName_text = ComponentUtil.getTextField(this.defaultTxt,this,{
            "x":76,
            "y":87,
            "realWidth":150,
            "color":16773818
         });
         this.SeachName_text.type = TextFieldType.INPUT;
         this.SeachName_text.addEventListener(FocusEvent.FOCUS_IN,this.onFocusIn);
         this.SeachName_text.addEventListener(FocusEvent.FOCUS_OUT,this.onFocusOut);
         this.Button_OK.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.Button_Cancel.addEventListener(MouseEvent.CLICK,this.cancleHandle);
      }
      
      protected function onFocusOut(e:FocusEvent) : void
      {
         if(e.target.text == "")
         {
            e.target.text = this.defaultTxt;
         }
      }
      
      protected function onFocusIn(e:FocusEvent) : void
      {
         if(e.target.text == this.defaultTxt)
         {
            e.target.text = "";
         }
      }
      
      private function cliHandle(e:MouseEvent) : void
      {
         e.target.parent.visible = false;
         trace(Model_team.teamMumberInfo_data_save[0]);
         if(Model_team.teamMumberInfo_data_save.length == 3)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10152",1) + "</font>");
            return;
         }
         TeamCGMessage.CG_DIRECT_TEAM_STATE(1,this.SeachName_text.text);
         this.SeachName_text.text = "";
      }
      
      private function cancleHandle(e:MouseEvent) : void
      {
         e.target.parent.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(this.f)
         {
            Utils.loadTitle("lang/ch/TeamInformatImgs.swf","JRDuiWu",new Bitmap(),{
               "x":70,
               "y":5
            },this);
            this.f = false;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

