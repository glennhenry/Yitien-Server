package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class QQClockCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function QQClockCGMessage()
      {
         super();
      }
      
      public static function CG_QQCLOCK_ACTION() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_QQCLOCK_ACTION,bytebuff);
      }
   }
}

