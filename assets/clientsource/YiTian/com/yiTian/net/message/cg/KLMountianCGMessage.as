package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class KLMountianCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function KLMountianCGMessage()
      {
         super();
      }
      
      public static function CG_ENTER_KL_MOUNTIAN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ENTER_KL_MOUNTIAN,bytebuff);
      }
      
      public static function CG_GET_KL_ROOM() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_GET_KL_ROOM,bytebuff);
      }
      
      public static function CG_CHANGE_KL_ROON(index:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeShort(index);
         SocketManager.send(MessageType.CG_CHANGE_KL_ROON,bytebuff);
      }
      
      public static function CG_KL_LEAVE() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_KL_LEAVE,bytebuff);
      }
      
      public static function CG_KL_RANK1() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_KL_RANK1,bytebuff);
      }
      
      public static function CG_KL_RANK(which:int, index:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(which);
         bytebuff.writeByte(index);
         SocketManager.send(MessageType.CG_KL_RANK,bytebuff);
      }
   }
}

