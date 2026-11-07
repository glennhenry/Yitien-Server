package com.yiTian.net.handler
{
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.modules.question.Model_question;
   import com.yiTian.view.modules.question.View_questions;
   
   public class CheckHandle
   {
      
      public function CheckHandle()
      {
         super();
      }
      
      public static function GC_SHOW_CHECK_PAN(btnStu:int, questionId:int) : void
      {
         Model_question.questionId = questionId;
         Model_question.sureBtnS = btnStu;
         var pan:View_questions = Singleton.getInstance(View_questions) as View_questions;
         if(!View_questions.firstInit)
         {
            pan.questionId = "右翻页";
         }
      }
   }
}

