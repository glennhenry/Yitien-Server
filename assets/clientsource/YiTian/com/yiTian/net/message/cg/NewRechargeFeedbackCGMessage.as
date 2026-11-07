package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class NewRechargeFeedbackCGMessage
   {
      
      public static var byteBuff:ByteArray = new ByteArray();
      
      public function NewRechargeFeedbackCGMessage()
      {
         super();
      }
      
      public static function CG_NEW_OPEN_FEEDBACK() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_NEW_OPEN_FEEDBACK,byteBuff);
      }
      
      public static function CG_NEW_GET_FEEDBACK(id:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(id);
         SocketManager.send(MessageType.CG_NEW_GET_FEEDBACK,byteBuff);
      }
   }
}

