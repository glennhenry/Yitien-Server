package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class HuangbangCGMessage
   {
      
      private static var bytes:ByteArray = new ByteArray();
      
      public function HuangbangCGMessage()
      {
         super();
      }
      
      public static function CG_ENTER_HUANGBANG() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_ENTER_HUANGBANG,bytes);
      }
      
      public static function CG_SHAKER() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_SHAKER,bytes);
      }
      
      public static function CG_FAST_FINISH_HUANGBANG(questId:int) : void
      {
         bytes.length = 0;
         bytes.writeInt(questId);
         SocketManager.send(MessageType.CG_FAST_FINISH_HUANGBANG,bytes);
      }
      
      public static function CG_FAST_FINISH_HUANGBANG_TEN() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_FAST_FINISH_HUANGBANG_TEN,bytes);
      }
      
      public static function CG_GIVE_UP_HUANGBANG(questId:int) : void
      {
         bytes.length = 0;
         bytes.writeInt(questId);
         SocketManager.send(MessageType.CG_GIVE_UP_HUANGBANG,bytes);
      }
      
      public static function CG_JUMP_HUANGBANG() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_JUMP_HUANGBANG,bytes);
      }
      
      public static function CG_GET_LASTWEEK_QUEST() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_GET_LASTWEEK_QUEST,bytes);
      }
      
      public static function CG_GET_LASTWEEK_QUEST_CONFIRM() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_GET_LASTWEEK_QUEST_CONFIRM,bytes);
      }
      
      public static function CG_EIXT_HUANGBANG() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_EIXT_HUANGBANG,bytes);
      }
      
      public static function CG_JUMP_LAST_POINT() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_JUMP_LAST_POINT,bytes);
      }
   }
}

