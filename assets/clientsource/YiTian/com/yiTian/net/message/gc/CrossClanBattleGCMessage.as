package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.net.handler.CrossClanBattleHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class CrossClanBattleGCMessage
   {
      
      public function CrossClanBattleGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_ALLCITY_DATA] = GC_ALLCITY_DATA;
         index[MessageType.GC_SEGIE_TIME] = this.GC_SEGIE_TIME;
         index[MessageType.GC_BATTLE_CONFIRM] = this.GC_BATTLE_CONFIRM;
         index[MessageType.GC_AUCTION_RESULT] = GC_AUCTION_RESULT;
         index[MessageType.GC_REFRESH_CITY_COLOR] = GC_REFRESH_CITY_COLOR;
         index[MessageType.GC_ENTER_BATTLE_SCENE] = GC_ENTER_BATTLE_SCENE;
         index[MessageType.GC_CONNECT_SOCKET] = GC_CONNECT_SOCKET;
         index[MessageType.GC_BATTLE_INFO] = GC_BATTLE_INFO;
         index[MessageType.GC_BATTLE_PRE_TIME] = GC_BATTLE_PRE_TIME;
         index[MessageType.GC_RESOURCE_TOWER] = GC_RESOURCE_TOWER;
         index[MessageType.GC_RESOURCE_MINE] = GC_RESOURCE_MINE;
         index[MessageType.GC_BUY_BUFF] = GC_BUY_BUFF;
         index[MessageType.GC_REFRESH_BUFF] = GC_REFRESH_BUFF;
         index[MessageType.GC_CRYSTAL] = GC_CRYSTAL;
         index[MessageType.GC_REFRESH_CRYSTAL_BLOOD] = GC_REFRESH_CRYSTAL_BLOOD;
         index[MessageType.GC_COMMIT_RESOURCE_MINE] = GC_COMMIT_RESOURCE_MINE;
         index[MessageType.GC_CLICK_WAR_CAR] = GC_CLICK_WAR_CAR;
         index[MessageType.GC_WAR_CAR_BATTLE_END] = GC_WAR_CAR_BATTLE_END;
         index[MessageType.GC_WAR_CAR_V_CRYSTAL] = GC_WAR_CAR_V_CRYSTAL;
         index[MessageType.GC_WAR_CAR_DISPOSE] = GC_WAR_CAR_DISPOSE;
         index[MessageType.GC_SOIDIER] = GC_SOIDIER;
         index[MessageType.GC_CLICK_PLAYER] = GC_CLICK_PLAYER;
         index[MessageType.GC_CHANGE_TOWER_NAME] = GC_CHANGE_TOWER_NAME;
         index[MessageType.GC_TIP] = GC_TIP;
         index[MessageType.GC_KUAFUCLAN_BATTLE_EXIT] = GC_KUAFUCLAN_BATTLE_EXIT;
         index[MessageType.GC_OPEN_CROSS_CLAN_ICON] = GC_OPEN_CROSS_CLAN_ICON;
         index[MessageType.GC_BUY_ROLE_BUFF] = GC_BUY_ROLE_BUFF;
         index[MessageType.GC_REFRESH_ROLE_BUFF] = GC_REFRESH_ROLE_BUFF;
         index[MessageType.GC_ROLE_MONEY] = GC_ROLE_MONEY;
         index[MessageType.GC_CITY_BATTLE_TIP] = GC_CITY_BATTLE_TIP;
      }
      
      public static function GC_ALLCITY_DATA(patch:IDataInput) : void
      {
         var str:String = patch.readUTF();
         var serverTime:int = patch.readInt();
         var endTime:int = patch.readInt();
         var crossClanName:String = patch.readUTF();
         CrossClanBattleHandler.GC_ALLCITY_DATA(str,serverTime,endTime,crossClanName);
      }
      
      public static function GC_AUCTION_RESULT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CrossClanBattleHandler.GC_AUCTION_RESULT(result);
      }
      
      public static function GC_REFRESH_CITY_COLOR(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CrossClanBattleHandler.GC_REFRESH_CITY_COLOR(result);
      }
      
      public static function GC_CONNECT_SOCKET(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var selfX:int = patch.readInt();
         var selfY:int = patch.readInt();
         var selfR:int = patch.readInt();
         var enemyX:int = patch.readInt();
         var enemyY:int = patch.readInt();
         var enemyR:int = patch.readInt();
         var selfCrystalId:int = patch.readInt();
         var enemyCrystalId:int = patch.readInt();
         var selfNpcId:int = patch.readInt();
         var enemyNpcId:int = patch.readInt();
         var selfBarrierPointStr:String = patch.readUTF();
         var enemyBarrierPointStr:String = patch.readUTF();
         CrossClanBattleHandler.GC_CONNECT_SOCKET(result,selfX,selfY,selfR,enemyX,enemyY,enemyR,selfCrystalId,enemyCrystalId,selfNpcId,enemyNpcId,selfBarrierPointStr,enemyBarrierPointStr);
      }
      
      public static function GC_BATTLE_INFO(patch:IDataInput) : void
      {
         var selfPoint:int = 0;
         var enemyPoint:int = 0;
         var i:int = 0;
         var serverTime:int = patch.readInt();
         var endTime:int = patch.readInt();
         var clanOne:String = patch.readUTF();
         var clanOneTowerCount:int = patch.readByte();
         var clanOnePoint:int = patch.readInt();
         var clanTwo:String = patch.readUTF();
         var clanTwoTowerCount:int = patch.readByte();
         var clanTwoPoint:int = patch.readInt();
         var selfTowerCountArr:Array = [];
         var enemyTowerCountArr:Array = [];
         if(Model_heFu.compareServName(GameUnitManager.hero.party,clanOne))
         {
            i = 0;
            while(i < clanOneTowerCount)
            {
               selfTowerCountArr.push(patch.readInt());
               i++;
            }
            i = 0;
            while(i < clanTwoTowerCount)
            {
               enemyTowerCountArr.push(patch.readInt());
               i++;
            }
            selfPoint = clanOnePoint;
            enemyPoint = clanTwoPoint;
         }
         else
         {
            i = 0;
            while(i < clanOneTowerCount)
            {
               enemyTowerCountArr.push(patch.readInt());
               i++;
            }
            i = 0;
            while(i < clanTwoTowerCount)
            {
               selfTowerCountArr.push(patch.readInt());
               i++;
            }
            selfPoint = clanTwoPoint;
            enemyPoint = clanOnePoint;
         }
         var systemTime:int = patch.readInt();
         var mineStartTime:int = patch.readInt();
         var mineAllTime:int = patch.readInt();
         var mineHasPassTime:int = systemTime - mineStartTime;
         var mineRefreshTime:int = mineAllTime - mineHasPassTime;
         CrossClanBattleHandler.GC_BATTLE_INFO(serverTime,endTime,clanOne,clanOneTowerCount,selfPoint,clanTwo,clanTwoTowerCount,enemyPoint,selfTowerCountArr,enemyTowerCountArr,mineHasPassTime,mineRefreshTime);
      }
      
      public static function GC_BATTLE_PRE_TIME(patch:IDataInput) : void
      {
         var time:int = patch.readInt();
         var battleTime:int = patch.readInt();
         CrossClanBattleHandler.GC_BATTLE_PRE_TIME(time,battleTime);
      }
      
      public static function GC_ENTER_BATTLE_SCENE(patch:IDataInput) : void
      {
         var crossType:String = patch.readUTF();
         var params:String = patch.readUTF();
         var testNum:Number = LongUtil.readLong(patch);
         var ip:String = patch.readUTF();
         var canConnectSocket:int = patch.readByte();
         CrossClanBattleHandler.GC_ENTER_BATTLE_SCENE(crossType,params,testNum,ip,canConnectSocket);
      }
      
      public static function GC_RESOURCE_TOWER(patch:IDataInput) : void
      {
         var status:int = patch.readByte();
         var id:int = patch.readInt();
         var guardId:Number = LongUtil.readLong(patch);
         CrossClanBattleHandler.GC_RESOURCE_TOWER(status,id,guardId);
      }
      
      public static function GC_RESOURCE_MINE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var id:int = patch.readInt();
         var type:int = patch.readByte();
         CrossClanBattleHandler.GC_RESOURCE_MINE(result,id,type);
      }
      
      public static function GC_BUY_BUFF(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CrossClanBattleHandler.GC_BUY_BUFF(result);
      }
      
      public static function GC_REFRESH_BUFF(patch:IDataInput) : void
      {
         var arr:Array = null;
         var len:int = patch.readByte();
         var data:Array = [];
         var i:int = 0;
         while(i < len)
         {
            arr = [];
            arr.push(patch.readInt());
            arr.push(patch.readInt());
            data.push(arr);
            i++;
         }
         var serverTime:int = patch.readInt();
         CrossClanBattleHandler.GC_REFRESH_BUFF(data,serverTime);
      }
      
      public static function GC_CRYSTAL(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var id:int = patch.readInt();
         CrossClanBattleHandler.GC_CRYSTAL(result,id);
      }
      
      public static function GC_REFRESH_CRYSTAL_BLOOD(patch:IDataInput) : void
      {
         var blood:String = patch.readUTF();
         var id:int = patch.readInt();
         var bloodMax:String = patch.readUTF();
         var clanName:String = patch.readUTF();
         CrossClanBattleHandler.GC_REFRESH_CRYSTAL_BLOOD(id,blood,bloodMax,clanName);
      }
      
      public static function GC_COMMIT_RESOURCE_MINE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var type:int = patch.readByte();
         var point:int = patch.readInt();
         CrossClanBattleHandler.GC_COMMIT_RESOURCE_MINE(result,type,point);
      }
      
      public static function GC_CLICK_WAR_CAR(patch:IDataInput) : void
      {
         var id:int = patch.readInt();
         CrossClanBattleHandler.GC_CLICK_WAR_CAR(id);
      }
      
      public static function GC_WAR_CAR_BATTLE_END(patch:IDataInput) : void
      {
         var id:int = patch.readInt();
         CrossClanBattleHandler.GC_WAR_CAR_BATTLE_END(id);
      }
      
      public static function GC_WAR_CAR_V_CRYSTAL(patch:IDataInput) : void
      {
         var id:int = patch.readInt();
         CrossClanBattleHandler.GC_WAR_CAR_V_CRYSTAL(id);
      }
      
      public static function GC_WAR_CAR_DISPOSE(patch:IDataInput) : void
      {
         var id:int = patch.readInt();
         CrossClanBattleHandler.GC_WAR_CAR_DISPOSE(id);
      }
      
      public static function GC_BASE_MSG(patch:IDataInput) : void
      {
         var selfX:int = patch.readInt();
         var selfY:int = patch.readInt();
         var selfR:int = patch.readInt();
         var enemyX:int = patch.readInt();
         var enemyY:int = patch.readInt();
         var enemyR:int = patch.readInt();
         CrossClanBattleHandler.GC_BASE_MSG(selfX,selfY,selfR,enemyX,enemyY,enemyR);
      }
      
      public static function GC_KUAFUCLAN_BATTLE_END(patch:IDataInput) : void
      {
         var result:int = patch.readInt();
         CrossClanBattleHandler.GC_KUAFUCLAN_BATTLE_END(result);
      }
      
      public static function GC_SOIDIER(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CrossClanBattleHandler.GC_SOIDIER(result);
      }
      
      public static function GC_CLICK_PLAYER(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CrossClanBattleHandler.GC_CLICK_PLAYER(result);
      }
      
      public static function GC_CHANGE_TOWER_NAME(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         var id:Number = LongUtil.readLong(patch);
         var name:String = patch.readUTF();
         CrossClanBattleHandler.GC_CHANGE_TOWER_NAME(type,id,name);
      }
      
      public static function GC_TIP(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         var result:int = patch.readByte();
         var len:int = patch.readInt();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            arr.push(patch.readUTF());
            i++;
         }
         CrossClanBattleHandler.GC_TIP(type,result,len,arr);
      }
      
      public static function GC_KUAFUCLAN_BATTLE_EXIT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CrossClanBattleHandler.GC_KUAFUCLAN_BATTLE_EXIT(result);
      }
      
      public static function GC_OPEN_CROSS_CLAN_ICON(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CrossClanBattleHandler.GC_OPEN_CROSS_CLAN_ICON(result);
      }
      
      public static function GC_BUY_ROLE_BUFF(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CrossClanBattleHandler.GC_BUY_ROLE_BUFF(result);
      }
      
      public static function GC_REFRESH_ROLE_BUFF(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         var len:int = patch.readInt();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            arr.push([patch.readInt(),patch.readByte()]);
            i++;
         }
         CrossClanBattleHandler.GC_REFRESH_ROLE_BUFF(type,arr);
      }
      
      public static function GC_ROLE_MONEY(patch:IDataInput) : void
      {
         var type:int = patch.readInt();
         var money:int = LongUtil.readLong(patch);
         CrossClanBattleHandler.GC_ROLE_MONEY(type,money);
      }
      
      public static function GC_CITY_BATTLE_TIP(patch:IDataInput) : void
      {
         var cityId:int = patch.readInt();
         CrossClanBattleHandler.GC_CITY_BATTLE_TIP(cityId);
      }
      
      public function GC_SEGIE_TIME(patch:IDataInput) : void
      {
         var str:String = patch.readUTF();
         var result:int = patch.readByte();
         var type:int = patch.readByte();
         CrossClanBattleHandler.GC_SEGIE_TIME(str,result,type);
      }
      
      public function GC_BATTLE_CONFIRM(patch:IDataInput) : void
      {
         var info:String = patch.readUTF();
         var result:int = patch.readByte();
         CrossClanBattleHandler.GC_BATTLE_CONFIRM(info,result);
      }
   }
}

