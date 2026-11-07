package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.vo.Vo_Skill;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.cast.CastEffect;
   
   public class SkillHandler
   {
      
      private static var _currentGrade:int;
      
      public function SkillHandler()
      {
         super();
      }
      
      public static function GC_SKILL_QUERY(result:int, skillIds:Array) : void
      {
         var ids:Array = null;
         var len:int = 0;
         var baseJob:int = 0;
         var i:int = 0;
         var skill:Vo_Skill = null;
         var id0:int = 0;
         if(result == 0)
         {
            Utils.print("技能出错");
            return;
         }
         if(result == 1)
         {
            Vo_Skill.data.splice(0);
            ids = [];
            len = int(skillIds.length);
            baseJob = int(Enum_job.getBaseJob(GameUnitManager.hero.job));
            i = 0;
            while(i < len)
            {
               if(Boolean(skillIds[i][0]))
               {
                  skill = new Vo_Skill(skillIds[i][0]);
                  skill.realId = skillIds[i][1];
               }
               else
               {
                  id0 = 30001 + baseJob * 1000 + (i + 1) * 100;
                  skill = new Vo_Skill(id0);
                  skill.realId = int(id0);
                  skill.current_grade = 0;
               }
               skill.gridId = i;
               Vo_Skill.data.push(skill);
               i++;
            }
            UIManager.skillPanel.update();
         }
      }
      
      public static function GC_SKILL_STUDY(result:int, index:int, id:int, realId:int) : void
      {
         var skill:Vo_Skill = null;
         if(result == 1)
         {
            skill = new Vo_Skill(id);
            skill.realId = realId;
            if(index > 0)
            {
               Vo_Skill.data[index - 1] = skill;
               UIManager.skillPanel.updateGrid(index - 1);
            }
            _currentGrade = skill.current_grade;
            if(!Global.skillEffect)
            {
               UIManager.skillPanel.downLoadEffect(getEffect);
            }
            else if(skill.current_grade < 2)
            {
               CastEffect.getSkillEffect("learntSkill",GameScene.popupLayer);
            }
            else
            {
               CastEffect.getSkillEffect("upSkill",GameScene.popupLayer);
            }
            if(GameUnitManager.hero.level < 30 && UIManager.skillPanel.visible)
            {
               UIManager.skillPanel.visible = false;
            }
         }
         else if(result == 2)
         {
            skill = new Vo_Skill(id);
            skill.realId = realId;
            Vo_Skill.data[index - 1] = skill;
            UIManager.skillPanel.updateGrid(index - 1);
            _currentGrade = skill.current_grade;
         }
         else if(result == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("688",0));
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("689",0));
         }
      }
      
      private static function getEffect() : void
      {
         if(_currentGrade < 2)
         {
            CastEffect.getSkillEffect("learntSkill",GameScene.popupLayer);
         }
         else
         {
            CastEffect.getSkillEffect("upSkill",GameScene.popupLayer);
         }
      }
      
      public static function GC_BAR_QUERY(result:int, skillIds:Array) : void
      {
         var i:int = 0;
         if(result == 1)
         {
            i = 0;
            while(i < skillIds.length)
            {
               Vo_Skill.barData[i] = skillIds[i];
               UIManager.mainMenu.setQuick(i,Vo_Skill.getDataById(skillIds[i]));
               UIManager.skillPanel.setQuickSkillVo(i,Vo_Skill.getDataById(skillIds[i]));
               i++;
            }
         }
      }
      
      public static function GC_SET_BAR(result:int, index:Array, ids:Array) : void
      {
         var i:int = 0;
         if(result == 1)
         {
            i = 0;
            while(i < index.length)
            {
               Vo_Skill.barData[index[i] - 1] = ids[i];
               UIManager.mainMenu.setQuick(index[i] - 1,Vo_Skill.getDataById(ids[i]));
               UIManager.skillPanel.setQuickSkillVo(index[i] - 1,Vo_Skill.getDataById(ids[i]));
               i++;
            }
         }
      }
   }
}

