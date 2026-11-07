package com.yiTian.view.modules.team
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Const_strImg;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.TeamCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.pet.PetPanel;
   import com.yiTian.view.modules.pet.PetVO;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ChaKanTeam extends Panel
   {
      
      public static var _teamId:int;
      
      public static var checkTeam_save:Array = new Array();
      
      public static var teamMembers_save:Array = new Array();
      
      public static var imgArr:Array = [34,190,346];
      
      private var Button_Join:Button;
      
      private var Button_Create:Button;
      
      private var Button_Pet_text02:Button;
      
      private var Button_Pet_text03:Button;
      
      private var Button_Pet_text01:Button;
      
      private var Name_text02:MyTextField;
      
      private var Job_text02:MyTextField;
      
      private var Lever_text02:MyTextField;
      
      private var Pet_text02:MyTextField;
      
      private var Name_text03:MyTextField;
      
      private var Job_text03:MyTextField;
      
      private var Lever_text03:MyTextField;
      
      private var Pet_text03:MyTextField;
      
      private var Name_text01:MyTextField;
      
      private var Job_text01:MyTextField;
      
      private var Lever_text01:MyTextField;
      
      private var Pet_text01:MyTextField;
      
      private var Image_01:DisplayObject;
      
      private var Image_02:DisplayObject;
      
      private var Image_03:DisplayObject;
      
      private var memberImgVec:Vector.<Bitmap>;
      
      private var f:Boolean = true;
      
      public function ChaKanTeam()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var i:int = 0;
         var teamMember:TeamMemberMessage = null;
         var bm:Bitmap = null;
         var back:DisplayObject = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":534,
            "height":360
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":486,
            "height":280
         },Global.Img_Cdm);
         move = new Rectangle(0,0,back.width,35);
         this.Button_Join = ComponentUtil.getButton(LangConfig.getWord("10149",1),"Button_Four",this,{
            "x":429,
            "y":325,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Create = ComponentUtil.getButton(LangConfig.getWord("10150",1),"Button_Four",this,{
            "x":348,
            "y":325,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":500,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.memberImgVec = new Vector.<Bitmap>();
         i = 0;
         while(i <= 2)
         {
            teamMember = new TeamMemberMessage();
            teamMember.x = imgArr[i];
            teamMember.y = 256.35;
            addChild(teamMember);
            ChaKanTeam.teamMembers_save[i] = teamMember;
            teamMember.visible = false;
            bm = new Bitmap();
            addChild(bm);
            bm.x = imgArr[i];
            bm.y = 50;
            this.memberImgVec.push(bm);
            i++;
         }
         this.Button_Join.addEventListener(MouseEvent.CLICK,this.joinTeamHandle);
         this.Button_Create.addEventListener(MouseEvent.CLICK,this.creTeamHandle);
      }
      
      private function joinTeamHandle(e:MouseEvent) : void
      {
         e.target.parent.visible = false;
         TeamCGMessage.CG_APPLY_TEAM(ChaKanTeam._teamId);
      }
      
      private function creTeamHandle(e:MouseEvent) : void
      {
         e.target.parent.visible = false;
         UIManager.teamSearchPanel.visible = false;
         TeamCGMessage.CG_CREATE_TEAM();
      }
      
      public function updataMessage(teamNumbers:int) : void
      {
         var d:Array = null;
         var tempI:int = 0;
         while(tempI <= 2)
         {
            d = ChaKanTeam.checkTeam_save[tempI];
            if(Boolean(d))
            {
               ChaKanTeam.teamMembers_save[tempI].update(ChaKanTeam.checkTeam_save[tempI]);
               ChaKanTeam.teamMembers_save[tempI].visible = true;
               Utils.getLoadBitmap(Const_strImg.getMemberUrl(d[8],d[6],8),this.memberImgVec[tempI]);
            }
            else
            {
               ChaKanTeam.teamMembers_save[tempI].visible = false;
               Utils.getLoadBitmap("resource/image/icon/23581.jpg",this.memberImgVec[tempI]);
            }
            tempI++;
         }
      }
      
      public function petInfoVisible(value:Boolean) : void
      {
         var point:Point = null;
         PetPanel.curPanel = this;
         UIManager.petInfoPanel.visible = value;
         point = this.localToGlobal(new Point(this.mouseX,this.mouseY));
         UIManager.petInfoPanel.x = point.x;
         UIManager.petInfoPanel.y = point.y - 280;
      }
      
      public function showPetInfoView(petVO:PetVO) : void
      {
         UIManager.petInfoPanel.petVO = petVO;
         UIManager.petInfoPanel.update();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(this.f)
         {
            Utils.loadTitle("lang/ch/TeamInformatImgs.swf","Title_DWXinXi",new Bitmap(),{
               "x":187,
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

