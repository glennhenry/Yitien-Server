package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.CGMessage;
   import com.yiTian.net.message.MessageType;
   
   public class WanJiaZhaoHuiCGMessage extends CGMessage
   {
      
      public function WanJiaZhaoHuiCGMessage()
      {
         super();
      }
      
      public static function CG_WJZH_SHOWPANEL() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_WJZH_SHOWPANEL,byteBuff);
      }
      
      public static function CG_WJZH_AWARD(index:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(index);
         SocketManager.send(MessageType.CG_WJZH_AWARD,byteBuff);
      }
      
      public static function CG_WJZH_INVITE(index:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeInt(index);
         SocketManager.send(MessageType.CG_WJZH_INVITE,byteBuff);
      }
   }
}

