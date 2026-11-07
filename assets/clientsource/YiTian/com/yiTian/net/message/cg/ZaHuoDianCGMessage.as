package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class ZaHuoDianCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function ZaHuoDianCGMessage()
      {
         super();
      }
      
      public static function CG_ZAHUODIAN_QUERY(zaHuoDianId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(zaHuoDianId);
         SocketManager.send(MessageType.CG_ZAHUODIAN_QUERY,bytebuff);
      }
      
      public static function CG_ZAHUODIAN_BUY(shopId:int, gridId:int, num:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(shopId);
         bytebuff.writeInt(gridId);
         bytebuff.writeShort(num);
         SocketManager.send(MessageType.CG_ZAHUODIAN_BUY,bytebuff);
      }
      
      public static function CG_ZAHUODIAN_SELL(gridId:Array, nums:Array) : void
      {
         bytebuff.length = 0;
         bytebuff.writeShort(gridId.length);
         var i:int = 0;
         while(i < gridId.length)
         {
            bytebuff.writeShort(gridId[i]);
            i++;
         }
         bytebuff.writeShort(nums.length);
         i = 0;
         while(i < nums.length)
         {
            bytebuff.writeShort(nums[i]);
            i++;
         }
         SocketManager.send(MessageType.CG_ZAHUODIAN_SELL,bytebuff);
      }
   }
}

