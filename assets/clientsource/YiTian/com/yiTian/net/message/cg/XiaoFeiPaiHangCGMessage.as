package com.yiTian.net.message.cg
{
   import com.yiTian.net.message.gc.XiaoFeiPaiHangGCMessage;
   import flash.utils.ByteArray;
   
   public class XiaoFeiPaiHangCGMessage
   {
      
      private static var _bytebuff:ByteArray = new ByteArray();
      
      public function XiaoFeiPaiHangCGMessage()
      {
         super();
      }
      
      public static function CG_OPEN_MENU() : void
      {
         _bytebuff.length = 0;
         XiaoFeiPaiHangGCMessage.getPhp();
      }
   }
}

