package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.CGMessage;
   import com.yiTian.net.message.MessageType;
   
   public class JvHuaSuanCGMessage extends CGMessage
   {
      
      public function JvHuaSuanCGMessage()
      {
         super();
      }
      
      public static function CG_JHS_OPEN() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_JHS_OPEN,byteBuff);
      }
      
      public static function CG_JHS_BUY(btnIndex:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(btnIndex);
         SocketManager.send(MessageType.CG_JHS_BUY,byteBuff);
      }
      
      public static function CG_JHS_GETAWARD(btnIndex:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(btnIndex);
         SocketManager.send(MessageType.CG_JHS_GETAWARD,byteBuff);
      }
   }
}

