package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.CGMessage;
   import com.yiTian.net.message.MessageType;
   
   public class CaiDengMiCGMessage extends CGMessage
   {
      
      public function CaiDengMiCGMessage()
      {
         super();
      }
      
      public static function CG_CaiDengMi_OPEN() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_CaiDengMi_OPEN,byteBuff);
      }
      
      public static function CG_CaiDengMi_CHOISE(choise:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(choise);
         SocketManager.send(MessageType.CG_CaiDengMi_CHOISE,byteBuff);
      }
   }
}

