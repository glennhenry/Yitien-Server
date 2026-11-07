package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class DAUCGMessage
   {
      
      private static var bytes:ByteArray = new ByteArray();
      
      public function DAUCGMessage()
      {
         super();
      }
      
      public static function CG_DAU_GET_REWARDINFO() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_DAU_GET_REWARDINFO,bytes);
      }
      
      public static function CG_DAU_GET_REWARD(index:int) : void
      {
         bytes.length = 0;
         bytes.writeByte(index);
         SocketManager.send(MessageType.CG_DAU_GET_REWARD,bytes);
      }
   }
}

