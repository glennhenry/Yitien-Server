package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_CrossType;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class KuaFuPaiDuiCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function KuaFuPaiDuiCGMessage()
      {
         super();
      }
      
      public static function CG_KuaFuPaiDui_ENTER() : void
      {
         Global.crossType = Enum_CrossType.CROSS_KuaFuPaiDui;
         CrossClanBattleCGMessage.CG_ENTER_BATTLE_SCENE(Global.crossType,"");
      }
      
      public static function CG_KuaFuPaiDui_SERVER_CHOICE(serverId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(serverId);
         SocketManager.send(MessageType.CG_KuaFuPaiDui_SERVER_CHOICE,bytebuff);
      }
      
      public static function CG_KuaFuPaiDui_EXIT() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_KuaFuPaiDui_EXIT,bytebuff);
      }
      
      public static function CG_KuaFuPaiDui_CHANGE_SOCKET() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_KuaFuPaiDui_CHANGE_SOCKET,bytebuff);
      }
      
      public static function CG_KuaFuPaiDui_CHANGE_ROOM(roomId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(roomId);
         SocketManager.send(MessageType.CG_KuaFuPaiDui_CHANGE_ROOM,bytebuff);
      }
      
      public static function CG_KuaFuPaiDui_FRESH_ROOM() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_KuaFuPaiDui_FRESH_ROOM,bytebuff);
      }
      
      public static function CG_KuaFuPaiDui_FRESH_PARTNER() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_KuaFuPaiDui_FRESH_PARTNER,bytebuff);
      }
      
      public static function CG_KuaFuPaiDui_INVITE(id:Number, zoneId:int) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,id);
         bytebuff.writeInt(zoneId);
         SocketManager.send(MessageType.CG_KuaFuPaiDui_INVITE,bytebuff);
      }
      
      public static function CG_KuaFuPaiDui_REPLY_INVITE(id:Number, flag:int, zoneId:int) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,id);
         bytebuff.writeByte(flag);
         bytebuff.writeInt(zoneId);
         SocketManager.send(MessageType.CG_KuaFuPaiDui_REPLY_INVITE,bytebuff);
      }
      
      public static function CG_KuaFuPaiDui_BREAK_UP() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_KuaFuPaiDui_BREAK_UP,bytebuff);
      }
      
      public static function CG_KuaFuPaiDui_STEP(round:int, flag:int, arrow:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(round);
         bytebuff.writeByte(flag);
         bytebuff.writeByte(arrow);
         SocketManager.send(MessageType.CG_KuaFuPaiDui_STEP,bytebuff);
      }
   }
}

