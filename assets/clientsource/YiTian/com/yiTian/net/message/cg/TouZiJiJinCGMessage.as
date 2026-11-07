package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.CGMessage;
   import com.yiTian.net.message.MessageType;
   
   public class TouZiJiJinCGMessage extends CGMessage
   {
      
      public function TouZiJiJinCGMessage()
      {
         super();
      }
      
      public static function CG_TouZiJiJin_CLICKICON() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_TouZiJiJin_CLICKICON,byteBuff);
      }
      
      public static function CG_TouZiJiJin_RENGOU(num:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(num);
         SocketManager.send(MessageType.CG_TouZiJiJin_RENGOU,byteBuff);
      }
      
      public static function CG_TouZiJiJin_GETAWARD() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_TouZiJiJin_GETAWARD,byteBuff);
      }
   }
}

