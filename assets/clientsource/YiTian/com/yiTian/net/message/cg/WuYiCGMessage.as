package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class WuYiCGMessage
   {
      
      public static var byteBuff:ByteArray = new ByteArray();
      
      public function WuYiCGMessage()
      {
         super();
      }
      
      public static function CG_WUYI_TIME() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_WUYI_TIME,byteBuff);
      }
   }
}

