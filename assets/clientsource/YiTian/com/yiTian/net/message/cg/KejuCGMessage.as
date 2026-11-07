package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class KejuCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function KejuCGMessage()
      {
         super();
      }
      
      public static function CG_POEMS_ANSWER(poemsId:int, answer:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(poemsId);
         bytebuff.writeInt(answer);
         SocketManager.send(MessageType.CG_POEMS_ANSWER,bytebuff);
      }
      
      public static function CG_QUIT_KEJU(type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_QUIT_KEJU,bytebuff);
      }
      
      public static function CG_USE_LUCKY() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_USE_LUCKY,bytebuff);
      }
      
      public static function CG_USE_CAISHEN(questID:int, answerId:int, isLucky:int, isCaiShen:int, time:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(questID);
         bytebuff.writeInt(answerId);
         bytebuff.writeByte(isLucky);
         bytebuff.writeByte(isCaiShen);
         bytebuff.writeInt(time);
         SocketManager.send(MessageType.CG_USE_CAISHEN,bytebuff);
      }
      
      public static function CG_GETKEJU_NPC() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_GETKEJU_NPC,bytebuff);
      }
      
      public static function CG_KEJUROLL(type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_KEJUROLL,bytebuff);
      }
      
      public static function CG_ENTER_KEJU() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ENTER_KEJU,bytebuff);
      }
      
      public static function CG_CATCHEND(fontId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(fontId);
         SocketManager.send(MessageType.CG_CATCHEND,bytebuff);
      }
      
      public static function CG_QUITCATCH(fontId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(fontId);
         SocketManager.send(MessageType.CG_QUITCATCH,bytebuff);
      }
      
      public static function CG_JOINKEJU(npcID:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(npcID);
         SocketManager.send(MessageType.CG_JOINKEJU,bytebuff);
      }
      
      public static function CG_ASKQUESTION() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ASKQUESTION,bytebuff);
      }
      
      public static function CG_READTIMEOUT(type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(type);
         SocketManager.send(MessageType.CG_READTIMEOUT,bytebuff);
      }
      
      public static function CG_ANSWERTIMEOUT(questID:int, answerId:int, isLucky:int, isCaiShen:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(questID);
         bytebuff.writeInt(answerId);
         bytebuff.writeByte(isLucky);
         bytebuff.writeByte(isCaiShen);
         SocketManager.send(MessageType.CG_ANSWERTIMEOUT,bytebuff);
      }
      
      public static function CG_CATCHICE(iceId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(iceId);
         SocketManager.send(MessageType.CG_CATCHICE,bytebuff);
      }
   }
}

