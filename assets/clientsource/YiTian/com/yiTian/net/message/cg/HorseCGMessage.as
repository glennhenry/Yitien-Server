package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class HorseCGMessage
   {
      
      private static var bytes:ByteArray = new ByteArray();
      
      public function HorseCGMessage()
      {
         super();
      }
      
      public static function CG_HORSE_PARTS_INFO() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_HORSE_PARTS_INFO,bytes);
      }
      
      public static function CG_HORSE_QIANGHUA_INFO() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_HORSE_QIANGHUA_INFO,bytes);
      }
      
      public static function CG_HORSE_LIB() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_HORSE_LIB,bytes);
      }
      
      public static function CG_HORSE_DUANZAO(duanzaoType:int, partType:int) : void
      {
         bytes.length = 0;
         bytes.writeByte(duanzaoType);
         bytes.writeByte(partType);
         SocketManager.send(MessageType.CG_HORSE_DUANZAO,bytes);
      }
      
      public static function CG_HORSE_JINJIE() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_HORSE_JINJIE,bytes);
      }
      
      public static function CG_HORSE_QIANGHUA() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_HORSE_QIANGHUA,bytes);
      }
      
      public static function CG_HORSE_LIB_ENABLE(hId:int, type:int) : void
      {
         bytes.length = 0;
         bytes.writeInt(hId);
         bytes.writeByte(type);
         SocketManager.send(MessageType.CG_HORSE_LIB_ENABLE,bytes);
      }
      
      public static function CG_HORSE_JINJIE_INFO() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_HORSE_JINJIE_INFO,bytes);
      }
      
      public static function CG_HORSE_SHOW_AND_HIDE(flag:int) : void
      {
         bytes.length = 0;
         bytes.writeByte(flag);
         SocketManager.send(MessageType.CG_HORSE_SHOW_AND_HIDE,bytes);
      }
      
      public static function CG_XINGZUOPNL_OPEN() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_XINGZUOPNL_OPEN,bytes);
      }
      
      public static function CG_ENABLE_STARGIGN() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_ENABLE_STARSIGN,bytes);
      }
      
      public static function CG_BREAK_STARSIGN(numXingyun:int) : void
      {
         bytes.length = 0;
         bytes.writeByte(numXingyun);
         SocketManager.send(MessageType.GC_STARSIGN_BREAK,bytes);
      }
   }
}

