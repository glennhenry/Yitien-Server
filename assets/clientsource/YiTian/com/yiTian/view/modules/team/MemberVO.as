package com.yiTian.view.modules.team
{
   import com.yiTian.data.vo.Vo_grid;
   
   public class MemberVO extends Vo_grid
   {
      
      public var orderId:int;
      
      public var memberId:Number = 0;
      
      public var name:String;
      
      public var level:int;
      
      public var job:int;
      
      public var hp:int;
      
      public var hpMax:int;
      
      public var mp:int;
      
      public var mpMax:int;
      
      public var memberOrPet:Boolean;
      
      public function MemberVO()
      {
         super();
      }
   }
}

