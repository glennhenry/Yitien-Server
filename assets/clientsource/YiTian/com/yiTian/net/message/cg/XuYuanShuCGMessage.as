package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.CGMessage;
   import com.yiTian.net.message.MessageType;
   
   public class XuYuanShuCGMessage extends CGMessage
   {
      
      public function XuYuanShuCGMessage()
      {
         super();
      }
      
      public static function CG_XuYuanShu_CLICKICON() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_XuYuanShu_CLICKICON,byteBuff);
      }
      
      public static function CG_XuYuanShu_RENGOU(num:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(num);
         SocketManager.send(MessageType.CG_XuYuanShu_RENGOU,byteBuff);
      }
      
      public static function CG_XuYuanShu_GETAWARD() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_XuYuanShu_GETAWARD,byteBuff);
      }
   }
}

