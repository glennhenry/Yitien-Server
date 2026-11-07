package com.yiTian.view.modules.activity.kaifuItem.tuangou
{
   public class AcitivityVo
   {
      
      public static var idIndex:int;
      
      public static var awardIndex:int;
      
      public static var HAS_HORSE:Boolean;
      
      public var id:int;
      
      public var allConditionDes:Array;
      
      public var allConditionStatus:Array;
      
      public var allConditionReward:Array;
      
      public var allConditionDes1:Array;
      
      public function AcitivityVo(id:int)
      {
         super();
         this.id = id;
         this.allConditionDes = [];
         this.allConditionStatus = [];
         this.allConditionReward = [];
         this.allConditionDes = [];
      }
   }
}

