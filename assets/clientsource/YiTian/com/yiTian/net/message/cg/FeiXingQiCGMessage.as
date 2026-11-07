package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class FeiXingQiCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function FeiXingQiCGMessage()
      {
         super();
      }
      
      public static function CG_FXQINFO(version:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(version);
         SocketManager.send(MessageType.CG_FXQINFO,bytebuff);
      }
      
      public static function CG_FXQROLL(version:int, point:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(version);
         bytebuff.writeByte(point);
         SocketManager.send(MessageType.CG_FXQROLL,bytebuff);
      }
      
      public static function CG_FXQROLLCOMPLETE(version:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(version);
         SocketManager.send(MessageType.CG_FXQROLLCOMPLETE,bytebuff);
      }
      
      public static function CG_FXQTODISCOMPLETE(version:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(version);
         SocketManager.send(MessageType.CG_FXQTODISCOMPLETE,bytebuff);
      }
      
      public static function CG_GUESSING(version:int, which:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(version);
         bytebuff.writeByte(which);
         SocketManager.send(MessageType.CG_GUESSING,bytebuff);
      }
      
      public static function CG_FXQACCELERATE(version:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(version);
         SocketManager.send(MessageType.CG_FXQACCELERATE,bytebuff);
      }
      
      public static function CG_FXQJOIN(version:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(version);
         SocketManager.send(MessageType.CG_FXQJOIN,bytebuff);
      }
      
      public static function CG_FXQMONSTER(version:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(version);
         SocketManager.send(MessageType.CG_FXQMONSTER,bytebuff);
      }
      
      public static function CG_FXQGETBOX(version:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(version);
         SocketManager.send(MessageType.CG_FXQGETBOX,bytebuff);
      }
      
      public static function CG_ROLLREWARD(version:int, type:int = 1) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(version);
         bytebuff.writeByte(type);
         SocketManager.send(MessageType.CG_ROLLREWARD,bytebuff);
      }
      
      public static function CG_FXQACCINFO(version:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(version);
         SocketManager.send(MessageType.CG_FXQACCINFO,bytebuff);
      }
   }
}

