package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.CGMessage;
   import com.yiTian.net.message.MessageType;
   
   public class HuangzhuanZPCGMessage extends CGMessage
   {
      
      public function HuangzhuanZPCGMessage()
      {
         super();
      }
      
      public static function CG_HZZP_OPENWIN() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_HZZP_OPENWIN,byteBuff);
      }
      
      public static function CG_HZZP_CJ() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_HZZP_CJ,byteBuff);
      }
   }
}

