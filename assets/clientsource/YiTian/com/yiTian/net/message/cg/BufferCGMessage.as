package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class BufferCGMessage
   {
      
      public static var byteBuff:ByteArray = new ByteArray();
      
      public function BufferCGMessage()
      {
         super();
      }
      
      public static function CG_BUFFER_END(buffId:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(buffId);
         SocketManager.send(MessageType.CG_BUFFER_END,byteBuff);
      }
      
      public static function CG_ADD_HP_MP(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_ADD_HP_MP,byteBuff);
      }
   }
}

