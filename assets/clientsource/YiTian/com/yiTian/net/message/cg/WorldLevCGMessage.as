package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class WorldLevCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function WorldLevCGMessage()
      {
         super();
      }
      
      public static function CG_GET_WL_DATA() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_GET_WL_DATA,bytebuff);
      }
      
      public static function CG_WL_REWARD(index:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(index);
         SocketManager.send(MessageType.CG_WL_REWARD,bytebuff);
      }
   }
}

