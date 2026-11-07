package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class KaiFuDiscountCGMessage
   {
      
      private static var byteBuff:ByteArray = new ByteArray();
      
      public function KaiFuDiscountCGMessage()
      {
         super();
      }
      
      public static function CG_BUY_KAIFU_DISCOUNTITEM(index:int, num:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(1);
         byteBuff.writeByte(index);
         byteBuff.writeByte(num);
         SocketManager.send(MessageType.CG_KAIFU_BUYGEM,byteBuff);
      }
      
      public static function CG_KAIFU_BUYGEM(index:int, count:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(2);
         byteBuff.writeByte(index);
         byteBuff.writeByte(count);
         SocketManager.send(MessageType.CG_KAIFU_BUYGEM,byteBuff);
      }
      
      public static function CG_KAIFU_BUYGIFT(index:int, count:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(3);
         byteBuff.writeByte(index);
         byteBuff.writeByte(count);
         SocketManager.send(MessageType.CG_KAIFU_BUYGEM,byteBuff);
      }
      
      public static function CG_BUY_DISCOUNT(index:int, count:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(4);
         byteBuff.writeByte(index);
         byteBuff.writeByte(count);
         SocketManager.send(MessageType.CG_KAIFU_BUYGEM,byteBuff);
      }
      
      public static function CG_KAIFU_BUYCARD(index:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(index);
         SocketManager.send(MessageType.CG_KAIFU_BUYCARD,byteBuff);
      }
   }
}

