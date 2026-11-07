package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class MasterSkillCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function MasterSkillCGMessage()
      {
         super();
      }
      
      public static function CG_MASTERSKILL_LEARN_UP(skillId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(skillId);
         SocketManager.send(MessageType.CG_MASTERSKILL_LEARN_UP,bytebuff);
      }
      
      public static function CG_MASTERSKILL_CHOOSE(skillId:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(skillId);
         SocketManager.send(MessageType.CG_MASTERSKILL_CHOOSE,bytebuff);
      }
      
      public static function CG_MASTERSKILL_ASKFOR_DATA() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_MASTERSKILL_ASKFOR_DATA,bytebuff);
      }
      
      public static function CG_MASTERSKILL_ICTROL() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_MASTERSKILL_ICTROL,bytebuff);
      }
   }
}

