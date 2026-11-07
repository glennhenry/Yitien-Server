package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.CGMessage;
   import com.yiTian.net.message.MessageType;
   
   public class GongCeJiShiCGMessage extends CGMessage
   {
      
      public function GongCeJiShiCGMessage()
      {
         super();
      }
      
      public static function GC_GCJS_SHOWPANEL() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_GCJS_SHOWPANEL,byteBuff);
      }
      
      public static function GC_GCJS_AWARD(index:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(index);
         SocketManager.send(MessageType.CG_GCJS_AWARD,byteBuff);
      }
   }
}

