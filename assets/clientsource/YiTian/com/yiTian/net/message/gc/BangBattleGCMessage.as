package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.net.handler.BangBattleHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class BangBattleGCMessage
   {
      
      public function BangBattleGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_ENTER_BANG_BATTLE] = this.GC_ENTER_BANG_BATTLE;
         index[MessageType.GC_MAIN_GROUND] = this.GC_MAIN_GROUND;
         index[MessageType.GC_QUEST_BANG_BATTLE] = this.GC_QUEST_BANG_BATTLE;
         index[MessageType.GC_SNATCH_ROOM] = this.GC_SNATCH_ROOM;
         index[MessageType.GC_LORD_INFO] = this.GC_LORD_INFO;
         index[MessageType.GC_COLLECT_JK] = this.GC_COLLECT_JK;
         index[MessageType.GC_CANNOT_USE_BUFF1] = this.GC_CANNOT_USE_BUFF1;
         index[MessageType.GC_BB_RANKS] = this.GC_BB_RANKS;
         index[MessageType.GC_BB_INFO] = this.GC_BB_INFO;
      }
      
      public function GC_ENTER_BANG_BATTLE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var flag:int = patch.readByte();
         BangBattleHandle.GC_ENTER_BANG_BATTLE(result,flag);
      }
      
      public function GC_MAIN_GROUND(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         BangBattleHandle.GC_MAIN_GROUND(result);
      }
      
      public function GC_QUEST_BANG_BATTLE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         BangBattleHandle.GC_QUEST_BANG_BATTLE(result);
      }
      
      public function GC_SNATCH_ROOM(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         BangBattleHandle.GC_SNATCH_ROOM(result);
      }
      
      public function GC_LORD_INFO(patch:IDataInput) : void
      {
         var version:int = patch.readInt();
         var len:int = patch.readByte();
         var array:Array = new Array();
         var i:int = 0;
         while(i < len)
         {
            array.push(LongUtil.readLong(patch));
            i++;
         }
         BangBattleHandle.GC_LORD_INFO(version,array);
      }
      
      public function GC_COLLECT_JK(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var uid:int = patch.readInt();
         BangBattleHandle.GC_COLLECT_JK(result,uid);
      }
      
      public function GC_BB_RANKS(patch:IDataInput) : void
      {
         var obj:Object = null;
         var len:int = patch.readByte();
         var arr:Array = new Array();
         var i:int = 0;
         while(i < len)
         {
            obj = new Object();
            obj.rank = i + 1;
            obj.bangId = LongUtil.readLong(patch);
            obj.bangName = patch.readUTF();
            obj.soccer = patch.readInt();
            arr.push(obj);
            i++;
         }
         var bIDArr:Array = [];
         var j:int = 0;
         while(j < 4)
         {
            bIDArr.push(LongUtil.readLong(patch));
            j += 1;
         }
         BangBattleHandle.GC_BB_RANKS(arr,bIDArr);
      }
      
      public function GC_CANNOT_USE_BUFF1(patch:IDataInput) : void
      {
         BangBattleHandle.GC_CANNOT_USE_BUFF1();
      }
      
      public function GC_BB_INFO(patch:IDataInput) : void
      {
         var actTime:int = patch.readShort();
         var mySoccer:int = patch.readInt();
         var killH:int = patch.readShort();
         var killM:int = patch.readShort();
         var bangSoccer:int = patch.readInt();
         var kuangRemain:int = patch.readShort();
         var isStart:int = patch.readByte();
         var bIDArr:Array = [];
         var j:int = 0;
         while(j < 4)
         {
            bIDArr.push(LongUtil.readLong(patch));
            j += 1;
         }
         BangBattleHandle.GC_BB_INFO(actTime,mySoccer,killH,killM,bangSoccer,kuangRemain,isStart,bIDArr);
      }
   }
}

