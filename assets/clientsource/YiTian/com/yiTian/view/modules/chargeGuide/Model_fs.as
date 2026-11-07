package com.yiTian.view.modules.chargeGuide
{
   public class Model_fs
   {
      
      public function Model_fs()
      {
         super();
      }
      
      public static function getVo(_sex:int, _idx:int) : int
      {
         var _id:int = 0;
         if(_sex == 1)
         {
            if(_idx == 2)
            {
               _id = 99111;
            }
            else
            {
               _id = 99101;
            }
         }
         else if(_sex == 2)
         {
            if(_idx == 2)
            {
               _id = 99112;
            }
            else if(_idx == 0)
            {
               _id = 99102;
            }
            else if(_idx == 1)
            {
               _id = 99102;
            }
         }
         return _id;
      }
   }
}

