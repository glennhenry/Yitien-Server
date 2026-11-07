package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class Little_system_CGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function Little_system_CGMessage()
      {
         super();
      }
      
      public static function CG_CHIP_GIFT(id_chip:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(id_chip);
         SocketManager.send(MessageType.CG_CHIP_GIFT,bytebuff);
      }
      
      public static function CG_CHIP_TASK_JIEMI() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_CHIP_TASK_JIEMI,bytebuff);
      }
   }
}

