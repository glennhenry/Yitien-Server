package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class CheckCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function CheckCGMessage()
      {
         super();
      }
      
      public static function CG_SHOW_CHECK_PAN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_SHOW_CHECK_PAN,bytebuff);
      }
      
      public static function CG_HANDUP_QUESTION(_type:int, questionId:int, queOption:String, others:String = "") : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(_type);
         bytebuff.writeInt(questionId);
         bytebuff.writeUTF(queOption);
         bytebuff.writeUTF(others);
         SocketManager.send(MessageType.CG_HANDUP_QUESTION,bytebuff);
      }
   }
}

