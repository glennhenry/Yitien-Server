package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.CGMessage;
   import com.yiTian.net.message.MessageType;
   
   public class HuangZuanCWCGMessage extends CGMessage
   {
      
      public function HuangZuanCWCGMessage()
      {
         super();
      }
      
      public static function CG_HZCW_SHOWPANEL() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_HZCW_SHOWPANEL,byteBuff);
      }
      
      public static function CG_HZCW_CHOUJIANG() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_HZCW_CHOUJIANG,byteBuff);
      }
      
      public static function CG_HZCW_DUIHUAN() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_HZCW_DUIHUAN,byteBuff);
      }
   }
}

