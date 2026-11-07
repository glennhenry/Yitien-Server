package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class LetterCGMessage
   {
      
      public static var byteBuff:ByteArray = new ByteArray();
      
      public function LetterCGMessage()
      {
         super();
      }
      
      public static function CG_MAIL(type:int, currentPage:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         byteBuff.writeShort(currentPage);
         SocketManager.send(MessageType.CG_MAIL,byteBuff);
      }
      
      public static function CG_SEND_MAIL(receiverName:String, content:String, msType:int, moneyNum:int, goodType:int, goodId:int, goodNum:int, gridIndex:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeUTF(receiverName);
         byteBuff.writeUTF(content);
         byteBuff.writeByte(msType);
         byteBuff.writeInt(moneyNum);
         byteBuff.writeByte(goodType);
         byteBuff.writeInt(goodId);
         byteBuff.writeShort(goodNum);
         byteBuff.writeShort(gridIndex);
         SocketManager.send(MessageType.CG_SEND_MAIL,byteBuff);
      }
      
      public static function CG_DELETE_MAIL(type:int, currentPage:int, nums:int, idArr:Array) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         byteBuff.writeShort(currentPage);
         byteBuff.writeByte(nums);
         var i:uint = 0;
         while(i < nums)
         {
            LongUtil.writeLong(byteBuff,idArr[i]);
            i++;
         }
         SocketManager.send(MessageType.CG_DELETE_MAIL,byteBuff);
      }
      
      public static function CG_GET_ATTACHMENT(type:int, currentPage:int, mailId:Number, attachType:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         byteBuff.writeShort(currentPage);
         LongUtil.writeLong(byteBuff,mailId);
         byteBuff.writeByte(attachType);
         SocketManager.send(MessageType.CG_GET_ATTACHMENT,byteBuff);
      }
      
      public static function CG_CLEAR_MAIL(type:int, currentPage:int) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         byteBuff.writeShort(currentPage);
         SocketManager.send(MessageType.CG_CLEAR_MAIL,byteBuff);
      }
      
      public static function CG_TURN_PAGE(type:int, mailIdStr:String) : void
      {
         byteBuff.length = 0;
         byteBuff.writeByte(type);
         byteBuff.writeUTF(mailIdStr);
         SocketManager.send(MessageType.CG_TURN_PAGE,byteBuff);
      }
   }
}

