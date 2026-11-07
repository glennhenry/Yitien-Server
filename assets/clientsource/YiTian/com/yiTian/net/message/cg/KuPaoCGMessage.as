package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class KuPaoCGMessage
   {
      
      public static var bytes:ByteArray = new ByteArray();
      
      public function KuPaoCGMessage()
      {
         super();
      }
      
      public static function CG_KP_REQUESTBASICINFO() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_KP_REQUESTBASICINFO,bytes);
      }
      
      public static function CG_KP_FRIENDSRANK() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_KP_FRIENDSRANK,bytes);
      }
      
      public static function CG_KP_REQUESTHP() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_KP_REQUESTHP,bytes);
      }
      
      public static function CG_KP_USEITEM(type:int) : void
      {
         bytes.length = 0;
         bytes.writeByte(type);
         SocketManager.send(MessageType.CG_KP_USEITEM,bytes);
      }
      
      public static function CG_KP_RANK(pageIndex:int) : void
      {
         bytes.length = 0;
         bytes.writeInt(pageIndex);
         SocketManager.send(MessageType.CG_KP_RANK,bytes);
      }
      
      public static function CG_KP_STARTGAME1() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_KP_STARTGAME1,bytes);
      }
      
      public static function CG_KP_SUBMITSCORE(meter:int, numCoin:int, isUseDouble:int, itemUseInfo:String, validateScore:int) : void
      {
         bytes.length = 0;
         bytes.writeInt(meter);
         bytes.writeInt(numCoin);
         bytes.writeByte(isUseDouble);
         bytes.writeUTF(itemUseInfo);
         bytes.writeInt(validateScore);
         SocketManager.send(MessageType.CG_KP_SUBMITSCORE,bytes);
      }
      
      public static function CG_KP_SHOWOFF(score:int) : void
      {
         bytes.length = 0;
         bytes.writeInt(score);
         SocketManager.send(MessageType.CG_KP_SHOWOFF,bytes);
      }
      
      public static function CG_KP_GETITEMBUYTIMES() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_KP_GETITEMBUYTIMES,bytes);
      }
   }
}

