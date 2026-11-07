package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class ChongChuJinagHuCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function ChongChuJinagHuCGMessage()
      {
         super();
      }
      
      public static function OpenMenu() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ChongChuJiangHu_OPEN_MENU,bytebuff);
      }
      
      public static function GetPrize(id:int) : void
      {
         trace("103003>>",id);
         bytebuff.length = 0;
         bytebuff.writeByte(id);
         SocketManager.send(MessageType.CG_ChongChuJiangHu_GET,bytebuff);
      }
   }
}

