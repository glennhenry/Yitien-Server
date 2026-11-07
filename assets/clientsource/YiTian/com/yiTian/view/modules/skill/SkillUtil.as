package com.yiTian.view.modules.skill
{
   public class SkillUtil
   {
      
      public function SkillUtil()
      {
         super();
      }
      
      public static function getSkillZX(sId:int) : int
      {
         var sub:int = sId % 100;
         if(sub >= 29)
         {
            return 2;
         }
         if(sub >= 19)
         {
            return 1;
         }
         return 0;
      }
   }
}

