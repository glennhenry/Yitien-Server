package com.yiTian.net.handler
{
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.gameUnit.GameUnit;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.gameUnit.role.Player;
   import com.yiTian.manager.CollectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BangBattleCGMessage;
   import flash.utils.getTimer;
   
   public class BangBattleHandle
   {
      
      private static var txtArr:Array;
      
      private static var oldInfo:Array;
      
      public static var _version:int;
      
      public function BangBattleHandle()
      {
         super();
      }
      
      private static function get TXTARR() : Array
      {
         var id:int = 0;
         var i:int = 0;
         if(!txtArr)
         {
            id = 22500;
            txtArr = [];
            i = 0;
            while(i < 4)
            {
               txtArr.push(LangConfig.getWord((id + i).toString(),2));
               i += 1;
            }
         }
         return txtArr;
      }
      
      public static function GC_ENTER_BANG_BATTLE(result:int, flag:int) : void
      {
         _version = -1;
         switch(result)
         {
            case 1:
               if(flag == 1)
               {
                  UIManager.bbIntroduce.visible = true;
               }
         }
         UIManager.centerBroadcast.addMsg(TXTARR[result - 1]);
      }
      
      public static function GC_COLLECT_JK(result:int, uid:Number) : void
      {
         var obj:Object = null;
         if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29055",2));
            return;
         }
         var npc:GameUnit = GameUnitManager.findUnit(uid,UnitType.NPC);
         if(Boolean(npc))
         {
            obj = new Object();
            obj.uid = uid;
            CollectManager.begin(npc as Npc,15000,TEMP,obj);
         }
      }
      
      private static function TEMP(obj:Object) : void
      {
         var npc:Npc = obj.npc;
         BangBattleCGMessage.CG_JKCOLLECT_FINISH(npc.id,npc.sysId);
      }
      
      public static function GC_MAIN_GROUND(result:int) : void
      {
         if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("22511",2));
            Model_bang.lastMGQTime = getTimer();
         }
      }
      
      public static function GC_QUEST_BANG_BATTLE(result:int) : void
      {
         var str:String = null;
         switch(result)
         {
            case 1:
               str = LangConfig.getWord("22512",2);
               break;
            case 2:
               str = LangConfig.getWord("22512",2);
         }
         UIManager.centerBroadcast.addMsg(str);
      }
      
      public static function GC_SNATCH_ROOM(result:int) : void
      {
         var str:String = null;
         switch(result)
         {
            case 1:
               str = LangConfig.getWord("22513",2);
               break;
            case 2:
               str = LangConfig.getWord("22514",2);
               break;
            case 3:
               str = "该晶矿已经被本帮占领";
         }
         UIManager.centerBroadcast.addMsg(str);
      }
      
      public static function GC_LORD_INFO(version:int, array:Array) : void
      {
         var p:Player = null;
         var oid:Number = NaN;
         var id:Number = NaN;
         if(version < _version)
         {
            return;
         }
         _version = version;
         for each(oid in Model_bang.jkLordArr)
         {
            p = GameUnitManager.findUnit(oid,UnitType.PLAYER) as Player;
            if(Boolean(p))
            {
               p.isLord = false;
            }
         }
         Model_bang.jkLordArr = array;
         for each(id in array)
         {
            p = GameUnitManager.findUnit(id,UnitType.PLAYER) as Player;
            if(Boolean(p))
            {
               p.isLord = true;
            }
         }
         if(array.length == 0)
         {
            GameUnitManager.hero.isLord = false;
         }
      }
      
      public static function GC_CANNOT_USE_BUFF1() : void
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("29056",2));
      }
      
      public static function GC_BB_RANKS(arr:Array, bArr:Array) : void
      {
         UIManager.bbRank.update(arr,bArr);
      }
      
      public static function GC_BB_INFO(actTime:int, mySoccer:int, killH:int, killM:int, bangSoccer:int, kuangRemain:int, isStart:int, bIDArr:Array) : void
      {
         UIManager.bbRanks.update(actTime,mySoccer,killH,killM,bangSoccer,kuangRemain,isStart);
         UIManager.bbRanks.updateBangLord(bIDArr);
      }
   }
}

