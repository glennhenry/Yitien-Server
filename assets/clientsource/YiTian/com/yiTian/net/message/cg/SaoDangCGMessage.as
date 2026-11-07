package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class SaoDangCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function SaoDangCGMessage()
      {
         super();
      }
      
      public static function CG_CONFIRM_CLEAN(cleanTimes:int, mapId:int, fubenId:int, type0:Boolean, type1:Boolean, type2:Boolean, type3:Boolean) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(cleanTimes);
         bytebuff.writeInt(mapId);
         bytebuff.writeInt(fubenId);
         bytebuff.writeByte(int(type0));
         bytebuff.writeByte(int(type1));
         bytebuff.writeByte(int(type2));
         bytebuff.writeByte(int(type3));
         SocketManager.send(MessageType.CG_CONFIRM_CLEAN,bytebuff);
      }
      
      public static function CG_CURRENT_CLEAN_TIMES(currentTimes:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(currentTimes);
         SocketManager.send(MessageType.CG_CURRENT_CLEAN_TIMES,bytebuff);
      }
      
      public static function CG_SAODAN_STOP() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_SAODAN_STOP,bytebuff);
      }
   }
}

