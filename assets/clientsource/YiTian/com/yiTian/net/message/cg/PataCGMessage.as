package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class PataCGMessage
   {
      
      public static var byteBuff:ByteArray = new ByteArray();
      
      public function PataCGMessage()
      {
         super();
      }
      
      public static function CG_OVERLORD() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_OVERLORD,byteBuff);
      }
      
      public static function CG_TTF_ENTRANCE(type:int = 1) : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_TTF_ENTRANCE,byteBuff);
      }
      
      public static function CG_LEAVE_TTF() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_LEAVE_TTF,byteBuff);
      }
      
      public static function CG_OVERLORD_LAYER_INFO() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_OVERLORD_LAYER_INFO,byteBuff);
      }
      
      public static function CG_ENTER_TTF() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_ENTER_TTF,byteBuff);
      }
      
      public static function CG_SKIP_BATTLE() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_SKIP_BATTLE,byteBuff);
      }
      
      public static function CG_CHALLENGE_OVERLORD(opera:int, layers:int, type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(opera);
         byteBuff.writeInt(layers);
         byteBuff.writeInt(type);
         SocketManager.send(MessageType.CG_CHALLENGE_OVERLORD,byteBuff);
      }
      
      public static function CG_ENTER_TTF_TIMES(type:int = 0) : void
      {
         byteBuff.length = 0;
         byteBuff.writeShort(type);
         SocketManager.send(MessageType.CG_ENTER_TTF_TIMES,byteBuff);
      }
      
      public static function CG_CHALLENGE_OVERLORD_STATE() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_CHALLENGE_OVERLORD_STATE,byteBuff);
      }
      
      public static function CG_OVERLORD_INFO(id:Number) : void
      {
         byteBuff.length = 0;
         LongUtil.writeLong(byteBuff,id);
         SocketManager.send(MessageType.CG_OVERLORD_INFO,byteBuff);
      }
   }
}

