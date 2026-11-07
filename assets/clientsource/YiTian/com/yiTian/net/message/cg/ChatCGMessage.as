package com.yiTian.net.message.cg
{
   import com.utils.LongUtil;
   import com.yiTian.data.model.Model_chat;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class ChatCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function ChatCGMessage()
      {
         super();
      }
      
      public static function CG_CHAT(chatType:int, chatContact:String, grid_id:int = 0) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(chatType);
         bytebuff.writeUTF(chatContact);
         if(Boolean(grid_id))
         {
            bytebuff.writeInt(grid_id);
         }
         SocketManager.send(MessageType.CG_CHAT,bytebuff);
         Model_chat.chat_save = [];
      }
      
      public static function CG_SID_CHAT(otherRoleId:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,otherRoleId);
         SocketManager.send(MessageType.CG_SID_CHAT,bytebuff);
      }
      
      public static function CG_SID_CHAT_SEND(otherRoleId:Number, contact:String, roleName:String, crossServType:int) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,otherRoleId);
         bytebuff.writeUTF(contact);
         bytebuff.writeUTF(Model_heFu.correctRoleServName(roleName));
         bytebuff.writeByte(crossServType);
         SocketManager.send(MessageType.CG_SID_CHAT_SEND,bytebuff);
      }
      
      public static function CG_SHOW(wpId:Number) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,wpId);
         SocketManager.send(MessageType.CG_SHOW,bytebuff);
      }
      
      public static function CG_KUAFU_CHAT(otherRoleId:Number, otherRoleName:String) : void
      {
         bytebuff.length = 0;
         LongUtil.writeLong(bytebuff,otherRoleId);
         bytebuff.writeUTF(Model_heFu.correctRoleServName(otherRoleName));
         SocketManager.send(MessageType.CG_KUAFU_CHAT,bytebuff);
      }
      
      public static function CG_DAOQI_SEND(id:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeInt(id);
         SocketManager.send(MessageType.CG_DAOQI_SEND,bytebuff);
      }
   }
}

