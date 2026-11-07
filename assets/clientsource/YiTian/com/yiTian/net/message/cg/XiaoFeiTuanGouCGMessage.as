package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.CGMessage;
   import com.yiTian.net.message.MessageType;
   
   public class XiaoFeiTuanGouCGMessage extends CGMessage
   {
      
      public function XiaoFeiTuanGouCGMessage()
      {
         super();
      }
      
      public static function CG_XFTG_OPEN() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_XFTG_OPEN,byteBuff);
      }
      
      public static function CG_XFTG_GETAWARD(index:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(index);
         SocketManager.send(MessageType.CG_XFTG_GETAWARD,byteBuff);
      }
      
      public static function CG_XFTG_BUY(index:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(index);
         SocketManager.send(MessageType.CG_XFTG_BUY,byteBuff);
      }
   }
}

