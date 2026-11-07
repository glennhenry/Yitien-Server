package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class FangChenMiCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function FangChenMiCGMessage()
      {
         super();
      }
      
      public static function CG_FCM_RETURN(type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         if(type == 1)
         {
            return;
         }
         SocketManager.send(MessageType.CG_FCM_RETURN,bytebuff);
      }
   }
}

