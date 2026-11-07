package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class QplusShareCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function QplusShareCGMessage()
      {
         super();
      }
      
      public static function CG_INVITE_QPLUS() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_INVITE_QPLUS,bytebuff);
      }
      
      public static function CG_ROULETTE_ING() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ROULETTE_ING,bytebuff);
      }
      
      public static function CG_SHARE_RESULT(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(id);
         SocketManager.send(MessageType.CG_SHARE_RESULT,bytebuff);
      }
      
      public static function CG_INVITE_RESULT() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_INVITE_RESULT,bytebuff);
      }
      
      public static function CG_GETING_GIFT(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(id);
         SocketManager.send(MessageType.CG_GETING_GIFT,bytebuff);
      }
      
      public static function CG_MICRO_BLOG() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_MICRO_BLOG,bytebuff);
      }
      
      public static function CG_BLOG_STEP(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(id);
         SocketManager.send(MessageType.CG_BLOG_STEP,bytebuff);
      }
      
      public static function CG_BLOG_GIFT() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_BLOG_GIFT,bytebuff);
      }
      
      public static function CG_MICRO_XIN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_MICRO_XIN,bytebuff);
      }
      
      public static function CG_MICRO_GIFT(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(id);
         SocketManager.send(MessageType.CG_MICRO_GIFT,bytebuff);
      }
   }
}

