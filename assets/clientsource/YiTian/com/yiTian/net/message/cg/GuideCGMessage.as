package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class GuideCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function GuideCGMessage()
      {
         super();
      }
      
      public static function CG_GUIDE_SKILL(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(id);
         SocketManager.send(MessageType.CG_GUIDE_SKILL,bytebuff);
      }
      
      public static function CG_GUIDE_PET() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_GUIDE_PET,bytebuff);
      }
      
      public static function CG_GUIDE_HORSE(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(id);
         SocketManager.send(MessageType.CG_GUIDE_HORSE,bytebuff);
      }
      
      public static function CG_GET_NEWPAWARD(seriNum:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeUTF(seriNum);
         SocketManager.send(MessageType.CG_GET_NEWPAWARD,bytebuff);
      }
      
      public static function CG_THIRDNEWER_PETCHANGE() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_THIRDNEWER_PETCHANGE,bytebuff);
      }
      
      public static function CG_BUYWEAPON() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_BUYWEAPON,bytebuff);
      }
   }
}

