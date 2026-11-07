package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class DaTingHuiGuiCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function DaTingHuiGuiCGMessage()
      {
         super();
      }
      
      public static function CG_QQGAME_AWARD_BACK() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_QQGAME_AWARD_BACK,bytebuff);
      }
   }
}

