package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.CGMessage;
   import com.yiTian.net.message.MessageType;
   
   public class MoneyTreeCGMessage extends CGMessage
   {
      
      public function MoneyTreeCGMessage()
      {
         super();
      }
      
      public static function CG_MONEYTREE_WATER() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_MONEYTREE_WATER,byteBuff);
      }
      
      public static function CG_MONEYTREE_OPENWIN() : void
      {
         byteBuff.length = 0;
         SocketManager.send(MessageType.CG_MONEYTREE_OPENWIN,byteBuff);
      }
      
      public static function CG_MONEYTREE_PLANT(index:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(index);
         SocketManager.send(MessageType.CG_MONEYTREE_PLANT,byteBuff);
      }
      
      public static function CG_MONEYTREE_GETWARD(index:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(index);
         SocketManager.send(MessageType.CG_MONEYTREE_GETWARD,byteBuff);
      }
   }
}

