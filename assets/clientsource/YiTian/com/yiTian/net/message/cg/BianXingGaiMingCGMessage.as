package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class BianXingGaiMingCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function BianXingGaiMingCGMessage()
      {
         super();
      }
      
      public static function CG_GAI_MING(newName:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeUTF(newName);
         SocketManager.send(MessageType.CG_GAI_MING,bytebuff);
      }
      
      public static function CG_CHANGE_BANGNAME(newName:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeUTF(newName);
         SocketManager.send(MessageType.CG_CHANGE_BANGNAME,bytebuff);
      }
   }
}

