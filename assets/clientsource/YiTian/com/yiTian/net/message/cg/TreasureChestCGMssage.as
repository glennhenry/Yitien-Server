package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class TreasureChestCGMssage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function TreasureChestCGMssage()
      {
         super();
      }
      
      public static function cg_buySeed_data(curPage:int, pos:int, id:int, num:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeShort(curPage);
         bytebuff.writeByte(pos);
         bytebuff.writeInt(id);
         bytebuff.writeByte(num);
         SocketManager.send(MessageType.cg_buySeed_data,bytebuff);
      }
   }
}

