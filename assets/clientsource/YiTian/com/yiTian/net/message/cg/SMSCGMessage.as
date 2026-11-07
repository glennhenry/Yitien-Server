package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class SMSCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function SMSCGMessage()
      {
         super();
      }
      
      public static function CG_OPEN_SMS_SHOP() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_OPEN_SMS_SHOP,bytebuff);
      }
      
      public static function CG_SMS_SHOP_BUY(grid_id:int, good_num:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(grid_id);
         bytebuff.writeInt(good_num);
         SocketManager.send(MessageType.CG_SMS_SHOP_BUY,bytebuff);
      }
      
      public static function CG_SMS_SHOP_REFRESH() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_SMS_SHOP_REFRESH,bytebuff);
      }
      
      public static function CG_SMS_MUL_REFRESH(refresh_times:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeShort(refresh_times);
         SocketManager.send(MessageType.CG_SMS_MUL_REFRESH,bytebuff);
      }
      
      public static function CG_SMS_CHECK_MUL_REFRESH() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_SMS_CHECK_MUL_REFRESH,bytebuff);
      }
      
      public static function CG_SMS_MUL_BUY(wpId:int, type:int, num:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(wpId);
         bytebuff.writeByte(type);
         bytebuff.writeShort(num);
         SocketManager.send(MessageType.CG_SMS_MUL_BUY,bytebuff);
      }
   }
}

