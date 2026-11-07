package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class WanAnSiCGMessage
   {
      
      public static var byteBuff:ByteArray = new ByteArray();
      
      public function WanAnSiCGMessage()
      {
         super();
      }
      
      public static function CG_WANANSI_TIMES() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_WANANSI_TIMES,byteBuff);
      }
      
      public static function CG_WANANSI_ENTER(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_WANANSI_ENTER,byteBuff);
      }
      
      public static function CG_WANANSI_QUIT() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_WANANSI_QUIT,byteBuff);
      }
      
      public static function CG_WANANSI_SKIP_BATTLE() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_WANANSI_SKIP_BATTLE,byteBuff);
      }
      
      public static function CG_WANANSI_FUHUO(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_WANANSI_FUHUO,byteBuff);
      }
   }
}

