package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class ZhuanZhiCGMessage
   {
      
      public static var bytes:ByteArray = new ByteArray();
      
      public function ZhuanZhiCGMessage()
      {
         super();
      }
      
      public static function CG_ZZ_ZHUANZHIINFO() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_ZZ_ZHUANZHIINFO,bytes);
      }
      
      public static function CG_ZZ_WOYAOZHUANZHI() : void
      {
         bytes.length = 0;
         SocketManager.send(MessageType.CG_ZZ_WOYAOZHUANZHI,bytes);
      }
      
      public static function CG_APPLY_TASK(taskId:int) : void
      {
         bytes.length = 0;
         bytes.writeByte(taskId);
         SocketManager.send(MessageType.CG_APPLY_TASK,bytes);
      }
      
      public static function CG_ZZ_CHOICE_WAY(way:int) : void
      {
         bytes.length = 0;
         bytes.writeByte(way);
         SocketManager.send(MessageType.CG_ZZ_CHOICE_WAY,bytes);
      }
   }
}

