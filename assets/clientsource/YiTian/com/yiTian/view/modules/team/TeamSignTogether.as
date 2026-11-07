package com.yiTian.view.modules.team
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.Enum_map_lib;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.GuangMingDingCGMessage;
   import com.yiTian.net.message.cg.PataCGMessage;
   import com.yiTian.net.message.cg.PetCGMessage;
   import com.yiTian.net.message.cg.QiJuCGMessage;
   import com.yiTian.net.message.cg.SceneCGMessage;
   import com.yiTian.net.message.cg.TeamCGMessage;
   import com.yiTian.net.message.cg.WanAnSiCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.mainUIBtnContainer.View_mainUiBtn_container;
   import com.yiTian.view.modules.pet.PetPanel;
   import com.yiTian.view.modules.pet.PetVO;
   import com.yiTian.view.modules.roleHead.PlayerMenu;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class TeamSignTogether extends Panel
   {
      
      private var buttonLeft:Button;
      
      private var buttonMiddle:Button;
      
      private var buttonRight:Button;
      
      private var teamSignArr:Array = [];
      
      public var tlp:TeamListPanel;
      
      private var _otherRoleId:Number;
      
      public var isLeaveFollow:int;
      
      private var isCap:Boolean;
      
      private var _capIsOffline:Boolean;
      
      private var totalTime:int;
      
      private var lastTime:int;
      
      public function TeamSignTogether()
      {
         super();
      }
      
      override protected function initDynamicView() : void
      {
         var teamSign:TeamSign = null;
         bAutoRemove = false;
         this.buttonLeft = ComponentUtil.getButton("","Button_Four",this,{"x":0},Global.Img_Cdm);
         this.buttonMiddle = ComponentUtil.getButton("","Button_Four",this,{"x":80},Global.Img_Cdm);
         this.buttonRight = ComponentUtil.getButton("","Button_Four",this,{"x":160},Global.Img_Cdm);
         this.buttonLeft.addEventListener(MouseEvent.CLICK,this.buttonHandler);
         this.buttonMiddle.addEventListener(MouseEvent.CLICK,this.buttonHandler);
         this.buttonRight.addEventListener(MouseEvent.CLICK,this.buttonHandler);
         var i:int = 0;
         while(i < 3)
         {
            teamSign = new TeamSign();
            teamSign.y = this.buttonLeft.height + 5 + i * (teamSign.height + 5);
            this.teamSignArr.push(teamSign);
            addChild(teamSign);
            teamSign.menuButton.addEventListener(MouseEvent.CLICK,this.signClickHandler);
            i++;
         }
      }
      
      private function signClickHandler(e:MouseEvent) : void
      {
         e.stopPropagation();
         if(this.isCap)
         {
            PlayerMenu.isSpecialCheck = false;
            if(Global.isInHome)
            {
               PlayerMenu.getInstance().show([PlayerMenu.yjdz,PlayerMenu.tcdw],{
                  "id":Model_team.teamMumberInfo_data_save[e.target.parent.index][13],
                  "name":Model_team.teamMumberInfo_data_save[e.target.parent.index][7]
               });
            }
            else
            {
               PlayerMenu.getInstance().show([PlayerMenu.yjdz,PlayerMenu.ckzl,PlayerMenu.fqjy,PlayerMenu.fsyj,PlayerMenu.fzmz,PlayerMenu.jhmd,PlayerMenu.jwhy,PlayerMenu.sl,PlayerMenu.tcdw],{
                  "id":Model_team.teamMumberInfo_data_save[e.target.parent.index][13],
                  "name":Model_team.teamMumberInfo_data_save[e.target.parent.index][7]
               });
            }
         }
         else
         {
            PlayerMenu.isSpecialCheck = false;
            if(!Global.isInHome)
            {
               PlayerMenu.getInstance().show([PlayerMenu.ckzl,PlayerMenu.fqjy,PlayerMenu.fsyj,PlayerMenu.fzmz,PlayerMenu.jhmd,PlayerMenu.jwhy,PlayerMenu.sl],{
                  "id":Model_team.teamMumberInfo_data_save[e.target.parent.index][13],
                  "name":Model_team.teamMumberInfo_data_save[e.target.parent.index][7]
               });
            }
         }
      }
      
      protected function pmRollOutHandler(event:MouseEvent) : void
      {
         event.currentTarget.removeEventListener(MouseEvent.MOUSE_OUT,this.pmRollOutHandler);
         event.currentTarget.visible = false;
      }
      
      private function buttonHandler(e:MouseEvent) : void
      {
         var tempB:Boolean = false;
         var j:uint = 0;
         var button:Button = e.target as Button;
         this.tlp = TeamListPanel.data[Model_team.team_id];
         switch(button.label)
         {
            case LangConfig.getWord("10170",1):
               tempB = false;
               j = 0;
               while(j < Model_team.teamMumberInfo_data_save.length)
               {
                  if(Model_team.isFollow[Model_team.teamMumberInfo_data_save[j][13]] == 0 && Model_team.teamMumberInfo_data_save[j][13] != GameUnitManager.hero.id)
                  {
                     TeamCGMessage.CG_CAP_FOLLOW(Model_team.teamMumberInfo_data_save[j][13]);
                     tempB = true;
                  }
                  j++;
               }
               if(tempB)
               {
                  this.btnCountDown(10);
                  UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10175",1) + "</font>");
                  break;
               }
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10176",1) + "</font>");
               break;
            case LangConfig.getWord("10177",1):
               if(this.isCap)
               {
                  UIManager.zhenxing.visible = !UIManager.zhenxing.visible;
               }
               if(UIManager.zhenxing.visible)
               {
                  UIManager.zhenxing.updata();
               }
               break;
            case LangConfig.getWord("10164",1):
               if(Data_lib.map[Global.sceneMap][Enum_map_lib.TYPE] != 3 && Data_lib.map[Global.sceneMap][Enum_map_lib.TYPE] != 5 && SceneConfig.getSceneType() != SceneConfig.KFBZ_BATTLE && SceneConfig.getSceneType() != SceneConfig.CROSS_CAMP_BATTLE)
               {
                  if(Global.isInHome)
                  {
                     this.outTeam();
                     break;
                  }
                  View_Alert.show(LangConfig.getWord("10168",1),View_Alert.OK_CANCAL,this.outTeam,null);
                  break;
               }
               this.outTeam();
               break;
            case LangConfig.getWord("10159",1):
               if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE)
               {
                  UIManager.centerBroadcast.addMsg("跨服帮会战中不能申请队长");
                  return;
               }
               if(SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
               {
                  UIManager.centerBroadcast.addMsg("皇城争霸战中不能申请队长");
                  return;
               }
               if(this._capIsOffline)
               {
                  TeamCGMessage.CG_CAP_RETURN(1,GameUnitManager.hero.id);
                  break;
               }
               TeamCGMessage.CG_APPLY_CAP(0);
               this.btnCountDown(30);
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10167",1) + "</font>");
               break;
            case LangConfig.getWord("10178",1):
               if(Boolean(this.tlp))
               {
                  this.tlp.genSuiHandle();
                  break;
               }
               TeamCGMessage.CG_FOLLOW_CAP(1,Model_team.team_id);
               break;
            case LangConfig.getWord("10179",1):
               if(Boolean(this.tlp))
               {
                  this.tlp.zanliHandle();
                  break;
               }
               TeamCGMessage.CG_LEAVE_TEAM(0);
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
            if(SceneConfig.getSceneType() != SceneConfig.HOME)
            {
               SceneCGMessage.CG_LEVEA_FUBEN();
            }
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
      
      private function showList() : void
      {
         var i:uint = 0;
         var temp:TeamSign = null;
         var index:int = 0;
         i = 0;
         while(i < 3)
         {
            temp = this.teamSignArr[index];
            this.teamSignArr[i].visible = false;
            if(i < Model_team.teamMumberInfo_data_save.length)
            {
               if(Model_team.teamMumberInfo_data_save[i][13] != GameUnitManager.hero.id)
               {
                  this.isLeaveFollow = Model_team.isFollow[Model_team.teamMumberInfo_data_save[i][13]];
                  temp.visible = true;
                  temp.index = i;
                  temp.dataArr = Model_team.teamMumberInfo_data_save[i];
                  temp.myName = Model_team.teamMumberInfo_data_save[i][7];
                  temp.levelTxt = Model_team.teamMumberInfo_data_save[i][9].toString();
                  temp.playerHead = "resource/image/icon/23" + Enum_job.getBaseJob(Model_team.teamMumberInfo_data_save[i][8]) + "1" + Model_team.memberIcon[i][1] + ".png";
                  temp.showLeaderHead = false;
                  temp.showLeaveHead = false;
                  temp.greyPlayerHead = false;
                  temp.greyLeaderHead = false;
                  if(Model_team.teamMumberInfo_data_save[i][0] == 0)
                  {
                     temp.showLeaderHead = true;
                  }
                  if(this.isLeaveFollow == 1)
                  {
                     temp.showLeaveHead = false;
                  }
                  else if(this.isLeaveFollow == 0)
                  {
                     temp.showLeaveHead = true;
                  }
                  else if(this.isLeaveFollow == -1)
                  {
                     temp.greyPlayerHead = true;
                     temp.greyLeaderHead = true;
                  }
                  if(Model_team.teamMumberInfo_data_save[i][11] > 0)
                  {
                     temp.showPetHead = true;
                     if(Global.pf == "qqgame")
                     {
                        if(Model_team.teamMumberInfo_data_save[i][6] == 20906)
                        {
                           Model_team.teamMumberInfo_data_save[i][6] = 20907;
                        }
                     }
                     temp.petHead = "resource/image/icon/" + Model_team.teamMumberInfo_data_save[i][6] + "_34.jpg";
                  }
                  else
                  {
                     temp.showPetHead = false;
                  }
                  index++;
               }
            }
            i++;
         }
         this.updateHM();
      }
      
      public function update() : void
      {
         var i:uint = 0;
         this.isCap = false;
         this._capIsOffline = false;
         this.buttonLeft.mouseEnabled = true;
         (this.buttonLeft as DisplayObject).filters = [];
         if(GameScene.instance.hasFrameCallBack(this.countDown))
         {
            GameScene.instance.removeFrameCallBack(this.countDown);
         }
         if(Boolean(Model_team.isTeam[GameUnitManager.hero.id]))
         {
            UIManager.teamSignTogether.visible = true;
            i = 0;
            while(i < Model_team.teamMumberInfo_data_save.length)
            {
               if(Model_team.teamMumberInfo_data_save[i][13] == GameUnitManager.hero.id && Model_team.teamMumberInfo_data_save[i][0] == 0)
               {
                  this.isCap = true;
               }
               if(Model_team.teamMumberInfo_data_save[i][0] == 0 && Model_team.isFollow[Model_team.teamMumberInfo_data_save[i][13]] == -1)
               {
                  this._capIsOffline = true;
               }
               i++;
            }
            if(this.isCap)
            {
               this.showList();
               this.buttonLeft.label = LangConfig.getWord("10170",1);
               this.buttonMiddle.label = LangConfig.getWord("10177",1);
               this.buttonRight.label = LangConfig.getWord("10164",1);
            }
            else
            {
               this.buttonLeft.label = LangConfig.getWord("10159",1);
               if(Model_team.isFollow[GameUnitManager.hero.id] == 1)
               {
                  this.buttonMiddle.label = LangConfig.getWord("10179",1);
               }
               else
               {
                  this.buttonMiddle.label = LangConfig.getWord("10178",1);
               }
               this.buttonRight.label = LangConfig.getWord("10164",1);
               this.showList();
            }
         }
         else
         {
            UIManager.teamSignTogether.visible = false;
         }
      }
      
      public function updateHM() : void
      {
         var arr:Array = null;
         var i:uint = 0;
         if(Model_team.teamMumberInfo_data_save.length > 1)
         {
            arr = Model_team.HMPArr.filter(function(item:Array, index:int, arr:Array):Boolean
            {
               if(item[0] != GameUnitManager.hero.id)
               {
                  return true;
               }
               return false;
            });
            i = 0;
            while(i < arr.length)
            {
               this.teamSignArr.forEach(function(item:TeamSign, index:int, a:Array):void
               {
                  if(item.visible && Boolean(item.dataArr))
                  {
                     if(arr[i][0] == item.dataArr[13])
                     {
                        item.updateHM(arr[i]);
                     }
                  }
               });
               i++;
            }
         }
      }
      
      public function btnCountDown(second:int) : void
      {
         this.totalTime = second;
         this.lastTime = getTimer();
         this.buttonLeft.mouseEnabled = false;
         (this.buttonLeft as DisplayObject).filters = Util.disabled;
         GameScene.instance.addFrameCallBack(this.countDown);
      }
      
      private function countDown(interval:int) : void
      {
         var now:int = getTimer();
         this.buttonLeft.label = (this.totalTime - Math.ceil((now - this.lastTime) / 1000)).toString();
         if(this.totalTime - Math.ceil((now - this.lastTime) / 1000) <= 0)
         {
            this.update();
         }
      }
      
      public function requestPetInfo(teamSign:TeamSign) : void
      {
         var memberData:Array = Model_team.teamMumberInfo_data_save[teamSign.index];
         PetCGMessage.CG_PET_OTHER_INFO(memberData[11]);
      }
      
      public function petInfoVisible(value:Boolean, teamSign:TeamSign) : void
      {
         PetPanel.curPanel = this;
         UIManager.petInfoPanel.visible = value;
         UIManager.petInfoPanel.x = 200;
         UIManager.petInfoPanel.y = Global.stage.mouseY;
      }
      
      public function showPetInfoView(petVO:PetVO) : void
      {
         UIManager.petInfoPanel.petVO = petVO;
         UIManager.petInfoPanel.update();
      }
      
      override public function resetPosition() : void
      {
         x = 0;
         y = 108;
      }
   }
}

