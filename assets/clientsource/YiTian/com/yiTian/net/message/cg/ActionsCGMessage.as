package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class ActionsCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function ActionsCGMessage()
      {
         super();
      }
      
      public static function CG_OPEN_BACKPLAYER_PAN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_OPEN_BACKPLAYER_PAN,bytebuff);
      }
      
      public static function CG_CHONGZHI_PAN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_CHONGZHI_PAN,bytebuff);
      }
      
      public static function CG_GETAWARD_BACKPLAYER(bigType:int, type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(bigType);
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_GETAWARD_BACKPLAYER,bytebuff);
      }
      
      public static function CG_TEQUAN_PAN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_TEQUAN_PAN,bytebuff);
      }
      
      public static function CG_QQXUANFENG_GETAWARD() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_QQXUANFENG_GETAWARD,bytebuff);
      }
      
      public static function CG_OPEN_CIRI_GF() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_OPEN_CIRI_GF,bytebuff);
      }
      
      public static function CG_GET_CIRI_GF(xiaBiao:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(xiaBiao);
         SocketManager.send(MessageType.CG_GET_CIRI_GF,bytebuff);
      }
      
      public static function CG_HUOYUEDU_APPLY() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_HUOYUEDU_APPLY,bytebuff);
      }
      
      public static function CG_HUOYUEDU_GETAWARD(_type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(_type);
         SocketManager.send(MessageType.CG_HUOYUEDU_GETAWARD,bytebuff);
      }
      
      public static function CG_HUOYUEDU_JOIN(_type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(_type);
         SocketManager.send(MessageType.CG_HUOYUEDU_JOIN,bytebuff);
      }
      
      public static function CG_CLICK_CAIFUTONG() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_CLICK_CAIFUTONG,bytebuff);
      }
   }
}

