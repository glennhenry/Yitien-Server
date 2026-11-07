package com.yiTian.net.message.gc
{
   import com.yiTian.manager.DailyBtnManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class DailyBtnGCMessage
   {
      
      public function DailyBtnGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_BTN_COUNT_UPDATE] = this.GC_BTN_COUNT_UPDATE;
         index[MessageType.GC_NEXT_SYS] = this.GC_NEXT_SYS;
      }
      
      private function GC_BTN_COUNT_UPDATE(patch:IDataInput) : void
      {
         var sysId:int = patch.readByte();
         var count:int = patch.readByte();
         DailyBtnManager.setCount(sysId,count);
      }
      
      private function GC_NEXT_SYS(patch:IDataInput) : void
      {
         var nextSys:int = patch.readByte();
         UIManager.nextSys.update(nextSys);
      }
   }
}

