package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class ChristmasWishCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function ChristmasWishCGMessage()
      {
         super();
      }
      
      public static function CG_GET_WISH(moneyType:uint, type:uint) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(moneyType);
         bytebuff.writeInt(type);
         SocketManager.send(MessageType.CG_GET_WISH,bytebuff);
      }
      
      public static function CG_OPEN_WISH() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_OPEN_WISH,bytebuff);
      }
   }
}

