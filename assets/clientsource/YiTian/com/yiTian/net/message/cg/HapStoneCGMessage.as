package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class HapStoneCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function HapStoneCGMessage()
      {
         super();
      }
      
      public static function CG_OPEN_HAP_PAN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_OPEN_HAP_PAN,bytebuff);
      }
      
      public static function CG_DUIHUAN_HAP(index:int, nums:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(index);
         bytebuff.writeInt(nums);
         SocketManager.send(MessageType.CG_DUIHUAN_HAP,bytebuff);
      }
      
      public static function CG_GETAWARD_HAP(index:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(index);
         SocketManager.send(MessageType.CG_GETAWARD_HAP,bytebuff);
      }
   }
}

