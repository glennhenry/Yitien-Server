package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class WuLinDuoBaoCGMessage
   {
      
      public static var byteBuff:ByteArray = new ByteArray();
      
      public function WuLinDuoBaoCGMessage()
      {
         super();
      }
      
      public static function CG_DUOBAO(flag:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(flag);
         SocketManager.send(MessageType.CG_DUOBAO,byteBuff);
      }
      
      public static function CG_GET_BAOXIANG(flag:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(flag);
         SocketManager.send(MessageType.CG_GET_BAOXIANG,byteBuff);
      }
      
      public static function CG_CANCEL_GET_BAOXIANG(flag:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(flag);
         SocketManager.send(MessageType.CG_CANCEL_GET_BAOXIANG,byteBuff);
      }
   }
}

