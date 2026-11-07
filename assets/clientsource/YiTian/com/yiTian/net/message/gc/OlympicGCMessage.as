package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.OlympicHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class OlympicGCMessage
   {
      
      public function OlympicGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_OLYMPIC_TIME] = this.GC_OLYMPIC_TIME;
         index[MessageType.GC_OLYMPIC_REWARD] = this.GC_OLYMPIC_REWARD;
         index[MessageType.GC_DAYS_OLM_REWARD] = this.GC_DAYS_OLM_REWARD;
      }
      
      public function GC_OLYMPIC_TIME(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         OlympicHandler.GC_OLYMPIC_TIME(result);
      }
      
      public function GC_OLYMPIC_REWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         OlympicHandler.GC_OLYMPIC_REWARD(result);
      }
      
      public function GC_DAYS_OLM_REWARD(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
      }
   }
}

