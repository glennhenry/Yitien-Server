package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class BangBattleCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function BangBattleCGMessage()
      {
         super();
      }
      
      public static function CG_ENTER_BANG_BATTLE() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ENTER_BANG_BATTLE,bytebuff);
      }
      
      public static function CG_MAIN_GROUND() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_MAIN_GROUND,bytebuff);
      }
      
      public static function CG_FOUR_ROOM(which:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(which);
         SocketManager.send(MessageType.CG_FOUR_ROOM,bytebuff);
      }
      
      public static function CG_QUEST_BANG_BATTLE(targetType:int, targetId:Number, sysId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(targetType);
         LongUtil.writeLong(bytebuff,targetId);
         bytebuff.writeInt(sysId);
         SocketManager.send(MessageType.CG_QUEST_BANG_BATTLE,bytebuff);
      }
      
      public static function CG_FR_RETURN_TO_MAIN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_FR_RETURN_TO_MAIN,bytebuff);
      }
      
      public static function CG_FR_LEAVE_BATTLE() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_FR_LEAVE_BATTLE,bytebuff);
      }
      
      public static function CG_MAIN_LEAVE_BATTLE() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_MAIN_LEAVE_BATTLE,bytebuff);
      }
      
      public static function CG_COLLECT_JK(uid:int, sid:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(uid);
         bytebuff.writeInt(sid);
         SocketManager.send(MessageType.CG_COLLECT_JK,bytebuff);
      }
      
      public static function CG_JKCOLLECT_FINISH(uid:int, sid:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(uid);
         bytebuff.writeInt(sid);
         SocketManager.send(MessageType.CG_JKCOLLECT_FINISH,bytebuff);
      }
      
      public static function CG_JK_COLLECT_INTERRUPT() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_JK_COLLECT_INTERRUPT,bytebuff);
      }
      
      public static function CG_BB_RANKS() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_BB_RANKS,bytebuff);
      }
   }
}

