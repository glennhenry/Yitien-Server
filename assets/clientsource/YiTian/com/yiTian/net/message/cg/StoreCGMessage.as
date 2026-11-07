package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class StoreCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function StoreCGMessage()
      {
         super();
      }
      
      public static function CG_PLAZA(sign:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(sign);
         SocketManager.send(MessageType.CG_PLAZA,bytebuff);
      }
      
      public static function CG_BUY_GOODS(wpid:int, wpNum:int, sign:int = 1) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(wpid);
         bytebuff.writeShort(wpNum);
         bytebuff.writeByte(sign);
         SocketManager.send(MessageType.CG_BUY_GOODS,bytebuff);
      }
   }
}

