package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class KongJianCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function KongJianCGMessage()
      {
         super();
      }
      
      public static function CG_LINGQU_DENGLU_3366() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_LINGQU_DENGLU_3366,bytebuff);
      }
      
      public static function CG_OPEN_KONGJIANDENGLU() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_OPEN_KONGJIANDENGLU,bytebuff);
      }
      
      public static function CG_DAY_KONGJIAN(type:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_DAY_KONGJIAN,bytebuff);
      }
   }
}

