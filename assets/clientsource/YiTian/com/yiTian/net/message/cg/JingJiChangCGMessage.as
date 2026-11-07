package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class JingJiChangCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function JingJiChangCGMessage()
      {
         super();
      }
      
      public static function CG_CHALLENGE_SNOWMAN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_CHALLENGE_SNOWMAN,bytebuff);
      }
      
      public static function CG_GET_PAIMING() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_GET_PAIMING,bytebuff);
      }
      
      public static function CG_GET_WAR_INFO() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_GET_WAR_INFO,bytebuff);
      }
      
      public static function CG_DEKARON(roleId:Number, pai_ming:int, name:String) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,roleId);
         bytebuff.writeInt(pai_ming);
         bytebuff.writeUTF(name);
         SocketManager.send(MessageType.CG_DEKARON,bytebuff);
      }
      
      public static function CG_DEKARON_RANDOM(_paiMing:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(_paiMing);
         SocketManager.send(MessageType.CG_DEKARON_RANDOM,bytebuff);
      }
      
      public static function CG_CANCEL_COOLTIME(wpId:int, Num:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(wpId);
         bytebuff.writeInt(Num);
         SocketManager.send(MessageType.CG_CANCEL_COOLTIME,bytebuff);
      }
      
      public static function CG_PAIHANG() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_PAIHANG,bytebuff);
      }
      
      public static function CG_PAIHANG_CHECK(_roleId:Number, _paiMing:int) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,_roleId);
         bytebuff.writeInt(_paiMing);
         SocketManager.send(MessageType.CG_PAIHANG_CHECK,bytebuff);
      }
      
      public static function CG_SET_POSITION(heroPosition:int, petPosition:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(heroPosition);
         bytebuff.writeByte(petPosition);
         SocketManager.send(MessageType.CG_SET_POSITION,bytebuff);
      }
      
      public static function CG_RANDOM_RESULT(_paiMing:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(_paiMing);
         SocketManager.send(MessageType.CG_RANDOM_RESULT,bytebuff);
      }
      
      public static function CG_XUANYAO(_warId:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,_warId);
         SocketManager.send(MessageType.CG_XUANYAO,bytebuff);
      }
      
      public static function CG_SPEED() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_SPEED,bytebuff);
      }
   }
}

