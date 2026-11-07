package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class ZhaoCaiMaoCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function ZhaoCaiMaoCGMessage()
      {
         super();
      }
      
      public static function CG_ZHAOCAIMAO_OPENWIN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ZHAOCAIMAO_OPENWIN,bytebuff);
      }
      
      public static function CG_ZHAOCAIMAO_WEIYANG(index:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,index);
         SocketManager.send(MessageType.CG_ZHAOCAIMAO_WEIYANG,bytebuff);
      }
      
      public static function CG_ZHAOCAIMAO_LY() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ZHAOCAIMAO_LY,bytebuff);
      }
      
      public static function CG_ZHAOCAIMAO_SEARCH(index:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeUTF(index);
         SocketManager.send(MessageType.CG_ZHAOCAIMAO_SEARCH,bytebuff);
      }
      
      public static function CG_ZHAOCAIMAO_ZHAOMU() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ZHAOCAIMAO_ZHAOMU,bytebuff);
      }
      
      public static function CG_ZHAOCAIMAO_PAGE(page:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(page);
         SocketManager.send(MessageType.CG_ZHAOCAIMAO_PAGE,bytebuff);
      }
   }
}

