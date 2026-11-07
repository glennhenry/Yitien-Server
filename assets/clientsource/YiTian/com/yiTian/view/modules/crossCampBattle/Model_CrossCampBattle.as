package com.yiTian.view.modules.crossCampBattle
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.gameUnit.role.Player;
   import com.yiTian.gameUnit.role.Role;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.KeyboardManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CrossCampBattleCGMessage;
   import com.yiTian.net.message.cg.CrossClanBattleCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.crossClanBattle.Model_CrossClanBattle;
   import com.yiTian.view.modules.team.TeamListPanel;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class Model_CrossCampBattle
   {
      
      public static var selfWarCar:Boolean;
      
      public static var selfNpcId:int;
      
      public static var enemyNpcId:int;
      
      public static var bindNpc:Npc;
      
      public static var breakCollectCrystal:Boolean;
      
      public static var breakCollectBuff:Boolean;
      
      public static var selfR:int;
      
      public static var enemyR:int;
      
      public static var ownCampId:String;
      
      public static var enemyCampId:String;
      
      public static var ownBannersId:int;
      
      public static var enemyBannersId:int;
      
      public static var heroS:int;
      
      public static var battleVersion:Number;
      
      public static var canBattle:Boolean;
      
      private static var lastTipTime:uint;
      
      public static var preTime:int = 10;
      
      public static var buffPointArr:Array = [];
      
      public static var buffEnemyPointArr:Array = [];
      
      public static var selfPoint:Point = new Point();
      
      public static var enemyPoint:Point = new Point();
      
      public static var emenyNpcPoint:Point = new Point();
      
      public static var selfWarCarArr:Array = [];
      
      public static var enemyWarCarArr:Array = [];
      
      public static var battleCarArr:Array = [];
      
      public static var battleCarPlayerArr:Array = [];
      
      private static var buffArr:Array = [];
      
      private static var buffEnemyArr:Array = [];
      
      public static var isMatch:Boolean = false;
      
      public static var hasDie:Boolean = false;
      
      public function Model_CrossCampBattle()
      {
         super();
      }
      
      public static function dealNpc(npcId:int, npc:Npc) : void
      {
         bindNpc = npc;
         if(npcId == 53535 || npcId == 53536)
         {
            dealHuangQi(npc);
         }
         else if(npcId == 53533 || npcId == 53534)
         {
            dealCrystal(npc);
         }
         else if(npcId == 53531 || npcId == 53532)
         {
            dealCommitNpc(npc);
         }
         else if(npcId == 53538)
         {
            dealWarChariot(npc);
         }
         else if(npcId == 53537)
         {
            dealBuff(npc);
         }
      }
      
      public static function isHuangqi(sysId:int) : Boolean
      {
         return sysId == 53535 || sysId == 53536;
      }
      
      private static function dealHuangQi(npc:Npc) : void
      {
         CrossCampBattleCGMessage.CG_CAMP_ATTACK_BANNERS(npc.id);
      }
      
      private static function dealCrystal(npc:Npc) : void
      {
         CrossCampBattleCGMessage.CG_CAMP_COLLECT_CRYSTAL(Enum_CrossCampBattle.CLICK_CRYSTAL,npc.id);
         GameUnitManager.hero.stopGo();
      }
      
      private static function dealCommitNpc(npc:Npc) : void
      {
         if(npc.id == selfNpcId)
         {
            UIManager.npcDialog.show(npc);
         }
         else
         {
            UIManager.centerBroadcast.addMsg("不是本阵营管理员",1);
         }
      }
      
      private static function dealWarChariot(npc:Npc) : void
      {
         if(selfWarCarArr.indexOf(npc.id) != -1)
         {
            if(Model_team.hasTeam() == true)
            {
               if(battleCarArr.indexOf(npc.id) == -1)
               {
                  if(battleCarPlayerArr.indexOf(GameUnitManager.hero.id) != -1)
                  {
                     UIManager.centerBroadcast.addMsg("你已驾驶了一辆战车",1);
                     return;
                  }
                  View_Alert.show("是否确定驾驶战车",View_Alert.OK_CANCAL,function(evt:MouseEvent = null):void
                  {
                     CrossCampBattleCGMessage.CG_CAMP_WAR_CAR(npc.id,Enum_CrossCampBattle.DRIVE_WAR_CAR);
                  });
               }
            }
            else
            {
               UIManager.centerBroadcast.addMsg("只有队长才能驾驶战车，请组队！",1);
            }
         }
         else if(enemyWarCarArr.indexOf(npc.id) != -1)
         {
            if(battleCarArr.indexOf(npc.id) != -1)
            {
               if(GameUnitManager.hero.crossCampBattleBuff == 39474)
               {
                  View_Alert.show("是否炸毁此战车",View_Alert.OK_CANCAL,function(evt:MouseEvent = null):void
                  {
                     CrossCampBattleCGMessage.CG_CAMP_WAR_CAR(npc.id,Enum_CrossCampBattle.BOMB_WAR_CAR);
                  });
               }
               else
               {
                  CrossCampBattleCGMessage.CG_CAMP_WAR_CAR(npc.id,Enum_CrossCampBattle.BOMB_WAR_CAR);
               }
            }
            else
            {
               UIManager.centerBroadcast.addMsg("战车没被驾驶不能炸",1);
            }
         }
      }
      
      private static function dealBuff(npc:Npc) : void
      {
         CrossCampBattleCGMessage.CG_CAMP_COLLECT_BUFF(Enum_CrossCampBattle.CLICK_BUFF,npc.id);
         GameUnitManager.hero.stopGo();
      }
      
      public static function breakCollect() : void
      {
         breakCollectCrystalFun();
         breakCollectBuffFun();
         Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_START,breakCollect);
      }
      
      public static function breakCollectCrystalFun() : void
      {
         if(breakCollectCrystal == true)
         {
            if(Boolean(bindNpc))
            {
               CrossCampBattleCGMessage.CG_CAMP_COLLECT_CRYSTAL(Enum_CrossCampBattle.COLLECT_CRYSTAL_BREAK,bindNpc.id);
               breakCollectCrystal = false;
            }
         }
      }
      
      public static function breakCollectBuffFun() : void
      {
         if(breakCollectBuff == true)
         {
            if(Boolean(bindNpc))
            {
               CrossCampBattleCGMessage.CG_CAMP_COLLECT_BUFF(Enum_CrossCampBattle.COLLECT_BUFF_BREAK,bindNpc.id);
               breakCollectBuff = false;
            }
         }
      }
      
      public static function checkVisible() : void
      {
         checkRange();
         dealEff();
         dealEnemyEff();
         dealTeamBtn();
      }
      
      private static function dealTeamBtn() : void
      {
         if(Utils.dist(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y,selfPoint.x,selfPoint.y) >= selfR * selfR)
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
         else if(hasDie == false)
         {
            UIManager.mainMenu.visible = true;
         }
         else
         {
            UIManager.mainMenu.visible = false;
         }
      }
      
      public static function setSingleCarRoute(role:Role, path:Array) : void
      {
         var cars:Array = null;
         var i:int = 0;
         if(battleCarArr.length > 0 && SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            cars = battleCarArr;
            i = 0;
            while(i < cars.length)
            {
               if(battleCarPlayerArr[i] == role.id)
               {
                  setWarCarRoute(role,path,cars[i]);
                  break;
               }
               i++;
            }
         }
      }
      
      public static function setWarCarRoute(role:Role, path:Array, carId:int) : void
      {
         var npc:Npc = null;
         npc = GameUnitManager.findUnit(carId,UnitType.NPC) as Npc;
         if(Boolean(npc))
         {
            GameUnitManager.setTempRoute(npc,role,path,0);
            npc.speed = role.speed;
         }
      }
      
      public static function checkRange(value:Boolean = false) : Boolean
      {
         if(checkSelfRange() == true)
         {
            GameUnitManager.hero.stopGo();
            return true;
         }
         if(checkEnemyRange() == true)
         {
            if(value == true)
            {
               UIManager.centerBroadcast.addMsg("无法进入敌方阵营安全区");
               value = false;
            }
            GameUnitManager.hero.stopGo();
            return true;
         }
         return false;
      }
      
      public static function checkSelfRange() : Boolean
      {
         if(Utils.dist(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y,selfPoint.x,selfPoint.y) >= (selfR - 30) * (selfR - 30) && Utils.dist(Model_CrossClanBattle.mouseX,Model_CrossClanBattle.mouseY,selfPoint.x,selfPoint.y) >= (selfR - 30) * (selfR - 30) && preTime > 0)
         {
            return true;
         }
         return false;
      }
      
      public static function checkEnemyRange() : Boolean
      {
         if(Utils.dist(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y,enemyPoint.x,enemyPoint.y) < enemyR * enemyR && Utils.dist(Model_CrossClanBattle.mouseX,Model_CrossClanBattle.mouseY,enemyPoint.x,enemyPoint.y) < enemyR * enemyR)
         {
            return true;
         }
         return false;
      }
      
      private static function dealEff() : void
      {
         var eff:Effect = null;
         if(buffArr.length > 0)
         {
            return;
         }
         var i:int = 0;
         while(i < buffPointArr.length)
         {
            eff = EffectManager.addEffect("35309",GameScene.mainLayer,750,buffPointArr[i][0],buffPointArr[i][1],true);
            buffArr.push(eff);
            GameScene.mainLayer.setChildIndex(eff,0);
            i++;
         }
      }
      
      public static function removeEff() : void
      {
         var eff:Effect = null;
         var i:int = buffArr.length - 1;
         while(i >= 0)
         {
            eff = buffArr[i];
            EffectManager.removeEffect(eff);
            buffArr.splice(i,1);
            i--;
         }
      }
      
      private static function dealEnemyEff() : void
      {
         var eff:Effect = null;
         if(buffEnemyArr.length > 0)
         {
            return;
         }
         var i:int = 0;
         while(i < buffEnemyPointArr.length)
         {
            eff = EffectManager.addEffect("35309",GameScene.mainLayer,750,buffEnemyPointArr[i][0],buffEnemyPointArr[i][1],true);
            buffEnemyArr.push(eff);
            GameScene.mainLayer.setChildIndex(eff,0);
            i++;
         }
      }
      
      public static function removeEnemyEff() : void
      {
         var eff:Effect = null;
         var i:int = buffEnemyArr.length - 1;
         while(i >= 0)
         {
            eff = buffEnemyArr[i];
            EffectManager.removeEffect(eff);
            buffEnemyArr.splice(i,1);
            i--;
         }
      }
      
      public static function doCampBattle(params:String) : void
      {
         var paramsArr:Array = params.split("_");
         var result:int = int(paramsArr[0]);
         var status:int = int(paramsArr[1]);
         heroS = paramsArr[0];
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN_OK,showPanel);
      }
      
      private static function showPanel() : void
      {
         if(SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            View_CrossCampBattleInfoPanel.instance.show();
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_FUBEN_OK,showPanel);
         }
      }
      
      public static function leaveFun() : void
      {
         var player:Player = null;
         var t:int = 0;
         KeyboardManager.isEnabled = true;
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_FUBEN_OK,showPanel);
         Model_CrossClanBattle.port = 0;
         SocketManager.setChangeSocketFun(false);
         SocketManager.setKuafuSocketFun(false);
         battleCarArr = [];
         battleCarPlayerArr = [];
         CrossClanBattleCGMessage.CG_KUAFUCLAN_BATTLE_CHANGE_SOCKET(Enum_CrossCampBattle.NEED_LOAD);
         removeEff();
         removeEnemyEff();
         if(View_CampRevivalPanel.instance.visible == true)
         {
            View_CampRevivalPanel.instance.hide();
         }
         preTime = 0;
         for each(player in Player.list)
         {
            (player as Player).crossCampBattleBuff = 0;
            (player as Player).removeCampWarCarEffect();
         }
         t = int(setTimeout(function():void
         {
            View_CrossCampBattleInfoPanel.instance.hide();
            UIManager.heroHead.update();
            clearTimeout(t);
         },500));
      }
      
      public static function notEnterScene() : Boolean
      {
         if(GameUnitManager.hero.level < 90)
         {
            UIManager.centerBroadcast.addMsg("等级不足90，无法进入");
            return true;
         }
         if(GameUnitManager.hero.paoBiao > 0)
         {
            UIManager.centerBroadcast.addMsg("拉镖状态下不能进入校场");
            return true;
         }
         if(Model_team.hasTeam() == true)
         {
            UIManager.centerBroadcast.addMsg("请退出队伍后再进入校场");
            return true;
         }
         if(SceneConfig.getSceneType() != SceneConfig.COMMON)
         {
            UIManager.centerBroadcast.addMsg("请在各大主城内进入校场");
            return true;
         }
         return false;
      }
   }
}

