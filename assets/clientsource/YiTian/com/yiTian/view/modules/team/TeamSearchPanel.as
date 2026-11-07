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
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFormatAlign;
   
   public class TeamSearchPanel extends Panel
   {
      
      private static var Button_Join:Button;
      
      private static var Button_View:Button;
      
      private static var Page_text:MyTextField;
      
      private static var _teamId:int;
      
      private static var _pageDynamic:int = 1;
      
      private static var _pageAcount:int = 1;
      
      private static var _teamsNumber:int = 0;
      
      private static var _leastLevel:int = 1;
      
      private static var _biggestLevel:int = 100;
      
      public static var pageSize:int = 5;
      
      public static var page:int = 0;
      
      private var Button_Create:Button;
      
      private var Button_Refresh:Button;
      
      private var ButtonPage_Right:Button;
      
      private var ButtonPage_Left:Button;
      
      public var totalPage:int;
      
      public var curentPage:int;
      
      private var isFirstOpen:Boolean = true;
      
      private var arr:Array = [];
      
      public function TeamSearchPanel()
      {
         super();
      }
      
      private static function cliHandle(e:MouseEvent) : void
      {
         e.target.parent.visible = false;
         TeamCGMessage.CG_CREATE_TEAM();
         UIManager.teamSearchPanel.visible = false;
      }
      
      public static function showTeamsMessage() : void
      {
         var i:int = 0;
         while(i <= 4)
         {
            Model_team.teamInfo_data_save[i].reset();
            i++;
         }
         var tempI:int = 0;
         while(tempI < pageSize && Boolean(Model_team.team_data_save[tempI]))
         {
            Model_team.teamInfo_data_save[tempI].update(Model_team.team_data_save[tempI],Model_team.team_data_save[tempI][0]);
            tempI++;
         }
         Page_text.text = UIManager.teamSearchPanel.curentPage.toString() + "/" + UIManager.teamSearchPanel.totalPage.toString();
      }
      
      override protected function initStaticView() : void
      {
         var back:DisplayObject = null;
         isTween = true;
         back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":528,
            "height":290
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":24,
            "y":40,
            "width":480,
            "height":210
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":25,
            "y":41,
            "width":478,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":420,
            "y":259,
            "width":44,
            "height":21
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60300",6),this,{
            "x":42,
            "y":41,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60301",6),this,{
            "x":131,
            "y":41,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60302",6),this,{
            "x":217,
            "y":41,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60303",6),this,{
            "x":306,
            "y":41,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60023",6),this,{
            "x":428,
            "y":41,
            "color":16764206,
            "size":12,
            "leading":0
         });
         move = new Rectangle(0,0,back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":494,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton.x = back.width - CloseButton.width - 8;
         this.Button_Refresh = ComponentUtil.getButton(LangConfig.getWord("10174",1),"Button_Two64",this,{
            "x":241,
            "y":257,
            "textColor":16773818
         },Global.Img_Cdm);
         this.Button_Create = ComponentUtil.getButton(LangConfig.getWord("10150",1),"Button_Four",this,{
            "x":314,
            "y":257,
            "textColor":16773818
         },Global.Img_Cdm);
         this.ButtonPage_Right = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":468,
            "y":259,
            "textColor":16184781
         },Global.Img_Cdm);
         this.ButtonPage_Left = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":396,
            "y":259,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Refresh.addEventListener(MouseEvent.CLICK,this.refreshHandle);
         this.ButtonPage_Left.addEventListener(MouseEvent.CLICK,this.showPrevPage);
         this.ButtonPage_Right.addEventListener(MouseEvent.CLICK,this.showNextPage);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.isFirstOpen)
            {
               Utils.loadTitle("lang/ch/TeamInformatImgs.swf","DWLiBiao",new Bitmap(),{
                  "x":184,
                  "y":5
               },this);
            }
            this.isFirstOpen = false;
            bind_target = Enum_explor.bind(Enum_explor.BTN_TEAM);
         }
      }
      
      private function showNextPage(event:MouseEvent) : void
      {
         if(UIManager.teamSearchPanel.totalPage > UIManager.teamSearchPanel.curentPage)
         {
            TeamCGMessage.CG_TEAM(UIManager.teamSearchPanel.curentPage + 1);
         }
      }
      
      private function showPrevPage(event:MouseEvent) : void
      {
         if(UIManager.teamSearchPanel.curentPage > 1)
         {
            TeamCGMessage.CG_TEAM(UIManager.teamSearchPanel.curentPage - 1);
         }
      }
      
      override protected function initDynamicView() : void
      {
         var i:int = 0;
         var teamInfoPanel:TeamInfoPanel = null;
         super.initDynamicView();
         Page_text = ComponentUtil.getTextField("0/0",this,{
            "x":423,
            "y":260,
            "color":16773818,
            "size":12,
            "leading":0
         });
         Page_text.realWidth = 42;
         Page_text.align = TextFormatAlign.CENTER;
         this.Button_Create.addEventListener(MouseEvent.CLICK,cliHandle);
         i = 0;
         while(i <= 4)
         {
            teamInfoPanel = new TeamInfoPanel();
            teamInfoPanel.x = 27;
            teamInfoPanel.y = 67 + (teamInfoPanel.height + 6) * i;
            addChild(teamInfoPanel);
            Model_team.teamInfo_data_save[i] = teamInfoPanel;
            i++;
         }
      }
      
      private function refreshHandle(e:MouseEvent) : void
      {
         page = 0;
         TeamCGMessage.CG_TEAM(1);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

