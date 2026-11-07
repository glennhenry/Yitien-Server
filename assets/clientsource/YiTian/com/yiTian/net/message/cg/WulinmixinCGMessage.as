package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class WulinmixinCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function WulinmixinCGMessage()
      {
         super();
      }
      
      public static function CG_OPEN_MENU() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_Wulinmixin_OPEN_PANEL,bytebuff);
      }
      
      public static function CG_OPEN_CARD(_id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(_id);
         SocketManager.send(MessageType.CG_Wulinmixin_OPEN_CARD,bytebuff);
         trace("****",MessageType.CG_Wulinmixin_OPEN_CARD,_id);
      }
   }
}

