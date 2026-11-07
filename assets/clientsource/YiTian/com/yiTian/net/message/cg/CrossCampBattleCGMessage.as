package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class CrossCampBattleCGMessage
   {
      
      public static var byteBuff:ByteArray = new ByteArray();
      
      public function CrossCampBattleCGMessage()
      {
         super();
      }
      
      public static function CG_CLICK_CAMP_ICON() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_CLICK_CAMP_ICON,byteBuff);
      }
      
      public static function CG_MATCH(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_MATCH,byteBuff);
      }
      
      public static function CG_NOTICE_SERVER_LOAD(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_NOTICE_SERVER_LOAD,byteBuff);
      }
      
      public static function CG_EXIT_CAMP_SCENE() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_EXIT_CAMP_SCENE,byteBuff);
      }
      
      public static function CG_CAMP_COLLECT_CRYSTAL(type:int, id:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         byteBuff.writeInt(id);
         SocketManager.send(MessageType.CG_CAMP_COLLECT_CRYSTAL,byteBuff);
      }
      
      public static function CG_CAMP_COLLECT_BUFF(type:int, id:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         byteBuff.writeInt(id);
         SocketManager.send(MessageType.CG_CAMP_COLLECT_BUFF,byteBuff);
      }
      
      public static function CG_CAMP_WAR_CAR(id:int, type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(id);
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_CAMP_WAR_CAR,byteBuff);
      }
      
      public static function CG_CAMP_COMMIT_ITEM(type:int, id:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         byteBuff.writeInt(id);
         SocketManager.send(MessageType.CG_CAMP_COMMIT_ITEM,byteBuff);
      }
      
      public static function CG_CAMP_ATTACK_PLAYER(id:Number, type:int, s:int) : void
      {
         byteBuff.length = 0;
         LongUtil.writeLong(byteBuff,id);
         byteBuff.writeByte(type);
         byteBuff.writeInt(s);
         SocketManager.send(MessageType.CG_CAMP_ATTACK_PLAYER,byteBuff);
      }
      
      public static function CG_CAMP_ATTACK_BANNERS(id:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(id);
         SocketManager.send(MessageType.CG_CAMP_ATTACK_BANNERS,byteBuff);
      }
      
      public static function CG_CAMP_REVIVE(type:int, version:Number) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         LongUtil.writeLong(byteBuff,version);
         SocketManager.send(MessageType.CG_CAMP_REVIVE,byteBuff);
      }
      
      public static function CG_BATTLE_EFFECT() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_BATTLE_EFFECT,byteBuff);
      }
      
      public static function CG_BATTLE_VERSION(type:Number) : void
      {
         byteBuff.length = 0;
         LongUtil.writeLong(byteBuff,type);
         SocketManager.send(MessageType.CG_BATTLE_VERSION,byteBuff);
      }
   }
}

