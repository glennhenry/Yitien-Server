package com.yiTian.manager
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_Skill;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.gameUnit.role.BattleUnit;
   import com.yiTian.gameUnit.role.FlyWord;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class BabySkillAdd
   {
      
      private static var effArr:Array = [];
      
      public function BabySkillAdd()
      {
         super();
      }
      
      public static function showActions(_curSkill:Array, hostBattleUnit:BattleUnit, endCal:Function) : void
      {
         hostBattleUnit.showbbAcionts(endCal);
      }
      
      public static function releaseSwfFly(_curSkill:Array, hostBattleUnit:BattleUnit) : void
      {
         var eff:Effect = null;
         var releaseSwf:int = int(_curSkill[Vo_Skill.RELEASE_SWF_EFFECT]);
         var isDown:int = releaseSwf == 35308 ? 0 : 1;
         if(Boolean(releaseSwf))
         {
            eff = hostBattleUnit.addEffect(releaseSwf.toString(),true,0,0,_curSkill[Vo_Skill.EFFECT_TIME] * 40,-1,null,0,isDown);
            effArr.push(eff);
         }
      }
      
      public static function end() : void
      {
         var eff:Effect = null;
         while(Boolean(effArr.length))
         {
            eff = effArr.pop();
            if(Boolean(eff) && Boolean(eff.parent) && eff.parent is BattleUnit)
            {
               (eff.parent as BattleUnit).removeEffect(eff);
            }
            eff = null;
         }
         effArr.splice(0);
      }
      
      public static function patchAtt(hostBattleUnit:BattleUnit, skillId:int) : void
      {
         var n:int = 0;
         var actionUrl:int = int(Data_lib.skill[skillId][Vo_Skill.ACTION]);
         hostBattleUnit.attack(actionUrl,200);
         n = int(setTimeout(function():void
         {
            clearTimeout(n);
            hostBattleUnit.action = Action.STAND;
         },200));
      }
      
      public static function skillNameFly(skillId:int, hostBattleUnit:BattleUnit) : void
      {
         BattleManager.getFlyWord(FlyWord.DRAWSKILLBABY,String(skillId),hostBattleUnit);
      }
   }
}

