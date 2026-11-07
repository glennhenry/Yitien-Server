package com.yiTian.data.vo
{
   public class Vo_Step
   {
      
      public var stepId:int;
      
      public var roleId:Number;
      
      public var hp:int;
      
      public var maxHp:int;
      
      public var mp:int;
      
      public var maxMp:int;
      
      public var skillId:int;
      
      public var bufferids:Array;
      
      public var targets:Array;
      
      public var angry:int;
      
      public function Vo_Step(stepId:int, roleId:Number, hp:int, maxHp:int, mp:int, maxMp:int, skillId:int, bufferids:Array, targets:Array, angry:int)
      {
         super();
         this.stepId = stepId;
         this.roleId = roleId;
         this.hp = hp;
         this.maxHp = maxHp;
         this.mp = mp;
         this.maxMp = maxMp;
         this.skillId = skillId;
         this.bufferids = bufferids;
         this.targets = targets;
         this.angry = angry;
      }
   }
}

