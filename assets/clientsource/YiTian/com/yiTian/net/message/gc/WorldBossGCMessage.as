package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.WorldBossHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class WorldBossGCMessage
   {
      
      public function WorldBossGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_WB_SHOW_ICON] = this.GC_WB_SHOW_ICON;
         index[MessageType.GC_WB_ENTERFUBEN] = this.GC_WB_ENTERFUBEN;
         index[MessageType.GC_WB_NUM_MEMBERJOIN] = this.GC_WB_NUM_MEMBERJOIN;
         index[MessageType.GC_WB_TIME_REMAIN] = this.GC_WB_TIME_REMAIN;
         index[MessageType.GC_WB_FUBENINFO] = this.GC_WB_FUBENINFO;
         index[MessageType.GC_WB_DAMAGED_TRACE] = this.GC_WB_DAMAGED_TRACE;
         index[MessageType.GC_WB_USE_CHUANGONG] = this.GC_WB_USE_CHUANGONG;
         index[MessageType.GC_WB_CHALLENGE] = this.GC_WB_CHALLENGE;
         index[MessageType.GC_WB_COLLECT] = this.GC_WB_COLLECT;
         index[MessageType.GC_WB_DAMAGED_CHARTS] = this.GC_WB_DAMAGED_CHARTS;
         index[MessageType.GC_WB_LEAVE_FUBEN] = this.GC_WB_LEAVE_FUBEN;
         index[MessageType.GC_WB_CHUANGONG] = this.GC_WB_CHUANGONG;
         index[MessageType.GC_WB_REVIVE] = this.GC_WB_REVIVE;
         index[MessageType.GC_WB_CHAT_BROADCAST] = this.GC_WB_CHAT_BROADCAST;
         index[MessageType.GC_WB_COLLDOWN] = this.GC_WB_COLLDOWN;
         index[MessageType.GC_WB_DMGBROADCAST] = this.GC_WB_DMGBROADCAST;
      }
      
      private function GC_WB_SHOW_ICON(patch:IDataInput) : void
      {
         var iconFlag:Number = patch.readByte();
         var isSuit:int = patch.readByte();
         var monsterID:int = patch.readInt();
         WorldBossHandle.GC_WB_SHOW_ICON(iconFlag,isSuit,monsterID);
      }
      
      private function GC_WB_ENTERFUBEN(patch:IDataInput) : void
      {
         var result:Number = patch.readByte();
         WorldBossHandle.GC_WB_ENTERFUBEN(result);
      }
      
      private function GC_WB_NUM_MEMBERJOIN(patch:IDataInput) : void
      {
         var num:Number = patch.readInt();
         WorldBossHandle.GC_WB_NUM_MEMBERJOIN(num);
      }
      
      private function GC_WB_TIME_REMAIN(patch:IDataInput) : void
      {
         var remain:Number = patch.readInt();
         var bossID:Number = patch.readInt();
         var color:int = patch.readByte();
         WorldBossHandle.GC_WB_TIME_REMAIN(remain,bossID,color);
      }
      
      private function GC_WB_FUBENINFO(patch:IDataInput) : void
      {
         var maxHp:Number = patch.readInt();
         var curHp:Number = patch.readInt();
         WorldBossHandle.GC_WB_FUBENINFO(maxHp,curHp);
      }
      
      private function GC_WB_DAMAGED_TRACE(patch:IDataInput) : void
      {
         var roleName:String = null;
         var damagePercent:Number = NaN;
         var ranks:Array = [];
         var len:int = patch.readByte();
         var i:int = 0;
         while(i < len)
         {
            roleName = patch.readUTF();
            damagePercent = patch.readShort();
            ranks.push([roleName,damagePercent]);
            i += 1;
         }
         var myRank:int = patch.readInt();
         var myDamagePercent:int = patch.readShort();
         WorldBossHandle.GC_WB_DAMAGED_TRACE(ranks,myRank,myDamagePercent);
      }
      
      private function GC_WB_USE_CHUANGONG(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WorldBossHandle.GC_WB_USE_CHUANGONG(result);
      }
      
      private function GC_WB_CHALLENGE(patch:IDataInput) : void
      {
         var battleID:Number = patch.readInt();
         var type:int = patch.readByte();
         WorldBossHandle.GC_WB_CHALLENGE(battleID,type);
      }
      
      private function GC_WB_COLLECT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WorldBossHandle.GC_WB_COLLECT(result);
      }
      
      private function GC_WB_DAMAGED_CHARTS(patch:IDataInput) : void
      {
         var roleName:String = null;
         var damagePercent:Number = NaN;
         var ranks:Array = [];
         var len:int = patch.readByte();
         var i:int = 0;
         while(i < len)
         {
            roleName = patch.readUTF();
            damagePercent = patch.readShort();
            ranks.push([roleName,damagePercent]);
            i += 1;
         }
         WorldBossHandle.GC_WB_DAMAGED_CHARTS(ranks);
      }
      
      private function GC_WB_LEAVE_FUBEN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WorldBossHandle.GC_WB_LEAVE_FUBEN(result);
      }
      
      private function GC_WB_CHUANGONG(patch:IDataInput) : void
      {
         var num:int = patch.readByte();
         WorldBossHandle.GC_WB_CHUANGONG(num);
      }
      
      private function GC_WB_REVIVE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         WorldBossHandle.GC_WB_REVIVE(result);
      }
      
      private function GC_WB_CHAT_BROADCAST(patch:IDataInput) : void
      {
         var bossSysID:int = patch.readInt();
         WorldBossHandle.GC_WB_CHAT_BROADCAST(bossSysID);
      }
      
      private function GC_WB_COLLDOWN(patch:IDataInput) : void
      {
         var remain:int = patch.readShort();
         WorldBossHandle.GC_WB_COLLDOWN(remain);
      }
      
      private function GC_WB_DMGBROADCAST(patch:IDataInput) : void
      {
         var roleName:String = null;
         var dmgPercent:int = 0;
         var dmgInfos:Array = [];
         var len:int = patch.readByte();
         var i:int = 0;
         while(i < len)
         {
            roleName = patch.readUTF();
            dmgPercent = patch.readShort();
            dmgInfos.push([roleName,dmgPercent]);
            i += 1;
         }
         WorldBossHandle.GC_WB_DMGBROADCAST(dmgInfos);
      }
   }
}

