package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class DepotCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public static const BAG_DEPOT:int = 1;
      
      public static const DEPOT_BAG:int = 2;
      
      public static const DEPOT:int = 3;
      
      public function DepotCGMessage()
      {
         super();
      }
      
      public static function CG_DEPOT_TIDY() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_DEPOT_TIDY,bytebuff);
      }
      
      public static function CG_DEPOT_DISCARD(gridId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeShort(gridId);
         SocketManager.send(MessageType.CG_DEPOT_DISCARD,bytebuff);
      }
      
      public static function CG_DEPOT_SWAP(label:int, drag_gridId:int, up_gridId:int, count:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(label);
         bytebuff.writeShort(drag_gridId);
         bytebuff.writeShort(up_gridId);
         bytebuff.writeByte(count);
         SocketManager.send(MessageType.CG_DEPOT_SWAP,bytebuff);
      }
   }
}

