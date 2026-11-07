package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class XunZhangCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function XunZhangCGMessage()
      {
         super();
      }
      
      public static function CG_XUNZHANG_JINJIE(jjHouId:int, jjQianId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(jjHouId);
         bytebuff.writeInt(jjQianId);
         SocketManager.send(MessageType.CG_XUNZHANG_JINJIE,bytebuff);
      }
      
      public static function CG_XUNZHANG_DIAOKE(witchNum:int, reLvl:int, gridId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(witchNum);
         bytebuff.writeByte(reLvl);
         bytebuff.writeByte(gridId);
         SocketManager.send(MessageType.CG_XUNZHANG_DIAOKE,bytebuff);
      }
   }
}

