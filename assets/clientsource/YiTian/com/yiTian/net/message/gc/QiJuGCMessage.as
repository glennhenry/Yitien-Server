package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_QiJu;
   import com.yiTian.data.model.Model_QiJu;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.BattleManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.QiJuHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.battle.SiWangFuHuoPanel;
   import com.yiTian.view.modules.qiJu.MyTeamVo;
   import com.yiTian.view.modules.qiJu.QiJuGameMessage;
   import com.yiTian.view.modules.qiJu.QiJu_Btn;
   import com.yiTian.view.modules.qiJu.QiJu_KillVo;
   import com.yiTian.view.modules.qiJu.TeamVo;
   import com.yiTian.view.modules.qiJu.View_JoinQiJu;
   import flash.utils.IDataInput;
   
   public class QiJuGCMessage
   {
      
      public function QiJuGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_SHOW_QIJU_BTN] = this.GC_SHOW_QIJU_BTN;
         index[MessageType.GC_CLICK_QIJU] = this.GC_CLICK_QIJU;
         index[MessageType.GC_QIJU_TEAMLIST] = this.GC_QIJU_TEAMLIST;
         index[MessageType.GC_QIJU_MYTEAM] = this.GC_QIJU_MYTEAM;
         index[MessageType.GC_GREAT_QIJU_TEAM] = this.GC_GREAT_QIJU_TEAM;
         index[MessageType.GC_UPDATA_LIST] = this.GC_UPDATA_LIST;
         index[MessageType.GC_QIJU_TEAMMATE] = this.GC_QIJU_TEAMMATE;
         index[MessageType.GC_START_QIJU] = this.GC_START_QIJU;
         index[MessageType.GC_ENTER_QIJUGAME] = this.GC_ENTER_QIJUGAME;
         index[MessageType.GC_UP_QIJUGAME_MSG] = this.GC_UP_QIJUGAME_MSG;
         index[MessageType.GC_QIJU_FIGHT] = this.GC_QIJU_FIGHT;
         index[MessageType.GC_UNKNOW_EVENT] = this.GC_UNKNOW_EVENT;
         index[MessageType.GC_QIJU_DIE] = this.GC_QIJU_DIE;
         index[MessageType.GC_QIJU_FUHUO] = this.GC_QIJU_FUHUO;
         index[MessageType.GC_QIJUBOSS_SHOW] = this.GC_QIJUBOSS_SHOW;
         index[MessageType.GC_QIJUBOSS_STATE] = this.GC_QIJUBOSS_STATE;
         index[MessageType.GC_GET_QIJU_CHEST] = this.GC_GET_QIJU_CHEST;
         index[MessageType.GC_EXIT_QIJUGAME] = this.GC_EXIT_QIJUGAME;
         index[MessageType.GC_QIJU_GAME_LIST] = this.GC_QIJU_GAME_LIST;
         index[MessageType.GC_JOIN_QIJU_TEAM] = this.GC_JOIN_QIJU_TEAM;
         index[MessageType.GC_FORBINDINTOFB] = this.GC_FORBINDINTOFB;
         index[MessageType.GC_QIJU_GAME_TIME] = this.GC_QIJU_GAME_TIME;
         index[MessageType.GC_SKIP_QIJU] = this.GC_SKIP_QIJU;
         index[MessageType.GC_QIJU_BUYTIME] = this.GC_QIJU_BUYTIME;
      }
      
      private function GC_QIJU_BUYTIME(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         switch(result)
         {
            case 0:
               UIManager.centerBroadcast.addMsg("购买失败！");
               break;
            case 1:
               ++Model_QiJu.qiJuGame_count;
               View_JoinQiJu.instance.setTime();
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80200",8));
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80205",8));
         }
      }
      
      private function GC_SKIP_QIJU(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         Model_QiJu.skip_time = patch.readByte();
         if(result == 1)
         {
            BattleManager.jumpBattle();
         }
         else if(result == -1)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + "跳过次数已使用完" + "</font>");
         }
      }
      
      private function GC_QIJU_GAME_TIME(patch:IDataInput) : void
      {
         Model_QiJu.qiJuGame_time = patch.readInt();
         Model_QiJu.qiJuGame_count = patch.readInt();
         if(Model_QiJu.qiJuGame_time >= Enum_QiJu.MAX_TIME && QiJu_Btn.isInit)
         {
            QiJu_Btn.instance.hide();
         }
         View_JoinQiJu.instance.setTime();
      }
      
      private function GC_FORBINDINTOFB(patch:IDataInput) : void
      {
         var result:int = patch.readInt();
         if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80178",8));
         }
      }
      
      private function GC_QIJU_GAME_LIST(patch:IDataInput) : void
      {
         var len:int = patch.readInt();
         var list:Array = [];
         var i:int = 0;
         while(i < len)
         {
            list.push(patch.readInt());
            i++;
         }
         View_JoinQiJu.instance.upCreatList(list);
      }
      
      private function GC_EXIT_QIJUGAME(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         switch(result)
         {
            case 1:
               QiJuHandler.disposeGame();
         }
      }
      
      private function GC_GET_QIJU_CHEST(patch:IDataInput) : void
      {
         var result:int = patch.readInt();
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80154",8));
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80155",8));
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80156",8));
               break;
            case 4:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80157",8));
               break;
            case 5:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80158",8));
         }
      }
      
      private function GC_QIJUBOSS_STATE(patch:IDataInput) : void
      {
         var nowBlood:Number = patch.readInt();
         var countBlood:Number = patch.readInt();
         if(Boolean(Model_QiJu.qiJuBoss))
         {
            Model_QiJu.qiJuBoss.upDataQiJuHP(nowBlood,countBlood);
         }
      }
      
      private function GC_QIJUBOSS_SHOW(patch:IDataInput) : void
      {
         Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,QiJuHandler.addBossEff);
      }
      
      private function GC_QIJU_FUHUO(patch:IDataInput) : void
      {
         var result:int = patch.readInt();
         switch(result)
         {
            case 1:
               UIManager.siWangFuHuoPanel.show(0);
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80159",8));
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80160",8));
         }
      }
      
      private function GC_UNKNOW_EVENT(patch:IDataInput) : void
      {
         var id:int = patch.readInt();
         QiJuHandler.addQiJuEvent(id);
      }
      
      private function GC_QIJU_FIGHT(patch:IDataInput) : void
      {
         var result:int = patch.readInt();
         if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80179",8));
         }
      }
      
      private function GC_ENTER_QIJUGAME(patch:IDataInput) : void
      {
         Model_QiJu.inQijuGame = true;
         Model_QiJu.game_type = patch.readInt();
         QiJuGameMessage.instance.show(Model_QiJu.game_type);
         Model_QiJu.skip_time = patch.readInt();
         UIManager.questTraceView.visible = false;
      }
      
      private function GC_UP_QIJUGAME_MSG(patch:IDataInput) : void
      {
         var vo:QiJu_KillVo = new QiJu_KillVo();
         vo.left_time = patch.readInt();
         vo.targetChessNum = patch.readInt();
         vo.targetChessCount = patch.readInt();
         vo.targetBossNum = patch.readInt();
         vo.targetBossCount = patch.readInt();
         vo.naviaChessNum = patch.readInt();
         vo.naviaChessCount = patch.readInt();
         vo.unKnowChessNum = patch.readInt();
         vo.unKnowChessCount = patch.readInt();
         vo.unKnowBossNum = patch.readInt();
         vo.unKnowBossCount = patch.readInt();
         vo.wuState = patch.readInt();
         vo.zhanState = patch.readInt() + 1;
         QiJuGameMessage.instance.upData(vo);
      }
      
      private function GC_SHOW_QIJU_EFF(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         QiJuHandler.addEff(type);
      }
      
      private function GC_EXIT_FUBEN(patch:IDataInput) : void
      {
         UIManager.questTraceView.visible = true;
         QiJuGameMessage.instance.visible = false;
      }
      
      private function GC_QIJU_DIE(patch:IDataInput) : void
      {
         Model_QiJu.leftTime = patch.readInt();
         var time:int = Model_QiJu.leftTime;
         if(UIManager.siWangFuHuoPanel.visible)
         {
            UIManager.siWangFuHuoPanel.show(SiWangFuHuoPanel.QIJU);
         }
      }
      
      private function GC_START_QIJU(patch:IDataInput) : void
      {
         var name:String = null;
         var result:int = patch.readInt();
         switch(result)
         {
            case 1:
               Model_QiJu.inQijuGame = true;
               View_JoinQiJu.instance.visible = false;
               break;
            case 2:
               name = patch.readUTF();
               UIManager.centerBroadcast.addMsg(name + LangConfig.getWord("80161",8));
               break;
            case 3:
               name = patch.readUTF();
               UIManager.centerBroadcast.addMsg(name + LangConfig.getWord("80162",8));
               break;
            case 5:
               name = patch.readUTF();
               UIManager.centerBroadcast.addMsg(name + LangConfig.getWord("80181",8));
         }
      }
      
      private function GC_QIJU_TEAMMATE(patch:IDataInput) : void
      {
         var name:String = Model_heFu.repNameByHero(patch.readUTF());
         var type:int = patch.readInt();
         var roleId:Number = LongUtil.readLong(patch);
         var teamId:int = patch.readInt();
         var content:String = LangConfig.getWord("80164",8,name,Enum_QiJu.type_level[type],Enum_QiJu.qiju_type[type],teamId,type);
         UIManager.chatPanel.add(content,roleId,101,name);
      }
      
      private function GC_UPDATA_LIST(patch:IDataInput) : void
      {
         var id:int = 0;
         var type:int = patch.readInt();
         if(type == 3)
         {
            id = patch.readInt();
            QiJuHandler.delItem(id);
            return;
         }
         var vo:TeamVo = new TeamVo();
         vo.team_id = patch.readInt();
         vo.team_type = patch.readInt();
         vo.team_num = patch.readInt();
         vo.captain_id = LongUtil.readLong(patch);
         vo.captain_name = patch.readUTF();
         vo.captain_job = patch.readInt();
         vo.captain_sex = patch.readInt();
         vo.status = patch.readByte();
         if(vo.team_num == 3 && vo.status != 0)
         {
            vo.status = 3;
         }
         if(type == 1)
         {
            QiJuHandler.addItem(vo);
         }
         else if(type == 2)
         {
            QiJuHandler.editItem(vo);
         }
      }
      
      private function GC_JOIN_QIJU_TEAM(patch:IDataInput) : void
      {
         var result:int = patch.readInt();
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80177",8));
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80166",8));
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80167",8));
               break;
            case 4:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80168",8));
               break;
            case 5:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80175",8));
               break;
            case 6:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80176",8));
               break;
            case 7:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80171",8));
               break;
            case 8:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80172",8));
         }
      }
      
      private function GC_GREAT_QIJU_TEAM(patch:IDataInput) : void
      {
         var result:int = patch.readInt();
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80165",8));
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80166",8));
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80167",8));
               break;
            case 4:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80168",8));
               break;
            case 5:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80169",8));
               break;
            case 6:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80170",8));
               break;
            case 7:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80171",8));
               break;
            case 8:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80172",8));
         }
      }
      
      private function GC_QIJU_MYTEAM(patch:IDataInput) : void
      {
         var vo:MyTeamVo = null;
         Model_QiJu.myTeamVo.length = 0;
         Model_QiJu.team_id = patch.readInt();
         Model_QiJu.team_Type = patch.readInt();
         Model_QiJu.team_captain_id = LongUtil.readLong(patch);
         var len:int = patch.readInt();
         var i:int = 0;
         while(i < len)
         {
            vo = new MyTeamVo();
            vo.id = LongUtil.readLong(patch);
            vo.name = patch.readUTF();
            vo.job = patch.readInt();
            vo.sex = patch.readInt();
            vo.isCaptain = patch.readInt();
            if(vo.id == GameUnitManager.hero.id && vo.isCaptain == 0)
            {
               Model_QiJu.isCaptain = true;
            }
            Model_QiJu.myTeamVo.push(vo);
            i++;
         }
         View_JoinQiJu.instance.upMyTeam();
      }
      
      private function GC_QIJU_TEAMLIST(patch:IDataInput) : void
      {
         var vo:TeamVo = null;
         Model_QiJu.listVo.length = 0;
         var len:int = patch.readInt();
         var i:int = 0;
         while(i < len)
         {
            vo = new TeamVo();
            vo.team_id = patch.readInt();
            vo.team_type = patch.readInt();
            vo.captain_id = LongUtil.readLong(patch);
            vo.captain_name = patch.readUTF();
            vo.captain_job = patch.readInt();
            vo.captain_sex = patch.readInt();
            vo.team_num = patch.readInt();
            vo.status = patch.readByte();
            if(vo.team_num == 3 && vo.status != 0)
            {
               vo.status = 3;
            }
            if(vo.team_num != 0)
            {
               Model_QiJu.listVo.push(vo);
            }
            i++;
         }
         QiJuHandler.upDataList();
      }
      
      private function GC_CLICK_QIJU(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         switch(result)
         {
            case 1:
               if(SceneConfig.getSceneType() == SceneConfig.QIJU)
               {
                  return;
               }
               if(!View_JoinQiJu.instance.visible)
               {
                  View_JoinQiJu.instance.visible = true;
               }
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80152",8));
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80173",8));
               break;
            case 4:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80174",8));
         }
      }
      
      private function GC_SHOW_QIJU_BTN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 1)
         {
            QiJu_Btn.instance.show();
         }
         else if(result == 2)
         {
            QiJu_Btn.instance.hide();
         }
      }
   }
}

