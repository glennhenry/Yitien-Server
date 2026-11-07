package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class PaiHangCGMessage
   {
      
      public static var byteBuff:ByteArray = new ByteArray();
      
      public function PaiHangCGMessage()
      {
         super();
      }
      
      public static function CG_PAIHANG_DENGJI(type:int, curPage:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(type);
         byteBuff.writeInt(curPage);
         SocketManager.send(MessageType.CG_PAIHANG_DENGJI,byteBuff);
      }
      
      public static function CG_PAIHANG_ZHANLI(type:int, curPage:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(type);
         byteBuff.writeInt(curPage);
         SocketManager.send(MessageType.CG_PAIHANG_ZHANLI,byteBuff);
      }
      
      public static function CG_PAIHANG_CAIFU(curPage:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(curPage);
         SocketManager.send(MessageType.CG_PAIHANG_CAIFU,byteBuff);
      }
      
      public static function CG_PAIHANG_MY(levelType:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(levelType);
         SocketManager.send(MessageType.CG_PAIHANG_MY,byteBuff);
      }
      
      public static function CG_PAIHANG_KUNLUN(type:int, curPage:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(type);
         byteBuff.writeInt(curPage);
         SocketManager.send(MessageType.CG_PAIHANG_KUNLUN,byteBuff);
      }
      
      public static function CG_PAIHANG_WULINDAHUI(type:int, curPage:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(type);
         byteBuff.writeInt(curPage);
         SocketManager.send(MessageType.CG_PAIHANG_WULINDAHUI,byteBuff);
      }
      
      public static function CG_PAIHANG_PET(curPage:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(curPage);
         SocketManager.send(MessageType.CG_PAIHANG_PET,byteBuff);
      }
      
      public static function CG_PAIHANG_BANGHUI(curPage:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(curPage);
         SocketManager.send(MessageType.CG_PAIHANG_BANGHUI,byteBuff);
      }
      
      public static function CG_PAIHANG_MEILI(type:int, curPage:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(type);
         byteBuff.writeInt(curPage);
         SocketManager.send(MessageType.CG_PAIHANG_MEILI,byteBuff);
      }
      
      public static function CG_PAIHANG_FLOWERS(type:int, curPage:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(type);
         byteBuff.writeInt(curPage);
         SocketManager.send(MessageType.CG_PAIHANG_FLOWERS,byteBuff);
      }
      
      public static function CG_KUAFU_FLOWERS(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_KUAFU_FLOWERS,byteBuff);
      }
      
      public static function CG_REQUEST_SHENBINGINFO(roleID:Number, type:int) : void
      {
         byteBuff.length = 0;
         LongUtil.writeLong(byteBuff,roleID);
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_REQUEST_SHENBINGINFO,byteBuff);
      }
      
      public static function CG_ASK_SHUXINGDANINFO(roleID:Number) : void
      {
         byteBuff.length = 0;
         LongUtil.writeLong(byteBuff,roleID);
         SocketManager.send(MessageType.CG_ASK_SHUXINGDANINFO,byteBuff);
      }
   }
}

