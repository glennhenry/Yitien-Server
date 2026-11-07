package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.BabyGiftHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class BabyGiftGCMessage
   {
      
      public function BabyGiftGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_ETLB_OPEN] = this.GC_ETLB_OPEN;
         index[MessageType.GC_ETLB_GETAWARD] = this.GC_ETLB_GETAWARD;
      }
      
      public function GC_ETLB_OPEN(patch:IDataInput) : void
      {
         var state:int = patch.readByte();
         BabyGiftHandler.GC_ETLB_OPEN(state);
      }
      
      public function GC_ETLB_GETAWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         BabyGiftHandler.GC_ETLB_GETAWARD(result);
      }
   }
}

