package com.yiTian.view.modules.team
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Const_strImg;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_map_lib;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.data.vo.Vo_ZhenFa;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.GuangMingDingCGMessage;
   import com.yiTian.net.message.cg.PataCGMessage;
   import com.yiTian.net.message.cg.QiJuCGMessage;
   import com.yiTian.net.message.cg.SceneCGMessage;
   import com.yiTian.net.message.cg.TeamCGMessage;
   import com.yiTian.net.message.cg.WanAnSiCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.mainUIBtnContainer.View_mainUiBtn_container;
   import com.yiTian.view.modules.pet.PetInfoPanel;
   import com.yiTian.view.modules.pet.PetPanel;
   import com.yiTian.view.modules.pet.PetVO;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flash.utils.Dictionary;
   
   public class TeamListPanel extends Panel
   {
      
      private static var Lever_Mix_text:MyTextField;
      
      private static var Lever_Max_text:MyTextField;
      
      private static var _teamMumbers:int;
      
      public static var pool:Array = [];
      
      public static var data:Dictionary = new Dictionary();
      
      private static var leastLevel:int = 1;
      
      private static var biggestLevel:int = 100;
      
      private var Button_ZhenXing:Button;
      
      private var Button_TiChu:Button;
      
      private var Button_ZhuangYi:Button;
      
      private var Button_YaoQing:Button;
      
      private var Button_ZhanLi:Button;
      
      private var Button_TuiChu:Button;
      
      private var Button_GenSui:Button;
      
      private var DengJi_CheckBox:DisplayObject;
      
      private var Button_Pet_text02:Button;
      
      private var Button_Pet_text03:Button;
      
      private var Button_Pet_text01:Button;
      
      public var ZhenXing_text:MyTextField;
      
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
      
      private var change_apply_cap:Array;
      
      private var kickRoleId:Number;
      
      private var _otherRoleId:Number;
      
      private var _teamId:int;
      
      private var registerCheckBox:CheckBox;
      
      private var petInfoView:PetInfoPanel;
      
      private var memberImgVec:Vector.<Bitmap>;
      
      private var isFirstOpen:Boolean = true;
      
      private var _selete:DisplayObject;
      
      private var overStyle:DisplayObject;
      
      private var clickSty:DisplayObject;
      
      public var _leastLevel:int = 1;
      
      public var _biggestLevel:int = 100;
      
      private var now_selete:DisplayObject;
      
      public function TeamListPanel()
      {
         super();
      }
      
      public static function changeHandle(e:Event) : void
      {
         if(int(Lever_Mix_text.text) >= int(Lever_Max_text.text))
         {
            if(Lever_Mix_text.text == "" || Lever_Max_text.text == "")
            {
               return;
            }
            Lever_Mix_text.text = "";
            Lever_Max_text.text = "";
            return;
         }
         if(int(Lever_Mix_text.text) > 100 || int(Lever_Max_text.text) > 100)
         {
            Lever_Mix_text.text = "";
            Lever_Max_text.text = "";
            return;
         }
         TeamCGMessage.CG_CHANGE_LEVEL(int(Lever_Mix_text.text),int(Lever_Max_text.text));
      }
      
      override protected function initStaticView() : void
      {
         var j:int = 0;
         var i:int = 0;
         var bm:Bitmap = null;
         var teamMember:TeamMemberMessage = null;
         this.change_apply_cap = [LangConfig.getWord("10158",1),LangConfig.getWord("10159",1)];
         isTween = true;
         var back:DisplayObject = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":534,
            "height":405
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":173,
            "y":55,
            "width":38,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":225,
            "y":55,
            "width":38,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":70,
            "y":55,
            "width":100,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":90,
            "width":486,
            "height":280
         },Global.Img_Cdm);
         move = new Rectangle(0,0,back.width,35);
         this.Button_ZhenXing = ComponentUtil.getButton(LangConfig.getWord("10160",1),"Button_Two",this,{
            "x":24,
            "y":53,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_TiChu = ComponentUtil.getButton(LangConfig.getWord("10161",1),"Button_Four",this,{
            "x":355,
            "y":37,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_ZhuangYi = ComponentUtil.getButton("","Button_Four",this,{
            "x":436,
            "y":37,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_YaoQing = ComponentUtil.getButton(LangConfig.getWord("10162",1),"Button_Four",this,{
            "x":274,
            "y":37,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_ZhanLi = ComponentUtil.getButton(LangConfig.getWord("10163",1),"Button_Four",this,{
            "x":355,
            "y":64,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_TuiChu = ComponentUtil.getButton(LangConfig.getWord("10164",1),"Button_Four",this,{
            "x":436,
            "y":64,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_GenSui = ComponentUtil.getButton(LangConfig.getWord("10165",1),"Button_Four",this,{
            "x":274,
            "y":64,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":500,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         Lever_Mix_text = ComponentUtil.getTextField("",this,{
            "x":185,
            "y":56,
            "color":14662240,
            "size":12,
            "leading":0
         });
         Lever_Max_text = ComponentUtil.getTextField("",this,{
            "x":232,
            "y":56,
            "color":14662240,
            "size":12,
            "leading":0
         });
         Lever_Mix_text.maxChars = 3;
         Lever_Max_text.maxChars = 3;
         this.ZhenXing_text = ComponentUtil.getTextField("",this,{
            "x":76,
            "y":56,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.registerCheckBox = new CheckBox("","CheckBox01",Global.Img_Cdm);
         this.registerCheckBox.x = 430;
         this.registerCheckBox.y = 378;
         addChild(this.registerCheckBox);
         this.registerCheckBox.text = "登记队伍";
         this.registerCheckBox.addEventListener(MouseEvent.CLICK,this.registerCheckBoxHandler);
         this.Image_01 = ComponentUtil.getDisplayObject("BackImage",this,{
            "x":ChaKanTeam.imgArr[0],
            "y":100,
            "width":153,
            "height":201,
            "alpha":0
         },ComponentUtil.domain);
         this.Image_02 = ComponentUtil.getDisplayObject("BackImage",this,{
            "x":ChaKanTeam.imgArr[1],
            "y":100,
            "width":153,
            "height":201,
            "alpha":0
         },ComponentUtil.domain);
         this.Image_03 = ComponentUtil.getDisplayObject("BackImage",this,{
            "x":ChaKanTeam.imgArr[2],
            "y":100,
            "width":153,
            "height":201,
            "alpha":0
         },ComponentUtil.domain);
         this.Image_01.name = "back0";
         this.Image_02.name = "back1";
         this.Image_03.name = "back2";
         this.Image_01.addEventListener(MouseEvent.CLICK,this.clickEvent);
         this.Image_02.addEventListener(MouseEvent.CLICK,this.clickEvent);
         this.Image_03.addEventListener(MouseEvent.CLICK,this.clickEvent);
         this.Image_01.addEventListener(MouseEvent.MOUSE_OVER,this.overEvent);
         this.Image_02.addEventListener(MouseEvent.MOUSE_OVER,this.overEvent);
         this.Image_03.addEventListener(MouseEvent.MOUSE_OVER,this.overEvent);
         this.Image_01.addEventListener(MouseEvent.MOUSE_OUT,this.outEvent);
         this.Image_02.addEventListener(MouseEvent.MOUSE_OUT,this.outEvent);
         this.Image_03.addEventListener(MouseEvent.MOUSE_OUT,this.outEvent);
         this.memberImgVec = new Vector.<Bitmap>();
         j = 0;
         while(j < 3)
         {
            bm = new Bitmap();
            addChild(bm);
            bm.x = this["Image_0" + (j + 1)].x;
            bm.y = this["Image_0" + (j + 1)].y;
            this.memberImgVec.push(bm);
            j++;
         }
         this.clickSty = ComponentUtil.getDisplayObject("BackImage_Choose",this,{"visible":false});
         i = 0;
         while(i <= 2)
         {
            teamMember = new TeamMemberMessage();
            teamMember.x = ChaKanTeam.imgArr[i];
            teamMember.y = 300;
            addChild(teamMember);
            Model_team.teamMumbers_data_save[i] = teamMember;
            teamMember.visible = false;
            i++;
         }
         this.petInfoView = new PetInfoPanel();
         addChild(this.petInfoView);
         this.petInfoView.visible = false;
         CloseButton.addEventListener(MouseEvent.CLICK,this.cloHandle);
         this.Button_TuiChu.addEventListener(MouseEvent.CLICK,this.quitHandle);
         this.Button_YaoQing.addEventListener(MouseEvent.CLICK,this.inviHandle);
         this.Button_TiChu.addEventListener(MouseEvent.CLICK,this.kickRoleHandle);
         this.Button_ZhuangYi.addEventListener(MouseEvent.CLICK,this.chanCapHandle);
      }
      
      private function checkBtnVisible() : void
      {
         if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE || SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            this.Button_ZhuangYi.enabled = false;
            this.Button_YaoQing.enabled = false;
            this.Button_GenSui.enabled = false;
         }
         else
         {
            this.Button_ZhuangYi.enabled = true;
            this.Button_YaoQing.enabled = true;
            this.Button_GenSui.enabled = true;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.isFirstOpen)
            {
               Utils.loadTitle("lang/ch/TeamInformatImgs.swf","Title_DWXinXi",new Bitmap(),{
                  "x":187,
                  "y":5
               },this);
            }
            this.isFirstOpen = false;
            bind_target = Enum_explor.bind(Enum_explor.BTN_TEAM);
            this.checkBtnVisible();
         }
      }
      
      private function updataMemberIma() : void
      {
         if(!visible)
         {
            return;
         }
         this.clickSty.visible = false;
         this.kickRoleId = 0;
         var a:Array = Model_team.teamMumberInfo_data_save;
         var b:Array = Model_team.memberIcon;
         var i:int = 0;
         while(i < this.memberImgVec.length)
         {
            if(Boolean(a[i]))
            {
               Utils.getLoadBitmap(Const_strImg.getMemberUrl(a[i][8],b[i][1],8),this.memberImgVec[i]);
            }
            else
            {
               Utils.getLoadBitmap("resource/image/icon/23581.jpg",this.memberImgVec[i]);
            }
            i++;
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
      
      private function outEvent(e:MouseEvent) : void
      {
         if(contains(this.overStyle) && !this._selete)
         {
            removeChild(this.overStyle);
         }
      }
      
      private function overEvent(e:MouseEvent) : void
      {
         this.show_overStyle(e.target as DisplayObject,true);
      }
      
      public function show_overStyle(target:DisplayObject, value:Boolean) : void
      {
         this.overStyle = ComponentUtil.getDisplayObject("BackImage_Choose",null,{
            "x":target.x - 1,
            "y":target.y - 1
         });
         this.overStyle.visible = value;
         addChild(this.overStyle);
      }
      
      protected function registerCheckBoxHandler(event:MouseEvent) : void
      {
         if(this.registerCheckBox.selected)
         {
            TeamCGMessage.CG_REGISTRATION_TEAM(1);
         }
         else
         {
            TeamCGMessage.CG_REGISTRATION_TEAM(0);
         }
      }
      
      private function kickRoleHandle(e:MouseEvent) : void
      {
         if(Boolean(this.kickRoleId) && this.kickRoleId != GameUnitManager.hero.id)
         {
            if(SceneConfig.getSceneType() == SceneConfig.GMD)
            {
               GuangMingDingCGMessage.CG_GMD_LEAVE_FUBEN(2,this.kickRoleId);
            }
            else
            {
               TeamCGMessage.CG_KICK_OUT(this.kickRoleId);
            }
         }
      }
      
      public function chanCapHandle(e:MouseEvent = null) : void
      {
         trace("chanCapHandle");
         if(this.Button_ZhuangYi.label == LangConfig.getWord("10158",1))
         {
            if(Boolean(this._otherRoleId) && this._otherRoleId != GameUnitManager.hero.id)
            {
               TeamCGMessage.CG_CHANGE_CAP(this._otherRoleId);
            }
            else
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10166",1));
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10167",1) + "</font>");
            TeamCGMessage.CG_APPLY_CAP(this._teamId);
         }
      }
      
      public function resetButtonZhuangYi(value:Boolean) : void
      {
         if(value)
         {
            this.Button_ZhuangYi.mouseEnabled = false;
            (this.Button_ZhuangYi as DisplayObject).filters = Util.disabled;
         }
         else
         {
            this.Button_ZhuangYi.mouseEnabled = true;
            (this.Button_ZhuangYi as DisplayObject).filters = [];
         }
      }
      
      private function cloHandle(e:MouseEvent) : void
      {
         if(!pool[this._teamId])
         {
            pool[this._teamId] = [];
         }
         pool[this._teamId].push(TeamListPanel.data[Model_team.team_id]);
         delete TeamListPanel.data[Model_team.team_id];
      }
      
      public function quitHandle(e:MouseEvent = null) : void
      {
         if(Data_lib.map[Global.sceneMap][Enum_map_lib.TYPE] != 3 && Data_lib.map[Global.sceneMap][Enum_map_lib.TYPE] != 5 && SceneConfig.getSceneType() != SceneConfig.KFBZ_BATTLE && SceneConfig.getSceneType() != SceneConfig.CROSS_CAMP_BATTLE)
         {
            if(Global.isInHome)
            {
               this.outTeam();
            }
            else
            {
               View_Alert.show(LangConfig.getWord("10168",1),View_Alert.OK_CANCAL,this.outTeam,null);
            }
         }
         else
         {
            this.outTeam();
         }
      }
      
      private function outTeam() : void
      {
         if(SceneConfig.getSceneType() == SceneConfig.GMD)
         {
            GuangMingDingCGMessage.CG_GMD_LEAVE_FUBEN(2);
            return;
         }
         TeamCGMessage.CG_QUIT_TEAM(1);
         if(UIManager.mainUiBtnContainer.curFuBenType == View_mainUiBtn_container.COMMON)
         {
            SceneCGMessage.CG_LEVEA_FUBEN();
         }
         else if(UIManager.mainUiBtnContainer.curFuBenType == View_mainUiBtn_container.PATA)
         {
            PataCGMessage.CG_LEAVE_TTF();
         }
         else if(UIManager.mainUiBtnContainer.curFuBenType == View_mainUiBtn_container.WANANSI)
         {
            WanAnSiCGMessage.CG_WANANSI_QUIT();
         }
         else if(UIManager.mainUiBtnContainer.curFuBenType == View_mainUiBtn_container.QIJU)
         {
            QiJuCGMessage.CG_EXIT_QIJUGAME(1);
         }
      }
      
      private function inviHandle(e:MouseEvent) : void
      {
         trace("inviHandle");
         if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE || SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            return;
         }
         UIManager.inviteTip.visible = !UIManager.inviteTip.visible;
      }
      
      public function updata(arr:Array) : void
      {
         var tt:* = undefined;
         var zfVO:Vo_ZhenFa = new Vo_ZhenFa(Model_team.currentZhenFa);
         this.ZhenXing_text.text = zfVO.level + LangConfig.getWord("10169",1) + zfVO.name;
         Lever_Mix_text.text = String(Model_team.leastLvlSave);
         Lever_Max_text.text = String(Model_team.biggestLvlSave);
         var i:int = 0;
         while(i <= arr.length - 1)
         {
            if(arr[i][arr[i].length - 1] == GameUnitManager.hero.id)
            {
               if(arr[i][0] == 0)
               {
                  Model_team.isCaptain[arr[i][arr[i].length - 1]];
                  Lever_Mix_text.type = TextFieldType.INPUT;
                  Lever_Max_text.type = TextFieldType.INPUT;
                  Lever_Mix_text.addEventListener(FocusEvent.FOCUS_OUT,changeHandle);
                  Lever_Max_text.addEventListener(FocusEvent.FOCUS_OUT,changeHandle);
                  this.Button_ZhuangYi.label = this.change_apply_cap[0];
                  this.Button_YaoQing.mouseEnabled = true;
                  this.Button_YaoQing.useHandCursor = true;
                  (this.Button_YaoQing as DisplayObject).filters = [];
                  this.Button_ZhenXing.mouseEnabled = true;
                  this.Button_ZhenXing.useHandCursor = true;
                  (this.Button_ZhenXing as DisplayObject).filters = [];
                  this.Button_TiChu.mouseEnabled = true;
                  this.Button_TiChu.useHandCursor = true;
                  (this.Button_TiChu as DisplayObject).filters = [];
                  this.Button_GenSui.mouseEnabled = true;
                  this.Button_GenSui.useHandCursor = true;
                  (this.Button_GenSui as DisplayObject).filters = [];
                  this.Button_GenSui.mouseEnabled = true;
                  this.Button_GenSui.useHandCursor = true;
                  (this.Button_GenSui as DisplayObject).filters = [];
                  this.Button_GenSui.label = LangConfig.getWord("10170",1);
                  this.Button_ZhanLi.mouseEnabled = false;
                  this.Button_ZhanLi.useHandCursor = false;
                  (this.Button_ZhanLi as DisplayObject).filters = Util.disabled;
                  this.Button_GenSui.addEventListener(MouseEvent.CLICK,this.capFollowHandle);
                  this.Button_ZhenXing.addEventListener(MouseEvent.CLICK,this.zhenXingHandle);
                  this.registerCheckBox.visible = true;
                  if(Boolean(Model_team.isRegest))
                  {
                     this.registerCheckBox.selected = true;
                  }
                  else
                  {
                     this.registerCheckBox.selected = false;
                  }
               }
               else
               {
                  Lever_Mix_text.type = TextFieldType.DYNAMIC;
                  Lever_Max_text.type = TextFieldType.DYNAMIC;
                  this.Button_ZhuangYi.label = this.change_apply_cap[1];
                  this.Button_TiChu.mouseEnabled = false;
                  this.Button_TiChu.useHandCursor = false;
                  (this.Button_TiChu as DisplayObject).filters = Util.disabled;
                  this.Button_YaoQing.mouseEnabled = false;
                  this.Button_YaoQing.useHandCursor = false;
                  (this.Button_YaoQing as DisplayObject).filters = Util.disabled;
                  this.Button_ZhenXing.mouseEnabled = false;
                  this.Button_ZhenXing.useHandCursor = false;
                  (this.Button_ZhenXing as DisplayObject).filters = Util.disabled;
                  this.Button_ZhanLi.label = LangConfig.getWord("10163",1);
                  this.Button_ZhanLi.mouseEnabled = false;
                  (this.Button_ZhanLi as DisplayObject).filters = Util.disabled;
                  this.Button_GenSui.label = LangConfig.getWord("10171",1);
                  this.Button_GenSui.mouseEnabled = false;
                  (this.Button_GenSui as DisplayObject).filters = Util.disabled;
                  if(Model_team.isFollow[GameUnitManager.hero.id] == 1)
                  {
                     this.Button_ZhanLi.mouseEnabled = true;
                     (this.Button_ZhanLi as DisplayObject).filters = [];
                  }
                  else if(Model_team.isFollow[GameUnitManager.hero.id] == 0)
                  {
                     this.Button_GenSui.mouseEnabled = true;
                     (this.Button_GenSui as DisplayObject).filters = [];
                  }
                  this.Button_ZhanLi.addEventListener(MouseEvent.CLICK,this.zanliHandle);
                  this.Button_GenSui.addEventListener(MouseEvent.CLICK,this.genSuiHandle);
                  this.registerCheckBox.visible = false;
               }
            }
            i++;
         }
         var j:int = 0;
         while(j <= 2)
         {
            Model_team.teamMumbers_data_save[j].visible = false;
            j++;
         }
         var tempI:int = 0;
         while(tempI <= arr.length - 1)
         {
            tt = arr[tempI][0];
            Model_team.teamMumbers_data_save[tempI].update(arr[tempI]);
            Model_team.teamMumbers_data_save[tempI].visible = true;
            tempI++;
         }
         this.updataMemberIma();
         this.checkBtnVisible();
      }
      
      public function updataCap(arr:Array, newCapId:int, newCapLocation:int, newMenberId:int, newMenberLocation:int) : void
      {
         var tempStr:String = arr[0][1].toString();
         Lever_Mix_text.text = String(this._leastLevel);
         Lever_Max_text.text = String(this._biggestLevel);
         var temI:int = 0;
         while(temI <= arr.length - 1)
         {
            Model_team.isCaptain[arr[temI][arr[temI].length - 1]] = false;
            temI++;
         }
         var i:int = 0;
         while(i <= arr.length - 1)
         {
            if(arr[i][0] == 0)
            {
               Model_team.isCaptain[arr[i][arr[i].length - 1]] = true;
               this.Button_GenSui.mouseEnabled = true;
               this.Button_GenSui.useHandCursor = true;
               (this.Button_GenSui as DisplayObject).filters = [];
               this.Button_ZhuangYi.label = this.change_apply_cap[0];
               this.Button_GenSui.label = LangConfig.getWord("10170",1);
               this.Button_GenSui.addEventListener(MouseEvent.CLICK,this.capFollowHandle);
            }
            else
            {
               this.Button_ZhuangYi.label = this.change_apply_cap[1];
            }
            if(arr[i][arr[i].length - 1] == newCapId)
            {
               arr[i][0] = newCapLocation;
            }
            if(arr[i][arr[i].length - 1] == newMenberId)
            {
               arr[i][0] = newMenberLocation;
            }
            i++;
         }
         var j:int = 0;
         while(j <= arr.length - 1)
         {
            if(arr[j][arr[j].length - 1] == GameUnitManager.hero.id)
            {
               if(arr[j][0] == 0)
               {
                  Model_team.isCaptain[GameUnitManager.hero.id] = true;
                  this.Button_ZhuangYi.label = this.change_apply_cap[0];
                  Lever_Mix_text.type = TextFieldType.INPUT;
                  Lever_Max_text.type = TextFieldType.INPUT;
                  Lever_Mix_text.addEventListener(FocusEvent.FOCUS_OUT,changeHandle);
                  Lever_Max_text.addEventListener(FocusEvent.FOCUS_OUT,changeHandle);
                  this.Button_TiChu.mouseEnabled = true;
                  this.Button_TiChu.useHandCursor = true;
                  (this.Button_TiChu as DisplayObject).filters = [];
                  this.Button_ZhenXing.mouseEnabled = true;
                  this.Button_ZhenXing.useHandCursor = true;
                  (this.Button_ZhenXing as DisplayObject).filters = [];
                  this.Button_YaoQing.mouseEnabled = true;
                  this.Button_YaoQing.useHandCursor = true;
                  (this.Button_YaoQing as DisplayObject).filters = [];
                  this.Button_ZhanLi.mouseEnabled = false;
                  this.Button_ZhanLi.useHandCursor = false;
                  (this.Button_ZhanLi as DisplayObject).filters = Util.disabled;
                  (this.Button_ZhuangYi as DisplayObject).filters = [];
                  this.Button_ZhuangYi.mouseEnabled = true;
                  this.registerCheckBox.visible = true;
                  if(Boolean(Model_team.isRegest))
                  {
                     this.registerCheckBox.selected = true;
                  }
                  else
                  {
                     this.registerCheckBox.selected = false;
                  }
               }
               else
               {
                  this.Button_ZhuangYi.label = this.change_apply_cap[1];
                  Lever_Mix_text.type = TextFieldType.DYNAMIC;
                  Lever_Max_text.type = TextFieldType.DYNAMIC;
                  this.Button_TiChu.mouseEnabled = false;
                  this.Button_TiChu.useHandCursor = false;
                  (this.Button_TiChu as DisplayObject).filters = Util.disabled;
                  this.Button_YaoQing.mouseEnabled = false;
                  this.Button_YaoQing.useHandCursor = false;
                  (this.Button_YaoQing as DisplayObject).filters = Util.disabled;
                  this.Button_ZhenXing.mouseEnabled = false;
                  this.Button_ZhenXing.useHandCursor = false;
                  (this.Button_ZhenXing as DisplayObject).filters = Util.disabled;
                  this.Button_ZhanLi.label = LangConfig.getWord("10163",1);
                  this.Button_ZhanLi.mouseEnabled = false;
                  (this.Button_ZhanLi as DisplayObject).filters = Util.disabled;
                  this.Button_GenSui.label = LangConfig.getWord("10171",1);
                  this.Button_GenSui.mouseEnabled = false;
                  (this.Button_GenSui as DisplayObject).filters = Util.disabled;
                  if(Model_team.isFollow[GameUnitManager.hero.id] == 1)
                  {
                     this.Button_ZhanLi.mouseEnabled = true;
                     (this.Button_ZhanLi as DisplayObject).filters = [];
                  }
                  else if(Model_team.isFollow[GameUnitManager.hero.id] == 0)
                  {
                     this.Button_GenSui.mouseEnabled = true;
                     (this.Button_GenSui as DisplayObject).filters = [];
                  }
                  this.Button_ZhanLi.addEventListener(MouseEvent.CLICK,this.zanliHandle);
                  this.Button_GenSui.addEventListener(MouseEvent.CLICK,this.genSuiHandle);
                  this.Button_ZhenXing.addEventListener(MouseEvent.CLICK,this.zhenXingHandle);
                  this.registerCheckBox.visible = false;
                  this.checkBtnVisible();
               }
            }
            j++;
         }
         var tempI:int = 0;
         while(tempI <= arr.length - 1)
         {
            Model_team.teamMumbers_data_save[tempI].update(arr[tempI]);
            Model_team.teamMumbers_data_save[tempI].visible = true;
            tempI++;
         }
         this.updataMemberIma();
      }
      
      public function zhenXingHandle(e:MouseEvent = null) : void
      {
         UIManager.zhenxing.visible = !UIManager.zhenxing.visible;
         UIManager.zhenxing.updata();
      }
      
      public function capFollowHandle(e:MouseEvent = null) : void
      {
         var j:uint = 0;
         while(j < Model_team.teamMumberInfo_data_save.length)
         {
            if(Model_team.isFollow[Model_team.teamMumberInfo_data_save[j][13]] == 0 && Model_team.teamMumberInfo_data_save[j][13] != GameUnitManager.hero.id)
            {
               TeamCGMessage.CG_CAP_FOLLOW(Model_team.teamMumberInfo_data_save[j][13]);
            }
            j++;
         }
      }
      
      public function genSuiHandle(e:MouseEvent = null) : void
      {
         this.Button_GenSui.mouseEnabled = false;
         this.Button_GenSui.useHandCursor = false;
         this.Button_GenSui.filters = Util.disabled;
         var i:int = 0;
         while(i <= Model_team.teamMumberInfo_data_save.length - 1)
         {
            if(GameUnitManager.hero.id == Model_team.teamMumberInfo_data_save[i][Model_team.teamMumberInfo_data_save[i].length - 1])
            {
               this.Button_ZhanLi.mouseEnabled = true;
               this.Button_ZhanLi.useHandCursor = true;
               this.Button_ZhanLi.filters = [];
            }
            i++;
         }
         TeamCGMessage.CG_FOLLOW_CAP(1,Model_team.team_id);
      }
      
      public function zanliHandle(e:MouseEvent = null) : void
      {
         this.Button_ZhanLi.mouseEnabled = false;
         this.Button_ZhanLi.useHandCursor = false;
         this.Button_ZhanLi.filters = Util.disabled;
         TeamCGMessage.CG_LEAVE_TEAM(0);
         var i:int = 0;
         while(i <= Model_team.teamMumberInfo_data_save.length - 1)
         {
            if(GameUnitManager.hero.id == Model_team.teamMumberInfo_data_save[i][Model_team.teamMumberInfo_data_save[i].length - 1])
            {
               this.Button_GenSui.mouseEnabled = true;
               this.Button_GenSui.useHandCursor = true;
               this.Button_GenSui.filters = [];
            }
            i++;
         }
      }
      
      private function clickEvent(e:MouseEvent) : void
      {
         var tempStr:String = e.target.name.substr(-1,1);
         trace("get back image..",tempStr,Model_team.teamMumberInfo_data_save.length);
         var a:Array = Model_team.teamMumberInfo_data_save;
         if(Boolean(a[int(tempStr)]))
         {
            this.kickRoleId = a[int(tempStr)][13];
            this._otherRoleId = a[int(tempStr)][13];
         }
         trace(this.now_selete);
         var temObj:DisplayObject = e.target as DisplayObject;
         this.clickSty.x = e.target.x - 1;
         this.clickSty.y = e.target.y - 1;
         this.clickSty.visible = true;
         if(Boolean(this.now_selete))
         {
            this.show_overStyle(this.now_selete,false);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

