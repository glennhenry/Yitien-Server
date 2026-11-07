package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class LFlowerCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function LFlowerCGMessage()
      {
         super();
      }
      
      public static function CG_IFLOWER_WY() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_IFLOWER_WY,bytebuff);
      }
      
      public static function CG_IFLOWER_OPEN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_IFLOWER_OPEN,bytebuff);
      }
      
      public static function CG_IFLOWER_KILLCD() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_IFLOWER_KILLCD,bytebuff);
      }
      
      public static function CG_IFLOWER_INVITE_N() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_IFLOWER_INVITE_N,bytebuff);
      }
      
      public static function CG_IFLOWER_INVITED() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_IFLOWER_INVITED,bytebuff);
      }
   }
}

