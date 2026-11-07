package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class HZXianGouCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function HZXianGouCGMessage()
      {
         super();
      }
      
      public static function CG_HZXG_SHOW_PANEL() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_HZXG_SHOW_PANEl,bytebuff);
      }
      
      public static function CG_HZXG_GET_AWARD(index:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(index);
         SocketManager.send(MessageType.CG_HZXG_GETAWARD,bytebuff);
      }
   }
}

