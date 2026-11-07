package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class ChunJieNianGaoCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function ChunJieNianGaoCGMessage()
      {
         super();
      }
      
      public static function CG_ChunJieNianGao_EAT(count:int, gridId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(count);
         bytebuff.writeInt(gridId);
         SocketManager.send(MessageType.CG_ChunJieNianGao_EAT,bytebuff);
      }
   }
}

