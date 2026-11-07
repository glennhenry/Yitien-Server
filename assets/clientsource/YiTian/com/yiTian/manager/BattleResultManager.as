package com.yiTian.manager
{
   import com.yiTian.data.config.Enum_battle_delay_type;
   import com.yiTian.data.config.Enum_thing_sysType;
   import com.yiTian.data.config.Enum_thing_type;
   import com.yiTian.data.model.Model_Battle;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.net.handler.QiJuHandler;
   import com.yiTian.net.message.cg.CrossCampBattleCGMessage;
   import com.yiTian.view.modules.battle.SiWangFuHuoPanel;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import com.yiTian.view.modules.crossCampBattle.Model_CrossCampBattle;
   import flash.utils.Dictionary;
   
   public class BattleResultManager
   {
      
      private static var data:Dictionary = new Dictionary();
      
      private static var delayData:Array = [];
      
      public function BattleResultManager()
      {
         super();
      }
      
      public static function addInfo(battleId:int, module:int, info:Array) : void
      {
         data[battleId] = {
            "module":module,
            "info":info
         };
      }
      
      public static function pushDelayInfo(data:Array) : void
      {
         delayData.push(data);
      }
      
      public static function dealResult(battleId:int, type:int, isWin:int) : void
      {
         trace("BattleResult",battleId,type,Boolean(isWin) ? "胜" : "负");
         if(GameUnitManager.hero.status == Status.WU_LING)
         {
            UIManager.countDown_tip.isBattleHandle();
            if(!isWin)
            {
               UIManager.countDown_tip.deadTimeHandle();
               UIManager.centerBroadcast.addMsg("您获得了1点积分",1);
            }
            else
            {
               UIManager.centerBroadcast.addMsg("您获得了2点积分",1);
            }
         }
         if(SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            CrossCampBattleCGMessage.CG_BATTLE_VERSION(Model_CrossCampBattle.battleVersion);
         }
         var battleInfo:Object = data[battleId];
         delete data[battleId];
         if(Boolean(battleInfo))
         {
            explain(battleInfo.module,battleInfo.info);
         }
         dealDelayInfo();
      }
      
      private static function explain(module:int, info:Array) : void
      {
         var thingInfo:String = null;
         var discript:String = null;
         var type:int = 0;
         Model_Battle.last_battle_rewards = info;
         switch(module)
         {
            case Enum_thing_sysType.BATTLE:
               EffectManager.showEff(info);
               break;
            case Enum_thing_sysType.SIWANG_FUHUO:
               UIManager.siWangFuHuoPanel.show(SiWangFuHuoPanel.PATA);
               break;
            case Enum_thing_sysType.WANANSI_SIWANG_FUHUO:
               UIManager.siWangFuHuoPanel.show(SiWangFuHuoPanel.WANANSI);
               break;
            case Enum_thing_sysType.QIJU_SIWANG_FUHUO:
               UIManager.siWangFuHuoPanel.show(SiWangFuHuoPanel.QIJU);
               break;
            case Enum_thing_sysType.GMD_REVIVE:
               UIManager.siWangFuHuoPanel.show(SiWangFuHuoPanel.GMD);
         }
         var len:int = int(info.length);
         var i:int = 0;
         while(i < len)
         {
            type = int(info[i][0]);
            if(type == Enum_thing_type.EQUIP)
            {
               thingInfo = Enum_BroadCastTool.instance.getEquipText(info[i][1]) + "×" + info[i][2];
            }
            else if(type == Enum_thing_type.ITEM)
            {
               thingInfo = Enum_BroadCastTool.instance.getItemText(info[i][1]) + "×" + info[i][2];
            }
            else
            {
               if(type == Enum_thing_type.QIJU)
               {
                  if(info[i][1] == 0)
                  {
                     return;
                  }
                  QiJuHandler.addQiJuEvent(info[i][1]);
                  return;
               }
               thingInfo = info[i][2];
            }
            discript = Enum_thing_type.getDiscript(type).replace("&va",thingInfo);
            UIManager.centerBroadcast.addMsg(discript,1);
            UIManager.selfBroadcast.addMsg(discript,1);
            i++;
         }
      }
      
      private static function dealDelayInfo() : void
      {
         while(Boolean(delayData.length))
         {
            dealDelayInfoItem(delayData.shift());
         }
      }
      
      private static function dealDelayInfoItem(data:Array) : void
      {
         switch(int(data[0]))
         {
            case Enum_battle_delay_type.HERO_QUEST:
               UIManager.questHeroPanel.showQuestBegin();
         }
      }
   }
}

