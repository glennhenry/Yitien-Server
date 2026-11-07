package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class GoldCJCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function GoldCJCGMessage()
      {
         super();
      }
      
      public static function CG_GLOD_CJ_START_LOTTERY(type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_GOLD_CJ_START_LOTTERY,bytebuff);
      }
      
      public static function CG_GLOD_CJ_LOCK_GRID(position:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(position);
         SocketManager.send(MessageType.CG_GOLD_CJ_LOCK_GRID,bytebuff);
      }
   }
}

