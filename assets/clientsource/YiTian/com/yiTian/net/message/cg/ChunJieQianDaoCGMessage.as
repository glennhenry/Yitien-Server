package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class ChunJieQianDaoCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function ChunJieQianDaoCGMessage()
      {
         super();
      }
      
      public static function CG_ChunJieQianDao_OPEN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ChunJieQianDao_OPEN,bytebuff);
      }
      
      public static function CG_ChunJieQianDao_SIGN(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(id);
         SocketManager.send(MessageType.CG_ChunJieQianDao_SIGN,bytebuff);
      }
      
      public static function CG_ChunJieQianDao_GET_PRIZE() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ChunJieQianDao_GET_PRIZE,bytebuff);
      }
   }
}

