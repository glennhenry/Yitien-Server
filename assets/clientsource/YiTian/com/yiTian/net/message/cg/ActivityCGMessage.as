package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class ActivityCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function ActivityCGMessage()
      {
         super();
      }
      
      public static function CG_ACTIVITY_CWJX_OPEN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ACTIVITY_CWJX_OPEN,bytebuff);
      }
      
      public static function CG_ACTIVITY_CWJX_GETWARD(index:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(index + 1);
         SocketManager.send(MessageType.CG_ACTIVITY_CWJX_GETWARD,bytebuff);
      }
   }
}

