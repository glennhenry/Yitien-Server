package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class ZaiZhanJiangHuCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function ZaiZhanJiangHuCGMessage()
      {
         super();
      }
      
      public static function CG_ZZJH_IconClick() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ZZJH_ICONCLICK,bytebuff);
      }
      
      public static function CG_ZZJH_ClickAwardButton(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(id);
         SocketManager.send(MessageType.CG_ZZJH_CLICKAWARDBUTTON,bytebuff);
      }
   }
}

