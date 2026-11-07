package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class QiJuCGMessage
   {
      
      private static var byteBuff:ByteArray = new ByteArray();
      
      public function QiJuCGMessage()
      {
         super();
      }
      
      public static function CG_QIJU_BUYTIME() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_QIJU_BUYTIME,byteBuff);
      }
      
      public static function CG_SKIP_QIJU() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_SKIP_QIJU,byteBuff);
      }
      
      public static function CG_EXIT_QIJUGAME(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_EXIT_QIJUGAME,byteBuff);
      }
      
      public static function CG_GET_QIJU_CHEST(objId:int, sysId:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(objId);
         byteBuff.writeInt(sysId);
         SocketManager.send(MessageType.CG_GET_QIJU_CHEST,byteBuff);
      }
      
      public static function CG_QIJU_FIGHT_FINISH() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_QIJU_FIGHT_FINISH,byteBuff);
      }
      
      public static function CG_QIJU_FIGHT(objId:int, sysId:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(objId);
         byteBuff.writeInt(sysId);
         SocketManager.send(MessageType.CG_QIJU_FIGHT,byteBuff);
      }
      
      public static function CG_QIJU_FUHUO(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_QIJU_FUHUO,byteBuff);
      }
      
      public static function CG_QIJU_TEAMMATE() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_QIJU_TEAMMATE,byteBuff);
      }
      
      public static function CG_START_QIJU() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_START_QIJU,byteBuff);
      }
      
      public static function CG_T_QIJU_TEAM(teamId:int, id:Number) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(teamId);
         LongUtil.writeLong(byteBuff,id);
         SocketManager.send(MessageType.CG_T_QIJU_TEAM,byteBuff);
      }
      
      public static function CG_EXIT_QIJU_TEAM(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_EXIT_QIJU_TEAM,byteBuff);
      }
      
      public static function CG_JOIN_QIJU_TEAM(id:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(id);
         SocketManager.send(MessageType.CG_JOIN_QIJU_TEAM,byteBuff);
      }
      
      public static function CG_GREAT_QIJU_TEAM(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(type);
         SocketManager.send(MessageType.CG_GREAT_QIJU_TEAM,byteBuff);
      }
      
      public static function CG_CLICK_QIJU() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_CLICK_QIJU,byteBuff);
      }
      
      public static function CG_OPEN_QIJU() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_OPEN_QIJU,byteBuff);
      }
   }
}

