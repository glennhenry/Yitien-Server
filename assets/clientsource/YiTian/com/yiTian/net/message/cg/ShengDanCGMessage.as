package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class ShengDanCGMessage
   {
      
      public static var byteBuff:ByteArray = new ByteArray();
      
      public function ShengDanCGMessage()
      {
         super();
      }
      
      public static function CG_SHENGDAN_CILCK() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_SHENGDAN_CILCK,byteBuff);
      }
      
      public static function CG_SHENGDAN_GET(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_SHENGDAN_GET,byteBuff);
      }
   }
}

