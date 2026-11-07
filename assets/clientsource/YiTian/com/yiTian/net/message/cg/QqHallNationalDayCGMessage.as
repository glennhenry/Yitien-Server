package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class QqHallNationalDayCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function QqHallNationalDayCGMessage()
      {
         super();
      }
      
      public static function cg_get_gift(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(id);
         SocketManager.send(MessageType.cg_qq_hall_get_gift,bytebuff);
      }
   }
}

