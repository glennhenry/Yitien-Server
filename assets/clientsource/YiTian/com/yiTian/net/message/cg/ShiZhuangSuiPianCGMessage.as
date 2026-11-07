package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class ShiZhuangSuiPianCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function ShiZhuangSuiPianCGMessage()
      {
         super();
      }
      
      public static function OpenMenu() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ShiZhuangSuiPian_OPEN,bytebuff);
      }
      
      public static function Buy(id:int, count:int) : void
      {
         bytebuff.length = 0;
         trace(">>买的",id,count);
         bytebuff.writeInt(id);
         bytebuff.writeInt(count);
         SocketManager.send(MessageType.CG_ShiZhuangSuiPian_BUY,bytebuff);
      }
   }
}

