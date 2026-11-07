package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class BagCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public static const DISCARD:int = 1;
      
      public static const USE_ITEM:int = 3;
      
      public function BagCGMessage()
      {
         super();
      }
      
      public static function CG_BAG_TIDY() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_BAG_TIDY,bytebuff);
      }
      
      public static function CG_BAG_COMPOSE(gridId:int, count:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeShort(gridId);
         bytebuff.writeByte(count);
         SocketManager.send(MessageType.CG_BAG_COMPOSE,bytebuff);
      }
      
      public static function CG_BAG_SWAP(Id1:int, Id2:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeShort(Id1);
         bytebuff.writeShort(Id2);
         SocketManager.send(MessageType.CG_BAG_SWAP,bytebuff);
      }
      
      public static function CG_BAG_REDUCE(label:int, gridId:int, count:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(label);
         bytebuff.writeShort(gridId);
         bytebuff.writeByte(count);
         SocketManager.send(MessageType.CG_BAG_REDUCE,bytebuff);
      }
      
      public static function CG_BAG_FIX() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_BAG_FIX,bytebuff);
      }
      
      public static function CG_BAG_ITEM_ID(id:int, isBind:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(id);
         bytebuff.writeByte(isBind);
         SocketManager.send(MessageType.CG_BAG_ITEM_ID,bytebuff);
      }
      
      public static function CG_BAG_EQUIP_ID_SERVER(id_sever:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,id_sever);
         SocketManager.send(MessageType.CG_BAG_EQUIP_ID_SERVER,bytebuff);
      }
      
      public static function CG_OPEN_BAG_GRID(type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_OPEN_BAG_GRID,bytebuff);
      }
      
      public static function CG_CZ_END(id_sever:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,id_sever);
         SocketManager.send(MessageType.CG_CZ_END,bytebuff);
      }
      
      public static function CG_SZ_RENEW(id_sever:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,id_sever);
         SocketManager.send(MessageType.CG_SZ_RENEW,bytebuff);
      }
      
      public static function CG_BAG_OPEN_GRID_TIPS(gridID:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(gridID);
         SocketManager.send(MessageType.CG_BAG_OPEN_GRID_TIPS,bytebuff);
      }
      
      public static function CG_BAG_OPEN_GRID_ON_CD(gridID:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(gridID);
         SocketManager.send(MessageType.CG_BAG_OPEN_GRID_ON_CD,bytebuff);
      }
      
      public static function CG_BAG_OPEN_GRID_OPEN(gridID:int, type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(gridID);
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_BAG_OPEN_GRID_OPEN,bytebuff);
      }
      
      public static function CG_BAG_OPEN_GRID_NOT_ON_TIME(gridID:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(gridID);
         SocketManager.send(MessageType.CG_BAG_OPEN_GRID_NOT_ON_TIME,bytebuff);
      }
      
      public static function CG_BAG_PWD_SETTER(str1:String, str2:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeUTF(str1);
         bytebuff.writeUTF(str2);
         SocketManager.send(MessageType.CG_BAG_PWD_SETTER,bytebuff);
      }
      
      public static function CG_BAG_PWD_TYPE_SETTING(type:int, str1:String, str2:String, str3:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         bytebuff.writeUTF(str1);
         bytebuff.writeUTF(str2);
         bytebuff.writeUTF(str3);
         SocketManager.send(MessageType.CG_BAG_PWD_TYPE_SETTING,bytebuff);
      }
      
      public static function CG_BAG_PWD_LOCK_UP() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_BAG_PWD_LOCK_UP,bytebuff);
      }
   }
}

