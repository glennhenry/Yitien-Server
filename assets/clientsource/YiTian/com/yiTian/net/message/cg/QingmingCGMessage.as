package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class QingmingCGMessage
   {
      
      private static var bytes:ByteArray = new ByteArray();
      
      public function QingmingCGMessage()
      {
         super();
      }
      
      public static function CG_QINGMING_REFRESH_PANEL() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_QINGMING_REFRESH_PANEL,bytes);
      }
      
      public static function CG_QINGMING_REFRESH_QUALITY() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_QINGMING_REFRESH_QUALITY,bytes);
      }
      
      public static function CG_QINGMING_GHOST_XY() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_QINGMING_GHOST_XY,bytes);
      }
      
      public static function CG_QINGMING_CATCHGHOSE(id:int) : void
      {
         bytes.length = 0;
         bytes.writeInt(id);
         SocketManager.send(MessageType.CG_QINGMING_CATCHGHOSE,bytes);
      }
   }
}

