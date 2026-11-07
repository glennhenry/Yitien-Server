package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class AwardOnlineCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function AwardOnlineCGMessage()
      {
         super();
      }
      
      public static function CG_GET_AWARD(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(id);
         SocketManager.send(MessageType.CG_GET_AWARD,bytebuff);
      }
      
      public static function CG_GET_CJ_INFO_BOARD() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_OPEN_BOARD,bytebuff);
      }
      
      public static function CG_GET_CJ_AWARD(type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_GET_DLCJ_AWARD,bytebuff);
      }
      
      public static function CG_CJ_SEND(type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_CJ_START_SEND,bytebuff);
      }
   }
}

