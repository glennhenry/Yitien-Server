package com.yiTian.net.handler
{
   import com.utils.LongUtil;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class GuangMingDingCGMessage
   {
      
      private static var bytes:ByteArray = new ByteArray();
      
      public function GuangMingDingCGMessage()
      {
         super();
      }
      
      public static function CG_GMD_ROOM_INFO(pageIndex:int) : void
      {
         bytes.length = 0;
         bytes.writeInt(pageIndex);
         SocketManager.send(MessageType.CG_GMD_ROOM_INFO,bytes);
      }
      
      public static function CG_GMD_HALL_INFO() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_GMD_HALL_INFO,bytes);
      }
      
      public static function CG_GMD_CREATE_ROOM(usePassWord:int, passWord:String) : void
      {
         bytes.length = 0;
         bytes.writeByte(usePassWord);
         bytes.writeUTF(passWord);
         SocketManager.send(MessageType.CG_GMD_CREATE_ROOM,bytes);
      }
      
      public static function CG_GMD_SEARCH_ROOM(roomID:int) : void
      {
         bytes.length = 0;
         bytes.writeInt(roomID);
         SocketManager.send(MessageType.CG_GMD_SEARCH_ROOM,bytes);
      }
      
      public static function CG_GMD_FAST_JOIN() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_GMD_FAST_JOIN,bytes);
      }
      
      public static function CG_GMD_INVITE_INFO(type:int) : void
      {
         bytes.length = 0;
         bytes.writeByte(type);
         SocketManager.send(MessageType.CG_GMD_INVITE_INFO,bytes);
      }
      
      public static function CG_GMD_INVITE_PLAYER(playerId:Number) : void
      {
         bytes.length = 0;
         LongUtil.writeLong(bytes,playerId);
         SocketManager.send(MessageType.CG_GMD_INVITE_PLAYER,bytes);
      }
      
      public static function CG_GMD_INVITE_QUICKLY() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_GMD_INVITE_QUICKLY,bytes);
      }
      
      public static function CG_GMD_INVITE_RESPON(targetRoom:int, pw:String) : void
      {
         bytes.length = 0;
         bytes.writeInt(targetRoom);
         bytes.writeUTF(pw);
         SocketManager.send(MessageType.CG_GMD_INVITE_RESPON,bytes);
      }
      
      public static function CG_GMD_LEAVE_TEAM() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_GMD_LEAVE_TEAM,bytes);
      }
      
      public static function CG_GMD_KICK_TEAMMEMBER(memberID:Number) : void
      {
         bytes.length = 0;
         LongUtil.writeLong(bytes,memberID);
         SocketManager.send(MessageType.CG_GMD_KICK_TEAMMEMBER,bytes);
      }
      
      public static function CG_GMD_SWAP_TEAMLEADER(memberID:Number) : void
      {
         bytes.length = 0;
         LongUtil.writeLong(bytes,memberID);
         SocketManager.send(MessageType.CG_GMD_SWAP_TEAMLEADER,bytes);
      }
      
      public static function CG_GMD_APPLY_TEAMLEADER(roleID:Number) : void
      {
         bytes.length = 0;
         bytes.writeInt(roleID);
         SocketManager.send(MessageType.CG_GMD_APPLY_TEAMLEADER,bytes);
      }
      
      public static function CG_GMD_MEMBER_READY(type:int) : void
      {
         bytes.length = 0;
         bytes.writeByte(type);
         SocketManager.send(MessageType.CG_GMD_MEMBER_READY,bytes);
      }
      
      public static function CG_GMD_BEGIN_CHALLENGE(id:Number) : void
      {
         bytes.length = 0;
         LongUtil.writeLong(bytes,id);
         SocketManager.send(MessageType.CG_GMD_BEGIN_CHALLENGE,bytes);
      }
      
      public static function CG_GMD_CHANGE_PASSWORD(pw:String) : void
      {
         bytes.length = 0;
         bytes.writeUTF(pw);
         SocketManager.send(MessageType.CG_GMD_CHANGE_PASSWORD,bytes);
      }
      
      public static function CG_GMD_ENTER_MAP() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_GMD_ENTER_MAP,bytes);
      }
      
      public static function CG_GMD_LEAVE_FUBEN(type:int, pId:Number = 0) : void
      {
         bytes.length = 0;
         bytes.writeByte(type);
         LongUtil.writeLong(bytes,pId);
         SocketManager.send(MessageType.CG_GMD_LEAVE_FUBEN,bytes);
      }
      
      public static function CG_GMD_USE_MIJI(id:int) : void
      {
         bytes.length = 0;
         bytes.writeInt(id);
         SocketManager.send(MessageType.CG_GMD_USE_MIJI,bytes);
      }
      
      public static function CG_GMD_REVIVE(type:int) : void
      {
         bytes.length = 0;
         bytes.writeByte(type);
         SocketManager.send(MessageType.CG_GMD_REVIVE,bytes);
      }
      
      public static function CG_GMD_JUMP_BATTLE() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_GMD_JUMP_BATTLE,bytes);
      }
   }
}

