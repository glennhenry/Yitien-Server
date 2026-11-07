package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class LiuShiWanJiaZhaoHuiCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function LiuShiWanJiaZhaoHuiCGMessage()
      {
         super();
      }
      
      public static function CG_LIUSHIWANJIA_AWARD_BACK() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_LIUSHIWANJIA_AWARD_BACK,bytebuff);
      }
   }
}

