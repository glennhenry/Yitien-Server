package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class ShouchangCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function ShouchangCGMessage()
      {
         super();
      }
      
      public static function CG_SHOUCHANG() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_SHOUCHANG,bytebuff);
      }
   }
}

