package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.CGMessage;
   import com.yiTian.net.message.MessageType;
   
   public class CrossDartCGMessage extends CGMessage
   {
      
      public function CrossDartCGMessage()
      {
         super();
      }
      
      public static function CG_CROSSDART_JIEBIAO(rid:Number, zoneID:int) : void
      {
         byteBuff.length = 0;
         LongUtil.writeLong(byteBuff,rid);
         byteBuff.writeInt(zoneID);
         SocketManager.send(MessageType.CG_CROSSDART_JIEBIAO,byteBuff);
      }
      
      public static function CG_CROSSDART_OPENAC(_t:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(_t);
         SocketManager.send(MessageType.CG_CROSSDART_OPENAC,byteBuff);
      }
      
      public static function CG_CROSSDART_GOGOGO() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_CROSSDART_GOGOGO,byteBuff);
      }
      
      public static function CG_CROSSDART_EXIT() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_CROSSDART_EXIT,byteBuff);
      }
   }
}

