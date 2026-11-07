package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class GengXinCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function GengXinCGMessage()
      {
         super();
      }
      
      public static function CG_GENGXINGONGGAO() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_GENGXINGONGGAO,bytebuff);
      }
   }
}

