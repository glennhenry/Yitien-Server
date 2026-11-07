package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.data.vo.Vo_ZhenFa;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.TeamCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.battle.SiWangFuHuoPanel;
   import com.yiTian.view.modules.team.ReceptInviTip;
   import com.yiTian.view.modules.team.TeamListPanel;
   import com.yiTian.view.modules.team.TeamSearchPanel;
   
   public class TeamHandle
   {
      
      private static var tempApplyerId:Number;
      
      public function TeamHandle()
      {
         super();
      }
      
      public static function GC_TEAM(teamsNumber:int, teamId:int, teamName:String, currentRoleNum:int, mostRoleNum:int, zhenFa:int, leastLevel:int, biggestLevel:int) : void
      {
         TeamSearchPanel.showTeamsMessage();
      }
      
      public static function GC_CREATE_TEAM(learndZhenFa:String, teamId:int, zhenFa:int, leastLimitLevel:int, biggestLimitLevel:int, isRegest:int, teamNumbers:int, position:int, captainId:Number, captainIcon:int, captainName:String, job:int, level:int, isFollow:int, isLeave:int, zhenFaPosition:int, petId:Number, petZhenFaPosition:int) : void
      {
         Model_team.teamMumberInfo_data_save = [];
         Model_team.teamMumberInfo_data_save.push([position,zhenFa,leastLimitLevel,biggestLimitLevel,teamNumbers,null,captainIcon,captainName,job,level,zhenFaPosition,petId,petZhenFaPosition,captainId]);
         Model_team.team_id = teamId;
         Model_team.memberIcon = [];
         var a:Array = [];
         a.push(position);
         a.push(isLeave);
         Model_team.memberIcon.push(a);
         UIManager.teamSignTogether.update();
         UIManager.zhenxing.updata();
         UIManager.mainUiBtnContainer.updataLeaveBtn();
         Global.control.sendNotification(Enum_MsgType.TEAM_CHANGE,null);
      }
      
      public static function GC_QUIT_TEAM(teamId:int) : void
      {
         Model_team.team_id = teamId;
         if(Boolean(TeamListPanel.data[Model_team.team_id]))
         {
            TeamListPanel.data[Model_team.team_id].updata(Model_team.teamMumberInfo_data_save);
         }
         UIManager.teamSignTogether.update();
         UIManager.zhenxing.updata();
         UIManager.smallMap.resetTeamMembers();
         UIManager.mainUiBtnContainer.updataLeaveBtn();
         Global.control.sendNotification(Enum_MsgType.TEAM_CHANGE,null);
      }
      
      public static function GC_TEAM_INVITE(teamId:int, myId:Number, teamCaptainName:String, otherRoleId:Number, zone:int = 0) : void
      {
         var i:uint = 0;
         var receInviTip:ReceptInviTip = null;
         if(Boolean(Model_team.save_inviTip[myId]))
         {
            Model_team.save_inviTip[myId].addMessage(teamCaptainName,teamId);
         }
         else
         {
            i = 0;
            while(i < ReceptInviTip.receptTimes.length)
            {
               if(ReceptInviTip.receptTimes[i].tipId == otherRoleId)
               {
                  return;
               }
               i++;
            }
            receInviTip = ReceptInviTip.getTip();
            receInviTip.addMessage(teamCaptainName,teamId,zone);
            receInviTip.countDown(otherRoleId);
            ReceptInviTip.receptTimes.push(receInviTip);
            if(Boolean(ReceptInviTip.receptTimes.length))
            {
               ReceptInviTip.receptTimes[0].visible = true;
            }
         }
         UIManager.mainUiBtnContainer.updataLeaveBtn();
         Global.control.sendNotification(Enum_MsgType.TEAM_CHANGE,null);
      }
      
      public static function GC_TEAM_RECEPT(teamId:int) : void
      {
         Model_team.team_id = teamId;
         if(Boolean(TeamListPanel.data[Model_team.team_id]))
         {
            TeamListPanel.data[Model_team.team_id].updata(Model_team.teamMumberInfo_data_save);
         }
         UIManager.teamSignTogether.update();
         UIManager.zhenxing.updata();
         UIManager.smallMap.resetTeamMembers();
         UIManager.mainUiBtnContainer.updataLeaveBtn();
         Global.control.sendNotification(Enum_MsgType.TEAM_CHANGE,null);
      }
      
      public static function RefuseTeam() : void
      {
         UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10212",1) + "</font>");
      }
      
      public static function GC_APPLY_TEAM(teamId:int) : void
      {
         var teamL:TeamListPanel = null;
         Model_team.team_id = teamId;
         if(Boolean(TeamListPanel.data[teamId]))
         {
            TeamListPanel.data[teamId]._leastLevel = Model_team.teamMumberInfo_data_save[0][2];
            TeamListPanel.data[teamId]._biggestLevel = Model_team.teamMumberInfo_data_save[0][3];
            TeamListPanel.data[teamId].updata(Model_team.teamMumberInfo_data_save);
         }
         else
         {
            teamL = new TeamListPanel();
            TeamListPanel.data[teamId] = teamL;
            teamL.init();
            trace(Model_team.teamMumberInfo_data_save);
            teamL._leastLevel = Model_team.teamMumberInfo_data_save[0][2];
            teamL._biggestLevel = Model_team.teamMumberInfo_data_save[0][3];
            teamL.updata(Model_team.teamMumberInfo_data_save);
         }
         UIManager.teamSignTogether.update();
         UIManager.zhenxing.updata();
         UIManager.smallMap.resetTeamMembers();
         UIManager.mainUiBtnContainer.updataLeaveBtn();
         Global.control.sendNotification(Enum_MsgType.TEAM_CHANGE,null);
      }
      
      public static function GC_CHECK_TEAM(teamNumbers:int, roleIcon:int, roleName:String, job:int, level:int, petId:Number) : void
      {
         UIManager.chaKanTeam.updataMessage(teamNumbers);
         UIManager.chaKanTeam.visible = true;
      }
      
      public static function GC_KICK_OUT(kickRoleId:Number, teamId:int, kickRoleName:String) : void
      {
         var j:uint = 0;
         Model_team.isTeam[kickRoleId] = false;
         var i:int = 0;
         while(i <= Model_team.teamMumberInfo_data_save.length - 1)
         {
            if(Model_team.teamMumberInfo_data_save[i][Model_team.teamMumberInfo_data_save[i].length - 1] == kickRoleId)
            {
               j = 0;
               while(j < Model_team.memberIcon.length)
               {
                  if(Model_team.memberIcon[j][0] == Model_team.teamMumberInfo_data_save[i][0])
                  {
                     Model_team.memberIcon.splice(j,1);
                     break;
                  }
                  j++;
               }
               Model_team.teamMumberInfo_data_save.splice(i,1);
               break;
            }
            i++;
         }
         var l:int = GameUnitManager.hero.id;
         if(kickRoleId == GameUnitManager.hero.id)
         {
            if(Boolean(TeamListPanel.data[teamId]))
            {
               TeamListPanel.data[teamId].visible = false;
            }
            Model_team.teamMumberInfo_data_save = [];
            delete TeamListPanel.data[teamId];
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10213",1) + "</font>");
         }
         else if(!Model_team.isCap())
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + kickRoleName + LangConfig.getWord("10214",1) + "</font>");
         }
         if(Boolean(TeamListPanel.data[teamId]))
         {
            TeamListPanel.data[teamId].updata(Model_team.teamMumberInfo_data_save);
         }
         UIManager.teamSignTogether.update();
         UIManager.zhenxing.updata();
         UIManager.smallMap.resetTeamMembers();
         UIManager.mainUiBtnContainer.updataLeaveBtn();
         Global.control.sendNotification(Enum_MsgType.TEAM_CHANGE,null);
      }
      
      public static function GC_CHANGE_CAP(newCapId:int, newCapLocation:int, newMenberId:int, newMenberLocation:int, teamId:int) : void
      {
         var teamL:TeamListPanel = null;
         if(Boolean(TeamListPanel.data[teamId]))
         {
            TeamListPanel.data[teamId].updataCap(Model_team.teamMumberInfo_data_save,newCapId,newCapLocation,newMenberId,newMenberLocation);
         }
         else
         {
            teamL = new TeamListPanel();
            TeamListPanel.data[teamId] = teamL;
            teamL.init();
            teamL.updataCap(Model_team.teamMumberInfo_data_save,newCapId,newCapLocation,newMenberId,newMenberLocation);
         }
         Model_team.isFollow[newCapId] = 1;
         UIManager.teamSignTogether.update();
         UIManager.zhenxing.updata();
         UIManager.smallMap.resetTeamMembers();
         UIManager.mainUiBtnContainer.updataLeaveBtn();
         Global.control.sendNotification(Enum_MsgType.TEAM_CHANGE,null);
      }
      
      public static function GC_APPLY_CAP(teamId:int, roleId:Number, applyRoleName:String) : void
      {
         UIManager.applyCaptainTip.visible = true;
         UIManager.applyCaptainTip.countDown(teamId,roleId,applyRoleName);
         UIManager.teamSignTogether.update();
         UIManager.zhenxing.updata();
      }
      
      public static function functionOK(roleId:int) : void
      {
         TeamCGMessage.CG_CAP_RETURN(1,tempApplyerId);
      }
      
      public static function functionCANCLE(roleId:int) : void
      {
         TeamCGMessage.CG_CAP_RETURN(0,tempApplyerId);
      }
      
      public static function GC_CAP_RETURN(result:int, newCapId:int, newCapLocation:int, newMenberId:int, newMenberLocation:int, teamId:int) : void
      {
         var teamL:TeamListPanel = null;
         if(result == 1)
         {
            if(Boolean(TeamListPanel.data[teamId]))
            {
               TeamListPanel.data[teamId].updataCap(Model_team.teamMumberInfo_data_save,newCapId,newCapLocation,newMenberId,newMenberLocation);
            }
            else
            {
               teamL = new TeamListPanel();
               TeamListPanel.data[teamId] = teamL;
               teamL.init();
               teamL.updataCap(Model_team.teamMumberInfo_data_save,newCapId,newCapLocation,newMenberId,newMenberLocation);
            }
            Model_team.isFollow[newCapId] = 1;
         }
         else if(result == 2)
         {
         }
         var i:uint = 0;
         while(i < Model_team.teamMumberInfo_data_save.length)
         {
            if(Model_team.teamMumberInfo_data_save[i][13] == newCapId)
            {
               Model_team.teamMumberInfo_data_save[i][0] = newCapLocation;
            }
            if(Model_team.teamMumberInfo_data_save[i][13] == newMenberId)
            {
               Model_team.teamMumberInfo_data_save[i][0] = newMenberLocation;
            }
            i++;
         }
         Model_team.positionSort();
         UIManager.teamSignTogether.update();
         UIManager.zhenxing.updata();
         UIManager.mainUiBtnContainer.updataLeaveBtn();
         Global.control.sendNotification(Enum_MsgType.TEAM_CHANGE,null);
      }
      
      public static function GC_REFUSE_APPLY_CAP(memberId:int) : void
      {
         var tlp:TeamListPanel = TeamListPanel.data[Model_team.team_id];
         if(GameUnitManager.hero.id == memberId)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10215",1) + "</font>");
         }
      }
      
      public static function GC_CHANGE_LEVEL(teamId:int, leastLevel:int, biggestLevel:int) : void
      {
         var teamL:TeamListPanel = null;
         Model_team.leastLvlSave = leastLevel;
         Model_team.biggestLvlSave = biggestLevel;
         if(Boolean(TeamListPanel.data[teamId]))
         {
            TeamListPanel.data[teamId]._leastLevel = leastLevel;
            TeamListPanel.data[teamId]._biggestLevel = biggestLevel;
            TeamListPanel.data[teamId].updata(Model_team.teamMumberInfo_data_save);
         }
         else
         {
            teamL = new TeamListPanel();
            TeamListPanel.data[teamId] = teamL;
            teamL.init();
            teamL._leastLevel = leastLevel;
            teamL._biggestLevel = biggestLevel;
            teamL.visible = true;
            teamL.updata(Model_team.teamMumberInfo_data_save);
         }
         UIManager.teamSignTogether.update();
         UIManager.zhenxing.updata();
      }
      
      public static function GC_CAP_FOLLOW(teamId:int, capName:String) : void
      {
         UIManager.capReqFollowTip.visible = true;
         UIManager.capReqFollowTip.countDown();
      }
      
      public static function capFollowOK() : void
      {
         var tlp:TeamListPanel = TeamListPanel.data[Model_team.team_id];
         if(Boolean(tlp))
         {
            tlp.genSuiHandle();
         }
         else
         {
            TeamCGMessage.CG_FOLLOW_CAP(1,Model_team.team_id);
         }
      }
      
      public static function capFollowCANCLE() : void
      {
         TeamCGMessage.CG_FOLLOW_CAP(0,Model_team.team_id);
      }
      
      public static function GC_CHANGE_ZHENFA(teamId:int, zhenFa:String, zhenxingType:int) : void
      {
         var memberId:Number = NaN;
         var j:uint = 0;
         var zfVO:Vo_ZhenFa = new Vo_ZhenFa(zhenxingType);
         Model_team.currentZhenFa = zfVO.id;
         if(Boolean(TeamListPanel.data[teamId]))
         {
            TeamListPanel.data[teamId].updata(Model_team.teamMumberInfo_data_save);
         }
         var memberArr:Array = zhenFa.split("|");
         var i:uint = 0;
         while(i < Model_team.teamMumberInfo_data_save.length)
         {
            memberId = Number(memberArr[i].split("_")[0]);
            j = 0;
            while(j < Model_team.teamMumberInfo_data_save.length)
            {
               if(memberId == Model_team.teamMumberInfo_data_save[j][13])
               {
                  Model_team.teamMumberInfo_data_save[j][10] = int(memberArr[i].split("_")[1]);
                  Model_team.teamMumberInfo_data_save[j][12] = int(memberArr[i].split("_")[2]);
                  trace(Model_team.teamMumberInfo_data_save[j][10]);
                  trace(Model_team.teamMumberInfo_data_save[j][12]);
               }
               j++;
            }
            i++;
         }
         if(UIManager.zhenxing.visible)
         {
            UIManager.zhenxing.updata();
         }
      }
      
      public static function GC_UPDATA_ZHENFA(result:int, teamId:int, learnZhenFa:String, curZhenFa:int) : void
      {
         Model_team.learnZhenFa = learnZhenFa;
         Model_team.currentZhenFa = curZhenFa;
         if(Boolean(TeamListPanel.data[teamId]))
         {
            TeamListPanel.data[teamId].updata(Model_team.teamMumberInfo_data_save);
         }
         if(UIManager.zhenxing.visible)
         {
            UIManager.zhenxing.updata();
         }
      }
      
      public static function GC_UPDATA_LEVEL(result:int, roleId:Number, level:int) : void
      {
         var a:Array = Model_team.teamMumberInfo_data_save;
         var i:uint = 0;
         while(i < a.length)
         {
            if(a[i][13] == roleId)
            {
               a[i][9] = level;
               break;
            }
            i++;
         }
         if(Boolean(TeamListPanel.data[Model_team.team_id]) && Boolean(TeamListPanel.data[Model_team.team_id].visible))
         {
            TeamListPanel.data[Model_team.team_id].updata(Model_team.teamMumberInfo_data_save);
         }
         UIManager.teamSignTogether.update();
      }
      
      public static function GC_UPDATE_HMBAR(result:int, arr:Array) : void
      {
         var i:uint = 0;
         var a:Array = Model_team.HMPArr;
         if(Boolean(a))
         {
            i = 0;
            while(i < a.length)
            {
               if(a[i][0] == arr[0])
               {
                  a[i][1] = arr[1];
                  a[i][2] = arr[2];
                  a[i][3] = arr[3];
                  a[i][4] = arr[4];
                  UIManager.teamSignTogether.updateHM();
                  if(UIManager.zhenxing.visible)
                  {
                     UIManager.zhenxing.updata();
                  }
                  break;
               }
               i++;
            }
         }
      }
      
      public static function GC_TEAM_PATA(roleId:Number, roleName:String) : void
      {
         UIManager.chatPanel.add("<font color=\'#FF0000\'> " + LangConfig.getWord("10216",1) + "   </font><a href=\'event:" + "role" + "_" + "\'>" + HtmlUtil.underLine(HtmlUtil.font(roleName,"#33CCFF")) + "</a>" + LangConfig.getWord("10217",1) + "<font color=\'#FFFF00\'>【</font><a href=\'event:" + "invi" + "_" + "\'>" + HtmlUtil.underLine(HtmlUtil.font(LangConfig.getWord("10218",1),"#FFFF00")) + "</a><font color=\'#FFFF00\'>】</font>",roleId,101,roleName);
      }
      
      public static function GC_TEAM_SIWANG_FUHUO(result:int) : void
      {
         if(result == 1)
         {
            UIManager.siWangFuHuoPanel.show(SiWangFuHuoPanel.PATA);
         }
         else if(result == 2)
         {
            UIManager.siWangFuHuoPanel.show(SiWangFuHuoPanel.WANANSI);
         }
         else if(result == 3)
         {
            UIManager.siWangFuHuoPanel.show(SiWangFuHuoPanel.QIJU);
         }
         else if(result == 4)
         {
            UIManager.siWangFuHuoPanel.show(SiWangFuHuoPanel.GMD);
         }
      }
   }
}

