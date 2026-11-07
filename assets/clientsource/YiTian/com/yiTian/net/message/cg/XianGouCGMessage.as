package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class XianGouCGMessage
   {
      
      private static var _bytebuff:ByteArray = new ByteArray();
      
      public function XianGouCGMessage()
      {
         super();
      }
      
      public static function CG_OPEN_MENU() : void
      {
         _bytebuff.length = 0;
         SocketManager.send(MessageType.CG_XianGou_OPEN,_bytebuff);
      }
      
      public static function CG_BUY(_id:int) : void
      {
         _bytebuff.length = 0;
         _bytebuff.writeInt(_id);
         SocketManager.send(MessageType.CG_XianGou_BUY,_bytebuff);
      }
      
      public static function CG_GET_XIANGOU_INFO() : void
      {
         _bytebuff.length = 0;
         SocketManager.send(MessageType.CG_GET_XIANGOU_INFO,_bytebuff);
      }
   }
}

