package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_CrossType;
   import com.yiTian.data.config.Enum_npc_type;
   import com.yiTian.data.model.Model_CrossDart;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.gameUnit.role.Player;
   import com.yiTian.manager.CollectManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.KeyboardManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CrossClanBattleCGMessage;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.KFHomeland.VoHome;
   import com.yiTian.view.modules.crossCampBattle.Model_CrossCampBattle;
   import com.yiTian.view.modules.crossClanBattle.CrossClanBattleSocket;
   import com.yiTian.view.modules.crossClanBattle.CrossClanRoleBuffer;
   import com.yiTian.view.modules.crossClanBattle.Enum_CrossClanBattle;
   import com.yiTian.view.modules.crossClanBattle.Model_CrossClanBattle;
   import com.yiTian.view.modules.crossClanBattle.View_BattleConfirmPanel;
   import com.yiTian.view.modules.crossClanBattle.View_ClanBattleInfo;
   import com.yiTian.view.modules.crossClanBattle.View_CrossChuanGongIcon;
   import com.yiTian.view.modules.crossClanBattle.View_CrossClanBattleIconTip;
   import com.yiTian.view.modules.crossClanBattle.View_MsgPanel;
   import com.yiTian.view.modules.crossClanBattle.View_allConfirmDataPanel;
   import com.yiTian.view.modules.crossDart.CrossDartController;
   import flash.display.Sprite;
   import flash.utils.setTimeout;
   
   public class CrossClanBattleHandler
   {
      
      private static var needFreshAution:Boolean;
      
      private static var canConnectSocket:Boolean = true;
      
      public static var buffArr:Array = [];
      
      public function CrossClanBattleHandler()
      {
         super();
      }
      
      public static function GC_ALLCITY_DATA(str:String, serverTime:int, endTime:int, crossClanName:String) : void
      {
         GameUnitManager.hero.crossClanName = crossClanName;
         GameUnitManager.hero.crossClanIdArr = [];
         var arr:Array = str.split(",");
         var allData:Array = [];
         var data:Array = [];
         var i:int = 0;
         while(i < arr.length)
         {
            data = arr[i].toString().split("_");
            allData.push(data);
            i++;
         }
         Model_CrossClanBattle.setAllCityData(allData,serverTime,endTime);
      }
      
      public static function GC_AUCTION_RESULT(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("竞拍成功");
               if(Boolean(View_BattleConfirmPanel.instance.nowVo))
               {
                  CrossClanBattleCGMessage.CG_BATTLE_CONFIRM(View_BattleConfirmPanel.instance.nowVo.id);
               }
               needFreshAution = false;
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("一个帮派只能竞拍一个城池");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("数据正在刷新,请稍后再操作");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("竞拍时间为周一12:00--周四22:00");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("服务器未开");
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("您所在的帮派已经是该城池归属者");
               break;
            case 7:
               UIManager.centerBroadcast.addMsg("数据正在刷新,请稍后再操作");
               break;
            case 8:
               UIManager.centerBroadcast.addMsg("没有该城池");
               break;
            case 10:
               UIManager.centerBroadcast.addMsg("您的银两不足");
               break;
            case 11:
               UIManager.centerBroadcast.addMsg("只有帮主/副帮主才能竞拍");
               break;
            case 12:
               UIManager.centerBroadcast.addMsg("竞拍失败,输入金额必须大于第一名");
               break;
            case 13:
               UIManager.centerBroadcast.addMsg("每次竞拍最少加价10W银两");
               break;
            case 14:
               UIManager.centerBroadcast.addMsg("请先加入帮会");
               break;
            case 15:
               UIManager.centerBroadcast.addMsg("起拍价格需高于10W银两");
               break;
            case 16:
               UIManager.centerBroadcast.addMsg("5级帮会才能竞拍");
               break;
            case 17:
               UIManager.centerBroadcast.addMsg("城池已被其他帮以50000000的价格拍下来了");
               break;
            case 18:
               UIManager.centerBroadcast.addMsg("竞拍价不能超过50000000");
               break;
            case 19:
               UIManager.centerBroadcast.addMsg("系统未开启");
               break;
            case 20:
               UIManager.centerBroadcast.addMsg("占领了相邻城池才能竞拍高级城池");
         }
      }
      
      public static function GC_SEGIE_TIME(str:String, result:int, type:int) : void
      {
         var arr:Array = null;
         var allData:Array = null;
         var data:Array = null;
         var i:int = 0;
         if(type == 2)
         {
            switch(result)
            {
               case 1:
                  arr = str.split(",");
                  allData = [];
                  data = [];
                  i = 0;
                  while(i < arr.length)
                  {
                     data = arr[i].toString().split("_");
                     allData.push(data);
                     i++;
                  }
                  Model_CrossClanBattle.setAllCityTimeData(allData);
                  break;
               case 2:
                  if(needShowSegieTimeTip() == true)
                  {
                     return;
                  }
                  UIManager.centerBroadcast.addMsg("数据正在刷新,请稍后再操作");
                  break;
               case 3:
                  if(needShowSegieTimeTip() == true)
                  {
                     return;
                  }
                  UIManager.centerBroadcast.addMsg("你未加入帮会");
                  break;
               case 4:
                  if(needShowSegieTimeTip() == true)
                  {
                     return;
                  }
                  UIManager.centerBroadcast.addMsg("请竞拍结束之后再查看攻城时间");
                  break;
               case 5:
                  if(needShowSegieTimeTip() == true)
                  {
                     return;
                  }
                  UIManager.centerBroadcast.addMsg("您所在的帮会没有城池对战");
            }
         }
         else
         {
            if(needShowSegieTimeTip() == true)
            {
               return;
            }
            Global.delegate.dosomething(View_allConfirmDataPanel.instance,View_allConfirmDataPanel.instance.show);
         }
      }
      
      private static function needShowSegieTimeTip() : Boolean
      {
         if(Model_CrossClanBattle.refreshTimeCount < 2 && Model_CrossClanBattle.refreshTimeCount != 0)
         {
            Model_CrossClanBattle.refreshTimeCount = 2;
            return true;
         }
         return false;
      }
      
      public static function GC_BATTLE_CONFIRM(info:String, result:int) : void
      {
         if(result == 2 && needFreshAution == true)
         {
            UIManager.centerBroadcast.addMsg("刷新成功");
         }
         needFreshAution = true;
         Model_CrossClanBattle.setBattleConfirmData(info);
      }
      
      public static function GC_REFRESH_CITY_COLOR(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("修改成功");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("只有帮主/副帮主才能修改颜色");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("每天只能修改一次颜色");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("不在修改颜色的时间范围，范围为周一到周四，每天一次");
               break;
            case 8:
               UIManager.centerBroadcast.addMsg("请先加入帮会");
               break;
            case 9:
               UIManager.centerBroadcast.addMsg("不在活动时间内");
               break;
            case 10:
               UIManager.centerBroadcast.addMsg("帮派没有附属的城池");
         }
      }
      
      public static function GC_CONNECT_SOCKET(result:int, selfX:int, selfY:int, selfR:int, enemyX:int, enemyY:int, enemyR:int, selfCrystalId:int, enemyCrystalId:int, selfNpcId:int, enemyNpcId:int, selfBarrierPointStr:String, enemyBarrierPointStr:String) : void
      {
         var selfArr:Array = null;
         var enemyArr:Array = null;
         var selfCrystal:Npc = null;
         var enemyCrystal:Npc = null;
         var i:int = 0;
         switch(result)
         {
            case 1:
               Model_CrossClanBattle.selfPoint.x = selfX;
               Model_CrossClanBattle.selfPoint.y = selfY;
               Model_CrossClanBattle.selfR = selfR - 75;
               Model_CrossClanBattle.enemyPoint.x = enemyX;
               Model_CrossClanBattle.enemyPoint.y = enemyY;
               Model_CrossClanBattle.enemyR = enemyR;
               Model_CrossClanBattle.selfCrystalId = selfCrystalId;
               Model_CrossClanBattle.enemyCrystalId = enemyCrystalId;
               Model_CrossClanBattle.selfNpcId = selfNpcId;
               Model_CrossClanBattle.enemyNpcId = enemyNpcId;
               selfArr = selfBarrierPointStr.split(",");
               enemyArr = enemyBarrierPointStr.split(",");
               Model_CrossClanBattle.selfBarrierPointArr = [];
               Model_CrossClanBattle.enemyBarrierPointArr = [];
               i = 0;
               while(i < selfArr.length)
               {
                  Model_CrossClanBattle.selfBarrierPointArr.push(selfArr[i].toString().split("_"));
                  Model_CrossClanBattle.enemyBarrierPointArr.push(enemyArr[i].toString().split("_"));
                  i++;
               }
               selfCrystal = GameUnitManager.findUnit(selfCrystalId,UnitType.NPC) as Npc;
               if(Boolean(selfCrystal))
               {
                  Model_CrossClanBattle.selfCrystalPoint.x = selfCrystal.x;
                  Model_CrossClanBattle.selfCrystalPoint.y = selfCrystal.y;
               }
               enemyCrystal = GameUnitManager.findUnit(enemyCrystalId,UnitType.NPC) as Npc;
               if(Boolean(enemyCrystal))
               {
                  Model_CrossClanBattle.enemyCrystalPoint.x = enemyCrystal.x;
                  Model_CrossClanBattle.enemyCrystalPoint.y = enemyCrystal.y;
               }
               Global.delegate.dosomething(View_MsgPanel.instance,View_MsgPanel.instance.showPreTime);
               KeyboardManager.isEnabled = false;
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("副本不存在");
               leaveFun(Enum_CrossClanBattle.NOT_LOAD);
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("跨服帮会战已经结束");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("亲们，今天是进行周五的战斗哇！");
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("亲们，今天是进行周六的战斗哇！");
               break;
            case 7:
               UIManager.centerBroadcast.addMsg("亲们，今天是进行周日的战斗哇！");
               break;
            case 8:
               UIManager.centerBroadcast.addMsg("不存在该帐号");
               break;
            case 12:
               UIManager.centerBroadcast.addMsg("您尚未加入帮会！");
               break;
            case 13:
               UIManager.centerBroadcast.addMsg("您加入的帮会尚未满一个小时，不能参加跨服帮战！");
         }
      }
      
      private static function leaveFun(type:int) : void
      {
         var player:Player = null;
         KeyboardManager.isEnabled = true;
         Model_CrossClanBattle.port = 0;
         SocketManager.setChangeSocketFun(false);
         SocketManager.setKuafuSocketFun(false);
         CrossClanBattleCGMessage.CG_KUAFUCLAN_BATTLE_CHANGE_SOCKET(type);
         Model_CrossClanBattle.removeEff();
         for each(player in Player.list)
         {
            (player as Player).crossClanBattleMine = false;
         }
         setTimeout(function():void
         {
            View_ClanBattleInfo.hidePanel();
            View_ClanBattleInfo.instance.hide();
         },500);
      }
      
      public static function GC_BATTLE_INFO(time:int, endTime:int, clanOne:String, clanOneTowerCount:int, clanOnePoint:int, clanTwo:String, clanTwoTowerCount:int, clanTwoPoint:int, selfTowerCountArr:Array, enemyTowerCountArr:Array, mineHasPassTime:int, mineRefreshTime:int) : void
      {
         Model_CrossClanBattle.setBattleInfoData(time,endTime,clanOne,clanOneTowerCount,clanOnePoint,clanTwo,clanTwoTowerCount,clanTwoPoint,selfTowerCountArr,enemyTowerCountArr,mineHasPassTime,mineRefreshTime);
      }
      
      public static function GC_BATTLE_PRE_TIME(time:int, battleTime:int) : void
      {
         Model_CrossClanBattle.setBattlePreTime(time,battleTime);
      }
      
      private static function showPanel() : void
      {
         if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE)
         {
            View_ClanBattleInfo.showPanel();
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_FUBEN_OK,showPanel);
         }
      }
      
      public static function GC_ENTER_BATTLE_SCENE(crossType:String, params:String, testNum:Number, ip:String, canConnectSocket:int) : void
      {
         Global.crossType = crossType;
         var arr:Array = ip.split(":");
         switch(canConnectSocket)
         {
            case 1:
               Model_CrossClanBattle.ip = arr[0];
               Model_CrossClanBattle.port = arr[1];
               Model_CrossClanBattle.testNum = testNum;
               CrossClanBattleSocket.index = [];
               CrossClanBattleSocket.registerMessage();
               CrossClanBattleSocket.connect(Model_CrossClanBattle.ip,Model_CrossClanBattle.port);
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("没有宠物");
               return;
            case 5:
               UIManager.centerBroadcast.addMsg("服务器没开");
               return;
         }
         switch(crossType)
         {
            case Enum_CrossType.CROSS_CLAN_BATTLE:
               doCrossClanBattle(params);
               Global.crossParams = GameUnitManager.hero.id + "_" + Model_CrossClanBattle.currentCityId + "_" + Model_CrossClanBattle.heroS;
               break;
            case Enum_CrossType.CROSS_HOME:
               doCrossHome(params);
               Global.crossParams = String(VoHome.heroS);
               break;
            case Enum_CrossType.CROSS_AiDeBaoBao:
               Global.crossParams = "";
               break;
            case Enum_CrossType.CROSS_KuaFuPaiDui:
               Global.crossParams = params;
               break;
            case Enum_CrossType.CROSS_CAMP_BATTLE:
               Model_CrossCampBattle.doCampBattle(params);
               Global.crossParams = params;
               break;
            case Enum_CrossType.CROSS_PAOBIAO:
               Model_CrossDart.inCrossScence = true;
               Global.crossParams = params;
               CrossDartController.enterCrossWorld();
         }
      }
      
      private static function doCrossHome(params:String) : void
      {
         var paramsArr:Array = params.split("_");
         var result:int = int(paramsArr[0]);
         VoHome.heroS = paramsArr[1];
         var status:int = int(paramsArr[2]);
         if(status == 1)
         {
            switch(result)
            {
               case 1:
                  UIManager.centerBroadcast.addMsg("中央服没开");
                  break;
               case 2:
                  UIManager.centerBroadcast.addMsg("等级不够38");
                  break;
               case 3:
                  UIManager.centerBroadcast.addMsg("正在跑镖当中，不能进入家园");
                  break;
               case 4:
                  UIManager.centerBroadcast.addMsg("没有家园");
                  break;
               case 5:
                  UIManager.centerBroadcast.addMsg("您的跨服好友的家园正在维护当中。");
            }
         }
      }
      
      private static function doCrossClanBattle(params:String) : void
      {
         var paramsArr:Array = params.split("_");
         var result:int = int(paramsArr[0]);
         var s:int = int(paramsArr[1]);
         var status:int = int(paramsArr[2]);
         Model_CrossClanBattle.heroS = s;
         if(status == 1)
         {
            switch(result)
            {
               case 1:
                  Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN_OK,showPanel);
                  break;
               case 2:
                  UIManager.centerBroadcast.addMsg("不在帮会战时间内");
                  break;
               case 3:
                  UIManager.centerBroadcast.addMsg("没有宠物不能进入");
                  break;
               case 4:
                  UIManager.centerBroadcast.addMsg("系统未开启");
                  break;
               case 5:
                  UIManager.centerBroadcast.addMsg("服务器未开");
                  break;
               case 8:
                  UIManager.centerBroadcast.addMsg("请先加入帮会");
                  break;
               case 9:
                  UIManager.centerBroadcast.addMsg("您的帮派没有报名参加");
                  break;
               case 10:
                  UIManager.centerBroadcast.addMsg("不在帮会战时间内");
            }
         }
         else
         {
            switch(status)
            {
               case 2:
                  UIManager.centerBroadcast.addMsg("挂机状态不能进入跨服帮会战");
                  break;
               case 3:
                  UIManager.centerBroadcast.addMsg("钓鱼中不能进入跨服帮会战");
                  break;
               case 4:
                  UIManager.centerBroadcast.addMsg("昆仑山状态不能进入跨服帮会战");
                  break;
               case 5:
                  UIManager.centerBroadcast.addMsg("采集中不能进入跨服帮会战");
                  break;
               case 6:
                  UIManager.centerBroadcast.addMsg("爬塔状态不能进入跨服帮会战");
                  break;
               case 7:
                  UIManager.centerBroadcast.addMsg("武林大会中不能进入跨服帮会战");
                  break;
               case 8:
                  UIManager.centerBroadcast.addMsg("帮战状态不能进入跨服帮会战");
                  break;
               case 9:
                  UIManager.centerBroadcast.addMsg("帮战采矿中不能进入跨服帮会战");
                  break;
               case 10:
                  UIManager.centerBroadcast.addMsg("万安寺状态不能进入跨服帮会战");
                  break;
               case 11:
                  UIManager.centerBroadcast.addMsg("科举殿试中不能进入跨服帮会战");
                  break;
               case 12:
                  UIManager.centerBroadcast.addMsg("珍龙棋局状态不能进入跨服帮会战");
                  break;
               case 13:
                  UIManager.centerBroadcast.addMsg("光眀顶中不能进入跨服帮会战");
                  break;
               case 14:
                  UIManager.centerBroadcast.addMsg("运镖中不能进入跨服帮会战");
                  break;
               default:
                  UIManager.centerBroadcast.addMsg("当前状态不能进入跨服帮会战");
            }
         }
      }
      
      public static function GC_RESOURCE_TOWER(status:int, id:int, guardId:Number) : void
      {
         var npc:Npc = GameUnitManager.findUnit(id,UnitType.NPC) as Npc;
         if(!npc)
         {
            return;
         }
         switch(status)
         {
            case 1:
               npc.beginCrossClanCollect("占领中...",1);
               Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_START,CollectManager.end);
               Model_CrossClanBattle.breakCollectTower = true;
               break;
            case 2:
               Model_CrossClanBattle.showGuardBtn(npc);
               if(guardId > 0)
               {
                  Model_CrossClanBattle.removeGuard(npc);
               }
               break;
            case 3:
               Model_CrossClanBattle.dealTowerBattle(npc);
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("占领成功");
               GameUnitManager.hero.lockTarget = null;
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("守护成功");
               npc.guardId = guardId;
               if(guardId > 0)
               {
                  Model_CrossClanBattle.removeGuard(npc);
               }
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("已经有人在占领中");
               break;
            case 8:
               UIManager.centerBroadcast.addMsg("守护名额已满");
               break;
            case 9:
               UIManager.centerBroadcast.addMsg("您有资源矿还没提交，不可占领");
               break;
            case 10:
               UIManager.centerBroadcast.addMsg("在家状态");
               break;
            case 11:
               UIManager.centerBroadcast.addMsg("当前资源塔已经不存在");
               break;
            case 12:
               UIManager.centerBroadcast.addMsg("占领塔读条时间未到");
               break;
            case 13:
               UIManager.centerBroadcast.addMsg("读条ID与当前ID不匹配");
               break;
            case 14:
               UIManager.centerBroadcast.addMsg("与玩家战斗");
               break;
            case 22:
               UIManager.centerBroadcast.addMsg("守护名额已满");
         }
      }
      
      public static function GC_CLICK_WAR_CAR(id:int) : void
      {
         var npc:Npc = null;
         var warCarStartGo:Function = null;
         warCarStartGo = function():void
         {
            CrossClanBattleCGMessage.CG_WAR_CAR_BATTLE_END(npc.id);
            Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_END,warCarStartGo);
         };
         npc = GameUnitManager.findUnit(id,UnitType.NPC) as Npc;
         if(!npc)
         {
            return;
         }
         npc.action = Action.STAND;
         Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,warCarStartGo);
      }
      
      public static function GC_WAR_CAR_BATTLE_END(id:int) : void
      {
         var npc:Npc = GameUnitManager.findUnit(id,UnitType.NPC) as Npc;
         if(!npc)
         {
            return;
         }
         npc.action = Action.RUN;
      }
      
      public static function GC_WAR_CAR_V_CRYSTAL(id:int) : void
      {
         var npc:Npc = GameUnitManager.findUnit(id,UnitType.NPC) as Npc;
         if(!npc)
         {
            return;
         }
         EffectManager.addEffect("35181",npc.parent as Sprite,5550,npc.global_x + 12,npc.global_y + 13,false);
         GameUnitManager.removeUnit(npc);
      }
      
      public static function GC_WAR_CAR_DISPOSE(id:int) : void
      {
         var npc:Npc = GameUnitManager.findUnit(id,UnitType.NPC) as Npc;
         if(!npc)
         {
            return;
         }
         GameUnitManager.removeUnit(npc);
      }
      
      public static function GC_RESOURCE_MINE(result:int, id:int, type:int) : void
      {
         var npc:Npc = null;
         switch(result)
         {
            case 1:
               npc = GameUnitManager.findUnit(id,UnitType.NPC) as Npc;
               if(!npc)
               {
                  return;
               }
               CollectManager.begin(npc,10000,function():void
               {
                  CrossClanBattleCGMessage.CG_RESOURCE_MINE(Enum_CrossClanBattle.COLLECT_MINE_FINISH,npc.id);
               });
               Model_CrossClanBattle.breakCollectMine = true;
               Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_START,CollectManager.end);
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("该资源矿已被采");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("已经有帮会成员在采集");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("开始跟敌人战斗");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("已经有矿石，每次只能采集一次资源矿");
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("该资源矿已被采集或消失");
               break;
            case 7:
               UIManager.centerBroadcast.addMsg("你正在采集");
               break;
            case 8:
               UIManager.centerBroadcast.addMsg("每次只能采集一次资源矿");
               break;
            case 9:
               UIManager.centerBroadcast.addMsg("您正处于守护状态，不能采集");
               break;
            case 10:
               UIManager.centerBroadcast.addMsg("每次只能采集一次资源矿");
               break;
            case 11:
               UIManager.centerBroadcast.addMsg("角色ID不匹配");
               break;
            case 12:
               UIManager.centerBroadcast.addMsg("中断采集/采集结束,矿石为未采集状态");
               break;
            case 14:
               UIManager.centerBroadcast.addMsg("您采集获得资源矿");
               GameUnitManager.hero.lockTarget = null;
         }
      }
      
      public static function GC_BUY_BUFF(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("购买成功");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("小兵已存在,请等小兵消失后再进行购买");
               break;
            case 8:
               UIManager.centerBroadcast.addMsg("buff不存在");
               break;
            case 20:
               UIManager.centerBroadcast.addMsg("帮派资源点不足");
               break;
            case 21:
               UIManager.centerBroadcast.addMsg("只有帮主/副帮主可以购买");
               break;
            case 22:
               UIManager.centerBroadcast.addMsg("buff冷却时间未到");
         }
      }
      
      public static function GC_REFRESH_BUFF(data:Array, serverTime:int) : void
      {
         Model_CrossClanBattle.refreshBuff(data,serverTime);
      }
      
      public static function GC_CRYSTAL(result:int, id:int) : void
      {
         switch(result)
         {
            case 1:
               GameUnitManager.hero.lockTarget = null;
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("水晶已给破坏");
               break;
            case 8:
               UIManager.centerBroadcast.addMsg("还在战斗中");
               break;
            case 9:
               UIManager.centerBroadcast.addMsg("本帮水晶不能攻击");
         }
      }
      
      public static function GC_REFRESH_CRYSTAL_BLOOD(id:int, blood:String, bloodMax:String, clanName:String) : void
      {
         var npc:Npc = GameUnitManager.findUnit(id,UnitType.NPC) as Npc;
         if(!npc)
         {
            return;
         }
         npc.setQiJuHP(true);
         npc.upDataQiJuHP(Number(blood),Number(bloodMax));
         var rate:Number = Number(blood) / Number(bloodMax) * 100;
         var rateStr:String = rate.toString();
         var rateString:String = "剩余" + rateStr.substr(0,rateStr.length > 5 ? 5 : rateStr.length) + "%气血";
         View_ClanBattleInfo.instance.refreshBlood(clanName,rateString);
      }
      
      public static function GC_BASE_MSG(selfX:int, selfY:int, selfR:int, enemyX:int, enemyY:int, enemyR:int) : void
      {
         Model_CrossClanBattle.selfPoint.x = selfX;
         Model_CrossClanBattle.selfPoint.y = selfY;
         Model_CrossClanBattle.selfR = selfR;
         Model_CrossClanBattle.enemyPoint.x = enemyX;
         Model_CrossClanBattle.enemyPoint.y = enemyY;
         Model_CrossClanBattle.enemyR = enemyR;
      }
      
      public static function GC_COMMIT_RESOURCE_MINE(result:int, type:int, point:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("您上缴资源矿成功，为帮会增加" + point + "点资源点");
               UIManager.selfBroadcast.addMsg("您上缴资源矿成功，为帮会增加" + point + "点资源点");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("您没有资源矿可以上缴");
         }
      }
      
      public static function GC_KUAFUCLAN_BATTLE_END(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("只有帮主/副帮主可以购买");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("帮派资源点不足");
         }
      }
      
      public static function GC_SOIDIER(result:int) : void
      {
         switch(result)
         {
            case 1:
               GameUnitManager.hero.lockTarget = null;
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("小兵已被消灭，请点水晶塔");
               break;
            case 8:
               UIManager.centerBroadcast.addMsg("非敌方小兵");
               break;
            case 9:
               UIManager.centerBroadcast.addMsg("敌方小兵ID为0");
         }
      }
      
      public static function GC_CLICK_PLAYER(result:int) : void
      {
         switch(result)
         {
            case 1:
         }
      }
      
      public static function GC_CHANGE_TOWER_NAME(type:int, id:Number, name:String) : void
      {
         var npc:Npc = null;
         var _npc:Array = null;
         var npcName:String = null;
         var player:Player = null;
         var _player:Player = null;
         if(type <= 4)
         {
            npc = GameUnitManager.findUnit(id,UnitType.NPC) as Npc;
            if(!npc)
            {
               return;
            }
            _npc = Data_lib.npc[npc.sysId];
            npcName = _npc[Npc.NAME];
            trace(GameUnitManager.hero.party,name);
            if(Model_heFu.compareServName(GameUnitManager.hero.party,name))
            {
               npc.name = "<font color=\'#04ff00\'>" + npcName + "</font>";
            }
            else
            {
               npc.name = "<font color=\'#fe0000\'>" + npcName + "</font>";
            }
            npc.npcType = Enum_npc_type.CROSS_MONSTER;
            npc.show();
         }
         else if(type == 20 || type == 21)
         {
            player = GameUnitManager.findUnit(id,UnitType.PLAYER) as Player;
            if(!player)
            {
               return;
            }
            if(type == 20)
            {
               player.crossClanBattleMine = false;
            }
            else if(type == 21)
            {
               player.crossClanBattleMine = true;
            }
         }
         else if(type == 22 || type == 23)
         {
            _player = GameUnitManager.findUnit(id,UnitType.PLAYER) as Player;
            if(!_player)
            {
               return;
            }
            if(type == 22)
            {
               _player.addBattleEff();
            }
            else if(type == 23)
            {
               _player.removeBattleEff();
            }
         }
      }
      
      public static function GC_TIP(type:int, result:int, len:int, data:Array) : void
      {
         switch(type)
         {
            case 1:
               switch(result)
               {
                  case 13:
                     UIManager.centerBroadcast.addMsg("对方还在战斗中");
                     break;
                  case 14:
                     UIManager.centerBroadcast.addMsg("等级不符合参与武林大会的条件");
                     break;
                  case 15:
                     UIManager.centerBroadcast.addMsg("你受到了天外飞仙的毁灭性击杀",1);
               }
               break;
            case 3:
               switch(result)
               {
                  case 1:
                     Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,showTip);
                     break;
                  case 2:
                     UIManager.selfBroadcast.addMsg("您采集获得资源矿");
                     break;
                  case 3:
                     UIManager.selfBroadcast.addMsg("您采集获得资源矿");
                     break;
                  case 4:
                     UIManager.selfBroadcast.addMsg("您采集获得资源矿");
                     break;
                  case 5:
                     Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,showTip2);
                     break;
                  case 6:
                     Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_END,showTip3);
                     break;
                  case 7:
                     UIManager.centerBroadcast.addMsg("本帮占领" + data[0] + "座资源塔，获得" + data[1] + "点资源点");
                     UIManager.selfBroadcast.addMsg("本帮占领" + data[0] + "座资源塔，获得" + data[1] + "点资源点");
                     break;
                  case 8:
                     UIManager.centerBroadcast.addMsg("帮主召唤了小兵，消耗了" + data[0] + "资源点 ");
                     UIManager.selfBroadcast.addMsg("帮主召唤了小兵，消耗了" + data[0] + "资源点 ");
                     break;
                  case 9:
                     UIManager.centerBroadcast.addMsg("帮主召唤了战车，消耗了" + data[0] + "资源点");
                     UIManager.selfBroadcast.addMsg("帮主召唤了战车，消耗了" + data[0] + "资源点");
                     break;
                  case 10:
                     UIManager.centerBroadcast.addMsg("帮主使用神之恩赐技能，消耗了" + data[0] + "资源点");
                     UIManager.selfBroadcast.addMsg("帮主使用神之恩赐技能，消耗了" + data[0] + "资源点");
                     break;
                  case 11:
                     UIManager.centerBroadcast.addMsg("本帮的战车对敌方水晶造成了" + data[0] + "伤害");
                     UIManager.selfBroadcast.addMsg("本帮的战车对敌方水晶造成了" + data[0] + "伤害");
                     break;
                  case 12:
                     UIManager.centerBroadcast.addMsg("本帮的资源水晶被敌方战车造成了" + data[0] + "伤害");
                     UIManager.selfBroadcast.addMsg("本帮的资源水晶被敌方战车造成了" + data[0] + "伤害");
                     break;
                  case 16:
                     UIManager.selfBroadcast.addMsg("队伍改变，导致战车重置回基地了");
                     UIManager.centerBroadcast.addMsg("队伍改变，导致战车重置回基地了",1);
                     break;
                  case 17:
                     UIManager.selfBroadcast.addMsg("队员提交水晶，为战旗恢复了" + data[0] + "血量");
                     UIManager.centerBroadcast.addMsg("队员提交水晶，为战旗恢复了" + data[0] + "血量",1);
               }
         }
      }
      
      private static function showTip() : void
      {
         UIManager.centerBroadcast.addMsg("您被打劫了，资源矿丢失一半");
         UIManager.selfBroadcast.addMsg("您被打劫了，资源矿丢失一半");
         Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_END,showTip);
      }
      
      private static function showTip2() : void
      {
         UIManager.centerBroadcast.addMsg("您被敌方帮众杀死了");
         UIManager.selfBroadcast.addMsg("您被敌方帮众杀死了");
         Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_END,showTip2);
      }
      
      private static function showTip3() : void
      {
         UIManager.centerBroadcast.addMsg("您杀死敌方帮众，帮派获得30点资源点");
         UIManager.selfBroadcast.addMsg("您杀死敌方帮众，帮派获得30点资源点");
         Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_END,showTip3);
      }
      
      public static function GC_KUAFUCLAN_BATTLE_EXIT(result:int) : void
      {
         switch(result)
         {
            case 1:
               Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_FUBEN_OK,showPanel);
               leaveFun(Enum_CrossClanBattle.NEED_LOAD);
               View_CrossChuanGongIcon.instance.updateMoneyTxt("");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("小兵已被消灭，请点水晶塔");
         }
      }
      
      public static function GC_OPEN_CROSS_CLAN_ICON(result:int) : void
      {
         if(result == 1)
         {
            View_CrossClanBattleIconTip.showTip();
         }
         else
         {
            View_CrossClanBattleIconTip.hide();
         }
      }
      
      public static function GC_BUY_ROLE_BUFF(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("购买成功");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("元宝不足");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("buff不存在");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("购买次数已满");
         }
      }
      
      public static function GC_REFRESH_ROLE_BUFF(type:int, data:Array) : void
      {
         var i:int = 0;
         var j:int = 0;
         var buff:CrossClanRoleBuffer = null;
         switch(type)
         {
            case 1:
               removeBuff();
               i = 0;
               while(i < Model_CrossClanBattle.roleBuffArr.length)
               {
                  j = 0;
                  while(j < data.length)
                  {
                     if(data[j][0] == Model_CrossClanBattle.roleBuffArr[i][Enum_CrossClanBattle.BUFF_ID])
                     {
                        buff = new CrossClanRoleBuffer();
                        buff.update(i,data[j][1]);
                        buffArr.push(buff);
                        UIManager.heroHead.addBuff(buff);
                        break;
                     }
                     j++;
                  }
                  i++;
               }
               break;
            case 2:
               removeBuff();
         }
      }
      
      private static function removeBuff() : void
      {
         var i:int = 0;
         while(i < buffArr.length)
         {
            UIManager.heroHead.removeBuff(buffArr[i] as CrossClanRoleBuffer);
            (buffArr[i] as CrossClanRoleBuffer).dispose();
            i++;
         }
         buffArr = [];
      }
      
      public static function GC_ROLE_MONEY(type:int, value:Number) : void
      {
         if(!Model_CrossClanBattle.roleBuffArr.length)
         {
            Model_CrossClanBattle.setRoleBuffData();
         }
         switch(type)
         {
            case 30:
               GameUnitManager.hero.strength = value;
               View_CrossChuanGongIcon.instance.updateMoneyTxt(GameUnitManager.hero.money + "");
               break;
            case 16:
               GameUnitManager.hero.money = value;
               View_CrossChuanGongIcon.instance.updateMoneyTxt(value + "");
         }
      }
      
      public static function GC_CITY_BATTLE_TIP(cityId:int) : void
      {
         if(!Model_CrossClanBattle.roleBuffArr.length)
         {
            Model_CrossClanBattle.setRoleBuffData();
         }
         View_Alert.show("跨服帮会战开启，是否进入跨服战场？",View_Alert.OK_CANCAL,function():void
         {
            Global.crossType = Enum_CrossType.CROSS_CLAN_BATTLE;
            CrossClanBattleCGMessage.CG_ENTER_BATTLE_SCENE(Global.crossType,cityId + "");
            Model_CrossClanBattle.currentCityId = cityId;
         });
      }
   }
}

