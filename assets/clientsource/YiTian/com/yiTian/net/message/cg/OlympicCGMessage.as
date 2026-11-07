package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class OlympicCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function OlympicCGMessage()
      {
         super();
      }
      
      public static function CG_OLYMPIC_REWARD(key:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeUTF(key);
         SocketManager.send(MessageType.CG_OLYMPIC_REWARD,bytebuff);
      }
      
      public static function CG_DAYS_OLM_REWARD(key:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeUTF(key);
         SocketManager.send(MessageType.CG_DAYS_OLM_REWARD,bytebuff);
      }
   }
}

