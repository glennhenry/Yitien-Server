package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class XiaoZhaoCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function XiaoZhaoCGMessage()
      {
         super();
      }
      
      public static function CG_XIAOZHAO_GET_WARD(index:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(index + 1);
         SocketManager.send(MessageType.CG_XIAOZHAO_GET_WARD,bytebuff);
      }
      
      public static function CG_XIAOZHAO_OPEN_WIN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_XIAOZHAO_OPEN_WIN,bytebuff);
      }
      
      public static function CG_XIAOZHAO_REFRESH(state:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(state);
         SocketManager.send(MessageType.CG_XIAOZHAO_REFRESH,bytebuff);
      }
   }
}

