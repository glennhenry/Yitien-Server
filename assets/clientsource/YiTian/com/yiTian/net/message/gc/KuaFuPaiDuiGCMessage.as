package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.net.handler.HumanHandler;
   import com.yiTian.net.handler.KuaFuPaiDuiHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class KuaFuPaiDuiGCMessage
   {
      
      public function KuaFuPaiDuiGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_EXP_UPGRADE] = GC_EXP_UPGRADE;
         index[MessageType.GC_KuaFuPaiDui_ICON] = this.GC_KuaFuPaiDui_ICON;
         index[MessageType.GC_KuaFuPaiDui_SERVER_CHOICE] = this.GC_KuaFuPaiDui_SERVER_CHOICE;
         index[MessageType.GC_KuaFuPaiDui_ENTER_EXIT] = this.GC_KuaFuPaiDui_ENTER_EXIT;
         index[MessageType.GC_KuaFuPaiDui_COUNT_DOWN] = this.GC_KuaFuPaiDui_COUNT_DOWN;
         index[MessageType.GC_KuaFuPaiDui_ROUND_START] = this.GC_KuaFuPaiDui_ROUND_START;
         index[MessageType.GC_KuaFuPaiDui_REST] = this.GC_KuaFuPaiDui_REST;
         index[MessageType.GC_KuaFuPaiDui_SCORE_LIST] = this.GC_KuaFuPaiDui_SCORE_LIST;
         index[MessageType.GC_KuaFuPaiDui_SCORE_ADD] = this.GC_KuaFuPaiDui_SCORE_ADD;
         index[MessageType.GC_KuaFuPaiDui_CHANGE_ROOM] = this.GC_KuaFuPaiDui_CHANGE_ROOM;
         index[MessageType.GC_KuaFuPaiDui_FRESH_ROOM] = this.GC_KuaFuPaiDui_FRESH_ROOM;
         index[MessageType.GC_KuaFuPaiDui_FRESH_PARTNER] = this.GC_KuaFuPaiDui_FRESH_PARTNER;
         index[MessageType.GC_KuaFuPaiDui_BE_INVITED] = this.GC_KuaFuPaiDui_BE_INVITED;
         index[MessageType.GC_KuaFuPaiDui_INVITE_RESULT1] = this.GC_KuaFuPaiDui_INVITE_RESULT1;
         index[MessageType.GC_KuaFuPaiDui_INVITE_RESULT2] = this.GC_KuaFuPaiDui_INVITE_RESULT2;
         index[MessageType.GC_KuaFuPaiDui_BREAK_UP] = this.GC_KuaFuPaiDui_BREAK_UP;
         index[MessageType.GC_KuaFuPaiDui_GET_EXP] = this.GC_KuaFuPaiDui_GET_EXP;
         index[MessageType.GC_LEVEL_UP_ABB] = this.GC_LEVEL_UP_ABB;
         index[MessageType.GC_KuaFuPaiDui_MY_RANK] = this.GC_KuaFuPaiDui_MY_RANK;
      }
      
      public static function GC_EXP_UPGRADE(patch:IDataInput) : void
      {
         var exp:int = patch.readInt();
         EffectManager.flyEffGlobal(exp);
      }
      
      public function GC_KuaFuPaiDui_ICON(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         KuaFuPaiDuiHandle.GC_KuaFuPaiDui_icon(flag);
      }
      
      public function GC_KuaFuPaiDui_SERVER_CHOICE(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         KuaFuPaiDuiHandle.GC_KuaFuPaiDui_SERVER_CHOICE(flag);
      }
      
      public function GC_KuaFuPaiDui_ENTER_EXIT(patch:IDataInput) : void
      {
         var roomId:int = 0;
         var serverId:int = 0;
         var flag:int = patch.readByte();
         if(flag == 1)
         {
            roomId = patch.readInt();
            serverId = patch.readByte();
         }
         KuaFuPaiDuiHandle.GC_KuaFuPaiDui_ENTER_EXIT(flag,roomId,serverId);
      }
      
      public function GC_KuaFuPaiDui_COUNT_DOWN(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         var time:int = patch.readInt();
         KuaFuPaiDuiHandle.GC_KuaFuPaiDui_COUNT_DOWN(flag,time);
      }
      
      public function GC_KuaFuPaiDui_ROUND_START(patch:IDataInput) : void
      {
         var round:int = patch.readByte();
         KuaFuPaiDuiHandle.GC_KuaFuPaiDui_ROUND_START(round);
      }
      
      public function GC_KuaFuPaiDui_REST(patch:IDataInput) : void
      {
         KuaFuPaiDuiHandle.GC_KuaFuPaiDui_REST();
      }
      
      public function GC_KuaFuPaiDui_SCORE_LIST(patch:IDataInput) : void
      {
         var len:int = patch.readByte();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            arr.push(patch.readUTF());
            i++;
         }
         KuaFuPaiDuiHandle.GC_KuaFuPaiDui_SCORE_LIST(arr);
      }
      
      public function GC_KuaFuPaiDui_SCORE_ADD(patch:IDataInput) : void
      {
         var score:int = patch.readInt();
         var totalScore:int = patch.readInt();
         KuaFuPaiDuiHandle.GC_KuaFuPaiDui_SCORE_ADD(score,totalScore);
      }
      
      public function GC_KuaFuPaiDui_CHANGE_ROOM(patch:IDataInput) : void
      {
         var roomId:int = 0;
         var serverId:int = 0;
         var flag:int = patch.readByte();
         if(flag == 1)
         {
            roomId = patch.readInt();
            serverId = patch.readByte();
         }
         KuaFuPaiDuiHandle.GC_KuaFuPaiDui_CHANGE_ROOM(flag,roomId,serverId);
      }
      
      public function GC_KuaFuPaiDui_FRESH_ROOM(patch:IDataInput) : void
      {
         var roomId:int = 0;
         var num:int = 0;
         var len:int = patch.readShort();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            roomId = patch.readInt();
            num = patch.readInt();
            arr.push([i + 1,roomId,num]);
            i++;
         }
         KuaFuPaiDuiHandle.GC_KuaFuPaiDui_FRESH_ROOM(arr);
      }
      
      public function GC_KuaFuPaiDui_FRESH_PARTNER(patch:IDataInput) : void
      {
         var id:Number = NaN;
         var name:String = null;
         var sex:int = 0;
         var zoneId:int = 0;
         var len:int = patch.readShort();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            id = LongUtil.readLong(patch);
            name = patch.readUTF();
            sex = patch.readByte();
            zoneId = patch.readInt();
            arr.push([id,zoneId,name,sex]);
            i++;
         }
         KuaFuPaiDuiHandle.GC_KuaFuPaiDui_FRESH_PARTNER(arr);
      }
      
      public function GC_KuaFuPaiDui_BE_INVITED(patch:IDataInput) : void
      {
         var playerId:Number = LongUtil.readLong(patch);
         var name:String = patch.readUTF();
         var zoneId:int = patch.readInt();
         KuaFuPaiDuiHandle.GC_KuaFuPaiDui_BE_INVITED(playerId,zoneId,name);
      }
      
      public function GC_KuaFuPaiDui_INVITE_RESULT1(patch:IDataInput) : void
      {
         var playerId:Number = NaN;
         var name:String = null;
         var zoneId:int = 0;
         var flag:int = patch.readByte();
         if(flag == 2)
         {
            playerId = LongUtil.readLong(patch);
            name = patch.readUTF();
            zoneId = patch.readInt();
         }
         KuaFuPaiDuiHandle.GC_KuaFuPaiDui_INVITE_RESULT1(flag,playerId,name,zoneId);
      }
      
      public function GC_KuaFuPaiDui_INVITE_RESULT2(patch:IDataInput) : void
      {
         var playerId:Number = NaN;
         var name:String = null;
         var zoneId:int = 0;
         var flag:int = patch.readByte();
         if(flag == 1)
         {
            playerId = LongUtil.readLong(patch);
            name = patch.readUTF();
            zoneId = patch.readInt();
         }
         KuaFuPaiDuiHandle.GC_KuaFuPaiDui_INVITE_RESULT2(flag,playerId,name,zoneId);
      }
      
      public function GC_KuaFuPaiDui_BREAK_UP(patch:IDataInput) : void
      {
         var flag:int = patch.readByte();
         var tips:int = patch.readByte();
         KuaFuPaiDuiHandle.GC_KuaFuPaiDui_BREAK_UP(flag,tips);
      }
      
      public function GC_KuaFuPaiDui_GET_EXP(patch:IDataInput) : void
      {
         var exp:int = patch.readInt();
         KuaFuPaiDuiHandle.GC_KuaFuPaiDui_GET_EXP(exp);
      }
      
      public function GC_LEVEL_UP_ABB(patch:IDataInput) : void
      {
         var id:Number = LongUtil.readLong(patch);
         var lv:int = patch.readShort();
         var power:int = patch.readInt();
         var att:int = patch.readInt();
         var def:int = patch.readInt();
         var maxHp:int = patch.readInt();
         var maxMp:int = patch.readInt();
         HumanHandler.GC_LEVEL_UP_ABB(id,lv,power,att,def,maxHp,maxMp);
      }
      
      public function GC_KuaFuPaiDui_MY_RANK(patch:IDataInput) : void
      {
         var arr:Array = [];
         var myRank:int = patch.readByte();
         var name:String = patch.readUTF();
         var score:int = patch.readInt();
         arr.push(myRank);
         arr.push(name);
         arr.push(score);
         KuaFuPaiDuiHandle.GC_KuaFuPaiDui_MY_RANK(arr);
      }
   }
}

