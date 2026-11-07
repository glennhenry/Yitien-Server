package com.yiTian.data.vo
{
   public class Vo_farm_guide
   {
      
      public static const type_guide_none:uint = 0;
      
      public static const type_guide_farmer:uint = 1;
      
      public static const type_guide_plant:uint = 2;
      
      public var type:uint;
      
      public var currentStep:uint;
      
      public var totalStep:uint;
      
      public var step:Vector.<uint>;
      
      public var isComplete:Boolean;
      
      public function Vo_farm_guide()
      {
         super();
      }
   }
}

