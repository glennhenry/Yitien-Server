package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class QuestCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function QuestCGMessage()
      {
         super();
      }
      
      public static function CG_QUEST_ACCEPT(questId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(questId);
         SocketManager.send(MessageType.CG_QUEST_ACCEPT,bytebuff);
      }
      
      public static function CG_QUEST_FINISH(questId:int, selIndex:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(questId);
         bytebuff.writeInt(selIndex);
         SocketManager.send(MessageType.CG_QUEST_FINISH,bytebuff);
      }
      
      public static function CG_QUEST_CONTINUE(questId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(questId);
         SocketManager.send(MessageType.CG_QUEST_CONTINUE,bytebuff);
      }
      
      public static function CG_QUEST_ABANDON(questId:int, reason:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(questId);
         bytebuff.writeByte(reason);
         SocketManager.send(MessageType.CG_QUEST_ABANDON,bytebuff);
      }
      
      public static function CG_QUEST_DAILY_ACCEPT(questId:int, itemId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(questId);
         bytebuff.writeInt(itemId);
         SocketManager.send(MessageType.CG_QUEST_DAILY_ACCEPT,bytebuff);
      }
      
      public static function CG_QUEST_DAILY_FASTFIN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_QUEST_DAILY_FASTFIN,bytebuff);
      }
      
      public static function CG_QUEST_DAILY_REFRESH() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_QUEST_DAILY_REFRESH,bytebuff);
      }
      
      public static function CG_QUEST_HERO_FINISH(questId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(questId);
         SocketManager.send(MessageType.CG_QUEST_HERO_FINISH,bytebuff);
      }
      
      public static function CG_GET_NEWER_GIFT() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_GET_NEWER_GIFT,bytebuff);
      }
   }
}

