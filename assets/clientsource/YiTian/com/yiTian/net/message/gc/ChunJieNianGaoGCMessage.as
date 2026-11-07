package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.ChunJieNianGaoHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class ChunJieNianGaoGCMessage
   {
      
      public function ChunJieNianGaoGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_ChunJieNianGao_Result] = this.GC_ChunJieNianGao_Result;
         index[MessageType.GC_ChunJieNianGao_Count] = this.GC_ChunJieNianGao_Count;
         index[MessageType.GC_ChunJieNianGao_EAT] = this.GC_ChunJieNianGao_EAT;
      }
      
      private function GC_ChunJieNianGao_Result(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         ChunJieNianGaoHandler.GC_ChunJieNianGao_Result(result);
      }
      
      private function GC_ChunJieNianGao_Count(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         var count:int = patch.readInt();
         ChunJieNianGaoHandler.GC_ChunJieNianGao_Count(type,count);
      }
      
      private function GC_ChunJieNianGao_EAT(patch:IDataInput) : void
      {
         var freeTimes:int = patch.readInt();
         var chargeTimes:int = patch.readInt();
         var gridId:int = patch.readInt();
         ChunJieNianGaoHandler.GC_ChunJieNianGao_EAT(freeTimes,chargeTimes,gridId);
      }
   }
}

