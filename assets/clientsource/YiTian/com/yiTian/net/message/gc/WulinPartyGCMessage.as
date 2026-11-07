package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.net.handler.WulinPartyHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class WulinPartyGCMessage
   {
      
      public function WulinPartyGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_ENTER_WULIN_DAHUI] = this.GC_ENTER_WULIN_DAHUI;
         index[MessageType.GC_TIPEUP] = this.GC_TIPEUP;
         index[MessageType.GC_PAIHANG_WULIN] = this.GC_PAIHANG_WULIN;
         index[MessageType.GC_WULIN_BEGIN] = this.GC_WULIN_BEGIN;
         index[MessageType.GC_BATTLE_WULIN] = this.GC_BATTLE_WULIN;
         index[MessageType.GC_WULIN_END] = this.GC_WULIN_END;
         index[MessageType.GC_QUIT_MEETING] = this.GC_QUIT_MEETING;
         index[MessageType.GC_WULIN_ADD_FRESH_ITEM] = this.GC_WULIN_ADD_FRESH_ITEM;
         index[MessageType.GC_WULIN_START_COUNT] = this.GC_WULIN_START_COUNT;
         index[MessageType.GC_ENTER_WULIN_DATA] = this.GC_ENTER_WULIN_DATA;
         index[MessageType.GC_CLICK_HERO_BATTLE] = this.GC_CLICK_HERO_BATTLE;
         index[MessageType.GC_TIMEUP_BACK] = this.GC_TIMEUP_BACK;
         index[MessageType.GC_DEADCOUNT] = this.GC_DEADCOUNT;
         index[MessageType.GC_BEEN_LIGHTTEN] = this.GC_BEEN_LIGHTTEN;
         index[MessageType.GC_DEAN_EFFECT] = this.GC_DEAN_EFFECT;
         index[MessageType.GC_LIFE_EFFECT] = this.GC_LIFE_EFFECT;
         index[MessageType.GC_PICKTOOLBACK] = this.GC_PICKTOOLBACK;
         index[MessageType.GC_COUNT_BACK] = this.GC_COUNT_BACK;
         index[MessageType.GC_WULIN_PARTY_EVEN_CUT] = this.GC_WULIN_PARTY_EVEN_CUT;
         index[MessageType.GC_GET_PAIHANG_DATA] = this.GC_GET_PAIHANG_DATA;
         index[MessageType.GC_WULIN_ONLINE_TIP] = this.GC_WULIN_ONLINE_TIP;
      }
      
      public function GC_ENTER_WULIN_DAHUI(patch:IDataInput) : void
      {
         var resule:int = patch.readByte();
         WulinPartyHandle.GC_ENTER_WULIN_DAHUI(resule);
      }
      
      public function GC_TIPEUP(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var leftLife:int = patch.readByte();
         var scores:int = patch.readShort();
         WulinPartyHandle.GC_TIPEUP(leftLife,scores);
      }
      
      public function GC_PAIHANG_WULIN(patch:IDataInput) : void
      {
         var temArr:Array = null;
         var self_Rank:int = patch.readInt();
         var self_jiFen:int = patch.readInt();
         var len:int = patch.readShort();
         var itemsArr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            temArr = [];
            temArr.push(patch.readByte());
            temArr.push(LongUtil.readLong(patch));
            temArr.push(patch.readUTF());
            temArr.push(patch.readShort());
            itemsArr.push(temArr);
            i++;
         }
      }
      
      public function GC_WULIN_BEGIN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WulinPartyHandle.GC_WULIN_BEGIN(result);
      }
      
      public function GC_BATTLE_WULIN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WulinPartyHandle.GC_BATTLE_WULIN(result);
      }
      
      public function GC_QUIT_MEETING(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WulinPartyHandle.GC_QUIT_MEETING(result);
      }
      
      public function GC_WULIN_END(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WulinPartyHandle.GC_WULIN_END(result);
      }
      
      public function GC_WULIN_ONLINE_TIP(patch:IDataInput) : void
      {
         var remainTime:int = patch.readShort();
         WulinPartyHandle.GC_WULIN_ONLINE_TIP(remainTime);
      }
      
      public function GC_WULIN_ADD_FRESH_ITEM(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WulinPartyHandle.GC_WULIN_ADD_FRESH_ITEM(result);
      }
      
      public function GC_WULIN_START_COUNT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WulinPartyHandle.GC_WULIN_START_COUNT(result);
      }
      
      public function GC_ENTER_WULIN_DATA(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var partyTime:int = patch.readShort();
         var lifeRemain:int = patch.readByte();
         var score:int = patch.readShort();
         var itemTimeCount:int = patch.readShort();
         var DeadCount:int = patch.readByte();
         WulinPartyHandle.GC_ENTER_WULIN_DATA(result,partyTime,lifeRemain,score,itemTimeCount,DeadCount);
      }
      
      public function GC_CLICK_HERO_BATTLE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WulinPartyHandle.GC_CLICK_HERO_BATTLE(result);
      }
      
      public function GC_TIMEUP_BACK(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WulinPartyHandle.GC_TIMEUP_BACK(result);
      }
      
      public function GC_DEADCOUNT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WulinPartyHandle.GC_DEADCOUNT(result);
      }
      
      public function GC_GET_PAIHANG_DATA(patch:IDataInput) : void
      {
         var temArr:Array = null;
         var result:int = patch.readByte();
         var selfScore:int = patch.readByte();
         var len:int = patch.readByte();
         var itemsArr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            temArr = [];
            temArr.push(patch.readByte());
            temArr.push(LongUtil.readLong(patch));
            temArr.push(patch.readUTF());
            temArr.push(patch.readShort());
            itemsArr.push(temArr);
            i++;
         }
         WulinPartyHandle.GC_PAIHANG_WULIN(len,itemsArr,selfScore);
      }
      
      public function GC_BEEN_LIGHTTEN(patch:IDataInput) : void
      {
         var roleId:Number = LongUtil.readLong(patch);
         WulinPartyHandle.GC_BEEN_LIGHTTEN(roleId);
      }
      
      public function GC_DEAN_EFFECT(patch:IDataInput) : void
      {
         var roleId:Number = LongUtil.readLong(patch);
         WulinPartyHandle.GC_DEAN_EFFECT(roleId);
      }
      
      public function GC_LIFE_EFFECT(patch:IDataInput) : void
      {
         var roleId:Number = LongUtil.readLong(patch);
         WulinPartyHandle.GC_LIFE_EFFECT(roleId);
      }
      
      public function GC_WULIN_ENTER_RESULT_HANDLE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WulinPartyHandle.GC_WULIN_ENTER_RESULT_HANDLE(result);
      }
      
      public function GC_PICKTOOLBACK(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WulinPartyHandle.GC_PICKTOOLBACK(result);
      }
      
      public function GC_COUNT_BACK(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WulinPartyHandle.GC_COUNT_BACK(result);
      }
      
      public function GC_WULIN_PARTY_EVEN_CUT(patch:IDataInput) : void
      {
         var count:int = patch.readShort();
         WulinPartyHandle.GC_WULIN_PARTY_EVEN_CUT(count);
      }
   }
}

