package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.CGMessage;
   import com.yiTian.net.message.MessageType;
   
   public class BlueDiamondFuLiCGMessage extends CGMessage
   {
      
      public function BlueDiamondFuLiCGMessage()
      {
         super();
      }
      
      public static function getAward(index:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(index);
         SocketManager.send(MessageType.CG_BLUEDIAMOND_GETAWARD,byteBuff);
      }
   }
}

