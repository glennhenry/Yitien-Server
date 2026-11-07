package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   
   public class WorldBossCGMessage
   {
      
      private static var _lastChallengeTime:int;
      
      private static var bytes:ByteArray = new ByteArray();
      
      public function WorldBossCGMessage()
      {
         super();
      }
      
      public static function CG_WB_ENTERFUBEN() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_WB_ENTERFUBEN,bytes);
      }
      
      public static function CG_WB_USE_CHUANGONG(costType:int) : void
      {
         bytes.length = 0;
         bytes.writeByte(costType);
         SocketManager.send(MessageType.CG_WB_USE_CHUANGONG,bytes);
      }
      
      public static function CG_WB_CHALLENGE() : void
      {
         var now:int = getTimer();
         if(now - _lastChallengeTime < 2000)
         {
            return;
         }
         _lastChallengeTime = now;
         bytes.length = 0;
         SocketManager.send(MessageType.CG_WB_CHALLENGE,bytes);
      }
      
      public static function CG_WB_COLLECT(id:Number, action:int) : void
      {
         bytes.length = 0;
         bytes.writeInt(id);
         bytes.writeByte(action);
         SocketManager.send(MessageType.CG_WB_COLLECT_BEGIN,bytes);
      }
      
      public static function CG_WB_DAMAGED_CHARTS(page:int) : void
      {
         bytes.length = 0;
         bytes.writeByte(page);
         SocketManager.send(MessageType.CG_WB_DAMAGED_CHARTS,bytes);
      }
      
      public static function CG_WB_REVIVE(type:int) : void
      {
         bytes.length = 0;
         bytes.writeByte(type);
         SocketManager.send(MessageType.CG_WB_REVIVE,bytes);
      }
      
      public static function CG_WB_LEAVE_FUBEN() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_WB_LEAVE_FUBEN,bytes);
      }
   }
}

