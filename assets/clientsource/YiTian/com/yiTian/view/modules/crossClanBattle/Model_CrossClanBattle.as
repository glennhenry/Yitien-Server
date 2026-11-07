package com.yiTian.view.modules.crossClanBattle
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CrossClanBattleCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.team.TeamListPanel;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class Model_CrossClanBattle
   {
      
      private static var bindNpc:Npc;
      
      public static var breakCollectMine:Boolean;
      
      public static var breakCollectTower:Boolean;
      
      public static var serverTime:int;
      
      public static var endConfirmTime:int;
      
      public static var ip:String;
      
      public static var heroS:int;
      
      public static var currentCityId:int;
      
      public static var selfR:int;
      
      public static var enemyR:int;
      
      public static var selfCrystalId:int;
      
      public static var enemyCrystalId:int;
      
      public static var selfNpcId:int;
      
      public static var enemyNpcId:int;
      
      public static var mouseX:int;
      
      public static var mouseY:int;
      
      public static var refreshTimeCount:int;
      
      public static var lastSceneType:int;
      
      public static var testNum:Number;
      
      private static var lastTime:uint;
      
      private static var lastTipTime:uint;
      
      private static var eff:Effect;
      
      private static var eff2:Effect;
      
      public static var port:int = 0;
      
      public static var preTime:int = 1000;
      
      public static var selfPoint:Point = new Point();
      
      public static var enemyPoint:Point = new Point();
      
      public static var selfBarrierPointArr:Array = [];
      
      public static var enemyBarrierPointArr:Array = [];
      
      public static var selfCrystalPoint:Point = new Point();
      
      public static var enemyCrystalPoint:Point = new Point();
      
      public static var allStaticCityData:Array = [];
      
      public static var allStaticCityDataByIndex:Array = [];
      
      public static var allCityVoData:Array = [];
      
      public static var allCityTimeData:Array = [];
      
      public static var battleConfirmData:Array = [];
      
      public static var resourceMineLvNameArr:Array = ["","初级","中级","高级"];
      
      public static var resourcePointArr:Array = [0,10,20,50];
      
      public static var bufferIdArr:Array = [39438,39439,39440];
      
      public static var canShowObject:Object = {};
      
      public static var roleBuffArr:Array = [];
      
      private static var towerIdArr:Array = [52608,52674,52675,52676];
      
      public static var weekArr:Array = ["周日","周一","周二","周三","周四","周五","周六"];
      
      public function Model_CrossClanBattle()
      {
         super();
      }
      
      public static function updateCity() : void
      {
         Global.control.sendNotification(Enum_CrossClanBattle.CITY_UPDATE,null);
      }
      
      public static function setRoleBuffData() : void
      {
         var arr:Array = null;
         var value:Array = null;
         var i:String = null;
         for(i in Data_lib.crossRoleBuff)
         {
            arr = new Array();
            arr.push(i);
            arr.push(Data_lib.crossRoleBuff[i][0]);
            arr.push(Data_lib.crossRoleBuff[i][1]);
            value = Data_lib.crossRoleBuff[i][2].toString().split("_");
            arr.push(value[0]);
            arr.push(value[1]);
            arr.push(Data_lib.crossRoleBuff[i][3]);
            arr.push(Data_lib.crossRoleBuff[i][4]);
            arr.push(Data_lib.crossRoleBuff[i][5]);
            roleBuffArr.push(arr);
         }
      }
      
      public static function setStaticCityData() : void
      {
         var arr:Array = null;
         var i:String = null;
         for(i in Data_lib.crossClanCity)
         {
            arr = new Array();
            arr.push(i);
            arr.push(Data_lib.crossClanCity[i][0]);
            arr.push(Data_lib.crossClanCity[i][1]);
            arr.push(Data_lib.crossClanCity[i][2]);
            arr.push(Data_lib.crossClanCity[i][3]);
            arr.push(Data_lib.crossClanCity[i][4]);
            allStaticCityData[i] = arr;
         }
      }
      
      public static function setAllCityData(data:Array, severTime:int, endTime:int) : void
      {
         var vo:CityVo = null;
         var i:int = 0;
         var j:int = 0;
         serverTime = severTime;
         endConfirmTime = endTime;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,frameStep);
         var index:int = 1;
         var len:int = int(data.length);
         allCityVoData = [];
         i = 0;
         while(i < Enum_CrossClanBattle.MAX_CITY_NUM)
         {
            vo = new CityVo();
            if(Boolean(data.length))
            {
               j = 0;
               while(j < len)
               {
                  if(data[j][0] == allStaticCityData[index][Enum_CrossClanBattle.CITY_ID])
                  {
                     vo.init(data[j],allStaticCityData[index][Enum_CrossClanBattle.CITY_ID],allStaticCityData[index][Enum_CrossClanBattle.CITY_NAME],allStaticCityData[index][Enum_CrossClanBattle.CITY_SILVER],endConfirmTime,allStaticCityData[index][Enum_CrossClanBattle.CITY_BATTLE_TIME],allStaticCityData[index][Enum_CrossClanBattle.CITY_INDEX]);
                     break;
                  }
                  if(vo.id == 0)
                  {
                     vo.init(null,allStaticCityData[index][Enum_CrossClanBattle.CITY_ID],allStaticCityData[index][Enum_CrossClanBattle.CITY_NAME],allStaticCityData[index][Enum_CrossClanBattle.CITY_SILVER],endConfirmTime,allStaticCityData[index][Enum_CrossClanBattle.CITY_BATTLE_TIME],allStaticCityData[index][Enum_CrossClanBattle.CITY_INDEX]);
                  }
                  j++;
               }
            }
            else
            {
               vo.init(null,allStaticCityData[index][Enum_CrossClanBattle.CITY_ID],allStaticCityData[index][Enum_CrossClanBattle.CITY_NAME],allStaticCityData[index][Enum_CrossClanBattle.CITY_SILVER],endConfirmTime,allStaticCityData[index][Enum_CrossClanBattle.CITY_BATTLE_TIME],allStaticCityData[index][Enum_CrossClanBattle.CITY_INDEX]);
            }
            index++;
            allCityVoData.push(vo);
            allStaticCityDataByIndex[vo.index - 1] = vo;
            i++;
         }
         updateCity();
      }
      
      private static function frameStep() : void
      {
         var now:uint = uint(getTimer());
         if(now - lastTime > 1000)
         {
            ++serverTime;
            lastTime = now;
            View_AllCityPanel.instance.updateServerTime();
            if(refreshTimeCount < 2 && endConfirmTime - serverTime <= 0 && serverTime > 100 && GameUnitManager.hero.party != "")
            {
               if(!allCityTimeData.length)
               {
                  CrossClanBattleCGMessage.CG_SEGIE_TIME();
               }
               ++refreshTimeCount;
            }
         }
      }
      
      public static function setAllCityTimeData(data:Array) : void
      {
         var i:int = 0;
         var len:int = int(data.length);
         var arr:Array = [];
         var allData:Array = [];
         i = 0;
         while(i < len)
         {
            arr = [data[i][0],allStaticCityData[data[i][0]][Enum_CrossClanBattle.CITY_NAME],data[i][1] == 0 ? "无" : data[i][1] + ".S" + data[i][2],data[i][3] == 0 ? "无" : data[i][3] + ".S" + data[i][4],data[i][5]];
            allData.push(arr);
            i++;
         }
         allCityTimeData = allData;
         Global.delegate.dosomething(view_AllSiegeTimePanel.instance,view_AllSiegeTimePanel.instance.show);
         view_AllSiegeTimePanel.instance.updateData();
      }
      
      public static function setBattleConfirmData(info:String) : void
      {
         if(info == "")
         {
            return;
         }
         battleConfirmData = info.split("_");
         var cityId:int = int(battleConfirmData[Enum_CrossClanBattle.CITY_ID]);
         var vo:CityVo = new CityVo();
         vo.init(battleConfirmData,cityId,allStaticCityData[cityId][Enum_CrossClanBattle.CITY_NAME],allStaticCityData[cityId][Enum_CrossClanBattle.CITY_SILVER],endConfirmTime,allStaticCityData[cityId][Enum_CrossClanBattle.CITY_BATTLE_TIME],allStaticCityData[cityId][Enum_CrossClanBattle.CITY_INDEX]);
         View_BattleConfirmPanel.instance.show(vo);
         var i:int = 0;
         while(i < allCityVoData.length)
         {
            if(allCityVoData[i].id == vo.id)
            {
               allCityVoData[i] = vo;
               break;
            }
            i++;
         }
         updateCity();
      }
      
      public static function setBattleInfoData(time:int, endTime:int, clanOne:String, clanOneTowerCount:int, clanOnePoint:int, clanTwo:String, clanTwoTowerCount:int, clanTwoPoint:int, selfTowerCountArr:Array, enemyTowerCountArr:Array, mineHasPassTime:int, mineRefreshTime:int) : void
      {
         var remainTime:int = endTime - time;
         var data:Array = [clanOne,clanOneTowerCount,clanOnePoint,clanTwo,clanTwoTowerCount,clanTwoPoint,selfTowerCountArr,enemyTowerCountArr,mineHasPassTime,mineRefreshTime];
         View_ClanBattleInfo.instance.show(remainTime,data);
      }
      
      public static function setBattlePreTime(time:int, battleTime:int) : void
      {
         preTime = 300 - (time - battleTime);
         Global.delegate.dosomething(View_MsgPanel.instance,View_MsgPanel.instance.showPreTime);
      }
      
      public static function refreshBuff(data:Array, serverTime:int) : void
      {
         View_ClanBattleBuffPanel.instance.refreshItem(data,serverTime);
      }
      
      public static function notEnterScene() : Boolean
      {
         if(Model_team.hasTeam() == true)
         {
            UIManager.centerBroadcast.addMsg("组队状态不能进入跨服帮会战战场");
            return true;
         }
         if(SceneConfig.getSceneType() != SceneConfig.COMMON)
         {
            UIManager.centerBroadcast.addMsg("副本中不能进入跨服帮会战战场");
            return true;
         }
         return false;
      }
      
      public static function breakCollect() : void
      {
         breakCollectTowerFun();
         breakCollectMineFun();
         Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_START,breakCollect);
      }
      
      public static function breakCollectMineFun() : void
      {
         if(breakCollectMine == true)
         {
            if(Boolean(bindNpc))
            {
               CrossClanBattleCGMessage.CG_RESOURCE_MINE(Enum_CrossClanBattle.COLLECT_MINE_BREAK,bindNpc.id);
               breakCollectMine = false;
            }
         }
      }
      
      public static function breakCollectTowerFun() : void
      {
         if(breakCollectTower == true)
         {
            if(Boolean(bindNpc))
            {
               CrossClanBattleCGMessage.CG_RESOURCE_TOWER(Enum_CrossClanBattle.COLLECT_TOWER_BREAK,bindNpc.id);
               breakCollectTower = false;
            }
         }
      }
      
      public static function isClanBattleNpc(npcId:int) : Boolean
      {
         if(npcId >= 52606 && npcId <= 52611 || towerIdArr.indexOf(npcId) != -1)
         {
            return true;
         }
         return false;
      }
      
      public static function dealNpc(npcId:int, npc:Npc) : void
      {
         bindNpc = npc;
         if(npcId == 52609)
         {
            dealCrystal(npc);
         }
         else if(towerIdArr.indexOf(npcId) != -1)
         {
            dealResourceTower(npc);
         }
         else if(npcId == 52606)
         {
            dealResourceNpc(npc);
         }
         else if(npcId == 52607)
         {
            dealResourceMine(npc);
         }
         else if(npcId == 52610)
         {
            dealWarChariot(npc);
         }
         else if(npcId == 52611)
         {
            dealSoldier(npc);
         }
      }
      
      private static function dealCrystal(npc:Npc) : void
      {
         if(npc.id == selfCrystalId)
         {
            return;
         }
         CrossClanBattleCGMessage.CG_CRYSTAL(npc.id);
      }
      
      private static function dealResourceTower(npc:Npc) : void
      {
         GameUnitManager.hero.stopGo();
         CrossClanBattleCGMessage.CG_RESOURCE_TOWER(Enum_CrossClanBattle.CLICK_TOWER,npc.id);
      }
      
      public static function showGuardBtn(npc:Npc) : void
      {
         removeGuard(npc);
         View_Alert.show("确定要守护此资源塔吗？",View_Alert.OK_CANCAL,function(evt:MouseEvent = null):void
         {
            if(npc.guardId > 0)
            {
               UIManager.centerBroadcast.addMsg("守护名额已满");
               return;
            }
            CrossClanBattleCGMessage.CG_RESOURCE_TOWER(Enum_CrossClanBattle.APPLY_GUARD,npc.id);
         });
      }
      
      public static function removeGuard(npc:Npc) : void
      {
         if(GameUnitManager.hero.id == npc.guardId)
         {
            npc.showGuardRange(true);
         }
      }
      
      public static function removeAttack(npc:Npc) : void
      {
      }
      
      private static function guard(e:MouseEvent = null) : void
      {
         if(!bindNpc)
         {
            return;
         }
      }
      
      private static function attack(e:MouseEvent) : void
      {
         e.stopImmediatePropagation();
         if(Boolean(bindNpc))
         {
            CrossClanBattleCGMessage.CG_CRYSTAL(bindNpc.id);
            removeAttack(bindNpc);
         }
      }
      
      public static function dealTowerBattle(npc:Npc) : void
      {
      }
      
      private static function dealResourceNpc(npc:Npc) : void
      {
         if(npc.id == selfNpcId)
         {
            UIManager.npcDialog.show(npc);
         }
         else
         {
            UIManager.centerBroadcast.addMsg("请到本帮基地管理员处提交资源矿");
         }
      }
      
      private static function dealResourceMine(npc:Npc) : void
      {
         GameUnitManager.hero.stopGo();
         if(Model_team.hasTeam() == true)
         {
            if(Model_team.isCap() == true)
            {
               CrossClanBattleCGMessage.CG_RESOURCE_MINE(Enum_CrossClanBattle.CLICK_MINE,npc.id);
            }
            else
            {
               UIManager.centerBroadcast.addMsg("只有队长才能采集资源矿");
            }
            return;
         }
         CrossClanBattleCGMessage.CG_RESOURCE_MINE(Enum_CrossClanBattle.CLICK_MINE,npc.id);
      }
      
      private static function dealWarChariot(npc:Npc) : void
      {
         CrossClanBattleCGMessage.CG_CLICK_WAR_CAR(npc.id);
      }
      
      private static function dealSoldier(npc:Npc) : void
      {
         CrossClanBattleCGMessage.CG_SOIDIER(npc.id);
      }
      
      public static function transDate(value:Number) : String
      {
         var date:Date = new Date(value * 1000);
         var week:String = weekArr[date.getDay()];
         var hoursStr:String = date.getHours() < 10 ? "0" + date.getHours() : date.getHours().toString();
         var minutesStr:String = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes().toString();
         var secondsStr:String = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds().toString();
         return week + " " + hoursStr + ":" + minutesStr + ":" + secondsStr;
      }
      
      public static function checkRange() : void
      {
         if(checkSelfRange() == true)
         {
            if(getTimer() - lastTipTime > 10000)
            {
               lastTipTime = getTimer();
               if(View_MsgPanel.instance.visible == true)
               {
                  Global.delegate.dosomething(View_MsgPanel.instance,View_MsgPanel.instance.showTipIcon);
               }
            }
            GameUnitManager.hero.stopGo();
         }
         if(checkEnemyRange() == true)
         {
            if(getTimer() - lastTipTime > 3000)
            {
               lastTipTime = getTimer();
               UIManager.centerBroadcast.addMsg("不能进入别帮基地");
            }
            GameUnitManager.hero.stopGo();
         }
      }
      
      public static function checkSelfRange() : Boolean
      {
         if(Utils.dist(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y,selfPoint.x,selfPoint.y) >= selfR * selfR && Utils.dist(mouseX,mouseY,selfPoint.x,selfPoint.y) >= selfR * selfR && preTime > 0)
         {
            return true;
         }
         return false;
      }
      
      public static function checkEnemyRange() : Boolean
      {
         if((Utils.dist(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y,enemyPoint.x,enemyPoint.y) - 20000 < enemyR * enemyR || Utils.dist(mouseX,mouseY,enemyPoint.x,enemyPoint.y) < enemyR * enemyR) && Utils.dist(mouseX,mouseY,enemyCrystalPoint.x,enemyCrystalPoint.y) > Enum_CrossClanBattle.MIN_RANGE && Utils.dist(mouseX,mouseY,enemyCrystalPoint.x,enemyCrystalPoint.y) < Enum_CrossClanBattle.MAX_RANGE)
         {
            return true;
         }
         return false;
      }
      
      private static function dealEff() : void
      {
         if(!selfBarrierPointArr.length || !enemyBarrierPointArr.length)
         {
            return;
         }
         if(preTime > 0)
         {
            if(!eff)
            {
               eff = EffectManager.addEffect("35204",GameScene.mainLayer,750,selfBarrierPointArr[2][0],selfBarrierPointArr[2][1],true);
            }
            GameScene.mainLayer.setChildIndex(eff,0);
         }
         else
         {
            removeEff();
         }
      }
      
      public static function removeEff() : void
      {
         if(Boolean(eff) && Boolean(eff.parent))
         {
            eff.parent.removeChild(eff);
            eff = null;
         }
      }
      
      private static function dealTeamBtn() : void
      {
         if(Utils.dist(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y,Model_CrossClanBattle.selfPoint.x,Model_CrossClanBattle.selfPoint.y) >= Model_CrossClanBattle.selfR * Model_CrossClanBattle.selfR)
         {
            if(Boolean(TeamListPanel.data[Model_team.team_id]) && TeamListPanel.data[Model_team.team_id].visible == true)
            {
               TeamListPanel.data[Model_team.team_id].visible = false;
            }
            if(UIManager.teamSearchPanel.visible == true)
            {
               UIManager.teamSearchPanel.visible = false;
            }
            if(UIManager.mainMenu.visible == true)
            {
               UIManager.mainMenu.visible = false;
            }
         }
         else
         {
            UIManager.mainMenu.visible = true;
         }
      }
      
      public static function checkVisible() : void
      {
         checkRange();
         dealEff();
         dealTeamBtn();
         if(Boolean(bindNpc))
         {
            bindNpc.updateBtnXY();
            if(Boolean(bindNpc) && bindNpc.guardId == GameUnitManager.hero.id)
            {
               if(Utils.dist(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y,bindNpc.global_x,bindNpc.global_y) >= 90000)
               {
                  bindNpc.showGuardRange(false);
                  bindNpc.guardId = 0;
                  UIManager.centerBroadcast.addMsg("离开守护范围，守护失败");
                  CrossClanBattleCGMessage.CG_RESOURCE_TOWER(Enum_CrossClanBattle.CANCEL_GUARD,bindNpc.id);
                  bindNpc = null;
               }
            }
         }
      }
   }
}

