package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class JinDanCGMessage
   {
      
      public static var byteBuff:ByteArray = new ByteArray();
      
      public function JinDanCGMessage()
      {
         super();
      }
      
      public static function CG_GOLD_EGG() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_GOLD_EGG,byteBuff);
      }
      
      public static function CG_HIT_EGG(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_HIT_EGG,byteBuff);
      }
   }
}

