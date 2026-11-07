package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class InviteFriendNewCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function InviteFriendNewCGMessage()
      {
         super();
      }
      
      public static function CG_OPEN_NEWFRIEND_PAN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_OPEN_NEWFRIEND_PAN,bytebuff);
      }
      
      public static function CG_GETAWARD_NEWFRIEND(_index:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(_index);
         SocketManager.send(MessageType.CG_GETAWARD_NEWFRIEND,bytebuff);
      }
   }
}

