package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class YellowDiamondCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function YellowDiamondCGMessage()
      {
         super();
      }
      
      public static function CG_YELLOW_DIAMOND_START() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_YELLOW_DIAMOND_START,bytebuff);
      }
      
      public static function CG_YELLOW_REQUEST_INITDATA() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_YELLOW_REQUEST_INITDATA,bytebuff);
      }
   }
}

