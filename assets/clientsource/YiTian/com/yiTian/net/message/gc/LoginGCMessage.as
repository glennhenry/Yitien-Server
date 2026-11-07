package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.LoginHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.map.Model_GM_KF;
   import flash.utils.IDataInput;
   
   public class LoginGCMessage
   {
      
      private static var i_index:int = 0;
      
      private static var ii_index:int = 0;
      
      public function LoginGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_DAILY_REMAIN] = this.GC_DAILY_REMAIN;
         index[MessageType.GC_VALIDATE] = this.GC_VALIDATE;
         index[MessageType.GC_VALIDATE_REWARD] = this.GC_VALIDATE_REWARD;
         index[MessageType.GC_VALIDATING_TIP] = this.GC_VALIDATING_TIP;
         index[MessageType.GC_SHUT_UP] = this.GC_SHUT_UP;
         index[MessageType.GC_SAVE_DATA] = this.GC_SAVE_DATA;
         index[MessageType.GC_GM_KEFU] = this.GC_GM_KEFU;
      }
      
      public function GC_OFF_LINE(patch:IDataInput) : void
      {
         var offLineType:int = patch.readByte();
         LoginHandler.GC_OFF_LINE(offLineType);
      }
      
      public function GC_DAILY_REMAIN(patch:IDataInput) : void
      {
         var JJC:int = patch.readByte();
         var DAILY_QUEST:int = patch.readByte();
         var LIN_QI:int = patch.readByte();
         var PA_TA:int = patch.readByte();
         var ZHANG_MEN_REN:int = patch.readByte();
         var CHUANG_GUAN:int = patch.readByte();
         var PAO_BIAO:int = patch.readByte();
         LoginHandler.GC_DAILY_REMAIN(JJC,DAILY_QUEST,LIN_QI,PA_TA,ZHANG_MEN_REN,CHUANG_GUAN,PAO_BIAO);
      }
      
      public function GC_VALIDATE(patch:IDataInput) : void
      {
         var info:int = patch.readInt();
         LoginHandler.GC_VALIDATE(info);
      }
      
      public function GC_VALIDATE_REWARD(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         var value:int = patch.readShort();
         LoginHandler.GC_VALIDATE_REWARD(type,value);
      }
      
      public function GC_VALIDATING_TIP(patch:IDataInput) : void
      {
         LoginHandler.GC_VALIDATING_TIP();
      }
      
      public function GC_SHUT_UP(patch:IDataInput) : void
      {
         LoginHandler.GC_SHUT_UP();
      }
      
      public function GC_SAVE_DATA(patch:IDataInput) : void
      {
         LoginHandler.GC_SAVE_DATA();
      }
      
      private function GC_GM_KEFU(patch:IDataInput) : void
      {
         var time:String = patch.readUTF();
         var sign:String = patch.readUTF();
         var sign2:String = Boolean(patch.bytesAvailable) ? patch.readUTF() : "";
         Model_GM_KF.link(time,sign,sign2);
      }
   }
}

