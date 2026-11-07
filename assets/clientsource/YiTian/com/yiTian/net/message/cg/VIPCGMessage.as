package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class VIPCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function VIPCGMessage()
      {
         super();
      }
      
      public static function CG_VIP_OPEN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_VIP_OPEN,bytebuff);
      }
      
      public static function CG_BUY_VIP(type:int, count:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         bytebuff.writeByte(count);
         SocketManager.send(MessageType.CG_BUY_VIP,bytebuff);
      }
      
      public static function CG_GET_VIP_YIQUAN(_type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(_type);
         SocketManager.send(MessageType.CG_GET_VIP_YIQUAN,bytebuff);
      }
      
      public static function CG_SAVE_VIP_SERVER_INFO(name:String, sex:int, phone:String, qq:String, card:String, address:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeUTF(name);
         bytebuff.writeInt(sex);
         bytebuff.writeUTF(phone);
         bytebuff.writeUTF(qq);
         bytebuff.writeUTF(card);
         bytebuff.writeUTF(address);
         SocketManager.send(MessageType.CG_SAVE_VIP_SERVER_INFO,bytebuff);
      }
   }
}

