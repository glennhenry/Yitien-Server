package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class BoatCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function BoatCGMessage()
      {
         super();
      }
      
      public static function CG_RENTSHIP(idStr:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeUTF(idStr);
         SocketManager.send(MessageType.CG_RENTSHIP,bytebuff);
      }
      
      public static function CG_QUIT_SHIP() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_QUIT_SHIP,bytebuff);
      }
      
      public static function CG_STARTEDGAME() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_STARTEDGAME,bytebuff);
      }
      
      public static function CG_BTNCLICK(typeIndex:int, way:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(typeIndex);
         bytebuff.writeByte(way);
         SocketManager.send(MessageType.CG_BTNCLICK,bytebuff);
      }
      
      public static function CG_ESH_HAPPENS(type:int, npcId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         bytebuff.writeInt(npcId);
         SocketManager.send(MessageType.CG_ESH_HAPPENS,bytebuff);
      }
      
      public static function CG_SHIP_USEPRO(promId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(promId);
         SocketManager.send(MessageType.CG_SHIP_USEPRO,bytebuff);
      }
      
      public static function CG_SHIP_BUYPRO(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(id);
         SocketManager.send(MessageType.CG_SHIP_BUYPRO,bytebuff);
      }
      
      public static function CG_QUIT_CHALL() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_QUIT_CHALL,bytebuff);
      }
      
      public static function CG_SHIPERS(id:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeUTF(id);
         SocketManager.send(MessageType.CG_SHIPERS,bytebuff);
      }
      
      public static function CG_LEFT_RIGHT() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_LEFT_RIGHT,bytebuff);
      }
      
      public static function CG_SHIP_MVOES(route:Array, way:int, status:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(status);
         bytebuff.writeShort(route.length);
         var i:int = 0;
         while(i < route.length)
         {
            bytebuff.writeShort(route[i][0]);
            bytebuff.writeShort(route[i][1]);
            i++;
         }
         bytebuff.writeByte(way);
         SocketManager.send(MessageType.CG_SHIP_MVOES,bytebuff);
      }
      
      public static function CG_SENDTO_SERVER_XY(global_x:int, global_y:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeShort(global_x);
         bytebuff.writeShort(global_y);
         SocketManager.send(MessageType.CG_SENDTO_SERVER_XY,bytebuff);
      }
      
      public static function CG_BOAT_CLICKTOPROM(id:int, boatId:String, bangId:Number = 0, quHao:int = 0) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(id);
         bytebuff.writeUTF(boatId);
         LongUtil.writeLong(bytebuff,bangId);
         bytebuff.writeInt(quHao);
         SocketManager.send(MessageType.CG_BOAT_CLICKTOPROM,bytebuff);
      }
      
      public static function CG_SEND_TO_SEVER_DEL(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(id);
         SocketManager.send(MessageType.CG_SEND_TO_SEVER_DEL,bytebuff);
      }
   }
}

