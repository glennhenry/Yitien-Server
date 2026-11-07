package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.CGMessage;
   import com.yiTian.net.message.MessageType;
   
   public class QTSignCGMessage extends CGMessage
   {
      
      public function QTSignCGMessage()
      {
         super();
      }
      
      public static function CG_QTSign_OPEN() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_QTSign_OPEN,byteBuff);
      }
      
      public static function CG_QTSign_SIGN() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_QTSign_SIGN,byteBuff);
      }
      
      public static function CG_QTSign_AWARD(id:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(id);
         SocketManager.send(MessageType.CG_QTSign_AWARD,byteBuff);
      }
   }
}

