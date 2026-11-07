package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.CGMessage;
   import com.yiTian.net.message.MessageType;
   
   public class JiaNianHuaCGMessage extends CGMessage
   {
      
      public function JiaNianHuaCGMessage()
      {
         super();
      }
      
      public static function CG_JiaNianHua_OPEN() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_JiaNianHua_OPEN,byteBuff);
      }
      
      public static function CG_JiaNianHua_GET() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_JiaNianHua_GET,byteBuff);
      }
      
      public static function CG_JiaNianHua_OPEN_2() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_JiaNianHua_OPEN_2,byteBuff);
      }
      
      public static function CG_JiaNianHua_GET_2() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_JiaNianHua_GET_2,byteBuff);
      }
   }
}

