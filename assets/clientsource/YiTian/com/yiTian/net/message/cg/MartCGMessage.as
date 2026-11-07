package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class MartCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function MartCGMessage()
      {
         super();
      }
      
      public static function CG_MYSOLD(gridId:int, Num:int, price:int, priceType:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(gridId);
         bytebuff.writeInt(Num);
         bytebuff.writeInt(price);
         bytebuff.writeInt(priceType);
         SocketManager.send(MessageType.CG_MYSOLD,bytebuff);
      }
      
      public static function CG_MARTSOLD(type:int, curPage:int, isPrice:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(type);
         bytebuff.writeInt(curPage);
         bytebuff.writeByte(isPrice);
         SocketManager.send(MessageType.CG_MARTSOLD,bytebuff);
      }
      
      public static function CG_MY_SOLD() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_MY_SOLD,bytebuff);
      }
      
      public static function CG_MY_BUY() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_MY_BUY,bytebuff);
      }
      
      public static function CG_MARTBUY(type:int, curPage:int, isPrice:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(type);
         bytebuff.writeInt(curPage);
         bytebuff.writeByte(isPrice);
         SocketManager.send(MessageType.CG_MARTBUY,bytebuff);
      }
      
      public static function CG_MYBUY(wpid:int, price:int, priceType:int, boughtNum:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(wpid);
         bytebuff.writeInt(price);
         bytebuff.writeInt(priceType);
         bytebuff.writeInt(boughtNum);
         SocketManager.send(MessageType.CG_MYBUY,bytebuff);
      }
      
      public static function CG_SEARCH(type_of_mart:int, wpName:String, job:int, type:int, pinjie:int, level:int, _curPage:int, isPrice:int) : void
      {
         bytebuff.length = 0;
         if(wpName == LangConfig.getWord("69",0) || wpName == "")
         {
            wpName = "0";
         }
         bytebuff.writeInt(type_of_mart);
         bytebuff.writeUTF(wpName);
         bytebuff.writeInt(job);
         bytebuff.writeInt(type);
         bytebuff.writeInt(pinjie);
         bytebuff.writeInt(level);
         bytebuff.writeInt(_curPage);
         bytebuff.writeByte(isPrice);
         SocketManager.send(MessageType.CG_SEARCH,bytebuff);
      }
      
      public static function CG_SOLD(id:Number, _num:int, _griId:int, _cur_pg:int) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,id);
         bytebuff.writeInt(_num);
         bytebuff.writeInt(_griId);
         bytebuff.writeInt(_cur_pg);
         SocketManager.send(MessageType.CG_SOLD,bytebuff);
      }
      
      public static function CG_CANCLE_BUY(id:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,id);
         SocketManager.send(MessageType.CG_CANCLE_BUY,bytebuff);
      }
      
      public static function CG_CANCLE_SOLD(id:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,id);
         SocketManager.send(MessageType.CG_CANCLE_SOLD,bytebuff);
      }
      
      public static function CG_BUY(id:Number, num:int, curPage:int) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,id);
         bytebuff.writeInt(num);
         bytebuff.writeInt(curPage);
         SocketManager.send(MessageType.CG_BUY,bytebuff);
      }
   }
}

