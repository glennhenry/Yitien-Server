package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class TreasureCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function TreasureCGMessage()
      {
         super();
      }
      
      public static function cg_treasure_bowl_data() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.cg_treasure_bowl_data,bytebuff);
      }
   }
}

