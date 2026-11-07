package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class ChongZhiPaiHangCGMessage
   {
      
      private static var _bytebuff:ByteArray = new ByteArray();
      
      public function ChongZhiPaiHangCGMessage()
      {
         super();
      }
      
      public static function CG_OPEN_MENU() : void
      {
         _bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ChongZhiPaiHang_OPEN_MENU,_bytebuff);
      }
   }
}

