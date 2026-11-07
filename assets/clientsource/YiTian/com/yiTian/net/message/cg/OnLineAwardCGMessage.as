package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class OnLineAwardCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function OnLineAwardCGMessage()
      {
         super();
      }
      
      public static function CG_PCU_GET_REWARD(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(id);
         SocketManager.send(MessageType.CG_PCU_GET_REWARD,bytebuff);
      }
      
      public static function CG_PCU_CAN_REWARD(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(id);
         SocketManager.send(MessageType.CG_PCU_CAN_REWARD,bytebuff);
      }
   }
}

