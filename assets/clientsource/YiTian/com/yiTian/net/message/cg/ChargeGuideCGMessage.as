package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class ChargeGuideCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function ChargeGuideCGMessage()
      {
         super();
      }
      
      public static function CG_GET_TEMP_FASHION() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_GET_TEMP_FASHION,bytebuff);
      }
      
      public static function CG_GET_TEMP_VIP() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_GET_TEMP_VIP,bytebuff);
      }
      
      public static function CG_STOP_USE() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_STOP_USE,bytebuff);
      }
   }
}

