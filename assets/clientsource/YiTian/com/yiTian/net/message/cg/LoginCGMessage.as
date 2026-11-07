package com.yiTian.net.message.cg
{
   import com.yiTian.manager.SocketManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.ByteArray;
   
   public class LoginCGMessage
   {
      
      public static var bytebuff:ByteArray = new ByteArray();
      
      public function LoginCGMessage()
      {
         super();
      }
      
      public static function CG_ASK_LOGIN(account:String, fcm:int, openkey:String, invkey:String, itime:String, iopenid:String, zoneid:String, pf:String, fpkey:String, user_source:String, contract_id:String, app_custom:String, fd:String, via:String, seqid:String, adtag:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeUTF(account);
         bytebuff.writeByte(fcm);
         bytebuff.writeUTF(openkey);
         bytebuff.writeUTF(invkey);
         bytebuff.writeUTF(itime);
         bytebuff.writeUTF(iopenid);
         if(zoneid == "")
         {
            zoneid = "0";
         }
         bytebuff.writeUTF(zoneid);
         bytebuff.writeUTF(pf);
         bytebuff.writeUTF(fpkey);
         bytebuff.writeUTF(user_source);
         bytebuff.writeUTF(contract_id);
         bytebuff.writeUTF(app_custom);
         bytebuff.writeUTF(fd);
         bytebuff.writeUTF(via);
         bytebuff.writeUTF(seqid);
         bytebuff.writeUTF(adtag);
         SocketManager.send(MessageType.CG_ASK_LOGIN,bytebuff);
      }
      
      public static function CG_ASK_CHARLIST() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_ASK_CHARLIST,bytebuff);
      }
      
      public static function CG_GM_KEFU(name:String) : void
      {
         bytebuff.length = 0;
         bytebuff.writeUTF(name);
         SocketManager.send(MessageType.CG_GM_KEFU,bytebuff);
      }
      
      public static function CG_BTN_EFF() : void
      {
         bytebuff.length = 0;
         SocketManager.send(MessageType.CG_BTN_EFF,bytebuff);
      }
      
      public static function CG_CREATE_ROLE(job:int, sex:int, name:String, isShare:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(job);
         bytebuff.writeByte(sex);
         bytebuff.writeUTF(name);
         bytebuff.writeByte(isShare);
         SocketManager.send(MessageType.CG_CREATE_ROLE,bytebuff);
      }
      
      public static function CG_VALIDATE(result:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeShort(result);
         SocketManager.send(MessageType.CG_VALIDATE,bytebuff);
      }
   }
}

