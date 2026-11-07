package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class HumanCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function HumanCGMessage()
      {
         super();
      }
      
      public static function CG_FIRST_PLAY() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_FIRST_PLAY,bytebuff);
      }
      
      public static function CG_CHENGHAO_UPGRADE() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_CHENGHAO_UPGRADE,bytebuff);
      }
      
      public static function CG_SOUND(type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_SOUND,bytebuff);
      }
   }
}

