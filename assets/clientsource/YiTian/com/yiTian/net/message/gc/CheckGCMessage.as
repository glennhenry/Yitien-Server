package com.yiTian.net.message.gc
{
   import com.yiTian.net.handler.CheckHandle;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.modules.question.QuestionTips;
   import com.yiTian.view.modules.question.View_questions;
   import flash.utils.IDataInput;
   
   public class CheckGCMessage
   {
      
      public function CheckGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_SHOW_CHECK_TIP] = this.GC_SHOW_CHECK_TIP;
         index[MessageType.GC_SHOW_CHECK_PAN] = this.GC_SHOW_CHECK_PAN;
      }
      
      public function GC_SHOW_CHECK_TIP(patch:IDataInput) : void
      {
         var pan:View_questions = null;
         var result:int = patch.readByte();
         if(result == 1)
         {
            QuestionTips.instance.showTip();
         }
         else if(result == 2)
         {
            QuestionTips.instance.removeTip();
            pan = Singleton.getInstance(View_questions) as View_questions;
            pan.endHd();
         }
      }
      
      public function GC_SHOW_CHECK_PAN(patch:IDataInput) : void
      {
         var btnStu:int = patch.readByte();
         var questionId:int = patch.readInt();
         CheckHandle.GC_SHOW_CHECK_PAN(btnStu,questionId);
      }
   }
}

