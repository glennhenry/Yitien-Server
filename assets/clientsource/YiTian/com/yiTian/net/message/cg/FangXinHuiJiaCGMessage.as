package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class FangXinHuiJiaCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function FangXinHuiJiaCGMessage()
      {
         super();
      }
      
      public static function CG_FangXinHuiJia_OPEN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_FangXinHuiJia_OPEN,bytebuff);
      }
      
      public static function CG_FangXinHuiJia_GET_PRIZE() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_FangXinHuiJia_GET_PRIZE,bytebuff);
      }
   }
}

