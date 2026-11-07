package com.yiTian.data.vo
{
   public class Vo_battle_lib_data
   {
      
      public var battleId:Number;
      
      public var type:int;
      
      public var selfZF:int;
      
      public var targetZF:int;
      
      public var units:Array;
      
      public var steps:Array;
      
      public var isWin:int;
      
      public var isReplay:Boolean = false;
      
      public var roundStartMap:Object;
      
      public var babySkill:String;
      
      public function Vo_battle_lib_data()
      {
         super();
      }
      
      public function clone() : Vo_battle_lib_data
      {
         var vo:Vo_battle_lib_data = new Vo_battle_lib_data();
         vo.battleId = this.battleId;
         vo.type = this.type;
         vo.selfZF = this.selfZF;
         vo.targetZF = this.targetZF;
         vo.units = this.units.concat();
         vo.steps = this.steps.concat();
         vo.isWin = this.isWin;
         vo.roundStartMap = this.roundStartMap;
         vo.babySkill = this.babySkill;
         return vo;
      }
   }
}

