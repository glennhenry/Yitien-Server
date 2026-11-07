package com.yiTian.view.modules.QShow
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class QShowSkinCGMessage
   {
      
      private static var byteBuff:ByteArray = new ByteArray();
      
      public function QShowSkinCGMessage()
      {
         super();
      }
      
      public static function CG_SHOWSKIN_ICON() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_SHOWSKIN_ICON,byteBuff);
      }
      
      public static function CG_SHOWSKIN_SAVE(type:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         SocketManager.send(MessageType.CG_SHOWSKIN_SAVE,byteBuff);
      }
      
      public static function CG_SHOWSKIN_GIFT() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_SHOWSKIN_GIFT,byteBuff);
      }
   }
}

