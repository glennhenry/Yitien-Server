package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class TianMingCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function TianMingCGMessage()
      {
         super();
      }
      
      public static function CG_USE_BLESSINGFRUIT(id:int, num:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(id);
         bytebuff.writeInt(num);
         SocketManager.send(MessageType.CG_USE_BLESSINGFRUIT,bytebuff);
      }
      
      public static function CG_USE_TIANMING(type1:int, sysId1:int, grid1Num:int, type2:int, sysId2:int, grid2Num:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type1);
         bytebuff.writeInt(sysId1);
         bytebuff.writeInt(grid1Num);
         bytebuff.writeByte(type2);
         bytebuff.writeInt(sysId2);
         bytebuff.writeInt(grid2Num);
         SocketManager.send(MessageType.CG_USE_TIANMING,bytebuff);
      }
      
      public static function CG_OPEN_TIANMING() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_OPEN_TIANMING,bytebuff);
      }
      
      public static function CG_COMP_BAG_TIANMING(type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_COMP_BAG_TIANMING,bytebuff);
      }
      
      public static function CG_UP_TIANFU() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_UP_TIANFU,bytebuff);
      }
      
      public static function CG_UP_ZHUFU() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_UP_ZHUFU,bytebuff);
      }
      
      public static function CG_TIANMING_LOCK(id:int, flag:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(id);
         bytebuff.writeByte(flag);
         SocketManager.send(MessageType.CG_TIANMING_LOCK,bytebuff);
      }
   }
}

