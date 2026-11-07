package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class VipBGiftCGMessage
   {
      
      private static var bt:ByteArray = new ByteArray();
      
      public function VipBGiftCGMessage()
      {
         super();
      }
      
      public static function CG_VIPBG_OPENWIN() : void
      {
         bt.length = 0;
         SocketManager.send(MessageType.CG_VIPBG_OPENWIN,bt);
      }
      
      public static function CG_VIPBG_GETGIFT(index:int) : void
      {
         bt.length = 0;
         bt.writeByte(index);
         SocketManager.send(MessageType.CG_VIPBG_GETGIFT,bt);
      }
      
      public static function CG_VIPBG_BUYGIFT(index:int) : void
      {
         bt.length = 0;
         bt.writeByte(index);
         SocketManager.send(MessageType.CG_VIPBG_BUYGIFT,bt);
      }
   }
}

