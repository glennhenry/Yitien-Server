package com.yiTian.view.modules.tip.tips
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.modules.team.MemberVO;
   
   public class View_ZhenXing_Tip extends View_tip
   {
      
      private var propertyTF:MyTextField;
      
      private var zhiYeArr:Array;
      
      public function View_ZhenXing_Tip()
      {
         super();
      }
      
      override public function Init() : void
      {
         this.zhiYeArr = [LangConfig.getWord("10036",1),LangConfig.getWord("10037",1),LangConfig.getWord("10038",1),LangConfig.getWord("10039",1)];
         addBorder();
         this.propertyTF = ComponentUtil.getTextField("",this,{
            "x":5,
            "y":5,
            "color":16043313
         });
         this.propertyTF.multiline = true;
      }
      
      override public function Show(vo:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         var mvo:MemberVO = null;
         mvo = vo as MemberVO;
         visible = true;
         if(mvo.memberOrPet)
         {
            this.propertyTF.htmlText = LangConfig.getWord("10583",1,mvo.name,mvo.level,this.zhiYeArr[Enum_job.getBaseJob(mvo.job) - 1],mvo.hp,mvo.hpMax,mvo.mp,mvo.mpMax);
         }
         else
         {
            this.propertyTF.htmlText = LangConfig.getWord("10584",1,mvo.name,mvo.level,mvo.hp,mvo.hpMax);
         }
         this.propertyTF.width = this.propertyTF.textWidth + 20;
         border.width = this.propertyTF.x + this.propertyTF.width + 5;
         border.height = this.propertyTF.y + this.propertyTF.height + 5;
      }
   }
}

