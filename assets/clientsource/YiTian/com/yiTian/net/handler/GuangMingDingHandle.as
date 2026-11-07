package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.gameUnit.GameUnit;
   import com.yiTian.gameUnit.role.Hero;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.BattleManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.SceneCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.TimeLineLL;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.guangMingDing.Enum_guangMingDing;
   import com.yiTian.view.modules.guangMingDing.GuangMingDingBattleCommand;
   import com.yiTian.view.modules.guangMingDing.GuangMingDingConfig;
   import com.yiTian.view.modules.guangMingDing.Model_guangMingDing;
   import com.yiTian.view.modules.guangMingDing.Msg_guangMingDing;
   import com.yiTian.view.modules.guangMingDing.View_gmdInviteResponPnl;
   import com.yiTian.view.modules.guangMingDing.View_gmdLeaderApplyPnl;
   import com.yiTian.view.modules.guangMingDing.View_gmdPassWordJoinPnl;
   import com.yiTian.view.modules.guangMingDing.View_gmdRewardTrace;
   import com.yiTian.view.modules.guangMingDing.View_guangMingDingChallengePnl;
   import com.yiTian.view.modules.guangMingDing.View_guangMingDingHallPanel;
   import com.yiTian.view.modules.guangMingDing.View_guangMingDingInvitePanel;
   import com.yiTian.view.modules.guangMingDing.View_guangMingDingTeamPanel;
   import com.yiTian.view.modules.guangMingDing.Vo_MiJi;
   import flash.events.Event;
   import flash.events.TextEvent;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class GuangMingDingHandle
   {
      
      private static var _battleResult:int;
      
      private static var scBID:Number = -1;
      
      private static var _battleID:Number = 0;
      
      public function GuangMingDingHandle()
      {
         super();
      }
      
      public static function GC_GMD_TIP(type:int) : void
      {
         var tipTxt:String = null;
         var hero:Hero = null;
         var id:Number = NaN;
         switch(type)
         {
            case 0:
               GuangMingDingConfig.removeTipBtn();
               break;
            case 1:
               GuangMingDingConfig.addTipBtn();
               break;
            case 2:
               tipTxt = "进入光眀顶次数已满";
               break;
            case 3:
               tipTxt = "已有队伍";
               break;
            case 4:
               tipTxt = "该房间不存在";
               break;
            case 5:
               tipTxt = "该房间已满人";
               break;
            case 6:
               tipTxt = "今日次数已满";
               break;
            case 7:
               tipTxt = "请输入密码";
               break;
            case 9:
               tipTxt = "只有房主（队长）才能邀请队员";
               break;
            case 10:
               tipTxt = "该玩家已经在其他房间中";
               break;
            case 11:
               tipTxt = "该玩家在战斗中";
               break;
            case 12:
               tipTxt = "对方不在线";
               break;
            case 13:
               tipTxt = "双方不在同一场景";
               break;
            case 14:
               tipTxt = "密码错误";
               break;
            case 15:
               tipTxt = "主推“开始”按钮高亮，表示可以进入“勇闯光眀顶”副本";
               break;
            case 16:
               GuangMingDingCGMessage.CG_GMD_ENTER_MAP();
               break;
            case 17:
               tipTxt = "光眀顶已挑战至顶层";
               break;
            case 18:
               tipTxt = "使用失败，您身上已有该秘籍效果";
               break;
            case 19:
               tipTxt = "购买次数已满";
               break;
            case 20:
               tipTxt = "请求已发送，等待对方回复";
               break;
            case 21:
               tipTxt = "该玩家在副本中";
               break;
            case 22:
               tipTxt = "该玩家已在房间中";
               break;
            case 23:
               tipTxt = "该玩家正在跑镖中";
               break;
            case 24:
               tipTxt = "该玩家今日勇闯光眀顶次数已满";
               break;
            case 25:
               hero = GameUnitManager.hero;
               id = hero.id;
               UIManager.siWangFuHuoPanel.show(0);
               break;
            case 26:
               tipTxt = "对方正在组队状态中";
               break;
            case 27:
               tipTxt = "有玩家尚未准备";
         }
         if(tipTxt != null)
         {
            UIManager.centerBroadcast.addMsg(tipTxt);
         }
      }
      
      public static function GC_GMD_ROOM_INFO(curPage:int, maxPage:int, teams:Array) : void
      {
         var teamPnl:View_guangMingDingTeamPanel;
         var pnl:View_guangMingDingHallPanel = null;
         if(SceneConfig.getSceneType() == SceneConfig.GMD)
         {
            return;
         }
         pnl = View_guangMingDingHallPanel.getInstance();
         teamPnl = View_guangMingDingTeamPanel.getInstance();
         if(teamPnl.visible || SceneConfig.getSceneType() == SceneConfig.GMD)
         {
            if(pnl.visible)
            {
               pnl.visible = false;
            }
            return;
         }
         Global.delegate.dosomething(pnl,function():void
         {
            if(!pnl.visible)
            {
               pnl.show();
            }
            pnl.updatePage(curPage,maxPage);
            pnl.updateRooms(teams);
         });
         Model_guangMingDing.curPage = curPage;
         Model_guangMingDing.maxPage = maxPage;
      }
      
      public static function GC_GMD_CREATE_ROOM(type:int) : void
      {
         if(type == 1)
         {
            UIManager.centerBroadcast.addMsg("成功创建房间");
            GuangMingDingCGMessage.CG_GMD_HALL_INFO();
         }
         Utils.print("创建房间返回：" + type.toString(),1);
      }
      
      public static function GC_GMD_MYINFO(remain:int, record:int) : void
      {
         Model_guangMingDing.remain = remain;
         Model_guangMingDing.record = record;
         Global.control.sendNotification(Msg_guangMingDing.GMD_REMAIN_UPDATE,remain);
         Global.control.sendNotification(Msg_guangMingDing.GMD_RECORD_UPDATE,record);
      }
      
      public static function GC_GMD_TEAM_INFO(teamID:Number, passWord:String, members:Array) : void
      {
         var pnl:View_guangMingDingTeamPanel = null;
         var a:Array = null;
         var aa:Array = null;
         var id:Number = NaN;
         var idd:Number = NaN;
         if(SceneConfig.getSceneType() == SceneConfig.GMD)
         {
            return;
         }
         pnl = View_guangMingDingTeamPanel.getInstance();
         if(pnl.visible && teamID == Model_guangMingDing.teamID)
         {
            for each(a in members)
            {
               id = Number(a[Enum_guangMingDing.MEMBER_ROLEID]);
               if(id != GameUnitManager.hero.id && !Model_guangMingDing.containMember(id,Model_guangMingDing.teamInfo))
               {
                  UIManager.centerBroadcast.addMsg(Model_heFu.repNameByHero(a[Enum_guangMingDing.MEMBER_NAME]) + "加入了房间");
               }
            }
            for each(aa in Model_guangMingDing.teamInfo)
            {
               idd = Number(aa[Enum_guangMingDing.MEMBER_ROLEID]);
               if(idd != GameUnitManager.hero.id && !Model_guangMingDing.containMember(idd,members))
               {
                  UIManager.centerBroadcast.addMsg(Model_heFu.repNameByHero(aa[Enum_guangMingDing.MEMBER_NAME]) + "退出了房间");
               }
            }
         }
         Model_guangMingDing.teamID = teamID;
         Model_guangMingDing.passWord = passWord;
         Model_guangMingDing.teamInfo = members;
         View_guangMingDingHallPanel.getInstance().hide();
         Global.delegate.dosomething(pnl,function():void
         {
            if(!pnl.visible)
            {
               pnl.show();
            }
            pnl.updateRoomID(teamID);
            pnl.updatePassWord(passWord);
            pnl.updateMembers(members);
            pnl._enteredItem.updateBtn();
         });
         Global.control.sendNotification(Msg_guangMingDing.GMD_PASSWORD_CHANGE,passWord);
         Global.control.sendNotification(Msg_guangMingDing.MYTEAM_UPDATE,members);
      }
      
      public static function GC_GMD_SEARCH_ROOM(result:int) : void
      {
         View_gmdPassWordJoinPnl.instance.show(result);
      }
      
      public static function GC_GMD_FAST_JOIN(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("成功加入房间");
         }
      }
      
      public static function GC_GMD_INVITE_INFO(type:int, roleInfos:Array) : void
      {
         var invitePnl:View_guangMingDingInvitePanel = null;
         invitePnl = Singleton.getInstance(View_guangMingDingInvitePanel);
         switch(type)
         {
            case 2:
               Global.delegate.dosomething(invitePnl,function():void
               {
                  invitePnl._bangList._list.source = roleInfos;
                  invitePnl._bangList._data = roleInfos;
               });
         }
      }
      
      public static function GC_GMD_INVITE_PLAYER(roleID:Number, roleName:String, id:int) : void
      {
         View_gmdInviteResponPnl.instance.show(roleID,roleName,id);
      }
      
      public static function GC_GMD_INVITE_QUICKLY(roleID:Number, roleName:String, teamID:Number, pw:String) : void
      {
         var txt:String = "<font color=\'#33ff33\'>" + HtmlUtil.createLink(roleName,true,"capID") + "</font>" + " </font color=\'#dddddd\'>开启了勇闯光眀顶副本，邀请大家踊跃参与！</font>" + HtmlUtil.createLink("<font color=\'#ffff33\'>【立刻加入】</font>",true,"pw");
         UIManager.chatPanel.addItem(txt,onTxtLink,{
            "roleID":roleID,
            "roleName":roleName,
            "teamID":teamID,
            "pw":pw
         },[1,10]);
      }
      
      private static function onTxtLink(e:TextEvent, data:Object) : void
      {
         GameScene.instance.onTextEventLink();
         if(!GuangMingDingConfig.isCanJoin())
         {
            return;
         }
         if(data.roleID == GameUnitManager.hero.id)
         {
            return;
         }
         if(e.text == "capID")
         {
            Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,data.roleID);
         }
         else if(e.text == "pw")
         {
            GuangMingDingCGMessage.CG_GMD_INVITE_RESPON(data.teamID,"-1");
         }
      }
      
      public static function GC_GMD_LEAVE_TEAM(result:int) : void
      {
         var teamPnl:View_guangMingDingTeamPanel = View_guangMingDingTeamPanel.getInstance();
         var hallPnl:View_guangMingDingHallPanel = View_guangMingDingHallPanel.getInstance();
         if(Model_guangMingDing.teamPnlHideFlag)
         {
            GuangMingDingCGMessage.CG_GMD_HALL_INFO();
            Global.delegate.dosomething(hallPnl,hallPnl.show);
         }
         Model_guangMingDing.teamPnlHideFlag = true;
         Global.delegate.dosomething(teamPnl,teamPnl.hide);
      }
      
      public static function GC_GMD_KICK_TEAMMEMBER() : void
      {
         var teamPnl:View_guangMingDingTeamPanel = View_guangMingDingTeamPanel.getInstance();
         if(teamPnl.visible)
         {
            teamPnl.hide();
            GuangMingDingCGMessage.CG_GMD_HALL_INFO();
         }
      }
      
      public static function GC_GMD_MEMBER_READY(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("准备成功");
         }
         else
         {
            UIManager.centerBroadcast.addMsg("取消准备");
         }
      }
      
      public static function GC_GMD_BEGIN_CHALLENGE(battleID:int, result:int, floor:int, miJiMap:Object, jumpFlag:int) : void
      {
         var k:String = null;
         var a:Array = null;
         var ii:int = 0;
         var vo:Vo_MiJi = null;
         _battleID = battleID;
         _battleResult = result;
         Model_guangMingDing.jumpFlag = jumpFlag;
         Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,removeBattleEff);
         if(SceneConfig.getSceneType() == SceneConfig.GMD)
         {
            switch(result)
            {
               case 1:
                  if(floor < 100)
                  {
                     Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,onBattleEnd);
                     if(SceneConfig.getSceneType() == SceneConfig.GMD)
                     {
                        GuangMingDingConfig.createJumpPoint();
                     }
                     break;
                  }
                  if(floor == 100)
                  {
                     scBID = battleID;
                     Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,playScAfterBattle);
                     GuangMingDingConfig.createJumpPoint();
                  }
                  break;
               default:
                  GuangMingDingConfig.resetNpcPos();
            }
         }
         if(miJiMap != null)
         {
            for(k in miJiMap)
            {
               a = miJiMap[k];
               ii = 0;
               while(ii < a.length)
               {
                  vo = new Vo_MiJi();
                  vo.id = a[ii];
                  a[ii] = vo;
                  ii += 1;
               }
            }
            new GuangMingDingBattleCommand().init(miJiMap,_battleID);
         }
         showRound(jumpFlag == 0);
      }
      
      public static function playScAfterBattle(bId:int) : void
      {
         if(bId == -1 || SceneConfig.getSceneType() == SceneConfig.GMD && bId == scBID)
         {
            SingleLoader.add("resource/timeLineClip/gmd100.tlc",onLoadSctTxtComplete);
         }
         scBID = -1;
         Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_END,playScAfterBattle);
      }
      
      private static function onLoadSctTxtComplete(info:Object) : void
      {
         if(SceneConfig.getSceneType() != SceneConfig.GMD)
         {
            return;
         }
         var text:String = (info.data as ByteArray).toString();
         var tl:TimeLineLL = Singleton.getInstance(TimeLineLL);
         tl.addEventListener(TimeLineLL.FINISH,scriptFinishHd);
         tl.playScript(text);
      }
      
      private static function scriptFinishHd(e:Event) : void
      {
         (e.target as TimeLineLL).removeEventListener(TimeLineLL.FINISH,scriptFinishHd);
         if(Global.sceneID == 12509)
         {
            UIManager.centerBroadcast.addMsg("<font size=\'16\'>╮(╯▽╰)╭ 恭喜通关</font>");
         }
      }
      
      private static function showRound(v:Boolean) : void
      {
         var k:int = 0;
         var distanceFloor:int = 0;
         var round:int = 0;
         if(v && (Model_guangMingDing._floor != 0 && SceneConfig.getSceneType() == SceneConfig.GMD))
         {
            k = GuangMingDingConfig.lvToLibKey(Model_guangMingDing._disFloor);
            distanceFloor = int(Data_lib.ycgmd[k][Enum_guangMingDing.LIB_MAP_FLOOR_JUMP_DIS]);
            round = int(Data_lib.ycgmd[k][Enum_guangMingDing.LIB_MAP_FLOOR_JUMP_ROUND]);
            updateRound(round,distanceFloor);
         }
         else
         {
            Model_guangMingDing.jumpInfo = "";
         }
         if(GameScene.battleLayer.isInit)
         {
            GameScene.battleLayer._bossHead.updateJumpTxt();
         }
      }
      
      private static function updateRound(round:int, disFloor:int) : void
      {
         if(round > 0 && disFloor > 0)
         {
            Model_guangMingDing.jumpInfo = LangConfig.reTxt("在 {0} 个回合内击败对手即可跳至第 {1} 层",round,disFloor);
         }
         else
         {
            Model_guangMingDing.jumpInfo = "";
         }
      }
      
      public static function GC_GMD_TEAMLEADER_RESPON(memberID:Number, memberName:String) : void
      {
         var str:String = LangConfig.reTxt("<font color=\'#33ff33\'>{0}</font>申请队长",memberName);
         View_gmdLeaderApplyPnl.instance.memberId = memberID;
         View_gmdLeaderApplyPnl.instance.applyFun(str,function():void
         {
            GuangMingDingCGMessage.CG_GMD_SWAP_TEAMLEADER(memberID);
         });
      }
      
      public static function GC_GMD_PASSWORD(pw:String) : void
      {
         Model_guangMingDing.passWord = pw;
         Global.control.sendNotification(Msg_guangMingDing.GMD_PASSWORD_CHANGE,pw);
      }
      
      public static function GC_GMD_ENTERINFO(floor:int, disFloor:int, mjInfos:Object, usingInfo:Object, leaderID:Number) : void
      {
         Model_guangMingDing.updateFloor(floor,disFloor);
         Model_guangMingDing.updateMJInfo(mjInfos);
         Model_guangMingDing.updateMJUseingInfo(usingInfo);
         var pnl:View_guangMingDingChallengePnl = Singleton.getInstance(View_guangMingDingChallengePnl);
         Global.delegate.dosomething(pnl,pnl.show);
         if(leaderID != 0 && leaderID == GameUnitManager.hero.id)
         {
            if(SceneConfig.getSceneType() == SceneConfig.GMD)
            {
               SceneCGMessage.CG_ENTER_FUBEN(GuangMingDingConfig.lvToLibKey(disFloor));
            }
         }
         if(disFloor - floor > 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.reTxt("正在跳转至第{0}层，请稍等",disFloor),1);
         }
      }
      
      public static function GC_GMD_USE_MJ(result:int, mjID:int, freeRemain:int, costRemain:int) : void
      {
         var useingMap:Object = null;
         var remainMap:Object = Model_guangMingDing._mjInfo;
         remainMap[mjID.toString()] = [freeRemain,costRemain];
         Model_guangMingDing.updateMJInfo(remainMap);
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("成功使用秘籍");
            useingMap = Model_guangMingDing._useingInfo;
            useingMap[mjID] = true;
            Model_guangMingDing.updateMJUseingInfo(useingMap);
         }
      }
      
      public static function GC_GMD_REWARD_LEVEL(lv:int) : void
      {
         var toIndex:int = 0;
         toIndex = int(setTimeout(function():void
         {
            Model_guangMingDing.rewardLv = lv;
            View_gmdRewardTrace.instance.update();
            View_gmdRewardTrace.instance.show();
            clearTimeout(toIndex);
         },3000));
      }
      
      public static function GC_GMD_MIJI_USEING(useingMap:Object) : void
      {
         Model_guangMingDing.updateMJUseingInfo(useingMap);
      }
      
      public static function GC_GMD_ROOM_HASPASSWORD(roomID:int) : void
      {
         View_gmdPassWordJoinPnl.instance.show(roomID);
      }
      
      public static function GC_GMD_REVIVE(bID:int, type:int, remain:int) : void
      {
         Model_guangMingDing.reviveTimes = remain;
         if(bID == 0)
         {
            UIManager.siWangFuHuoPanel.show(4);
         }
         else
         {
            Model_guangMingDing.needShowDeadPnlAfterBattle = true;
            Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,battleShowDeadPnl);
         }
      }
      
      public static function GC_GMD_JUMP_BATTLE(result:int, times:int) : void
      {
         Model_guangMingDing.jumpLeftTimes = times;
         if(result == 1)
         {
            BattleManager.jumpBattle();
         }
      }
      
      private static function battleShowDeadPnl(bID:int) : void
      {
         if(Model_guangMingDing.needShowDeadPnlAfterBattle)
         {
            UIManager.siWangFuHuoPanel.show(4);
            Model_guangMingDing.needShowDeadPnlAfterBattle = false;
         }
         Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,battleShowDeadPnl);
      }
      
      private static function onBattleEnd(bId:int) : void
      {
         if(_battleID == bId)
         {
            if(_battleResult == 1)
            {
               GuangMingDingCGMessage.CG_GMD_ENTER_MAP();
            }
            Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_END,onBattleEnd);
         }
      }
      
      private static function removeBattleEff() : void
      {
         var gameUnit:GameUnit = null;
         Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_END,removeBattleEff);
         for each(gameUnit in GameUnitManager.list)
         {
            if(gameUnit is Npc)
            {
               (gameUnit as Npc).removeBattleEff();
               (gameUnit as Npc).isInBattle = false;
            }
         }
      }
   }
}

