package com.yiTian.view.modules.tip.tips
{
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.data.vo.Vo_BangUpdateInfo;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.HtmlUtil;
   import flash.text.TextFieldAutoSize;
   
   public class View_BangHuiUpdateTip extends View_tip
   {
      
      private var tf_mainInfo:MyTextField;
      
      private var tf_buildCond1:MyTextField;
      
      private var tf_needSource1:MyTextField;
      
      private var tf_currentSource1:MyTextField;
      
      private var tf_buildCond2:MyTextField;
      
      private var tf_needSource2:MyTextField;
      
      private var tf_currentSource2:MyTextField;
      
      public function View_BangHuiUpdateTip()
      {
         super();
      }
      
      override public function Init() : void
      {
         addBorder();
         this.tf_mainInfo = ComponentUtil.getTextField("",this,{
            "x":54,
            "y":0
         });
         this.tf_buildCond1 = ComponentUtil.getTextField("",this,{
            "x":4,
            "y":23
         });
         this.tf_needSource1 = ComponentUtil.getTextField("",this,{
            "x":84,
            "y":23
         });
         this.tf_currentSource1 = ComponentUtil.getTextField("",this,{
            "x":164,
            "y":23
         });
         this.tf_buildCond2 = ComponentUtil.getTextField("",this,{
            "x":4,
            "y":45,
            "realWidth":50,
            "height":22
         });
         this.tf_buildCond2.autoSize = TextFieldAutoSize.CENTER;
         this.tf_needSource2 = ComponentUtil.getTextField("",this,{
            "x":84,
            "y":45,
            "realWidth":50,
            "height":22
         });
         this.tf_needSource2.autoSize = TextFieldAutoSize.CENTER;
         this.tf_currentSource2 = ComponentUtil.getTextField("",this,{
            "x":164,
            "y":45,
            "realWidth":50,
            "height":22
         });
         this.tf_currentSource2.autoSize = TextFieldAutoSize.CENTER;
         this.tf_buildCond1.htmlText = HtmlUtil.font(LangConfig.getWord("22616",2),ColorConstant.getColorStr(ColorConstant.BLUE_LIGHT),12);
         this.tf_needSource1.htmlText = HtmlUtil.font(LangConfig.getWord("22617",2),ColorConstant.getColorStr(ColorConstant.BLUE_LIGHT),12);
         this.tf_currentSource1.htmlText = HtmlUtil.font(LangConfig.getWord("22618",2),ColorConstant.getColorStr(ColorConstant.BLUE_LIGHT),12);
      }
      
      override public function Show(obj:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         visible = true;
         var vo:Vo_BangUpdateInfo = obj as Vo_BangUpdateInfo;
         this.tf_mainInfo.htmlText = HtmlUtil.font(vo.mainStr,ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),14);
         this.tf_buildCond2.textColor = 15657165;
         this.tf_needSource2.textColor = 12648254;
         if(vo.needSource > vo.currentSource)
         {
            this.tf_currentSource2.textColor = 13789470;
         }
         else
         {
            this.tf_currentSource2.textColor = 13789470;
         }
         this.tf_buildCond2.text = vo.buildConditionStr;
         this.tf_needSource2.text = vo.needSource.toString();
         this.tf_currentSource2.text = vo.currentSource.toString();
         border.width = 220;
         border.height = 65;
      }
   }
}

