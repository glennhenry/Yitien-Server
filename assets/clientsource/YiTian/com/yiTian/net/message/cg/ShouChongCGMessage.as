package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class ShouChongCGMessage
   {
      
      public static var byteBuff:ByteArray = new ByteArray();
      
      public function ShouChongCGMessage()
      {
         super();
      }
      
      public static function CG_SHOUCHONG_AWARD() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_SHOUCHONG_AWARD,byteBuff);
      }
   }
}

