package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class BattleCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function BattleCGMessage()
      {
         super();
      }
      
      public static function CG_BATTLE(id:Number, type:int, sysId:int) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,id);
         bytebuff.writeByte(type);
         bytebuff.writeInt(sysId);
         SocketManager.send(MessageType.CG_BATTLE,bytebuff);
      }
      
      public static function CG_BATTLE_FINISH() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_BATTLE_FINISH,bytebuff);
      }
      
      public static function CG_SIWANG_FUHUO(type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_SIWANG_FUHUO,bytebuff);
      }
   }
}

