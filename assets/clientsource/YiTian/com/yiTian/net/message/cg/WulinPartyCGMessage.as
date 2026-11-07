package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class WulinPartyCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function WulinPartyCGMessage()
      {
         super();
      }
      
      public static function CG_ENTER_WULIN_DAHUI() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ENTER_WULIN_DAHUI,bytebuff);
      }
      
      public static function CG_QUIT_MEETING() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_QUIT_MEETING,bytebuff);
      }
      
      public static function CG_TIMEUP() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_TIMEUP,bytebuff);
      }
      
      public static function CG_DEADCOUNT(_type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(_type);
         SocketManager.send(MessageType.CG_DEADCOUNT,bytebuff);
      }
      
      public static function CG_PAIHANG_WULIN(type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_PAIHANG_WULIN,bytebuff);
      }
      
      public static function CG_GET_PAIHANG_DATA() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_GET_PAIHANG_DATA,bytebuff);
      }
      
      public static function CG_BATTLE_WULIN(targetType:int, targetId:Number, sysId:int) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,targetId);
         SocketManager.send(MessageType.CG_BATTLE_WULIN,bytebuff);
      }
      
      public static function CG_WULINF_BUFF(id:int, type:int, sysId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(id);
         bytebuff.writeInt(sysId);
         SocketManager.send(MessageType.CG_WULINF_BUFF,bytebuff);
      }
      
      public static function CG_WULIN_ENTER_RESULT_HANDLE() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_WULIN_ENTER_RESULT_HANDLE,bytebuff);
      }
   }
}

