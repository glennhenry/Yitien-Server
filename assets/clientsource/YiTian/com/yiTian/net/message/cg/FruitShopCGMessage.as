package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class FruitShopCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function FruitShopCGMessage()
      {
         super();
      }
      
      public static function CG_FRUIT_SHOP_DATA() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_FRUIT_SHOP_DATA,bytebuff);
      }
      
      public static function CG_FRUIT_SHOP_BUY(value:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(value);
         SocketManager.send(MessageType.CG_FRUIT_SHOP_BUY,bytebuff);
      }
      
      public static function CG_FRUIT_SHOP_SER_TIME() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_FRUIT_SHOP_SER_TIME,bytebuff);
      }
   }
}

