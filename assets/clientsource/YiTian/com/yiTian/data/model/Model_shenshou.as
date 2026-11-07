package com.yiTian.data.model
{
   import com.yiTian.data.vo.Vo_shenshou;
   
   public class Model_shenshou
   {
      
      public static var state:int;
      
      public static var grawNum:int;
      
      public static var challBoo:int;
      
      public static var challTime:int;
      
      public static var feedState:int;
      
      public function Model_shenshou()
      {
         super();
      }
      
      public static function getVoData(vo:Vo_shenshou) : void
      {
         state = vo.state;
         grawNum = vo.grawNum;
         challBoo = vo.challBoo;
         challTime = vo.challTime;
         feedState = vo.feedState;
      }
   }
}

