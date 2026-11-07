package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class SignCGMessage
   {
      
      public static var byteBuff:ByteArray = new ByteArray();
      
      public function SignCGMessage()
      {
         super();
      }
      
      public static function CG_SIGN_INFO() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_SIGN_INFO,byteBuff);
      }
      
      public static function CG_HOLIDAY_REWARD(state:int = 1) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(state);
         SocketManager.send(MessageType.CG_HOLIDAY_REWARD,byteBuff);
      }
      
      public static function CG_WEEK_WAGE(state:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(state);
         SocketManager.send(MessageType.CG_WEEK_WAGE,byteBuff);
      }
      
      public static function CG_SIGN(yearAndMonth:int, day:int, needFee:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(yearAndMonth);
         byteBuff.writeInt(day);
         byteBuff.writeInt(needFee);
         SocketManager.send(MessageType.CG_SIGN,byteBuff);
      }
      
      public static function CG_REWARD(id:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(id);
         SocketManager.send(MessageType.CG_REWARD,byteBuff);
      }
   }
}

