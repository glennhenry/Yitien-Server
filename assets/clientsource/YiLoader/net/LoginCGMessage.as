package net
{
   import flash.utils.ByteArray;
   import manager.SocketManager;
   
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
      
      public static function CG_CREATE_ROLE(job:int, sex:int, name:String, isShare:int, isShouTing:int) : void
      {
         bytebuff.length = 0;
         bytebuff.writeByte(job);
         bytebuff.writeByte(sex);
         bytebuff.writeUTF(name);
         bytebuff.writeByte(isShare);
         bytebuff.writeByte(isShouTing);
         SocketManager.send(MessageType.CG_CREATE_ROLE,bytebuff);
      }
   }
}

