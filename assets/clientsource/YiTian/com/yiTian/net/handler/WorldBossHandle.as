package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.CollectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.GuaJiCGMessage;
   import com.yiTian.net.message.cg.WorldBossCGMessage;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.activity.Model_actDaily;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import com.yiTian.view.modules.worldBoss.Model_WorldBoss;
   import com.yiTian.view.modules.worldBoss.View_DamageRankTracePnl;
   import com.yiTian.view.modules.worldBoss.View_PrePareCountDown;
   import com.yiTian.view.modules.worldBoss.View_WorldBossBloodPnl;
   import com.yiTian.view.modules.worldBoss.View_WorldBossMapInfo;
   import com.yiTian.view.modules.worldBoss.WorldBossUtil;
   
   public class WorldBossHandle
   {
      
      private static var _battleID:Number;
      
      private static var _type:int;
      
      public function WorldBossHandle()
      {
         super();
      }
      
      public static function GC_WB_SHOW_ICON(iconFlag:int, isSuit:int, monsterID:int) : void
      {
         if(iconFlag == 1)
         {
            WorldBossUtil.setBtnVis(true);
            Model_actDaily.getInstance().updateAct(8,true);
            UIManager.smallMap.addTip(0);
            if(isSuit == 1 && GameUnitManager.hero.level >= 30)
            {
               View_Alert.show(LangConfig.reTxt("武魂地图召唤出{0},邀请各位大侠前往挑战",Data_lib.npc[monsterID][Npc.NAME]),View_Alert.OK_CANCAL,function():void
               {
                  GuaJiHandle.cancelCallBack = gjCancelCb;
                  GuaJiCGMessage.CG_GUAJI_CANCEL("");
               });
            }
         }
         else
         {
            WorldBossUtil.setBtnVis(false);
            Model_actDaily.getInstance().updateAct(8,false);
            UIManager.smallMap.removeTip(0);
         }
      }
      
      private static function gjCancelCb() : void
      {
         WorldBossCGMessage.CG_WB_ENTERFUBEN();
      }
      
      public static function GC_WB_ENTERFUBEN(result:int) : void
      {
         var msg:String = null;
         switch(result)
         {
            case 0:
               msg = "不在活动时间";
               break;
            case 1:
               View_WorldBossBloodPnl.instance.visible = true;
               View_DamageRankTracePnl.instance.visible = true;
               View_WorldBossMapInfo.instance.visible = true;
               UIManager.mainUiBtnContainer.visible = false;
               UIManager.smallMap.visible = false;
               UIManager.questTraceView.visible = false;
               WorldBossUtil.checkShowFirstIntroduce();
               break;
            case 2:
               msg = "等级达到30级才能参与世界boss活动";
               break;
            case 3:
               msg = "竞技场排名前500名才能参与世界boss活动";
               break;
            case 4:
               msg = "组队状态不能参与世界boss活动";
               break;
            case 5:
               msg = "请先退出副本";
               break;
            case 6:
               msg = "该状态不能进入";
               break;
            case 7:
               msg = "成功从武魂boss身上偷到一个宝箱";
               break;
            case 8:
               msg = "武魂boss还没被消灭，不能捐灵";
         }
         if(msg != null)
         {
            UIManager.centerBroadcast.addMsg(msg);
         }
      }
      
      public static function GC_WB_NUM_MEMBERJOIN(num:int) : void
      {
         Model_WorldBoss.updateMember(num);
      }
      
      public static function GC_WB_TIME_REMAIN(remain:int, bossID:Number, color:int) : void
      {
         View_PrePareCountDown.instance;
         Model_WorldBoss.updateRemain(remain);
         Model_WorldBoss.updateBossInfo(bossID,color);
      }
      
      public static function GC_WB_FUBENINFO(maxHp:int, curHp:int) : void
      {
         Model_WorldBoss.updateBoss(maxHp,curHp);
      }
      
      public static function GC_WB_DAMAGED_TRACE(ranks:Array, myRank:int, myDamagePercent:int) : void
      {
         Model_WorldBoss.updateRankTrace(ranks,myRank,myDamagePercent);
      }
      
      public static function GC_WB_USE_CHUANGONG(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("您获得一次传功，攻击增加10%");
         }
      }
      
      public static function GC_WB_COLLECT(result:int) : void
      {
         if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("30秒冷却时间未到");
            CollectManager.endNoReason();
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30060",3));
            CollectManager.endNoReason();
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30062",3));
            CollectManager.endNoReason();
         }
         else if(result == 5)
         {
            UIManager.centerBroadcast.addMsg("采集成功");
         }
      }
      
      public static function GC_WB_DAMAGED_CHARTS(ranks:Array, curPage:int = 1, maxPage:int = 1) : void
      {
         maxPage = int(ranks.length / 10);
         if(maxPage % 10 == 0)
         {
            maxPage -= 1;
         }
         maxPage = Math.max(0,maxPage);
         curPage = 0;
         Model_WorldBoss.updateRank(maxPage,curPage,ranks);
      }
      
      public static function GC_WB_LEAVE_FUBEN(result:int) : void
      {
         if(result == 1)
         {
            View_WorldBossBloodPnl.instance.visible = false;
            View_DamageRankTracePnl.instance.visible = false;
            View_WorldBossMapInfo.instance.visible = false;
            UIManager.mainUiBtnContainer.visible = true;
            UIManager.smallMap.visible = true;
            UIManager.questTraceView.visible = true;
            UIManager.mainUiBtnContainer.resetPosition();
            UIManager.smallMap.resetPosition();
            UIManager.questTraceView.resetPosition();
            WorldBossUtil.setAutoBattle(false);
            Model_WorldBoss._LQ_NOTMIT = false;
            Model_WorldBoss._YB_NOTMIT = false;
            Model_WorldBoss._reviveType = 1;
            View_PrePareCountDown.instance.visible = false;
         }
      }
      
      public static function GC_WB_COLLDOWN(remain:int) : void
      {
         UIManager.centerBroadcast.addMsg(LangConfig.reTxt("冷却时间未到,还需等待{0}秒",remain));
      }
      
      public static function GC_WB_CHALLENGE(battleID:Number, type:int) : void
      {
         Model_WorldBoss._reviveType = type;
         _battleID = battleID;
         _type = type;
         if(battleID != 0)
         {
            Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,ONBATTLEEND);
         }
         else
         {
            Model_WorldBoss.updateRevive(type);
         }
      }
      
      private static function ONBATTLEEND(bID:Number) : void
      {
         if(bID == _battleID && SceneConfig.getSceneType() == SceneConfig.WORLDBOSS)
         {
            Model_WorldBoss.updateRevive(_type);
         }
         Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_END,ONBATTLEEND);
      }
      
      public static function GC_WB_CHUANGONG(num:int) : void
      {
         Model_WorldBoss.updateChuanGong(num);
      }
      
      public static function GC_WB_REVIVE(type:int) : void
      {
         if(type == 1)
         {
            UIManager.centerBroadcast.addMsg("您复活了");
            Model_WorldBoss.updateRevive(1);
            Model_WorldBoss._reviveType = 1;
            if(Model_WorldBoss._autoChallenge && Model_WorldBoss._reviveType != 2 && SceneConfig.getSceneType() == SceneConfig.WORLDBOSS)
            {
               WorldBossUtil.autoChallenge();
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg("复活失败");
         }
      }
      
      public static function GC_WB_CHAT_BROADCAST(bossSysID:int) : void
      {
         var bossName:String = "<font color=\'#ff33ff\'>" + Enum_BroadCastTool.instance.getMonsterName(bossSysID) + "</font>";
         var txt:String = LangConfig.reTxt("世界boss{0}在武魂地图砸出一大堆<font color=\'#ffff00\'>武魂宝箱</font>",bossName);
         UIManager.chatPanel.addItem(txt,null,null,[1]);
      }
      
      public static function GC_WB_DMGBROADCAST(dmgInfos:Array) : void
      {
         var colorLv:int = 0;
         var rankStr:String = null;
         var percentStr:String = null;
         var roleName:String = null;
         if(dmgInfos.length == 0)
         {
            return;
         }
         var dmgTxts:Array = [];
         var len:int = Math.min(dmgInfos.length,3);
         var rankReps:Array = ["一","二","三"];
         var i:int = 0;
         while(i < len)
         {
            colorLv = int(rankReps[2 - i]);
            rankStr = LangConfig.reTxt("第{0}名",rankReps[i]);
            percentStr = LangConfig.reTxt("伤害{0}%",dmgInfos[i][1] / 100);
            roleName = "<font color=\'#ffff00\'>" + dmgInfos[i][0] + "</font>";
            dmgTxts.push(LangConfig.reTxt("  <font color=\'#ffffff\'>{0} 玩家 {1} {2}</font>",rankStr,roleName,percentStr));
            i += 1;
         }
         var txt:String = LangConfig.reTxt("  <font color=\'#ffff33\'>本次武魂Boss名字伤害排名\n{1}</font>",dmgInfos.length,dmgTxts.join("\n"));
         UIManager.chatPanel.addItem(txt,null,null,[1]);
      }
   }
}

