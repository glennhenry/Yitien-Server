package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class LingQiWuHunCGMessage
   {
      
      public static var byteBuff:ByteArray = new ByteArray();
      
      public function LingQiWuHunCGMessage()
      {
         super();
      }
      
      public static function CG_LINGQIWUHUN() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_LINGQIWUHUN,byteBuff);
      }
      
      public static function CG_JUANXIAN_LINGQI(heroMakeId:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(heroMakeId);
         SocketManager.send(MessageType.CG_JUANXIAN_LINGQI,byteBuff);
      }
   }
}

