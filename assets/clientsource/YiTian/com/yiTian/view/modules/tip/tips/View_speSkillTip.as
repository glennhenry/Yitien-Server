package com.yiTian.view.modules.tip.tips
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.vo.Vo_Skill;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.HtmlUtil;
   
   public class View_speSkillTip extends View_tip
   {
      
      private static var TFNAME:String;
      
      private static var TFLVL:String;
      
      private static var TFJOB:String;
      
      private var titleTF:MyTextField;
      
      private var tfName:MyTextField;
      
      private var lvl:MyTextField;
      
      private var job:MyTextField;
      
      private var _skill:Vo_Skill;
      
      public function View_speSkillTip()
      {
         super();
      }
      
      override public function Init() : void
      {
         addBorder();
         TFNAME = LangConfig.getWord("60317",6);
         TFLVL = LangConfig.getWord("60318",6);
         TFJOB = LangConfig.getWord("60319",6);
         this.titleTF = ComponentUtil.getTextField(LangConfig.getWord("60320",6),this,{
            "x":30,
            "y":5,
            "color":16742144,
            "size":14,
            "bold":true
         });
         this.tfName = ComponentUtil.getTextField(TFNAME + "",this,{
            "x":9,
            "y":26.5,
            "color":14013822,
            "size":12
         });
         this.lvl = ComponentUtil.getTextField(TFLVL + "",this,{
            "x":9,
            "y":48,
            "color":14013822,
            "wordWrap":true
         });
         this.job = ComponentUtil.getTextField(TFJOB + "",this,{
            "x":9,
            "y":71,
            "realWidth":120,
            "color":14013822
         });
         border.width = 132;
         border.height = 92;
      }
      
      override public function Show(vo:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         visible = true;
         this._skill = vo as Vo_Skill;
         this.tfName.htmlText = TFNAME + HtmlUtil.font(this._skill.str_name,"#ff7700");
         this.lvl.htmlText = TFLVL + HtmlUtil.font(type.toString(),"#ff7700");
         this.job.htmlText = TFJOB + HtmlUtil.font(Enum_job.getJob(int(this._skill.job)),"#ff7700");
         border.width = 132;
         border.height = 92;
      }
   }
}

