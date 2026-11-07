package com.yiTian.view.modules.pata
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Enum_battleType;
   import com.yiTian.data.config.Enum_npc_type;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.gameUnit.GameUnit;
   import com.yiTian.gameUnit.role.Door;
   import com.yiTian.gameUnit.role.Hero;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.gameUnit.role.Role;
   import com.yiTian.manager.BattleManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.MapManager;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.PataCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.auto.HandupMgr;
   import com.yiTian.view.comp.View_Alert;
   
   public class PataVO
   {
      
      public static var tiaoGuoCiShu:int;
      
      public static var pataTimes:int;
      
      public static var mapId:int;
      
      public static var layers:int;
      
      public static var overlordsInfo:String;
      
      public static var overlordListStr:String;
      
      public static var layersArr:Array;
      
      public static var layersAwardArr:Array;
      
      public static var layersOverlordsArr:Array;
      
      private static var _autoUtil:HandupMgr;
      
      public static var type:int = 1;
      
      public static var fuBenFlat:int = -1;
      
      public function PataVO()
      {
         super();
      }
      
      public static function dataHandle() : void
      {
         var i:uint = 0;
         if(Boolean(overlordListStr))
         {
            layersArr = [];
            layersArr = overlordListStr.split(",");
            layersAwardArr = [];
            layersOverlordsArr = [];
            i = 0;
            while(i < layersArr.length)
            {
               layersAwardArr[i] = layersArr[i].split("#")[0];
               layersOverlordsArr[i] = layersArr[i].split("#")[1];
               i++;
            }
         }
      }
      
      public static function start() : void
      {
         HandupMgr.setType(1);
         HandupMgr.roleFun = roleFun;
         HandupMgr.battlePlayFun = battleStartFun;
         HandupMgr.conditionFun = conditionFun;
         HandupMgr.addNpcFun = roleFun;
         HandupMgr.show();
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_SCENE,turnoffHandup);
      }
      
      public static function turnoffHandup() : void
      {
         HandupMgr.turnoff();
         HandupMgr.hide();
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_SCENE,turnoffHandup);
      }
      
      private static function conditionFun(... param) : Boolean
      {
         if(Global.isInBattle || ModalUIManager.isShow || View_Alert.isShow || UIManager.siWangFuHuoPanel.visible)
         {
            GameUnitManager.hero.stopGo();
            GameUnitManager.hero.lockTarget = null;
            return false;
         }
         if(Model_team.hasTeam() && Model_team.isCap() || !Model_team.hasTeam())
         {
            return true;
         }
         return false;
      }
      
      private static function battleStartFun(bId:Number) : void
      {
         var count:int = 0;
         var hasJumpCount:Boolean = false;
         var h:Hero = GameUnitManager.hero;
         h.lockTarget = null;
         if(h.vip == 0)
         {
            count = 15;
         }
         else if(h.vip == 1)
         {
            count = 45;
         }
         else if(h.vip == 2)
         {
            count = 75;
         }
         else
         {
            count = -1;
         }
         if(count == -1)
         {
            hasJumpCount = true;
         }
         else
         {
            hasJumpCount = count - tiaoGuoCiShu > 0;
         }
         if(BattleManager.bType == Enum_battleType.PATA && hasJumpCount)
         {
            if(Model_team.hasTeam() && Model_team.isCap() || !Model_team.hasTeam())
            {
               PataCGMessage.CG_SKIP_BATTLE();
            }
         }
      }
      
      private static function roleFun(unit:GameUnit) : Boolean
      {
         var dx:Number = NaN;
         var dy:Number = NaN;
         var hero:Hero = null;
         var d:Door = null;
         if(unit is Npc)
         {
            if((unit as Npc).npcType == Enum_npc_type.PATA_MONSTER)
            {
               dx = 65;
               dy = 35;
               hero = GameUnitManager.hero;
               if(Utils.dist(hero.global_x,hero.global_y,unit.global_x,unit.global_y) <= dx * dx + dy * dy)
               {
                  hero.stopGo();
                  unit.interaction();
               }
               else
               {
                  GameUnitManager.hero.lockTarget = unit as Role;
                  if(!GameUnitManager.hero.go(unit.global_x + dx,unit.global_y + dy))
                  {
                     hero.stopGo();
                     unit.interaction();
                  }
               }
               return true;
            }
         }
         else if(unit is Door)
         {
            d = unit as Door;
            if(MapManager.isFubenFinish && unit.visible)
            {
               GameUnitManager.hero.go(unit.global_x,unit.global_y);
               return true;
            }
         }
         GameUnitManager.hero.lockTarget = null;
         return false;
      }
   }
}

