package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class CrossClanBattleCGMessage
   {
      
      public static var byteBuff:ByteArray = new ByteArray();
      
      public function CrossClanBattleCGMessage()
      {
         super();
      }
      
      public static function CG_ALLCITY_DATA() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_ALLCITY_DATA,byteBuff);
      }
      
      public static function CG_AUCTION(id:int, silver:String) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(id);
         byteBuff.writeUTF(silver);
         SocketManager.send(MessageType.CG_AUCTION,byteBuff);
      }
      
      public static function CG_SEGIE_TIME() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_SEGIE_TIME,byteBuff);
      }
      
      public static function CG_REFRESH_CITY_COLOR(color:String) : void
      {
         byteBuff.length = 0;
         byteBuff.writeUTF(color);
         SocketManager.send(MessageType.CG_REFRESH_CITY_COLOR,byteBuff);
      }
      
      public static function CG_BATTLE_CONFIRM(id:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(id);
         SocketManager.send(MessageType.CG_BATTLE_CONFIRM,byteBuff);
      }
      
      public static function CG_ENTER_BATTLE_SCENE(crossType:String, id:String) : void
      {
         byteBuff.length = 0;
         byteBuff.writeUTF(crossType);
         byteBuff.writeUTF(id);
         SocketManager.send(MessageType.CG_ENTER_BATTLE_SCENE,byteBuff);
      }
      
      public static function CG_RESOURCE_TOWER(type:int, id:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         byteBuff.writeInt(id);
         SocketManager.send(MessageType.CG_RESOURCE_TOWER,byteBuff);
      }
      
      public static function CG_RESOURCE_MINE(type:int, id:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         byteBuff.writeInt(id);
         SocketManager.send(MessageType.CG_RESOURCE_MINE,byteBuff);
      }
      
      public static function CG_COMMIT_RESOURCE_MINE() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_COMMIT_RESOURCE_MINE,byteBuff);
      }
      
      public static function CG_CONNECT_SOCKET(crossType:String, crossParams:String, testNum:Number, id:Number) : void
      {
         byteBuff.length = 0;
         byteBuff.writeUTF(crossType);
         byteBuff.writeUTF(crossParams);
         LongUtil.writeLong(byteBuff,testNum);
         LongUtil.writeLong(byteBuff,id);
         SocketManager.send(MessageType.CG_CONNECT_SOCKET,byteBuff);
      }
      
      public static function CG_BUY_BUFF(buffId:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(buffId);
         SocketManager.send(MessageType.CG_BUY_BUFF,byteBuff);
      }
      
      public static function CG_CRYSTAL(id:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(id);
         SocketManager.send(MessageType.CG_CRYSTAL,byteBuff);
      }
      
      public static function CG_CLICK_WAR_CAR(id:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(id);
         SocketManager.send(MessageType.CG_CLICK_WAR_CAR,byteBuff);
      }
      
      public static function CG_WAR_CAR_BATTLE_END(id:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(id);
         SocketManager.send(MessageType.CG_WAR_CAR_BATTLE_END,byteBuff);
      }
      
      public static function CG_WAR_CAR_V_CRYSTAL(id:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(id);
         SocketManager.send(MessageType.CG_WAR_CAR_V_CRYSTAL,byteBuff);
      }
      
      public static function CG_SOIDIER(id:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(id);
         SocketManager.send(MessageType.CG_SOIDIER,byteBuff);
      }
      
      public static function CG_CLICK_PLAYER(id:Number) : void
      {
         byteBuff.length = 0;
         LongUtil.writeLong(byteBuff,id);
         SocketManager.send(MessageType.CG_CLICK_PLAYER,byteBuff);
      }
      
      public static function CG_KUAFUCLAN_BATTLE_EXIT() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_KUAFUCLAN_BATTLE_EXIT,byteBuff);
      }
      
      public static function CG_KUAFUCLAN_BATTLE_CHANGE_SOCKET(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_KUAFUCLAN_BATTLE_CHANGE_SOCKET,byteBuff);
      }
      
      public static function CG_BUY_ROLE_BUFF(id:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(id);
         SocketManager.send(MessageType.CG_BUY_ROLE_BUFF,byteBuff);
      }
   }
}

