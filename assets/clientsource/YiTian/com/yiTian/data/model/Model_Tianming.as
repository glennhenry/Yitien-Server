package com.yiTian.data.model
{
   import com.yiTian.data.vo.Vo_TianMing;
   
   public class Model_Tianming
   {
      
      public static var openNum:int;
      
      public static var zhuFuLevel:int;
      
      public static var tianFuLevel:int;
      
      public static var zhuFuExp:int;
      
      public static var isLock:Boolean;
      
      public static var tianMingVo:Vector.<Vo_TianMing> = new Vector.<Vo_TianMing>();
      
      public static var myTianMing:Vector.<Vo_TianMing> = new Vector.<Vo_TianMing>();
      
      public function Model_Tianming()
      {
         super();
      }
   }
}

