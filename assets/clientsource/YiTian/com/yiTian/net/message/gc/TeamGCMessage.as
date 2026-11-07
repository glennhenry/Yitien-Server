package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.model.Model_jingJiChang;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.TeamHandle;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.net.message.cg.KLMountianCGMessage;
   import com.yiTian.net.message.cg.TeamCGMessage;
   import com.yiTian.view.modules.team.ChaKanTeam;
   import com.yiTian.view.modules.team.TeamListPanel;
   import flash.utils.IDataInput;
   
   public class TeamGCMessage
   {
      
      public function TeamGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_TEAM] = this.GC_TEAM;
         index[MessageType.GC_CREATE_TEAM] = this.GC_CREATE_TEAM;
         index[MessageType.GC_QUIT_TEAM] = this.GC_QUIT_TEAM;
         index[MessageType.GC_TEAM_INVITE] = this.GC_TEAM_INVITE;
         index[MessageType.GC_TEAM_RECEPT] = this.GC_TEAM_RECEPT;
         index[MessageType.GC_APPLY_TEAM] = this.GC_APPLY_TEAM;
         index[MessageType.GC_CHECK_TEAM] = this.GC_CHECK_TEAM;
         index[MessageType.GC_KICK_OUT] = this.GC_KICK_OUT;
         index[MessageType.GC_CHANGE_CAP] = this.GC_CHANGE_CAP;
         index[MessageType.GC_APPLY_CAP] = this.GC_APPLY_CAP;
         index[MessageType.GC_CAP_RETURN] = this.GC_CAP_RETURN;
         index[MessageType.GC_CHANGE_LEVEL] = this.GC_CHANGE_LEVEL;
         index[MessageType.GC_CAP_FOLLOW] = this.GC_CAP_FOLLOW;
         index[MessageType.GC_CHANGE_ZHENFA] = this.GC_CHANGE_ZHENFA;
         index[MessageType.GC_LEAVE_TEAM] = this.GC_LEAVE_TEAM;
         index[MessageType.GC_FOLLOW_CAP] = this.GC_FOLLOW_CAP;
         index[MessageType.GC_DIRECT_TEAM] = this.GC_DIRECT_TEAM;
         index[MessageType.GC_DIRECT_TEAM_STATE] = this.GC_DIRECT_TEAM_STATE;
         index[MessageType.GC_REGISTRATION_TEAM] = GC_REGISTRATION_TEAM;
         index[MessageType.GC_UPDATE_HMBAR] = GC_UPDATE_HMBAR;
         index[MessageType.GC_PET_BIANSHENKA] = GC_PET_BIANSHENKA;
         index[MessageType.GC_OFFLINE_AWAY] = GC_OFFLINE_AWAY;
         index[MessageType.GC_UPDATA_ZHENFA] = GC_UPDATA_ZHENFA;
         index[MessageType.GC_UPDATA_LEVEL] = GC_UPDATA_LEVEL;
         index[MessageType.GC_TEAM_PATA] = GC_TEAM_PATA;
         index[MessageType.GC_TEAM_SIWANG_FUHUO] = GC_TEAM_SIWANG_FUHUO;
         index[MessageType.GC_GETPOS] = GC_GETPOS;
      }
      
      public static function GC_REGISTRATION_TEAM(patch:IDataInput) : void
      {
         var reslt:int = patch.readByte();
         var isRegest:int = patch.readByte();
         Model_team.isRegest = isRegest;
      }
      
      public static function GC_UPDATE_HMBAR(patch:IDataInput) : void
      {
         var reslt:int = patch.readByte();
         var arr:Array = [];
         arr.push(LongUtil.readLong(patch));
         arr.push(patch.readInt());
         arr.push(patch.readInt());
         arr.push(patch.readInt());
         arr.push(patch.readInt());
         TeamHandle.GC_UPDATE_HMBAR(reslt,arr);
      }
      
      public static function GC_PET_BIANSHENKA(patch:IDataInput) : void
      {
         var usedRoleId:Number = NaN;
         var petIma:int = 0;
         var petId:Number = NaN;
         var arr:Array = null;
         var i:uint = 0;
         var p:Array = null;
         var isHave:Boolean = false;
         var a:Array = null;
         var result:int = patch.readByte();
         if(result == 1)
         {
            usedRoleId = LongUtil.readLong(patch);
            petIma = patch.readInt();
            petId = LongUtil.readLong(patch);
            arr = Model_team.teamMumberInfo_data_save;
            i = 0;
            while(i < arr.length)
            {
               if(arr[i][13] == usedRoleId)
               {
                  arr[i][6] = petIma;
                  arr[i][11] = petId;
                  break;
               }
               i++;
            }
            isHave = false;
            a = Model_team.petInfoArr;
            i = 0;
            while(i < a.length)
            {
               if(petId == a[i][0])
               {
                  isHave = true;
                  break;
               }
               i++;
            }
            if(isHave)
            {
               Model_team.petInfoArr[i][1] = patch.readUTF();
               Model_team.petInfoArr[i][2] = patch.readShort();
               Model_team.petInfoArr[i][3] = patch.readInt();
               Model_team.petInfoArr[i][4] = patch.readInt();
            }
            else
            {
               p = [];
               p.push(petId);
               p.push(patch.readUTF());
               p.push(patch.readShort());
               p.push(patch.readInt());
               p.push(patch.readInt());
               Model_team.petInfoArr.push(p);
            }
            if(Boolean(TeamListPanel.data[Model_team.team_id]) && Boolean(TeamListPanel.data[Model_team.team_id].visible))
            {
               TeamListPanel.data[Model_team.team_id].updata(Model_team.teamMumberInfo_data_save);
            }
            UIManager.teamSignTogether.update();
         }
      }
      
      public static function GC_OFFLINE_AWAY(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == -1)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10206",1) + "</font>");
         }
         else if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10207",1) + "</font>");
         }
      }
      
      public static function GC_UPDATA_ZHENFA(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var teamId:int = patch.readInt();
         var learnZhenFa:String = patch.readUTF();
         var curZhenFa:int = patch.readInt();
         TeamHandle.GC_UPDATA_ZHENFA(result,teamId,learnZhenFa,curZhenFa);
      }
      
      public static function GC_UPDATA_LEVEL(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var roleId:Number = LongUtil.readLong(patch);
         var level:int = patch.readInt();
         TeamHandle.GC_UPDATA_LEVEL(result,roleId,level);
      }
      
      public static function GC_TEAM_PATA(patch:IDataInput) : void
      {
         var roleId:Number = LongUtil.readLong(patch);
         var roleName:String = patch.readUTF();
         roleName = Model_heFu.repNameByHero(roleName);
         TeamHandle.GC_TEAM_PATA(roleId,roleName);
      }
      
      public static function GC_TEAM_SIWANG_FUHUO(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         TeamHandle.GC_TEAM_SIWANG_FUHUO(result);
      }
      
      public static function GC_GETPOS(patch:IDataInput) : void
      {
         Model_jingJiChang.heropos = patch.readInt();
         Model_jingJiChang.petpos = patch.readInt();
      }
      
      public function GC_TEAM(patch:IDataInput) : void
      {
         var i:int = 0;
         var teamId:int = 0;
         var teamName:String = null;
         var currentRoleNum:int = 0;
         var mostRoleNum:int = 0;
         var zhenFa:int = 0;
         var leastLevel:int = 0;
         var biggestLevel:int = 0;
         var captainId:Number = NaN;
         var captainJob:int = 0;
         Model_team.team_data_save = [];
         var result_succ:int = patch.readByte();
         var curentPage:int = patch.readInt();
         UIManager.teamSearchPanel.curentPage = curentPage;
         var totalPage:int = patch.readInt();
         UIManager.teamSearchPanel.totalPage = totalPage;
         var teamsNumber:int = patch.readByte();
         if(teamsNumber > 0)
         {
            i = 0;
            while(i <= teamsNumber - 1)
            {
               teamId = patch.readInt();
               teamName = patch.readUTF();
               currentRoleNum = patch.readByte();
               mostRoleNum = patch.readByte();
               zhenFa = patch.readInt();
               leastLevel = patch.readShort();
               biggestLevel = patch.readShort();
               captainId = LongUtil.readLong(patch);
               captainJob = patch.readByte();
               Model_team.team_data_save.push([teamId,teamName,currentRoleNum,mostRoleNum,zhenFa,leastLevel,biggestLevel,captainId,captainJob]);
               i++;
            }
         }
         TeamHandle.GC_TEAM(teamsNumber,teamId,teamName,currentRoleNum,mostRoleNum,zhenFa,leastLevel,biggestLevel);
      }
      
      public function GC_CREATE_TEAM(patch:IDataInput) : void
      {
         var p:Array = null;
         var successed:int = patch.readByte();
         var teamId:int = patch.readInt();
         var zhenFa:int = patch.readInt();
         Model_team.currentZhenFa = zhenFa;
         var leastLimitLevel:int = patch.readShort();
         var biggestLimitLevel:int = patch.readShort();
         var isRegest:int = patch.readByte();
         var learndZhenFa:String = patch.readUTF();
         var teamNumbers:int = patch.readByte();
         var position:int = patch.readByte();
         var captainId:Number = LongUtil.readLong(patch);
         var captainIcon:int = patch.readInt();
         var captainName:String = Model_heFu.repNameByHero(patch.readUTF());
         var job:int = patch.readByte();
         var level:int = patch.readShort();
         var isFollow:int = patch.readByte();
         var isLeave:int = patch.readByte();
         var zhenFaPosition:int = patch.readByte();
         var petId:Number = LongUtil.readLong(patch);
         var petZhenFaPosition:int = patch.readByte();
         Model_team.petInfoArr = [];
         if(petId > 0)
         {
            p = [];
            p.push(petId);
            p.push(patch.readUTF());
            p.push(patch.readShort());
            p.push(patch.readInt());
            p.push(patch.readInt());
            Model_team.petInfoArr.push(p);
         }
         Model_team.isRegest = isRegest;
         Model_team.isTeam[captainId] = true;
         Model_team.isCaptain[captainId] = true;
         Model_team.isFollow[captainId] = isFollow;
         Model_team.learnZhenFa = learndZhenFa;
         Model_team.leastLvlSave = leastLimitLevel;
         Model_team.biggestLvlSave = biggestLimitLevel;
         TeamHandle.GC_CREATE_TEAM(learndZhenFa,teamId,zhenFa,leastLimitLevel,biggestLimitLevel,isRegest,teamNumbers,position,captainId,captainIcon,captainName,job,level,isFollow,isLeave,zhenFaPosition,petId,petZhenFaPosition);
      }
      
      public function GC_QUIT_TEAM(patch:IDataInput) : void
      {
         var arr:Array = null;
         var position:int = 0;
         var roleId:Number = NaN;
         var roleIcon:int = 0;
         var roleName:String = null;
         var job:int = 0;
         var level:int = 0;
         var isFollow:int = 0;
         var isLeave:int = 0;
         var zhenFaPosition:int = 0;
         var petId:Number = NaN;
         var petZhenFaPosition:int = 0;
         var a:Array = null;
         var p:Array = null;
         Model_team.teamMumberInfo_data_save = [];
         var successed:int = patch.readByte();
         var type:int = patch.readByte();
         var quitRoleId:Number = LongUtil.readLong(patch);
         var quitRoleName:String = Model_heFu.repNameByHero(patch.readUTF());
         if(quitRoleId == GameUnitManager.hero.id)
         {
            Model_team.isTeam[GameUnitManager.hero.id] = false;
            Model_team.isCaptain[GameUnitManager.hero.id] = false;
            if(Boolean(TeamListPanel.data[Model_team.team_id]))
            {
               TeamListPanel.data[Model_team.team_id].visible = false;
               delete TeamListPanel.data[Model_team.team_id];
            }
            if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE)
            {
               UIManager.mainUiBtnContainer.updataLeaveBtn();
            }
            if(UIManager.zhenxing.visible)
            {
               UIManager.zhenxing.visible = false;
            }
            if(UIManager.teamSignTogether.visible)
            {
               UIManager.teamSignTogether.visible = false;
            }
            UIManager.smallMap.resetTeamMembers();
            switch(type)
            {
               case 3:
                  KLMountianCGMessage.CG_ENTER_KL_MOUNTIAN();
            }
            return;
         }
         UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + quitRoleName + LangConfig.getWord("10182",1) + "</font>");
         var teamId:int = patch.readInt();
         var zhenFa:int = patch.readInt();
         Model_team.currentZhenFa = zhenFa;
         var leastLimitLevel:int = patch.readShort();
         Model_team.leastLvlSave = leastLimitLevel;
         var biggestLimitLevel:int = patch.readShort();
         Model_team.biggestLvlSave = biggestLimitLevel;
         var isRegest:int = patch.readByte();
         Model_team.isRegest = isRegest;
         var learndZhenFa:String = patch.readUTF();
         var teamNumbers:int = patch.readByte();
         Model_team.HMPArr = [];
         Model_team.memberIcon = [];
         Model_team.petInfoArr = [];
         var i:int = 0;
         while(i <= teamNumbers - 1)
         {
            position = patch.readByte();
            roleId = LongUtil.readLong(patch);
            roleIcon = patch.readInt();
            roleName = Model_heFu.repNameByHero(patch.readUTF());
            job = patch.readByte();
            level = patch.readShort();
            isFollow = patch.readByte();
            isLeave = patch.readByte();
            zhenFaPosition = patch.readByte();
            petId = LongUtil.readLong(patch);
            petZhenFaPosition = patch.readByte();
            arr = [];
            arr.push(roleId);
            arr.push(patch.readInt());
            arr.push(patch.readInt());
            arr.push(patch.readInt());
            arr.push(patch.readInt());
            Model_team.HMPArr.push(arr);
            Model_team.teamMumberInfo_data_save.push([position,zhenFa,leastLimitLevel,biggestLimitLevel,teamNumbers,null,roleIcon,roleName,job,level,zhenFaPosition,petId,petZhenFaPosition,roleId]);
            a = [];
            a.push(position);
            a.push(isLeave);
            Model_team.memberIcon.push(a);
            Model_team.isFollow[roleId] = isFollow;
            if(petId > 0)
            {
               p = [];
               p.push(petId);
               p.push(patch.readUTF());
               p.push(patch.readShort());
               p.push(patch.readInt());
               p.push(patch.readInt());
               Model_team.petInfoArr.push(p);
            }
            i++;
         }
         Model_team.learnZhenFa = learndZhenFa;
         TeamHandle.GC_QUIT_TEAM(teamId);
      }
      
      public function GC_TEAM_INVITE(patch:IDataInput) : void
      {
         var teamId:int = 0;
         var myId:Number = NaN;
         var captainName:String = null;
         var otherRoleId:Number = NaN;
         var zone:int = 0;
         var result:int = patch.readByte();
         trace("result:",result);
         if(result > 0)
         {
            teamId = patch.readInt();
            myId = LongUtil.readLong(patch);
            captainName = Model_heFu.repNameByHero(patch.readUTF());
            otherRoleId = LongUtil.readLong(patch);
            zone = 0;
            if(Global.isInHome)
            {
               zone = patch.readInt();
            }
            TeamHandle.GC_TEAM_INVITE(teamId,myId,captainName,otherRoleId,zone);
         }
         else if(result == -3)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10183",1) + "</font>");
         }
         else if(result == -5)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10184",1) + "</font>");
            Model_team.isTeam[GameUnitManager.hero.id] = false;
         }
         else if(result == -4)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10185",1) + "</font>");
            Model_team.isTeam[GameUnitManager.hero.id] = false;
         }
         else if(result == -6)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10186",1) + "</font>");
            Model_team.isTeam[GameUnitManager.hero.id] = false;
         }
      }
      
      public function GC_TEAM_RECEPT(patch:IDataInput) : void
      {
         var arr:Array = null;
         var position:int = 0;
         var roleId:Number = NaN;
         var roleIcon:int = 0;
         var roleName:String = null;
         var job:int = 0;
         var level:int = 0;
         var isFollow:int = 0;
         var isLeave:int = 0;
         var zhenFaPosition:int = 0;
         var petId:Number = NaN;
         var petZhenFaPosition:int = 0;
         var a:Array = null;
         var p:Array = null;
         var successed:int = patch.readByte();
         if(successed == -3)
         {
            TeamHandle.RefuseTeam();
            return;
         }
         Model_team.teamMumberInfo_data_save = [];
         var teamId:int = patch.readInt();
         var zhenFa:int = patch.readInt();
         Model_team.currentZhenFa = zhenFa;
         Model_team.currentZhenFa = zhenFa;
         var leastLimitLevel:int = patch.readShort();
         Model_team.leastLvlSave = leastLimitLevel;
         var biggestLimitLevel:int = patch.readShort();
         Model_team.biggestLvlSave = biggestLimitLevel;
         var isRegest:int = patch.readByte();
         Model_team.isRegest = isRegest;
         var learndZhenFa:String = patch.readUTF();
         var teamNumbers:int = patch.readByte();
         Model_team.HMPArr = [];
         Model_team.memberIcon = [];
         Model_team.petInfoArr = [];
         var i:int = 0;
         while(i <= teamNumbers - 1)
         {
            position = patch.readByte();
            roleId = LongUtil.readLong(patch);
            roleIcon = patch.readInt();
            roleName = Model_heFu.repNameByHero(patch.readUTF());
            job = patch.readByte();
            level = patch.readShort();
            isFollow = patch.readByte();
            isLeave = patch.readByte();
            zhenFaPosition = patch.readByte();
            petId = LongUtil.readLong(patch);
            petZhenFaPosition = patch.readByte();
            arr = [];
            arr.push(roleId);
            arr.push(patch.readInt());
            arr.push(patch.readInt());
            arr.push(patch.readInt());
            arr.push(patch.readInt());
            Model_team.HMPArr.push(arr);
            Model_team.isTeam[roleId] = true;
            Model_team.isFollow[roleId] = isFollow;
            Model_team.teamMumberInfo_data_save.push([position,zhenFa,leastLimitLevel,biggestLimitLevel,teamNumbers,null,roleIcon,roleName,job,level,zhenFaPosition,petId,petZhenFaPosition,roleId]);
            a = [];
            a.push(position);
            a.push(isLeave);
            Model_team.memberIcon.push(a);
            if(petId > 0)
            {
               p = [];
               p.push(petId);
               p.push(patch.readUTF());
               p.push(patch.readShort());
               p.push(patch.readInt());
               p.push(patch.readInt());
               Model_team.petInfoArr.push(p);
            }
            i++;
         }
         Model_team.learnZhenFa = learndZhenFa;
         Model_team.positionSort();
         TeamHandle.GC_TEAM_RECEPT(teamId);
      }
      
      public function GC_APPLY_TEAM(patch:IDataInput) : void
      {
         var teamId:int = 0;
         var zhenFa:int = 0;
         var leastLimitLevel:int = 0;
         var biggestLimitLevel:int = 0;
         var isRegest:int = 0;
         var learndZhenFa:String = null;
         var teamNumbers:int = 0;
         var arr:Array = null;
         var i:int = 0;
         var position:int = 0;
         var roleId:Number = NaN;
         var roleIcon:int = 0;
         var roleName:String = null;
         var job:int = 0;
         var level:int = 0;
         var isFollow:int = 0;
         var isLeave:int = 0;
         var zhenFaPosition:int = 0;
         var petId:Number = NaN;
         var petZhenFaPosition:int = 0;
         var a:Array = null;
         var p:Array = null;
         var successed:int = patch.readByte();
         Model_team.teamMumberInfo_data_save = [];
         if(successed > 0)
         {
            Model_team.isTeam[GameUnitManager.hero.id] = true;
            UIManager.teamSearchPanel.visible = false;
            teamId = patch.readInt();
            zhenFa = patch.readInt();
            Model_team.currentZhenFa = zhenFa;
            leastLimitLevel = patch.readShort();
            Model_team.leastLvlSave = leastLimitLevel;
            biggestLimitLevel = patch.readShort();
            Model_team.biggestLvlSave = biggestLimitLevel;
            isRegest = patch.readByte();
            Model_team.isRegest = isRegest;
            learndZhenFa = patch.readUTF();
            teamNumbers = patch.readByte();
            Model_team.HMPArr = [];
            Model_team.memberIcon = [];
            Model_team.petInfoArr = [];
            i = 0;
            while(i <= teamNumbers - 1)
            {
               position = patch.readByte();
               roleId = LongUtil.readLong(patch);
               roleIcon = patch.readInt();
               roleName = Model_heFu.repNameByHero(patch.readUTF());
               job = patch.readByte();
               level = patch.readShort();
               isFollow = patch.readByte();
               isLeave = patch.readByte();
               zhenFaPosition = patch.readByte();
               petId = LongUtil.readLong(patch);
               petZhenFaPosition = patch.readByte();
               arr = [];
               arr.push(roleId);
               arr.push(patch.readInt());
               arr.push(patch.readInt());
               arr.push(patch.readInt());
               arr.push(patch.readInt());
               Model_team.HMPArr.push(arr);
               Model_team.isFollow[roleId] = isFollow;
               Model_team.teamMumberInfo_data_save.push([position,zhenFa,leastLimitLevel,biggestLimitLevel,teamNumbers,null,roleIcon,roleName,job,level,zhenFaPosition,petId,petZhenFaPosition,roleId]);
               a = [];
               a.push(position);
               a.push(isLeave);
               Model_team.memberIcon.push(a);
               if(petId > 0)
               {
                  p = [];
                  p.push(petId);
                  p.push(patch.readUTF());
                  p.push(patch.readShort());
                  p.push(patch.readInt());
                  p.push(patch.readInt());
                  Model_team.petInfoArr.push(p);
               }
               i++;
            }
            Model_team.learnZhenFa = learndZhenFa;
            Model_team.positionSort();
            TeamHandle.GC_APPLY_TEAM(teamId);
         }
         else if(successed == -4)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10187",1) + "</font>");
            Model_team.isTeam[GameUnitManager.hero.id] = false;
         }
         else if(successed == -6)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10186",1) + "</font>");
            Model_team.isTeam[GameUnitManager.hero.id] = false;
         }
         else if(successed == -2)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10188",1) + "</font>");
            Model_team.isTeam[GameUnitManager.hero.id] = false;
         }
         else if(successed == -7)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10189",1) + "</font>");
            Model_team.isTeam[GameUnitManager.hero.id] = false;
         }
         else if(successed == -8)
         {
            Model_team.isTeam[GameUnitManager.hero.id] = false;
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10190",1) + "</font>");
         }
         else if(successed == -9)
         {
            Model_team.isTeam[GameUnitManager.hero.id] = false;
            UIManager.centerBroadcast.addMsg("双方只能在帮会基地里进行组队");
         }
      }
      
      public function GC_CHECK_TEAM(patch:IDataInput) : void
      {
         var teamNumbers:int = 0;
         var i:int = 0;
         var roleIcon:int = 0;
         var roleName:String = null;
         var job:int = 0;
         var level:int = 0;
         var petId:Number = NaN;
         ChaKanTeam.checkTeam_save = [];
         var successed:int = patch.readByte();
         if(successed == 1)
         {
            teamNumbers = patch.readByte();
            i = 0;
            while(i <= teamNumbers - 1)
            {
               roleIcon = patch.readInt();
               roleName = Model_heFu.repNameByHero(patch.readUTF());
               job = patch.readInt();
               level = patch.readShort();
               petId = LongUtil.readLong(patch);
               ChaKanTeam.checkTeam_save.push([null,null,null,null,null,null,roleIcon,roleName,job,level,petId]);
               i++;
            }
            TeamHandle.GC_CHECK_TEAM(teamNumbers,roleIcon,roleName,job,level,petId);
         }
         else if(successed == -1)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10191",1) + "</font>");
         }
      }
      
      public function GC_KICK_OUT(patch:IDataInput) : void
      {
         var kickRoleId:Number = NaN;
         var teamId:int = 0;
         var kickRoleName:String = null;
         var successed:int = patch.readByte();
         if(Boolean(successed))
         {
            kickRoleId = LongUtil.readLong(patch);
            teamId = patch.readInt();
            kickRoleName = Model_heFu.repNameByHero(patch.readUTF());
            TeamHandle.GC_KICK_OUT(kickRoleId,teamId,kickRoleName);
         }
      }
      
      public function GC_CHANGE_CAP(patch:IDataInput) : void
      {
         var successed:int = patch.readByte();
         if(successed == -1)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10192",1) + "</font>");
            return;
         }
         var teamId:int = patch.readInt();
         var newCapId:int = patch.readInt();
         var newCapLocation:int = patch.readByte();
         var newMenberId:int = patch.readInt();
         var newMenberLocation:int = patch.readByte();
         TeamHandle.GC_CHANGE_CAP(newCapId,newCapLocation,newMenberId,newMenberLocation,teamId);
      }
      
      public function GC_APPLY_CAP(patch:IDataInput) : void
      {
         var successed:int = patch.readByte();
         var teamId:int = patch.readInt();
         var roleId:Number = LongUtil.readLong(patch);
         var applyRoleName:String = Model_heFu.repNameByHero(patch.readUTF());
         if(Model_team.isCap())
         {
            TeamHandle.GC_APPLY_CAP(teamId,roleId,applyRoleName);
         }
         else
         {
            UIManager.teamSignTogether.btnCountDown(30);
         }
      }
      
      public function GC_CAP_RETURN(patch:IDataInput) : void
      {
         var teamId:int = 0;
         var newCapId:int = 0;
         var newCapLocation:int = 0;
         var newMenberId:int = 0;
         var newMenberLocation:int = 0;
         var memberId:Number = NaN;
         var result:int = patch.readByte();
         if(result == 1)
         {
            teamId = patch.readInt();
            newCapId = patch.readInt();
            newCapLocation = patch.readByte();
            newMenberId = patch.readInt();
            newMenberLocation = patch.readByte();
            TeamHandle.GC_CAP_RETURN(result,newCapId,newCapLocation,newMenberId,newMenberLocation,teamId);
         }
         else if(result == 2)
         {
            memberId = LongUtil.readLong(patch);
            TeamHandle.GC_REFUSE_APPLY_CAP(memberId);
         }
      }
      
      public function GC_CHANGE_LEVEL(patch:IDataInput) : void
      {
         var teamId:int = 0;
         var leastLevel:int = 0;
         var biggestLevel:int = 0;
         var result:int = patch.readByte();
         if(Boolean(result))
         {
            teamId = patch.readInt();
            leastLevel = patch.readShort();
            biggestLevel = patch.readShort();
            TeamHandle.GC_CHANGE_LEVEL(teamId,leastLevel,biggestLevel);
         }
      }
      
      public function GC_CAP_FOLLOW(patch:IDataInput) : void
      {
         var teamId:int = 0;
         var capName:String = null;
         var result:int = patch.readByte();
         if(Boolean(result))
         {
            teamId = patch.readInt();
            capName = Model_heFu.repNameByHero(patch.readUTF());
            TeamHandle.GC_CAP_FOLLOW(teamId,capName);
         }
      }
      
      public function GC_CHANGE_ZHENFA(patch:IDataInput) : void
      {
         var teamId:int = 0;
         var zhenFa:String = null;
         var zhenxingType:int = 0;
         var result:int = patch.readByte();
         if(Boolean(result))
         {
            teamId = patch.readInt();
            zhenFa = patch.readUTF();
            zhenxingType = patch.readInt();
            TeamHandle.GC_CHANGE_ZHENFA(teamId,zhenFa,zhenxingType);
         }
      }
      
      public function GC_LEAVE_TEAM(patch:IDataInput) : void
      {
         var teamId:Number = NaN;
         var zhuangTai:int = 0;
         if(Boolean(patch.readByte()))
         {
            teamId = LongUtil.readLong(patch);
            zhuangTai = patch.readByte();
            Model_team.isFollow[teamId] = zhuangTai;
            UIManager.teamSignTogether.update();
         }
      }
      
      public function GC_FOLLOW_CAP(patch:IDataInput) : void
      {
         var teamId:int = 0;
         var teamX:int = 0;
         var teamY:int = 0;
         var roleId:Number = NaN;
         var reslt:int = patch.readByte();
         if(reslt == -1)
         {
            if(Boolean(Model_team.isCaptain[GameUnitManager.hero.id]))
            {
               return;
            }
         }
         else if(reslt == 1)
         {
            teamId = patch.readInt();
            teamX = patch.readInt();
            teamY = patch.readInt();
            roleId = LongUtil.readLong(patch);
            Model_team.isFollow[roleId] = reslt;
            UIManager.teamSignTogether.update();
         }
         else if(reslt == 0)
         {
         }
      }
      
      public function GC_DIRECT_TEAM_STATE(patch:IDataInput) : void
      {
         var state:int = 0;
         var otherRoleId:Number = NaN;
         var zone:int = 0;
         var len:int = int(Model_team.teamMumberInfo_data_save.length);
         var reslt:int = patch.readByte();
         if(Boolean(reslt))
         {
            state = patch.readByte();
            otherRoleId = LongUtil.readLong(patch);
            zone = 0;
            if(Global.isInHome)
            {
               zone = patch.readInt();
            }
            switch(state)
            {
               case -5:
                  UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10193",1) + "</font>");
                  break;
               case -4:
                  TeamCGMessage.CG_DIRECT_TEAM_STATE(0,otherRoleId.toString(),zone);
                  break;
               case -3:
                  UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10194",1) + "</font>");
                  break;
               case -2:
                  UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10186",1) + "</font>");
                  break;
               case -1:
                  UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10195",1) + "</font>");
                  break;
               case 0:
                  if(Model_team.teamMumberInfo_data_save.length == 3)
                  {
                     UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10196",1) + "</font>");
                     break;
                  }
                  UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10197",1) + "</font>");
                  TeamCGMessage.CG_DIRECT_TEAM(otherRoleId,2,zone);
                  break;
               case 1:
                  if(Model_team.teamMumberInfo_data_save.length > 0)
                  {
                     UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10198",1) + "</font>");
                     break;
                  }
                  TeamCGMessage.CG_DIRECT_TEAM(otherRoleId,2,zone);
                  break;
               case 2:
                  if(Model_team.teamMumberInfo_data_save.length > 0)
                  {
                     UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10198",1) + "</font>");
                     break;
                  }
                  TeamCGMessage.CG_DIRECT_TEAM(otherRoleId,2,zone);
                  break;
               case 3:
                  UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10199",1) + "</font>");
            }
         }
      }
      
      public function GC_DIRECT_TEAM(patch:IDataInput) : void
      {
         var teamId:int = 0;
         var zhenFa:int = 0;
         var leastLimitLevel:int = 0;
         var biggestLimitLevel:int = 0;
         var isRegest:int = 0;
         var learndZhenFa:String = null;
         var teamNumbers:int = 0;
         var arr:Array = null;
         var i:int = 0;
         var position:int = 0;
         var roleId:Number = NaN;
         var roleIcon:int = 0;
         var roleName:String = null;
         var job:int = 0;
         var level:int = 0;
         var isFollow:int = 0;
         var isLeave:int = 0;
         var zhenFaPosition:int = 0;
         var petId:int = 0;
         var petZhenFaPosition:int = 0;
         var a:Array = null;
         var p:Array = null;
         var otherName:String = null;
         var reslt:int = patch.readByte();
         switch(reslt)
         {
            case 1:
               Model_team.teamMumberInfo_data_save = [];
               teamId = patch.readInt();
               zhenFa = patch.readInt();
               Model_team.currentZhenFa = zhenFa;
               leastLimitLevel = patch.readShort();
               biggestLimitLevel = patch.readShort();
               isRegest = patch.readByte();
               learndZhenFa = patch.readUTF();
               teamNumbers = patch.readByte();
               Model_team.isRegest = isRegest;
               Model_team.learnZhenFa = learndZhenFa;
               Model_team.leastLvlSave = leastLimitLevel;
               Model_team.biggestLvlSave = biggestLimitLevel;
               Model_team.HMPArr = [];
               Model_team.memberIcon = [];
               Model_team.petInfoArr = [];
               i = 0;
               while(i <= teamNumbers - 1)
               {
                  position = patch.readByte();
                  roleId = LongUtil.readLong(patch);
                  roleIcon = patch.readInt();
                  roleName = Model_heFu.repNameByHero(patch.readUTF());
                  job = patch.readByte();
                  level = patch.readShort();
                  isFollow = patch.readByte();
                  isLeave = patch.readByte();
                  zhenFaPosition = patch.readByte();
                  petId = patch.readInt();
                  petZhenFaPosition = patch.readByte();
                  arr = [];
                  arr.push(roleId);
                  arr.push(patch.readInt());
                  arr.push(patch.readInt());
                  arr.push(patch.readInt());
                  arr.push(patch.readInt());
                  Model_team.HMPArr.push(arr);
                  Model_team.isTeam[roleId] = true;
                  if(position == 0)
                  {
                     Model_team.isCaptain[roleId] = true;
                     Model_team.isFollow[roleId] = isFollow;
                     TeamHandle.GC_CREATE_TEAM(learndZhenFa,teamId,zhenFa,leastLimitLevel,biggestLimitLevel,isRegest,teamNumbers,position,roleId,roleIcon,roleName,job,level,isFollow,isLeave,zhenFaPosition,petId,petZhenFaPosition);
                  }
                  else
                  {
                     Model_team.teamMumberInfo_data_save.push([position,zhenFa,leastLimitLevel,biggestLimitLevel,teamNumbers,null,roleIcon,roleName,job,level,zhenFaPosition,petId,petZhenFaPosition,roleId]);
                  }
                  a = [];
                  a.push(position);
                  a.push(isLeave);
                  Model_team.memberIcon.push(a);
                  if(petId > 0)
                  {
                     p = [];
                     p.push(petId);
                     p.push(patch.readUTF());
                     p.push(patch.readShort());
                     p.push(patch.readInt());
                     p.push(patch.readInt());
                     Model_team.petInfoArr.push(p);
                  }
                  i++;
               }
               Model_team.positionSort();
               TeamHandle.GC_TEAM_RECEPT(teamId);
               if(Model_team.teamMumberInfo_data_save[Model_team.teamMumberInfo_data_save.length - 1][13] != GameUnitManager.hero.id)
               {
                  UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + Model_team.teamMumberInfo_data_save[Model_team.teamMumberInfo_data_save.length - 1][7] + LangConfig.getWord("10149",1) + "</font>");
               }
               break;
            case 0:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10200",1) + "</font>");
               break;
            case -1:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10201",1) + "</font>");
               break;
            case -2:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10202",1) + "</font>");
               break;
            case -3:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10203",1) + "</font>");
               break;
            case -4:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10204",1) + "</font>");
               break;
            case -5:
               otherName = patch.readUTF();
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + otherName + LangConfig.getWord("10205",1) + "</font>");
               break;
            case -6:
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10186",1) + "</font>");
         }
      }
   }
}

