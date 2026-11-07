package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class QifuCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function QifuCGMessage()
      {
         super();
      }
      
      public static function CG_OPEN_QIFU_PAN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_OPEN_QIFU_PAN,bytebuff);
      }
      
      public static function CG_QIFU_TYPE(_type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(_type);
         SocketManager.send(MessageType.CG_QIFU_TYPE,bytebuff);
      }
      
      public static function CG_QIFU_DUIHUAN(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(id);
         SocketManager.send(MessageType.CG_QIFU_DUIHUAN,bytebuff);
      }
   }
}

