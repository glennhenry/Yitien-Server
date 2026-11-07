package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.CaiDengMiHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class CaiDengMiGCMessage
   {
      
      public function CaiDengMiGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_CaiDengMi_OPEN] = this.GC_CaiDengMi_OPEN;
         index[MessageType.GC_CaiDengMi_CHOISE] = this.GC_CaiDengMi_CHOISE;
      }
      
      public function GC_CaiDengMi_OPEN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var titleId:int = 0;
         var haveAnsweredCount:int = 0;
         var rightCount:int = 0;
         if(result == 1)
         {
            titleId = patch.readInt();
            haveAnsweredCount = patch.readByte();
            rightCount = patch.readByte();
         }
         CaiDengMiHandle.GC_CaiDengMi_OPEN(result,titleId,haveAnsweredCount,rightCount);
      }
      
      public function GC_CaiDengMi_CHOISE(patch:IDataInput) : void
      {
         CaiDengMiHandle.GC_CaiDengMi_CHOISE(patch.readByte());
      }
   }
}

