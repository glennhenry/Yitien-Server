package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class HeFuHuoDongCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function HeFuHuoDongCGMessage()
      {
         super();
      }
      
      public static function CG_OPEN_MENU(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(id);
         SocketManager.send(MessageType.CG_HeFuHuoDong_OPEN,bytebuff);
      }
      
      public static function CG_HeFu_GET(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(id);
         SocketManager.send(MessageType.CG_HeFuHuoDong_HeFu_GET,bytebuff);
      }
      
      public static function CG_HuiGui_GET(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(id);
         SocketManager.send(MessageType.CG_HeFuHuoDong_HuiGui_GET,bytebuff);
      }
      
      public static function CG_ChongZhi_GET(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(id);
         SocketManager.send(MessageType.CG_HeFuHuoDong_ChongZhi_GET,bytebuff);
      }
      
      public static function CG_ZaiXian_YaoJiang() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_HeFuHuoDong_ZaiXian_YaoJiang,bytebuff);
      }
      
      public static function CG_ZaiXian_GET(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(id);
         SocketManager.send(MessageType.CG_HeFuHuoDong_ZaiXian_GET,bytebuff);
      }
   }
}

