package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.CGMessage;
   import com.yiTian.net.message.MessageType;
   
   public class CardCGMessage extends CGMessage
   {
      
      public function CardCGMessage()
      {
         super();
      }
      
      public static function CG_CARD_OPEN_PANEL() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_CARD_OPEN_PANEL,byteBuff);
      }
      
      public static function CG_CARD_COUNT_DOWN_TIMEOUT() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_CARD_COUNT_DOWN_TIMEOUT,byteBuff);
      }
      
      public static function CG_CARD_ZhanBu(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_CARD_ZhanBu,byteBuff);
      }
      
      public static function CG_CARD_FenJie(bagType:int, FenJieType:int, bagPosition:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(bagType);
         byteBuff.writeByte(FenJieType);
         byteBuff.writeShort(bagPosition);
         SocketManager.send(MessageType.CG_CARD_FenJie,byteBuff);
      }
      
      public static function CG_CARD_PICK_UP(type:int, bagGridID:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         byteBuff.writeShort(bagGridID);
         SocketManager.send(MessageType.CG_CARD_PICK_UP,byteBuff);
      }
      
      public static function CG_CARD_BUY(cardID:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(cardID);
         SocketManager.send(MessageType.CG_CARD_BUY,byteBuff);
      }
      
      public static function CG_CARD_OPEN_EQUIP_GRID() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_CARD_OPEN_EQUIP_GRID,byteBuff);
      }
      
      public static function CG_CARD_EQUIP(type:int, gridID:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         byteBuff.writeShort(gridID);
         SocketManager.send(MessageType.CG_CARD_EQUIP,byteBuff);
      }
      
      public static function CG_CARD_TunShi(type:int, TunShiType:int, gridID:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         byteBuff.writeByte(TunShiType);
         byteBuff.writeShort(gridID);
         SocketManager.send(MessageType.CG_CARD_TunShi,byteBuff);
      }
      
      public static function CG_CARD_ShengXing(type:int, gridID:int, material:String) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         byteBuff.writeShort(gridID);
         byteBuff.writeUTF(material);
         SocketManager.send(MessageType.CG_CARD_ShengXing,byteBuff);
      }
      
      public static function CG_CARD_TOTAL_ATTIBUTE() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_CARD_TOTAL_ATTIBUTE,byteBuff);
      }
      
      public static function CG_CARD_LOCK(bagGridID:int, type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeShort(bagGridID);
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_CARD_LOCK,byteBuff);
      }
   }
}

