package com.yiTian.net.handler
{
   import com.utils.ColorConstant;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.gameUnit.role.Player;
   import com.yiTian.manager.CollectManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.KeyboardManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CrossCampBattleCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.crossCampBattle.CampEnterTip;
   import com.yiTian.view.modules.crossCampBattle.CrossCampBuff;
   import com.yiTian.view.modules.crossCampBattle.Enum_CrossCampBattle;
   import com.yiTian.view.modules.crossCampBattle.Model_CrossCampBattle;
   import com.yiTian.view.modules.crossCampBattle.View_CampBattlePrePanel;
   import com.yiTian.view.modules.crossCampBattle.View_CampRevivalPanel;
   import com.yiTian.view.modules.crossCampBattle.View_CrossCampBattleIconTip;
   import com.yiTian.view.modules.crossCampBattle.View_CrossCampBattleInfoPanel;
   import com.yiTian.view.modules.crossCampBattle.View_CrossCampMainPanel;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CrossCampBattleHandler
   {
      
      private static var buff:CrossCampBuff;
      
      private static var runFun:Function;
      
      private static var buffIdArr:Array = [39475,39474,53533,53534];
      
      public function CrossCampBattleHandler()
      {
         super();
      }
      
      public static function GC_OPEN_CROSS_CAMP_BATTLE_ICON(result:int) : void
      {
         if(result == 1)
         {
            View_CrossCampBattleIconTip.showTip();
         }
         else
         {
            View_CrossCampBattleIconTip.hide();
         }
      }
      
      public static function GC_CLICK_CAMP_ICON(result:int, serverTime:int, openTime:int) : void
      {
         switch(result)
         {
            case 1:
               Global.delegate.dosomething(View_CrossCampMainPanel.instance,function():void
               {
                  View_CrossCampMainPanel.instance.update(openTime + 900 - serverTime);
                  View_CrossCampMainPanel.instance.setBtnName(false);
               });
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("不是皇城争霸时间");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("等级不够");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("服务器没开");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("活动已经开始，不能进入战场");
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("不知什麽情況，找華");
               break;
            case 7:
               UIManager.centerBroadcast.addMsg("报名时间已截止");
               break;
            case 8:
               UIManager.centerBroadcast.addMsg("战场已开启，欢迎参与下次活动");
               break;
            case 9:
               UIManager.centerBroadcast.addMsg("活动还没开始，稍等");
         }
      }
      
      public static function GC_CAMP_OPEN_TIP() : void
      {
         Global.delegate.dosomething(CampEnterTip.instance,function():void
         {
            CampEnterTip.instance.show("战场已开启是否进入战场，关闭此窗口后可在活动图标处进入战场","确定进入","enter");
         });
         Global.delegate.dosomething(View_CrossCampMainPanel.instance,View_CrossCampMainPanel.instance.showEnterBitmap);
      }
      
      public static function GC_MATCH(result:int, serverTime:int, openTime:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("成功进入匹配");
               View_CrossCampMainPanel.instance.setBtnName(true);
               Model_CrossCampBattle.isMatch = true;
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("成功取消匹配");
               Model_CrossCampBattle.isMatch = false;
               View_CrossCampMainPanel.instance.setBtnName(false);
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("没有匹配，无法取消匹配");
               View_CrossCampMainPanel.instance.setBtnName(false);
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("服务器已满");
         }
         Global.delegate.dosomething(View_CrossCampMainPanel.instance,function():void
         {
            View_CrossCampMainPanel.instance.update(openTime + 900 - serverTime);
         });
      }
      
      public static function GC_ENTER_CAMP_SCENE_RESULT(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("失败原因");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("不在报名名单中,请在8:00-8:15报名");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("请下次准时参加活动");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("没有队伍类型");
         }
      }
      
      public static function GC_ENTER_CAMP_SCENE(result:int, serverTime:int, openTime:int, ownCampId:String, enemyCampId:String) : void
      {
         var time:int = 0;
         switch(result)
         {
            case 1:
               Model_CrossCampBattle.ownCampId = ownCampId;
               Model_CrossCampBattle.enemyCampId = enemyCampId;
               time = openTime - serverTime;
               Model_CrossCampBattle.preTime = time;
               Global.delegate.dosomething(View_CampBattlePrePanel.instance,View_CampBattlePrePanel.instance.showPreTime);
               KeyboardManager.isEnabled = false;
               Global.control.sendNotification(Enum_CrossCampBattle.ENTER_SCENE_OK,null);
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("没有宠物");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("副本不存在");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("等级不匹配,升级了吗？");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("活动结束了，请下次准时啦");
               break;
            case 10:
               UIManager.centerBroadcast.addMsg("2个角色ID不匹配");
         }
      }
      
      public static function GC_ENTER_CAMP_DATA(selfX:int, selfY:int, selfR:int, enemyX:int, enemyY:int, enemyR:int, selfBannersId:int, enemyBannersId:int, selfNpcId:int, enemyNpcId:int, selfBuffData:Array, enemyBuffData:Array, selfWarCarArr:Array, enemyWarCarArr:Array) : void
      {
         if(selfX == 389)
         {
            Model_CrossCampBattle.selfPoint.x = 629;
            Model_CrossCampBattle.selfPoint.y = 4610;
            Model_CrossCampBattle.enemyPoint.x = 7125;
            Model_CrossCampBattle.enemyPoint.y = 40;
         }
         else
         {
            Model_CrossCampBattle.selfPoint.x = 7125;
            Model_CrossCampBattle.selfPoint.y = 40;
            Model_CrossCampBattle.enemyPoint.x = 629;
            Model_CrossCampBattle.enemyPoint.y = 4610;
         }
         Model_CrossCampBattle.selfR = selfR;
         Model_CrossCampBattle.enemyR = enemyR;
         Model_CrossCampBattle.ownBannersId = selfBannersId;
         Model_CrossCampBattle.enemyBannersId = enemyBannersId;
         Model_CrossCampBattle.selfNpcId = selfNpcId;
         Model_CrossCampBattle.enemyNpcId = enemyNpcId;
         Model_CrossCampBattle.buffPointArr = selfBuffData;
         Model_CrossCampBattle.buffEnemyPointArr = enemyBuffData;
         Model_CrossCampBattle.selfWarCarArr = selfWarCarArr;
         Model_CrossCampBattle.enemyWarCarArr = enemyWarCarArr;
         updateNpcStatus();
      }
      
      private static function updateNpcStatus() : void
      {
         var npcName:String = null;
         var _npc:Array = [];
         var enemyNpc:Npc = GameUnitManager.findUnit(Model_CrossCampBattle.enemyNpcId,UnitType.NPC) as Npc;
         if(Boolean(enemyNpc))
         {
            _npc = Data_lib.npc[enemyNpc.sysId];
            npcName = _npc[Npc.NAME];
            Model_CrossCampBattle.emenyNpcPoint.x = enemyNpc.x;
            Model_CrossCampBattle.emenyNpcPoint.y = enemyNpc.y;
            enemyNpc.name = "<font color=\'#fe0000\'>" + npcName + "</font>";
            enemyNpc.show();
         }
         dealNpcName(Model_CrossCampBattle.ownBannersId,true);
         dealNpcName(Model_CrossCampBattle.enemyBannersId,false);
         dealNpcName(Model_CrossCampBattle.selfNpcId,true);
         var i:int = 0;
         while(i < Model_CrossCampBattle.selfWarCarArr.length)
         {
            dealNpcName(Model_CrossCampBattle.selfWarCarArr[i],true);
            i++;
         }
         i = 0;
         while(i < Model_CrossCampBattle.enemyWarCarArr.length)
         {
            dealNpcName(Model_CrossCampBattle.enemyWarCarArr[i],false);
            i++;
         }
      }
      
      private static function dealNpcName(id:int, self:Boolean) : void
      {
         var npcName:String = null;
         var npc:Npc = null;
         var _npc:Array = [];
         npc = GameUnitManager.findUnit(id,UnitType.NPC) as Npc;
         if(!npc)
         {
            return;
         }
         _npc = Data_lib.npc[npc.sysId];
         npcName = _npc[Npc.NAME];
         if(self == true)
         {
            npc.name = "<font color=\'#04ff00\'>" + npcName + "</font>";
         }
         else
         {
            npc.name = "<font color=\'#fe0000\'>" + npcName + "</font>";
         }
         if(npc.sysId == 53538 && Model_CrossCampBattle.battleCarArr.indexOf(npc.id) == -1)
         {
            npc.addCampCarEff();
         }
         npc.show();
      }
      
      public static function GC_EXIT_CAMP_SCENE(result:int) : void
      {
         switch(result)
         {
            case 1:
               Model_CrossCampBattle.leaveFun();
               if(Boolean(buff))
               {
                  UIManager.heroHead.removeBuff(buff);
                  buff.dispose();
               }
         }
      }
      
      public static function GC_CAMP_COLLECT_CRYSTAL(result:int, id:int) : void
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
               CollectManager.begin(npc,3000,function():void
               {
                  CrossCampBattleCGMessage.CG_CAMP_COLLECT_CRYSTAL(Enum_CrossCampBattle.COLLECT_CRYSTAL_FINISH,npc.id);
               });
               Model_CrossCampBattle.breakCollectCrystal = true;
               Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_START,CollectManager.end);
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("该水晶已被采",1);
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("已经有成员在采集",1);
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("开始跟敌人战斗",1);
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("已经有水晶，每次只能采集一次水晶",1);
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("该水晶已被采集或消失",1);
               break;
            case 7:
               UIManager.centerBroadcast.addMsg("你正在采集",1);
               break;
            case 8:
               UIManager.centerBroadcast.addMsg("每次只能采集一次水晶",1);
               break;
            case 11:
               UIManager.centerBroadcast.addMsg("角色ID不匹配",1);
               break;
            case 12:
               UIManager.centerBroadcast.addMsg("距离太远，不能采集",1);
               break;
            case 13:
               UIManager.centerBroadcast.addMsg("玩家正在采集别的矿,如果异常,请等待N秒后再尝试",1);
               break;
            case 14:
               Global.delegate.dosomething(CampEnterTip.instance,function():void
               {
                  CampEnterTip.instance.show("获得水晶后交给己方阵营总管可为己方旗帜回血","确定");
               });
               GameUnitManager.hero.lockTarget = null;
         }
      }
      
      public static function GC_CAMP_COLLECT_BUFF(result:int, id:int) : void
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
               CollectManager.begin(npc,3000,function():void
               {
                  CrossCampBattleCGMessage.CG_CAMP_COLLECT_BUFF(Enum_CrossCampBattle.COLLECT_BUFF_FINISH,npc.id);
               });
               Model_CrossCampBattle.breakCollectBuff = true;
               Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_START,CollectManager.end);
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("该BUFF已被采",1);
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("已经有成员在采集",1);
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("开始跟敌人战斗",1);
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("身上已经携带此BUFF不可重复采集",1);
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("该BUFF已被采集或消失",1);
               break;
            case 7:
               UIManager.centerBroadcast.addMsg("你正在采集",1);
               break;
            case 8:
               UIManager.centerBroadcast.addMsg("每次只能采集一次BUFF",1);
               break;
            case 11:
               UIManager.centerBroadcast.addMsg("角色ID不匹配",1);
               break;
            case 12:
               UIManager.centerBroadcast.addMsg("距离太远，不能采集",1);
               break;
            case 13:
               UIManager.centerBroadcast.addMsg("玩家正在采集别的BUFF,如果异常,请等待N秒后再尝试",1);
               break;
            case 39475:
               Global.delegate.dosomething(CampEnterTip.instance,function():void
               {
                  CampEnterTip.instance.show("获得炸弹后可直接炸毁敌方战车对玩家无效","确定");
               });
               GameUnitManager.hero.lockTarget = null;
               break;
            case 39474:
               Global.delegate.dosomething(CampEnterTip.instance,function():void
               {
                  CampEnterTip.instance.show("获得飞剑可点击敌方玩家将其秒杀,对携带战车的玩家无效","确定");
               });
               GameUnitManager.hero.lockTarget = null;
         }
      }
      
      public static function GC_CAMP_WAR_CAR(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("驾驶成功",1);
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("战车不存在",1);
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("非本阵营战车");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("炸敌人战车成功",1);
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("战车跑远了",1);
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("战车不存在",1);
               break;
            case 10:
               UIManager.centerBroadcast.addMsg("你离战车太远了",1);
               break;
            case 20:
               Model_CrossCampBattle.selfWarCar = true;
               if(Model_team.hasTeam() == true)
               {
                  View_Alert.show("是否确定驾驶战车",View_Alert.OK_CANCAL,function(evt:MouseEvent = null):void
                  {
                     if(Boolean(Model_CrossCampBattle.bindNpc))
                     {
                        CrossCampBattleCGMessage.CG_CAMP_WAR_CAR(Model_CrossCampBattle.bindNpc.id,Enum_CrossCampBattle.DRIVE_WAR_CAR);
                     }
                  });
                  break;
               }
               UIManager.centerBroadcast.addMsg("只有队长才能驾驶战车，请组队！",1);
               break;
            case 21:
               Model_CrossCampBattle.selfWarCar = false;
               View_Alert.show("是否炸毁此战车",View_Alert.OK_CANCAL,function(evt:MouseEvent = null):void
               {
                  if(Boolean(Model_CrossCampBattle.bindNpc))
                  {
                     CrossCampBattleCGMessage.CG_CAMP_WAR_CAR(Model_CrossCampBattle.bindNpc.id,Enum_CrossCampBattle.BOMB_WAR_CAR);
                  }
               });
               break;
            case 22:
               UIManager.centerBroadcast.addMsg("活动未开始，不能驾驶战车",1);
         }
      }
      
      public static function GC_CAMP_COMMIT_ITEM(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("上交成功",1);
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("你没有水晶",1);
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("你没有玉精髓",1);
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("不是本阵营管理员",1);
               break;
            case 10:
               UIManager.centerBroadcast.addMsg("距离太远",1);
         }
      }
      
      public static function GC_CAMP_INFO(selfId:String, selfBlood:String, selfMaxBlood:String, enemyId:String, enemyBlood:String, enemyMaxBlood:String, redQiZiId:int, blueQiZiId:int) : void
      {
         View_CrossCampBattleInfoPanel.instance.update(selfBlood,selfMaxBlood,enemyBlood,enemyMaxBlood,redQiZiId,blueQiZiId);
      }
      
      public static function GC_BUFF_COUNTDOWN(mineTime:int, buffTime:int, serverTime:int) : void
      {
         View_CrossCampBattleInfoPanel.instance.updateBuffTime(mineTime - serverTime,buffTime - serverTime);
      }
      
      public static function GC_CAMP_PLAYER_POINTS(points:int) : void
      {
         View_CrossCampBattleInfoPanel.instance.updatePoints(points);
      }
      
      public static function GC_CAMP_UPDATE_STATUS(result:int, playerId:Number, id:String) : void
      {
         var player:Player = GameUnitManager.findUnit(playerId,UnitType.PLAYER) as Player;
         if(!player)
         {
            return;
         }
         player.campId = id;
         if(Model_CrossCampBattle.ownCampId == player.campId)
         {
            player.name = HtmlUtil.font(player.name,ColorConstant.getColorStr(ColorConstant.BLUE));
         }
         else
         {
            player.name = HtmlUtil.font(player.name,ColorConstant.getColorStr(ColorConstant.RED));
         }
         player.nameBar.show();
         if(result == 6)
         {
            player.addBattleEff();
            player.removeCampWarCarEffect();
         }
         else if(result == 5)
         {
            player.addCampWarCarEff();
            player.removeBattleEff();
         }
         else
         {
            player.removeBattleEff();
            player.removeCampWarCarEffect();
            player.crossCampBattleBuff = result - 1;
         }
         if(playerId == GameUnitManager.hero.id)
         {
            if(buffIdArr.indexOf(result) == -1)
            {
               if(Boolean(buff))
               {
                  UIManager.heroHead.removeBuff(buff);
                  buff.dispose();
               }
            }
            else if(buffIdArr.indexOf(result) != -1)
            {
               if(Boolean(buff) && buff.id == result)
               {
                  return;
               }
               buff = new CrossCampBuff();
               buff.update(result);
               UIManager.heroHead.addBuff(buff);
            }
         }
      }
      
      public static function GC_CAMP_ATTACK_PLAYER(data:Array, result:int) : void
      {
         var player:Player = null;
         switch(result)
         {
            case 1:
               GameUnitManager.hero.lockTarget = null;
               break;
            case 2:
               if(!data.length)
               {
                  return;
               }
               player = GameUnitManager.findUnit(data[0],UnitType.PLAYER) as Player;
               if(!player)
               {
                  return;
               }
               View_Alert.show("是否摧毁该玩家的战车",View_Alert.OK_CANCAL,function(evt:MouseEvent = null):void
               {
                  CrossCampBattleCGMessage.CG_CAMP_ATTACK_PLAYER(data[0],Enum_CrossCampBattle.PK_WAR_CAR,0);
               });
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("玩家不存在",1);
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("飞剑攻击",1);
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("炸弹攻击",1);
               break;
            case 10:
               UIManager.centerBroadcast.addMsg("距离太远",1);
         }
      }
      
      public static function GC_CAMP_ATTACK_BANNERS(result:int) : void
      {
         switch(result)
         {
            case 1:
               GameUnitManager.hero.lockTarget = null;
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("战旗已被破坏",1);
               break;
            case 10:
               UIManager.centerBroadcast.addMsg("距离太远",1);
               break;
            case 11:
               UIManager.centerBroadcast.addMsg("玩家还在战斗中",1);
         }
      }
      
      public static function GC_CAMP_REVIVE(result:int, serverTime:int, endBattleTime:int) : void
      {
         var time:int = 30 - (serverTime - endBattleTime);
         switch(result)
         {
            case 1:
               View_CampRevivalPanel.instance.hide();
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("时间未到,别乱复活",1);
               View_CampRevivalPanel.instance.show(time);
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("元宝不足",1);
               View_CampRevivalPanel.instance.show(time);
         }
      }
      
      public static function GC_WAR_CAR_COUNTDOWN(deadTime:int, time:int, id:int) : void
      {
         var npc:Npc = GameUnitManager.findUnit(id,UnitType.NPC) as Npc;
         if(!npc)
         {
            return;
         }
         npc.showCountCownText(deadTime - time);
      }
      
      public static function GC_PLAY_BATTLE_EFFECT(type:int, teamA:Array, teamB:Array) : void
      {
         var player:Player = null;
         var i:int = 0;
         switch(type)
         {
            case 1:
               i = 0;
               while(i < teamB.length)
               {
                  player = GameUnitManager.findUnit(teamB[i],UnitType.PLAYER) as Player;
                  if(Boolean(player))
                  {
                     player.addEffect("35300",false,12,5,2500,-1,function():void
                     {
                        i = 0;
                        while(i < teamB.length)
                        {
                           if(teamB[i] == GameUnitManager.hero.id)
                           {
                              CrossCampBattleCGMessage.CG_BATTLE_VERSION(Model_CrossCampBattle.battleVersion);
                              break;
                           }
                           ++i;
                        }
                     });
                  }
                  i++;
               }
               break;
            case 2:
               i = 0;
               while(i < teamB.length)
               {
                  player = GameUnitManager.findUnit(teamB[i],UnitType.PLAYER) as Player;
                  if(Boolean(player))
                  {
                     EffectManager.addEffect("35300",player.parent as Sprite,2500,player.x + 12,player.y + 5,false,3,function():void
                     {
                        i = 0;
                        while(i < teamB.length)
                        {
                           if(teamB[i] == GameUnitManager.hero.id)
                           {
                              CrossCampBattleCGMessage.CG_BATTLE_VERSION(Model_CrossCampBattle.battleVersion);
                              break;
                           }
                           ++i;
                        }
                     });
                  }
                  i++;
               }
         }
      }
      
      public static function GC_REVIVE_VERSION(result:Number) : void
      {
         Model_CrossCampBattle.battleVersion = result;
      }
      
      public static function GC_CAMP_COMMON_TIP(result:int) : void
      {
         switch(result)
         {
            case 2:
               UIManager.centerBroadcast.addMsg("距离不足",1);
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("NPC不存在",1);
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("该玩家距离不足",1);
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("不是敌对阵营",1);
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("只有队长才能驾驶战车，请组队！",1);
               break;
            case 7:
               updateNpcStatus();
               break;
            case 8:
               UIManager.centerBroadcast.addMsg("元宝不足",1);
               break;
            case 9:
               UIManager.centerBroadcast.addMsg("有战车不能采集",1);
               break;
            case 10:
               UIManager.centerBroadcast.addMsg("玩家正在战斗中",1);
         }
      }
      
      public static function GC_CAMP_WARCAR_MOVE(playerId:Number, carId:int, type:int) : void
      {
         var player:Player = null;
         var tempRoute:Array = null;
         var index:int = 0;
         var npc:Npc = GameUnitManager.findUnit(carId,UnitType.NPC) as Npc;
         if(type == 1)
         {
            player = GameUnitManager.findUnit(playerId,UnitType.PLAYER) as Player;
            if(!player)
            {
               return;
            }
            if(Model_CrossCampBattle.battleCarArr.indexOf(carId) == -1)
            {
               Model_CrossCampBattle.battleCarArr.push(carId);
               Model_CrossCampBattle.battleCarPlayerArr.push(playerId);
            }
            if(Boolean(player.tempRoute))
            {
               tempRoute = player.tempRoute;
            }
            else if(Boolean(player.route))
            {
               tempRoute = player.route;
            }
            else
            {
               tempRoute = [];
            }
            if(Boolean(npc))
            {
               npc.removeCampCarEffect();
               npc.countdownTime = 0;
            }
            Model_CrossCampBattle.setWarCarRoute(player,tempRoute,carId);
         }
         else if(type == 2)
         {
            index = Model_CrossCampBattle.battleCarArr.indexOf(carId);
            if(index != -1)
            {
               if(Boolean(npc))
               {
                  npc.route = [];
               }
               Model_CrossCampBattle.battleCarArr.splice(index,1);
               Model_CrossCampBattle.battleCarPlayerArr.splice(index,1);
            }
         }
      }
      
      public static function GC_CAMP_OPEN_REVIVI_PANEL() : void
      {
         View_CampRevivalPanel.instance.show(60);
      }
   }
}

