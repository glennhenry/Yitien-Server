package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.net.handler.CrossCampBattleHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class CrossCampBattleGCMessage
   {
      
      public function CrossCampBattleGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_OPEN_CROSS_CAMP_BATTLE_ICON] = GC_OPEN_CROSS_CAMP_BATTLE_ICON;
         index[MessageType.GC_CLICK_CAMP_ICON] = GC_CLICK_CAMP_ICON;
         index[MessageType.GC_CAMP_OPEN_TIP] = GC_CAMP_OPEN_TIP;
         index[MessageType.GC_MATCH] = GC_MATCH;
         index[MessageType.GC_ENTER_CAMP_SCENE] = GC_ENTER_CAMP_SCENE;
         index[MessageType.GC_ENTER_CAMP_DATA] = GC_ENTER_CAMP_DATA;
         index[MessageType.GC_EXIT_CAMP_SCENE] = GC_EXIT_CAMP_SCENE;
         index[MessageType.GC_CAMP_COLLECT_CRYSTAL] = GC_CAMP_COLLECT_CRYSTAL;
         index[MessageType.GC_CAMP_COLLECT_BUFF] = GC_CAMP_COLLECT_BUFF;
         index[MessageType.GC_CAMP_WAR_CAR] = GC_CAMP_WAR_CAR;
         index[MessageType.GC_CAMP_COMMIT_ITEM] = GC_CAMP_COMMIT_ITEM;
         index[MessageType.GC_CAMP_INFO] = GC_CAMP_INFO;
         index[MessageType.GC_CAMP_PLAYER_POINTS] = GC_CAMP_PLAYER_POINTS;
         index[MessageType.GC_CAMP_UPDATE_STATUS] = GC_CAMP_UPDATE_STATUS;
         index[MessageType.GC_CAMP_ATTACK_PLAYER] = GC_CAMP_ATTACK_PLAYER;
         index[MessageType.GC_CAMP_ATTACK_BANNERS] = GC_CAMP_ATTACK_BANNERS;
         index[MessageType.GC_CAMP_REVIVE] = GC_CAMP_REVIVE;
         index[MessageType.GC_WAR_CAR_COUNTDOWN] = GC_WAR_CAR_COUNTDOWN;
         index[MessageType.GC_ENTER_CAMP_SCENE_RESULT] = GC_ENTER_CAMP_SCENE_RESULT;
         index[MessageType.GC_PLAY_BATTLE_EFFECT] = GC_PLAY_BATTLE_EFFECT;
         index[MessageType.GC_REVIVE_VERSION] = GC_REVIVE_VERSION;
         index[MessageType.GC_CAMP_COMMON_TIP] = GC_CAMP_COMMON_TIP;
         index[MessageType.GC_CAMP_WARCAR_MOVE] = GC_CAMP_WARCAR_MOVE;
         index[MessageType.GC_CAMP_OPEN_REVIVI_PANEL] = GC_CAMP_OPEN_REVIVI_PANEL;
         index[MessageType.GC_BUFF_COUNTDOWN] = GC_BUFF_COUNTDOWN;
      }
      
      public static function GC_OPEN_CROSS_CAMP_BATTLE_ICON(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CrossCampBattleHandler.GC_OPEN_CROSS_CAMP_BATTLE_ICON(result);
      }
      
      public static function GC_CLICK_CAMP_ICON(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var serverTime:int = patch.readInt();
         var openTime:int = patch.readInt();
         CrossCampBattleHandler.GC_CLICK_CAMP_ICON(result,serverTime,openTime);
      }
      
      public static function GC_CAMP_OPEN_TIP(patch:IDataInput) : void
      {
         CrossCampBattleHandler.GC_CAMP_OPEN_TIP();
      }
      
      public static function GC_MATCH(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var serverTime:int = patch.readInt();
         var openTime:int = patch.readInt();
         CrossCampBattleHandler.GC_MATCH(result,serverTime,openTime);
      }
      
      public static function GC_ENTER_CAMP_SCENE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var serverTime:int = patch.readInt();
         var openTime:int = patch.readInt();
         var ownCampId:String = patch.readUTF();
         var enemyCampId:String = patch.readUTF();
         CrossCampBattleHandler.GC_ENTER_CAMP_SCENE(result,serverTime,openTime,ownCampId,enemyCampId);
      }
      
      public static function GC_ENTER_CAMP_DATA(patch:IDataInput) : void
      {
         var selfX:int = patch.readInt();
         var selfY:int = patch.readInt();
         var selfR:int = patch.readInt();
         var enemyX:int = patch.readInt();
         var enemyY:int = patch.readInt();
         var enemyR:int = patch.readInt();
         var selfBannersId:int = patch.readInt();
         var enemyBannersId:int = patch.readInt();
         var selfNpcId:int = patch.readInt();
         var enemyNpcId:int = patch.readInt();
         var selfBuffStr:String = patch.readUTF();
         var enemyBuffStr:String = patch.readUTF();
         var selfBuffArr:Array = selfBuffStr.split(",");
         var enemyBuffArr:Array = enemyBuffStr.split(",");
         var selfWarCarLen:int = patch.readInt();
         var selfWarCarArr:Array = [];
         var i:int = 0;
         while(i < selfWarCarLen)
         {
            selfWarCarArr.push(patch.readInt());
            i++;
         }
         var enemyWarCarLen:int = patch.readInt();
         var enemyWarCarArr:Array = [];
         i = 0;
         while(i < enemyWarCarLen)
         {
            enemyWarCarArr.push(patch.readInt());
            i++;
         }
         var selfBuffData:Array = [];
         var enemyBuffData:Array = [];
         i = 0;
         while(i < selfBuffArr.length)
         {
            selfBuffData.push(selfBuffArr[i].toString().split("_"));
            i++;
         }
         i = 0;
         while(i < enemyBuffArr.length)
         {
            enemyBuffData.push(enemyBuffArr[i].toString().split("_"));
            i++;
         }
         CrossCampBattleHandler.GC_ENTER_CAMP_DATA(selfX,selfY,selfR,enemyX,enemyY,enemyR,selfBannersId,enemyBannersId,selfNpcId,enemyNpcId,selfBuffData,enemyBuffData,selfWarCarArr,enemyWarCarArr);
      }
      
      public static function GC_EXIT_CAMP_SCENE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CrossCampBattleHandler.GC_EXIT_CAMP_SCENE(result);
      }
      
      public static function GC_CAMP_COLLECT_CRYSTAL(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var id:int = patch.readInt();
         CrossCampBattleHandler.GC_CAMP_COLLECT_CRYSTAL(result,id);
      }
      
      public static function GC_CAMP_COLLECT_BUFF(patch:IDataInput) : void
      {
         var result:int = patch.readInt();
         var id:int = patch.readInt();
         CrossCampBattleHandler.GC_CAMP_COLLECT_BUFF(result,id);
      }
      
      public static function GC_CAMP_WAR_CAR(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CrossCampBattleHandler.GC_CAMP_WAR_CAR(result);
      }
      
      public static function GC_CAMP_COMMIT_ITEM(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CrossCampBattleHandler.GC_CAMP_COMMIT_ITEM(result);
      }
      
      public static function GC_CAMP_INFO(patch:IDataInput) : void
      {
         var selfId:String = null;
         var selfBlood:String = null;
         var selfMaxBlood:String = null;
         var enemyId:String = null;
         var enemyBlood:String = null;
         var enemyMaxBlood:String = null;
         var redId:String = patch.readUTF();
         var redMaxBlood:String = patch.readUTF();
         var redBlood:String = patch.readUTF();
         var blueId:String = patch.readUTF();
         var blueMaxBlood:String = patch.readUTF();
         var blueBlood:String = patch.readUTF();
         var redQiZiId:int = patch.readInt();
         var blueQiZiId:int = patch.readInt();
         if(redId == "Blue")
         {
            selfId = redId;
            enemyId = blueId;
            selfMaxBlood = redMaxBlood;
            enemyMaxBlood = blueMaxBlood;
            selfBlood = redBlood;
            enemyBlood = blueBlood;
         }
         else
         {
            selfId = blueId;
            enemyId = redId;
            selfMaxBlood = blueMaxBlood;
            enemyMaxBlood = redMaxBlood;
            selfBlood = blueBlood;
            enemyBlood = redBlood;
         }
         CrossCampBattleHandler.GC_CAMP_INFO(selfId,selfBlood,selfMaxBlood,enemyId,enemyBlood,enemyMaxBlood,redQiZiId,blueQiZiId);
      }
      
      public static function GC_CAMP_PLAYER_POINTS(patch:IDataInput) : void
      {
         var points:int = patch.readInt();
         CrossCampBattleHandler.GC_CAMP_PLAYER_POINTS(points);
      }
      
      public static function GC_CAMP_UPDATE_STATUS(patch:IDataInput) : void
      {
         var result:int = patch.readInt();
         var playerId:Number = LongUtil.readLong(patch);
         var id:String = patch.readUTF();
         CrossCampBattleHandler.GC_CAMP_UPDATE_STATUS(result,playerId,id);
      }
      
      public static function GC_CAMP_ATTACK_PLAYER(patch:IDataInput) : void
      {
         var data:Array = [];
         var result:int = patch.readByte();
         var len:int = patch.readByte();
         var i:int = 0;
         while(i < len)
         {
            data.push(LongUtil.readLong(patch));
            i++;
         }
         CrossCampBattleHandler.GC_CAMP_ATTACK_PLAYER(data,result);
      }
      
      public static function GC_CAMP_ATTACK_BANNERS(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CrossCampBattleHandler.GC_CAMP_ATTACK_BANNERS(result);
      }
      
      public static function GC_CAMP_REVIVE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var serverTime:int = patch.readInt();
         var endBattleTime:int = patch.readInt();
         CrossCampBattleHandler.GC_CAMP_REVIVE(result,serverTime,endBattleTime);
      }
      
      public static function GC_WAR_CAR_COUNTDOWN(patch:IDataInput) : void
      {
         var id:int = patch.readInt();
         var deadTime:int = patch.readInt();
         var time:int = patch.readInt();
         CrossCampBattleHandler.GC_WAR_CAR_COUNTDOWN(deadTime,time,id);
      }
      
      public static function GC_ENTER_CAMP_SCENE_RESULT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CrossCampBattleHandler.GC_ENTER_CAMP_SCENE_RESULT(result);
      }
      
      public static function GC_PLAY_BATTLE_EFFECT(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         var lenA:int = patch.readByte();
         var teamA:Array = [];
         var i:int = 0;
         while(i < lenA)
         {
            teamA.push(LongUtil.readLong(patch));
            i++;
         }
         var lenB:int = patch.readByte();
         var teamB:Array = [];
         i = 0;
         while(i < lenB)
         {
            teamB.push(LongUtil.readLong(patch));
            i++;
         }
         CrossCampBattleHandler.GC_PLAY_BATTLE_EFFECT(type,teamA,teamB);
      }
      
      public static function GC_REVIVE_VERSION(patch:IDataInput) : void
      {
         var result:Number = LongUtil.readLong(patch);
         CrossCampBattleHandler.GC_REVIVE_VERSION(result);
      }
      
      public static function GC_CAMP_COMMON_TIP(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         CrossCampBattleHandler.GC_CAMP_COMMON_TIP(result);
      }
      
      public static function GC_CAMP_WARCAR_MOVE(patch:IDataInput) : void
      {
         var playerId:Number = LongUtil.readLong(patch);
         var carId:int = patch.readInt();
         var type:int = patch.readByte();
         CrossCampBattleHandler.GC_CAMP_WARCAR_MOVE(playerId,carId,type);
      }
      
      public static function GC_CAMP_OPEN_REVIVI_PANEL(patch:IDataInput) : void
      {
         CrossCampBattleHandler.GC_CAMP_OPEN_REVIVI_PANEL();
      }
      
      public static function GC_BUFF_COUNTDOWN(patch:IDataInput) : void
      {
         var mineTime:int = patch.readInt();
         var buffTime:int = patch.readInt();
         var serverTime:int = patch.readInt();
         CrossCampBattleHandler.GC_BUFF_COUNTDOWN(mineTime,buffTime,serverTime);
      }
   }
}

