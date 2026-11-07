package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class CangBaoTuCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function CangBaoTuCGMessage()
      {
         super();
      }
      
      public static function CG_CANGBAOTU_AWARD(gridId:int, voId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeShort(gridId);
         bytebuff.writeInt(voId);
         SocketManager.send(MessageType.CG_CANGBAOTU_AWARD,bytebuff);
      }
   }
}

