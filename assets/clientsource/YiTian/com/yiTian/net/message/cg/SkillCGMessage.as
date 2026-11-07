package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class SkillCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function SkillCGMessage()
      {
         super();
      }
      
      public static function CG_SKILL_STUDY(index:int, way:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(index);
         bytebuff.writeByte(way);
         SocketManager.send(MessageType.CG_SKILL_STUDY,bytebuff);
      }
      
      public static function CG_SET_BAR(type:int, indexA:int, indexB:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(type);
         bytebuff.writeByte(indexA);
         bytebuff.writeByte(indexB);
         SocketManager.send(MessageType.CG_SET_BAR,bytebuff);
      }
   }
}

