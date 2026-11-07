package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class MeiRiXianGouCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function MeiRiXianGouCGMessage()
      {
         super();
      }
      
      public static function CG_MRXG_OPEN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_MRXG_OPEN,bytebuff);
      }
      
      public static function CG_MRXG_BUY(index:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(index);
         SocketManager.send(MessageType.CG_MRXG_BUY,bytebuff);
      }
   }
}

