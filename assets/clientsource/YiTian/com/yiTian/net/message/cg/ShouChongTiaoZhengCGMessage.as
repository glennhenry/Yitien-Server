package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class ShouChongTiaoZhengCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function ShouChongTiaoZhengCGMessage()
      {
         super();
      }
      
      public static function CG_ShouChongTiaoZheng_GET_PRIZE() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ShouChongTiaoZheng_GET_PRIZE,bytebuff);
      }
      
      public static function CG_ShouChongTiaoZheng_LINK() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ShouChongTiaoZheng_LINK,bytebuff);
      }
   }
}

