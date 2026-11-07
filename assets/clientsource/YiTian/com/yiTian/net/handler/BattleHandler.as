package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.data.Enum_battleType;
   import com.yiTian.data.config.Enum_server_battleunit;
   import com.yiTian.data.model.Model_Battle;
   import com.yiTian.data.vo.Vo_battle_lib_data;
   import com.yiTian.manager.BattleManager;
   import com.yiTian.manager.BattleResultManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.battle.SiWangFuHuoPanel;
   
   public class BattleHandler
   {
      
      public function BattleHandler()
      {
         super();
      }
      
      public static function GC_BATTLE(battleId:Number, result:int, type:int, selfZF:int, targetZF:int, roles:Array, steps:Array, isWin:int, roundStartMap:Object, babySkill:String) : void
      {
         var battleVo:Vo_battle_lib_data = null;
         var bSwapDir:Boolean = false;
         var roleInfo:Array = null;
         var r:Array = null;
         roundStartMap ||= {};
         if(result == 1)
         {
            battleVo = new Vo_battle_lib_data();
            battleVo.battleId = battleId;
            battleVo.type = type;
            battleVo.selfZF = selfZF;
            battleVo.targetZF = targetZF;
            battleVo.units = roles;
            battleVo.steps = steps;
            battleVo.isWin = isWin;
            battleVo.roundStartMap = roundStartMap;
            battleVo.babySkill = babySkill;
            bSwapDir = false;
            if(type == Enum_battleType.KUAFUZHAN1 || type == Enum_battleType.KUAFUZHAN2)
            {
               battleVo.isReplay = true;
               for each(roleInfo in roles)
               {
                  if(GameUnitManager.hero.id.toString().length < 10)
                  {
                     if(roleInfo[Enum_server_battleunit.ID] % 1000000 == GameUnitManager.hero.id && roleInfo[Enum_server_battleunit.DIRECTION] == 2)
                     {
                        bSwapDir = true;
                     }
                  }
                  else if(GameUnitManager.hero.id == roleInfo[Enum_server_battleunit.ID] && roleInfo[Enum_server_battleunit.DIRECTION] == 2)
                  {
                     bSwapDir = true;
                  }
               }
            }
            if(bSwapDir)
            {
               for each(r in roles)
               {
                  r[Enum_server_battleunit.DIRECTION] = r[Enum_server_battleunit.DIRECTION] == 1 ? 2 : 1;
               }
            }
            BattleManager.init(battleVo);
            Model_Battle.last_battle_vo = battleVo;
         }
      }
      
      public static function GC_BATTLE_RESULT(battleId:int, module:int, info:Array) : void
      {
         BattleResultManager.addInfo(battleId,module,info);
      }
      
      public static function GC_SIWANG_FUHUO(result:int) : void
      {
         if(Boolean(result))
         {
            if(Global.isInBattle)
            {
               BattleManager.jumpBattle();
            }
            UIManager.siWangFuHuoPanel.show(SiWangFuHuoPanel.HIDE);
         }
      }
      
      public static function GC_CHALLENGE(result:int, leftTime:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("617",0));
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("618",0) + leftTime + LangConfig.getWord("619",0));
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("620",0));
         }
      }
   }
}

