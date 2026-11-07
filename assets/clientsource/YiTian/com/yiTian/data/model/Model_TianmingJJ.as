package com.yiTian.data.model
{
   import com.yiTian.view.modules.tianmingjj.Vo_TianmingJJ;
   
   public class Model_TianmingJJ
   {
      
      public static var remaindTMS:int;
      
      public static var currentTMD:int;
      
      public static var isEffect:Boolean;
      
      public static var result:String;
      
      public static var currentTimes:int;
      
      public static var startPlay:Boolean;
      
      public static var currentUpSysId:int;
      
      public static var vec:Vector.<Vo_TianmingJJ> = new Vector.<Vo_TianmingJJ>();
      
      public static const TOOLID:int = 45294;
      
      public function Model_TianmingJJ()
      {
         super();
      }
      
      public static function isMax() : Boolean
      {
         var counts:int = 0;
         var i:int = 0;
         while(i < vec.length)
         {
            if(vec[i].value == 6)
            {
               counts++;
            }
            i++;
         }
         return counts == 6;
      }
   }
}

