package com.yiTian.net.message.cg
{
   import com.yiTian.data.model.Model_WeiLie;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class WeiLieCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function WeiLieCGMessage()
      {
         super();
      }
      
      public static function CG_WEILIE_OPEN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_WEILIE_OPEN,bytebuff);
      }
      
      public static function CG_WEILIE_SHOT(type:String) : void
      {
         bytebuff.length = 0;
         switch(type)
         {
            case Model_WeiLie.QZYG:
               SocketManager.send(MessageType.CG_WEILIE_SHOT,bytebuff);
               break;
            case Model_WeiLie.QZGS:
               SocketManager.send(MessageType.CG_PPTREE_SHOT,bytebuff);
         }
      }
      
      public static function CG_PPTREE_OPEN() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_PPTREE_OPEN,bytebuff);
      }
      
      public static function CG_PPTREE_SHOT() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_PPTREE_SHOT,bytebuff);
      }
   }
}

