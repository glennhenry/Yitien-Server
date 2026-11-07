package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class JianghulixianCGMessage
   {
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function JianghulixianCGMessage()
      {
         super();
      }
      
      public static function CG_Jianghulixian_GET_RESULT(_id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(_id);
         SocketManager.send(MessageType.CG_Jianghulixian_GET_RESULT,bytebuff);
      }
      
      public static function CG_Jianghulixian_CHANGE_CARD(_arr:Array) : void
      {
         var i:* = undefined;
         bytebuff.length = 0;
         bytebuff.writeByte(_arr.length);
         for(i in _arr)
         {
            bytebuff.writeByte(_arr[i]);
         }
         SocketManager.send(MessageType.CG_Jianghulixian_CHANGE_CARD,bytebuff);
      }
   }
}

