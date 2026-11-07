package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.CGMessage;
   import com.yiTian.net.message.MessageType;
   
   public class BabyGiftCGMessage extends CGMessage
   {
      
      public function BabyGiftCGMessage()
      {
         super();
      }
      
      public static function CG_ETLB_OPEN() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_ETLB_OPEN,byteBuff);
      }
      
      public static function CG_ETLB_GETAWARD() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_ETLB_GETAWARD,byteBuff);
      }
   }
}

