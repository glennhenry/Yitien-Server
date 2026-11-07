package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class RetrieExpCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function RetrieExpCGMessage()
      {
         super();
      }
      
      public static function CG_RETRIEEXP_INFO() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_RETRIEEXP_INFO,bytebuff);
      }
      
      public static function CG_RETRIEEXP1(type:int, date:int, tokenGridId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         bytebuff.writeInt(date);
         bytebuff.writeInt(tokenGridId);
         SocketManager.send(MessageType.CG_RETRIEEXP1,bytebuff);
      }
      
      public static function CG_RETRIEEXP2(type:int, date:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         bytebuff.writeInt(date);
         SocketManager.send(MessageType.CG_RETRIEEXP2,bytebuff);
      }
   }
}

