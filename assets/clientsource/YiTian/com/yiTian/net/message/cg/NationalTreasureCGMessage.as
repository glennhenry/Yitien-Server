package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class NationalTreasureCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function NationalTreasureCGMessage()
      {
         super();
      }
      
      public static function CG_WABAO_DATA() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_WABAO_DATA,bytebuff);
      }
      
      public static function CG_WABAO(index:int, id:int, area:int, type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(index);
         bytebuff.writeInt(id);
         bytebuff.writeByte(area);
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_WABAO,bytebuff);
      }
      
      public static function CG_CHANGE_PAGE(area:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(area);
         SocketManager.send(MessageType.CG_CHANGE_PAGE,bytebuff);
      }
      
      public static function CG_REFRESH_DATA(area:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(area);
         SocketManager.send(MessageType.CG_REFRESH_DATA,bytebuff);
      }
      
      public static function CG_GOODS_QUERY() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_GOODS_QUERY,bytebuff);
      }
      
      public static function CG_BUY_GOOD(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(id);
         SocketManager.send(MessageType.CG_BUY_GOOD,bytebuff);
      }
   }
}

