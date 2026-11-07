package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class WuxingCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function WuxingCGMessage()
      {
         super();
      }
      
      public static function CG_OPEN_WUXINGPAN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_OPEN_WUXINGPAN,bytebuff);
      }
      
      public static function CG_XIUXING_WUXING(style:int, type:int, underSign:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(style);
         bytebuff.writeByte(type);
         bytebuff.writeByte(underSign);
         SocketManager.send(MessageType.CG_XIUXING_WUXING,bytebuff);
      }
   }
}

