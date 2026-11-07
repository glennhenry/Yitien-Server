package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class FishingCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function FishingCGMessage()
      {
         super();
      }
      
      public static function CG_ENTER_RIVER(riverIndex:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(riverIndex);
         SocketManager.send(MessageType.CG_ENTER_RIVER,bytebuff);
      }
      
      public static function CG_XIAGAN(riverId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(riverId);
         SocketManager.send(MessageType.CG_XIAGAN,bytebuff);
      }
      
      public static function CG_FISHINGONTIME(riverId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(riverId);
         SocketManager.send(MessageType.CG_FISHINGONTIME,bytebuff);
      }
      
      public static function CG_SHOUGAN(riverId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(riverId);
         SocketManager.send(MessageType.CG_SHOUGAN,bytebuff);
      }
      
      public static function CG_CHECK_FISH(riverId:int, rollId:Number) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(riverId);
         LongUtil.writeLong(bytebuff,rollId);
         SocketManager.send(MessageType.CG_CHECK_FISH,bytebuff);
      }
      
      public static function CG_FISH_TO_WHERE(riverId:int, fishIndex:int, where:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(riverId);
         bytebuff.writeByte(fishIndex);
         bytebuff.writeByte(where);
         SocketManager.send(MessageType.CG_FISH_TO_WHERE,bytebuff);
      }
      
      public static function CG_SNATCH_FISH(roleId:Number, riverId:int, fishIndex:int, itemId:int, count:int) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,roleId);
         bytebuff.writeByte(riverId);
         bytebuff.writeByte(fishIndex);
         bytebuff.writeInt(itemId);
         bytebuff.writeByte(count);
         SocketManager.send(MessageType.CG_SNATCH_FISH,bytebuff);
      }
      
      public static function CG_LEAVE_FISHING(riverId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(riverId);
         SocketManager.send(MessageType.CG_LEAVE_FISHING,bytebuff);
      }
      
      public static function CG_FISH_ROOM() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_FISH_ROOM,bytebuff);
      }
   }
}

