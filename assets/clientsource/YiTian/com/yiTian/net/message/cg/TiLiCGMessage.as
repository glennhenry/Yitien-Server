package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class TiLiCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function TiLiCGMessage()
      {
         super();
      }
      
      public static function TiliBought(_type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(_type);
         SocketManager.send(MessageType.CG_TILI_STORE_BOUGHT,bytebuff);
      }
      
      public static function CG_GET_TILI() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_GET_TILI,bytebuff);
      }
      
      public static function CG_BUYTILI() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_BUYTILI,bytebuff);
      }
   }
}

