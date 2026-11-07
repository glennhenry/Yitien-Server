package com.yiTian.view.modules.tip.tips.shenBing
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import com.yiTian.view.modules.shenBing.ShenBingUtil;
   import com.yiTian.view.modules.shenBing.Vo_ShenBingSkill;
   import com.yiTian.view.modules.tip.tips.View_tip;
   
   public class View_ShenBingSkillTip extends View_tip
   {
      
      private var _tfLabel:MyTextField;
      
      private var _tfQuality:MyTextField;
      
      private var _tfTriggle:MyTextField;
      
      private var _tfSkillEffection:MyTextField;
      
      public function View_ShenBingSkillTip()
      {
         super();
      }
      
      override public function Init() : void
      {
         addBorder();
         this._tfLabel = ComponentUtil.getTextField("",this,{
            "x":4,
            "y":5,
            "size":14,
            "color":16777011
         });
         this._tfQuality = ComponentUtil.getTextField("",this,{
            "x":4,
            "y":30,
            "wordWrap":true,
            "realWidth":180
         });
         this._tfTriggle = ComponentUtil.getTextField("",this,{
            "x":4,
            "y":50,
            "realWidth":180
         });
         this._tfSkillEffection = ComponentUtil.getTextField("",this,{
            "x":4,
            "y":70,
            "wordWrap":true,
            "realWidth":180
         });
      }
      
      override public function Show(obj:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         var vo:Vo_ShenBingSkill = obj as Vo_ShenBingSkill;
         this._tfLabel.htmlText = vo.str_name;
         if(vo.posType == Vo_ShenBingSkill.PT_IDLE)
         {
            this._tfQuality.htmlText = LangConfig.reTxt("<font color=\'#afe4e4\'>技能品质：</font>{0}{1}",Enum_BroadCastTool.instance.getColorStr(ShenBingUtil.colorLabel[vo.quality],vo.quality),vo.isMaxQuality() ? "<font color=\'#ffaa33\'>（最高品质）</font>" : "");
         }
         else if(vo.posType == Vo_ShenBingSkill.PT_ENABLEDANDVALUE)
         {
            this._tfQuality.htmlText = LangConfig.reTxt("<font color=\'#dddd33\'>神兵</font><font color=\'#ffff33\'>(已激活)</font>\n<font color=\'#afe4e4\'>技能品质：</font>{0}{1}",Enum_BroadCastTool.instance.getColorStr(ShenBingUtil.colorLabel[vo.quality],vo.quality),vo.isMaxQuality() ? "<font color=\'#ffaa33\'>（最高品质）</font>" : "");
         }
         this._tfTriggle.htmlText = LangConfig.reTxt("<font color=\'#afe4e4\'>触发条件：</font>{0}",vo.triggleDiscription);
         this._tfSkillEffection.htmlText = LangConfig.reTxt("<font color=\'#afe4e4\'>技能效果：</font>{0}",vo.discription);
         this._tfTriggle.y = this._tfQuality.y + this._tfQuality.textHeight + 5;
         this._tfSkillEffection.y = this._tfTriggle.y + this._tfTriggle.textHeight + 5;
         border.height = this._tfSkillEffection.y + this._tfSkillEffection.textHeight + 8;
         border.width = Math.max(this._tfTriggle.x + this._tfTriggle.textWidth,this._tfSkillEffection.x + this._tfSkillEffection.textWidth) + 8;
      }
   }
}

