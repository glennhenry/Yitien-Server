package com.yiTian.view.modules.tip.tips
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_Skill;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.HtmlUtil;
   
   public class View_SkillTip extends View_tip
   {
      
      private static var _masterSkillIdS:Array = [31150,31250,31350,32150,32250,32350,33150,33250,33350,34150,34250,34350];
      
      private var _skill:Vo_Skill;
      
      private var _nameTF:MyTextField;
      
      private var _infoTF:MyTextField;
      
      public function View_SkillTip()
      {
         super();
      }
      
      override public function Init() : void
      {
         addBorder();
         this._nameTF = ComponentUtil.getTextField("",this,{
            "x":8,
            "y":5,
            "color":327424,
            "size":16,
            "bold":true,
            "leading":4
         });
         this._infoTF = ComponentUtil.getTextField("",this,{
            "x":8,
            "color":14013822,
            "realWidth":130,
            "wordWrap":true,
            "leading":4
         });
      }
      
      override public function Show(vo:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         var _skill_jiefeng:String = null;
         visible = true;
         if(this._skill == vo)
         {
            return;
         }
         this._skill = vo as Vo_Skill;
         var temSkill:Vo_Skill = type != Enum_type_grid.STATIC_SKILL ? this.getNextSkill(this._skill) : null;
         if(this._skill.current_grade == 0)
         {
            _skill_jiefeng = "";
            if(_masterSkillIdS.indexOf(this._skill.id) != -1)
            {
               if(!this._skill.isDaBiao)
               {
                  _skill_jiefeng = HtmlUtil.font("解封条件：" + this._skill.skill_jiefeng + "\n","#fe0000");
               }
               else
               {
                  _skill_jiefeng = HtmlUtil.font("技能书来源：" + temSkill.special_skill_sour + "\n","#fe0000");
               }
            }
            this._nameTF.htmlText = HtmlUtil.font(this._skill.str_name,"#f4cd31") + HtmlUtil.font(LangConfig.getWord("778",0),"#b21a1a",12);
            this._infoTF.htmlText = HtmlUtil.font(this._skill.str_describe,"#379ae4") + "\n" + HtmlUtil.font(LangConfig.getWord("779",0),"#d5d57e") + HtmlUtil.font(String(this._skill.current_grade + 1),"#ffac00") + "\n" + HtmlUtil.font(LangConfig.getWord("780",0),"#d5d57e") + HtmlUtil.font(this._skill.mp_consume.toString(),"#ffac00") + "\n" + HtmlUtil.font(LangConfig.getWord("781",0),"#d5d57e") + HtmlUtil.font(this._skill.cooltime.toString(),"#ffac00") + "\n" + _skill_jiefeng + HtmlUtil.font(temSkill.effect_description,"#ccff00");
         }
         else
         {
            this._nameTF.htmlText = HtmlUtil.font(this._skill.str_name,"#f4cd31");
            if(this._skill.current_grade >= 10 && type != Enum_type_grid.MASTER_SKILL || type == Enum_type_grid.MASTER_SKILL && this._skill.current_grade >= 20)
            {
               this._nameTF.htmlText = HtmlUtil.font(this._skill.str_name,"#f4cd31") + (type == Enum_type_grid.STATIC_SKILL ? "" : HtmlUtil.font(LangConfig.getWord("782",0),"#00ff00",12));
               this._infoTF.htmlText = HtmlUtil.font(this._skill.str_describe,"#379ae4") + "\n" + (type != Enum_type_grid.STATIC_SKILL ? HtmlUtil.font(LangConfig.getWord("783",0),"#d5d57e") : HtmlUtil.font("技能需求等级：","#d5d57e")) + HtmlUtil.font(String(this._skill.current_grade),"#ffac00") + "\n" + HtmlUtil.font(LangConfig.getWord("780",0),"#d5d57e") + HtmlUtil.font(this._skill.mp_consume.toString(),"#ffac00") + "\n" + HtmlUtil.font(LangConfig.getWord("781",0),"#d5d57e") + HtmlUtil.font(this._skill.cooltime.toString(),"#ffac00") + "\n" + HtmlUtil.font(this._skill.effect_description.toString(),"#ccff00");
            }
            else
            {
               this._infoTF.htmlText = HtmlUtil.font(this._skill.str_describe,"#379ae4") + "\n" + (type != Enum_type_grid.STATIC_SKILL ? LangConfig.getWord("783",0) : HtmlUtil.font("技能需求等级：","#d5d57e")) + HtmlUtil.font(String(this._skill.current_grade),"#ffac00") + "\n" + LangConfig.getWord("780",0) + HtmlUtil.font(this._skill.mp_consume.toString(),"#ffac00") + "\n" + LangConfig.getWord("781",0) + HtmlUtil.font(this._skill.cooltime.toString(),"#ffac00") + "\n" + HtmlUtil.font(this._skill.effect_description.toString(),"#ccff00") + (temSkill != null ? "\n\n" + LangConfig.getWord("779",0) + HtmlUtil.font(String(this._skill.current_grade + 1),"#ffac00") + "\n" + LangConfig.getWord("780",0) + HtmlUtil.font(temSkill.mp_consume.toString(),"#f9ff00") + "\n" + LangConfig.getWord("781",0) + HtmlUtil.font(temSkill.cooltime.toString(),"#f9ff00") + "\n" + HtmlUtil.font(temSkill.effect_description,"#ccff00") : "");
            }
         }
         this._infoTF.y = this._nameTF.y + this._nameTF.textHeight + 3;
         border.width = this._infoTF.width + 13;
         border.height = this._infoTF.y + this._infoTF.height + 5;
      }
      
      private function getNextSkill(_skill_vo:Vo_Skill) : Vo_Skill
      {
         var temVo:Vo_Skill = null;
         if(Boolean(_skill_vo.promo_skill_id))
         {
            temVo = new Vo_Skill(_skill_vo.promo_skill_id);
         }
         else
         {
            temVo = new Vo_Skill(_skill_vo.id);
         }
         return temVo;
      }
   }
}

