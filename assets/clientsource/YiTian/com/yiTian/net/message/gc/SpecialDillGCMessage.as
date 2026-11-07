package com.yiTian.net.message.gc
{
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.specialBtnDill.Model_specialD;
   import flash.utils.IDataInput;
   
   public class SpecialDillGCMessage
   {
      
      public function SpecialDillGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_TEST] = this.GC_TEST;
      }
      
      private function GC_TEST(patch:IDataInput) : void
      {
         Model_specialD.showExtAllbtn();
      }
   }
}

