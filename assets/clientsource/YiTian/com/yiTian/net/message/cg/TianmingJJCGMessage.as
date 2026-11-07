package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class TianmingJJCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function TianmingJJCGMessage()
      {
         super();
      }
      
      public static function CG_TMJJ_OPENWIN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_TMJJ_OPENWIN,bytebuff);
      }
      
      public static function CG_TMJJ_TZ(gid:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(gid);
         SocketManager.send(MessageType.CG_TMJJ_TZ,bytebuff);
      }
      
      public static function CG_TMJJ_LQ(type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_TMJJ_LQ,bytebuff);
      }
      
      public static function CG_TMJJ_JJ(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(id);
         SocketManager.send(MessageType.CG_TMJJ_JJ,bytebuff);
      }
      
      public static function CG_TMJJ_JJ_START(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(id);
         SocketManager.send(MessageType.CG_TMJJ_JJ_START,bytebuff);
      }
   }
}

