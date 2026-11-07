package com.yiTian.net.message.gc
{
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.qqClock.QQClock_Btn;
   import flash.utils.IDataInput;
   
   public class QQClockGCMessage
   {
      
      public function QQClockGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_QQCLOCK_BTN] = this.GC_QQCLOCK_BTN;
      }
      
      private function GC_QQCLOCK_BTN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 1)
         {
            QQClock_Btn.instance.show();
         }
         else if(result == 2)
         {
            QQClock_Btn.instance.hide();
         }
      }
   }
}

