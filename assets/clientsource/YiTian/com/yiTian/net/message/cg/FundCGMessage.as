package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class FundCGMessage
   {
      
      private static var bytes:ByteArray = new ByteArray();
      
      public function FundCGMessage()
      {
         super();
      }
      
      public static function CG_FUND() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_FUND,bytes);
      }
      
      public static function CG_FUND_BUY(_jjType:int) : void
      {
         bytes.length = 0;
         bytes.writeByte(_jjType);
         SocketManager.send(MessageType.CG_FUND_BUY,bytes);
      }
      
      public static function CG_FUND_MALL() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_FUND_MALL,bytes);
      }
      
      public static function CG_FUND_RECHARGE() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_FUND_RECHARGE,bytes);
      }
      
      public static function CG_MEINVKEFU_SEND() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_MEINVKEFU_SEND,bytes);
      }
      
      public static function CG_FUND_PAY(id:int, num:int) : void
      {
         bytes.length = 0;
         bytes.writeInt(id);
         bytes.writeByte(num);
         SocketManager.send(MessageType.CG_FUND_PAY,bytes);
      }
      
      public static function CG_GET_REWARD(type:int, index:int) : void
      {
         bytes.length = 0;
         bytes.writeByte(type);
         bytes.writeByte(index);
         SocketManager.send(MessageType.CG_GET_REWARD,bytes);
      }
   }
}

