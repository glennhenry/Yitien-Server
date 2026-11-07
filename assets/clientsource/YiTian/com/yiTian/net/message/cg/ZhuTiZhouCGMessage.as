package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class ZhuTiZhouCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function ZhuTiZhouCGMessage()
      {
         super();
      }
      
      public static function ZTZ_GETAWARD(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(id);
         SocketManager.send(MessageType.CG_ZTZ_GETAWARD,bytebuff);
      }
      
      public static function XSLB_GETAWARD(itemId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(itemId);
         SocketManager.send(MessageType.CG_XSLB_GETAWARD,bytebuff);
      }
      
      public static function CG_ZTZ_GONGGAO(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(id);
         SocketManager.send(MessageType.CG_ZTZ_GONGGAO,bytebuff);
      }
   }
}

