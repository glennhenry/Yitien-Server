package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class ShenBingCGMessage
   {
      
      private static var bytes:ByteArray = new ByteArray();
      
      public function ShenBingCGMessage()
      {
         super();
      }
      
      public static function CG_SHENBING() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_SHENBING,bytes);
      }
      
      public static function CG_CUILIAN(costType:int, num:int) : void
      {
         bytes.length = 0;
         bytes.writeByte(costType);
         bytes.writeByte(num);
         SocketManager.send(MessageType.CG_CUILIAN,bytes);
      }
      
      public static function CG_SWAP_SKILL(type:int, srcIndex:int, disIndex:int) : void
      {
         bytes.length = 0;
         bytes.writeByte(type);
         bytes.writeByte(srcIndex);
         bytes.writeByte(disIndex);
         SocketManager.send(MessageType.CG_SWAP_SKILL,bytes);
      }
      
      public static function CG_SHENBING_UPDATE_SKILL(index:int, type:int) : void
      {
         bytes.length = 0;
         bytes.writeByte(index);
         bytes.writeByte(type);
         SocketManager.send(MessageType.CG_SHENBING_UPDATE_SKILL,bytes);
      }
      
      public static function CG_SHENBING_BUY_SKILL(id:int, count:int) : void
      {
         bytes.length = 0;
         bytes.writeInt(id);
         bytes.writeByte(count);
         SocketManager.send(MessageType.CG_SHENBING_BUY_SKILL,bytes);
      }
   }
}

