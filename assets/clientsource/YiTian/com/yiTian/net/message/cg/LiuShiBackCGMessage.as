package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class LiuShiBackCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function LiuShiBackCGMessage()
      {
         super();
      }
      
      public static function CG_LIUSHIBACK_OPEN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_LIUSHIBACK_OPEN,bytebuff);
      }
      
      public static function CG_LIUSHIBACK_AWARD(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(id);
         SocketManager.send(MessageType.CG_LIUSHIBACK_AWARD,bytebuff);
      }
   }
}

