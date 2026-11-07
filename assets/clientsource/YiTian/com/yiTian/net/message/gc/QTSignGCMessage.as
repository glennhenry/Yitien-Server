package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.QTsignHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class QTSignGCMessage
   {
      
      public function QTSignGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_QTSign_OPEN] = this.GC_QTSign_OPEN;
         index[MessageType.GC_QTSign_SIGN] = this.GC_QTSign_SIGN;
         index[MessageType.GC_QTSign_AWARD] = this.GC_QTSign_AWARD;
      }
      
      public function GC_QTSign_OPEN(patch:IDataInput) : void
      {
         var signRecordDays:String = patch.readUTF();
         var time:int = patch.readInt();
         var award:String = patch.readUTF();
         var date:int = patch.readInt();
         QTsignHandler.GC_QTSign_OPEN(signRecordDays,time,award,date);
      }
      
      public function GC_QTSign_SIGN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         QTsignHandler.GC_QTSign_SIGN(result);
      }
      
      public function GC_QTSign_AWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         QTsignHandler.GC_QTSign_AWARD(result);
      }
   }
}

