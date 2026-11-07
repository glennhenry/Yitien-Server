package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.MidAutumnHandler;
   import com.yiTian.net.handler.TreasureBowlHandle;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class MidAutumnGCMessage
   {
      
      public function MidAutumnGCMessage(index:Array)
      {
         super();
         index[MessageType.gc_mid_autumn_day] = this.gc_mid_autumn_day;
      }
      
      private function gc_mid_autumn_day(patch:IDataInput) : void
      {
         var value:uint = uint(patch.readByte());
         if(value == 1)
         {
            MidAutumnHandler.addIcon();
            TreasureBowlHandle.addIcon();
         }
         else if(value == 2)
         {
            MidAutumnHandler.removeIcon();
            TreasureBowlHandle.removeIcon();
         }
      }
   }
}

