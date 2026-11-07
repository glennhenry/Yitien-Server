package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class TianTiCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function TianTiCGMessage()
      {
         super();
      }
      
      public static function CG_TIANTI() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_TIANTI,bytebuff);
      }
      
      public static function CG_TIANTIBATTLE(lv:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(lv);
         SocketManager.send(MessageType.CG_TIANTIBATTLE,bytebuff);
      }
      
      public static function CG_REFRESHTIANTI() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_REFRESHTIANTI,bytebuff);
      }
      
      public static function CG_XINFA() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_XINFA,bytebuff);
      }
      
      public static function CG_XINFACJ() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_XINFACJ,bytebuff);
      }
      
      public static function CG_XINFACJ2() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_XINFACJ2,bytebuff);
      }
      
      public static function CG_TIANTIAUTOB(isCheckBag:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(isCheckBag);
         SocketManager.send(MessageType.CG_TIANTIAUTOB,bytebuff);
      }
      
      public static function CG_TIANTIREWARDS() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_TIANTIREWARDS,bytebuff);
      }
      
      public static function CG_XINFAUP() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_XINFALVUP,bytebuff);
      }
      
      public static function CG_XINFA_GOD() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_XINFA_GOD,bytebuff);
      }
      
      public static function CG_XINFACJ_GOD() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_XINFACJ_GOD,bytebuff);
      }
      
      public static function CG_XINFACJ2_GOD() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_XINFACJ2_GOD,bytebuff);
      }
   }
}

