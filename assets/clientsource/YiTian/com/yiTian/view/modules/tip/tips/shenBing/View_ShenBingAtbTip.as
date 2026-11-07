package com.yiTian.view.modules.tip.tips.shenBing
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_lib_attribute;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import com.yiTian.view.modules.shenBing.Enum_ShenBing;
   import com.yiTian.view.modules.shenBing.Vo_ShenBingAtb;
   import com.yiTian.view.modules.tip.tips.View_tip;
   
   public class View_ShenBingAtbTip extends View_tip
   {
      
      private var _tfTitle:MyTextField;
      
      private var _skillTitle:MyTextField;
      
      private var _tfAtb1:MyTextField;
      
      private var _tfSkill:MyTextField;
      
      private var st1s:Array = [];
      
      private var st2s:Array = [];
      
      private var skillStrs:Array = [];
      
      public function View_ShenBingAtbTip()
      {
         super();
      }
      
      override public function Init() : void
      {
         addBorder();
         this._tfTitle = ComponentUtil.getTextField("神兵",this,{
            "x":10,
            "y":7,
            "size":14,
            "color":16777011
         });
         ComponentUtil.getTextField("淬炼属性",this,{
            "x":10,
            "y":30,
            "color":14540083
         });
         this._tfAtb1 = ComponentUtil.getTextField("",this,{"x":10});
         this._skillTitle = ComponentUtil.getTextField("淬炼技能",this,{
            "x":10,
            "y":30,
            "color":14540083
         });
         this._tfSkill = ComponentUtil.getTextField("",this,{"x":10});
      }
      
      override public function Show(obj:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         var vo:Vo_ShenBingAtb = null;
         var id:int = 0;
         var str:String = null;
         var skillName:String = null;
         var skillLevel:int = 0;
         vo = obj as Vo_ShenBingAtb;
         this.st1s.splice(0);
         this.st2s.splice(0);
         this.skillStrs.splice(0);
         var i:int = 0;
         while(i < vo.atbs.length)
         {
            str = Data_lib.attribute[vo.atbs[i]][Enum_lib_attribute.STR_NAME] + "<font color=\'#33ff33\'> + " + vo.atbs[i + 1] + "</font>" + "<font color=\'#f9ff00\'> (+ " + vo.atbs[i + 2] + ")</font>";
            this.st1s.push(str);
            i += 3;
         }
         if(this.st1s.length == 0)
         {
            this.st1s.push("暂无属性加成");
         }
         this._tfAtb1.htmlText = this.st1s.join("\n");
         this._tfAtb1.y = 50;
         this._skillTitle.y = this._tfAtb1.y + this._tfAtb1.textHeight + 10;
         for each(id in vo.skills)
         {
            skillName = Data_lib.sbSkill[id][Enum_ShenBing.SKILL_NAME];
            skillLevel = int(Data_lib.sbSkill[id][Enum_ShenBing.SKILL_QUALITY]);
            this.skillStrs.push(Enum_BroadCastTool.instance.getColorStr(skillName,skillLevel));
         }
         if(this.skillStrs.length == 0)
         {
            this.skillStrs.push("暂无神兵技能");
         }
         this._tfSkill.y = this._skillTitle.y + this._skillTitle.textHeight + 5;
         this._tfSkill.htmlText = this.skillStrs.join("\n");
         border.width = Math.max(this._tfSkill.x + this._tfSkill.textWidth,this._tfAtb1.x + this._tfAtb1.textWidth,115) + 10;
         border.height = this._tfSkill.y + this._tfSkill.textHeight + 10;
      }
   }
}

