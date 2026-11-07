package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class LeiJiChongZhiCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function LeiJiChongZhiCGMessage()
      {
         super();
      }
      
      public static function CG_LJCZ_SHOWPANEL() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_LJCZ_SHOWPANEL,bytebuff);
      }
      
      public static function CG_LJCZ_GETAWARD(dangshu:int, index:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(dangshu);
         bytebuff.writeByte(index);
         SocketManager.send(MessageType.CG_LJCZ_GETAWARD,bytebuff);
      }
   }
}

