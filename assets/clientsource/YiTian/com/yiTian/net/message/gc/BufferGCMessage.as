package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.BufferHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class BufferGCMessage
   {
      
      public function BufferGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_BUFFER] = this.GC_BUFFER;
         index[MessageType.GC_BUFFER_END] = this.GC_BUFFER_END;
         index[MessageType.GC_ADD_HP_MP] = this.GC_ADD_HP_MP;
      }
      
      public function GC_BUFFER(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var buffId:int = patch.readInt();
         var value:int = patch.readInt();
         BufferHandler.GC_BUFFER(result,buffId,value);
      }
      
      public function GC_BUFFER_END(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var buffId:int = patch.readInt();
         var time:int = patch.readInt();
         BufferHandler.GC_BUFFER_END(result,buffId,time);
      }
      
      public function GC_ADD_HP_MP(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         BufferHandler.GC_ADD_HP_MP(result);
      }
   }
}

