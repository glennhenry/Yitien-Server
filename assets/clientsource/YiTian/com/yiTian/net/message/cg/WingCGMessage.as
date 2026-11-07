package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class WingCGMessage
   {
      
      private static var byteBuff:ByteArray = new ByteArray();
      
      public function WingCGMessage()
      {
         super();
      }
      
      public static function CG_WING_OPEN() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_WING_OPEN,byteBuff);
      }
      
      public static function CG_WING_BLESS_MENU() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_WING_BLESS_MENU,byteBuff);
      }
      
      public static function CG_WING_BUY(flag:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(flag);
         SocketManager.send(MessageType.CG_WING_BUY,byteBuff);
      }
      
      public static function CG_WING_UP_LEVEL(flag:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(flag);
         SocketManager.send(MessageType.CG_WING_UP_LEVEL,byteBuff);
      }
      
      public static function CG_WING_CHANGE_MODEL(modelId:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(modelId);
         SocketManager.send(MessageType.CG_WING_CHANGE_MODEL,byteBuff);
      }
      
      public static function CG_WING_SHOW_AND_HIDE(flag:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(flag);
         SocketManager.send(MessageType.CG_WING_SHOW_AND_HIDE,byteBuff);
      }
      
      public static function CG_WING_BUFF_TIMEOUT() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_WING_BUFF_TIMEOUT,byteBuff);
      }
      
      public static function CG_WING_CHANGE_HuanHua() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_WING_CHANGE_HuanHua,byteBuff);
      }
   }
}

