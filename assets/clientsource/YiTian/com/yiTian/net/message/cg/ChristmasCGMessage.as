package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class ChristmasCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function ChristmasCGMessage()
      {
         super();
      }
      
      public static function cg_christmas_open_view() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.cg_christmas_open_view,bytebuff);
      }
      
      public static function cg_christmas_request_collect(id:uint, xx:int, yy:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(id);
         bytebuff.writeInt(xx);
         bytebuff.writeInt(yy);
         SocketManager.send(MessageType.cg_christmas_request_collect,bytebuff);
      }
      
      public static function cg_christmas_collect_result(mapid:uint, nid:uint, result:uint, xx:int, yy:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(mapid);
         bytebuff.writeInt(nid);
         bytebuff.writeByte(result);
         bytebuff.writeInt(xx);
         bytebuff.writeInt(yy);
         SocketManager.send(MessageType.cg_christmas_collect_result,bytebuff);
      }
      
      public static function cg_christmas_get_gift(pos:uint) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(pos);
         SocketManager.send(MessageType.cg_christmas_get_gift,bytebuff);
      }
      
      public static function cg_christmas_one_key_snowman() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.cg_christmas_one_key_snowman,bytebuff);
      }
   }
}

