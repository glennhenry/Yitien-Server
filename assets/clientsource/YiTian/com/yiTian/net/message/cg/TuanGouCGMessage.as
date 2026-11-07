package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class TuanGouCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function TuanGouCGMessage()
      {
         super();
      }
      
      public static function CG_TUANGOU_REQUEST_LIST() : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(1);
         SocketManager.send(MessageType.CG_TUANGOU_REQUEST_LIST,bytebuff);
      }
      
      public static function CG_TUANGOU_TAKE_GOODS(goodsID:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(goodsID);
         SocketManager.send(MessageType.CG_TUANGOU_TAKE_GOODS,bytebuff);
      }
      
      public static function CG_TUANGOU_REQUEST_START() : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(1);
         SocketManager.send(MessageType.CG_TUANGOU_REQUEST_START,bytebuff);
      }
   }
}

