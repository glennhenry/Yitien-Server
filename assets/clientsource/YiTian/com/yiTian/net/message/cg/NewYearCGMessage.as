package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class NewYearCGMessage
   {
      
      private static var bytes:ByteArray = new ByteArray();
      
      public function NewYearCGMessage()
      {
         super();
      }
      
      public static function CG_NIANGAOMAIL_BUY_ITEM(id:int, num:int) : void
      {
         bytes.length = 0;
         bytes.writeInt(id);
         bytes.writeInt(num);
         SocketManager.send(MessageType.CG_NIANGAOMAIL_BUY_ITEM,bytes);
      }
      
      public static function CG_NIANSHOUDATA() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_OPEN_NIANSHOU,bytes);
      }
      
      public static function CG_USENIANSHOUTOKEN(tokenId:int) : void
      {
         bytes.length = 0;
         bytes.writeInt(tokenId);
         SocketManager.send(MessageType.CG_GET_NIANSHOU,bytes);
      }
      
      public static function CG_SMS_GET_INDEX() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_SMS_GET_INDEX,bytes);
      }
   }
}

