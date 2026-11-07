package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class BlueDiamondCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function BlueDiamondCGMessage()
      {
         super();
      }
      
      public static function CG_BLUE_DIAMOND_START() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_BLUE_DIAMOND_START,bytebuff);
      }
      
      public static function CG_REQUEST_INITDATA() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_BLUE_REQUEST_INITDATA,bytebuff);
      }
      
      public static function CG_XFCJ_OPENPAN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_XFCJ_OPENPAN,bytebuff);
      }
      
      public static function CG_XFCJ2_OPENPAN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_XFCJ2_OPENPAN,bytebuff);
      }
      
      public static function CG_QQGAMECJ_OPENPAN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_QQGAMECJ_OPENPAN,bytebuff);
      }
      
      public static function CG_QQGAMECJ_CHOUJIANG() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_QQGAMECJ_CHOUJIANG,bytebuff);
      }
      
      public static function CG_XFCJ_CHOUJIANG() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_XFCJ_CHOUJIANG,bytebuff);
      }
      
      public static function CG_XFCJ2_CHOUJIANG() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_XFCJ2_CHOUJIANG,bytebuff);
      }
      
      public static function CG_QQGAMEXF_SHOWPLANE() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_QQGAMEXF_SHOWPAN,bytebuff);
      }
      
      public static function CG_ZHUANPAN_PLAY() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ZHUANPAN_PLAY,bytebuff);
      }
      
      public static function CG_ZHUANPAN_OPEN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ZHUANPAN_OPEN,bytebuff);
      }
      
      public static function CG_XINGYUNCHONGZHI_PLAY() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_XINGYUNCHONGZHI_PLAY,bytebuff);
      }
      
      public static function CG_XINGYUNCHONGZHI_OPEN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_XINGYUNCHONGZHI_OPEN,bytebuff);
      }
   }
}

