package com.yiTian.view.modules.tip.tips
{
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.banhui.Vo_BangZF;
   
   public class View_ZFTip extends View_tip
   {
      
      private var tf_name:MyTextField;
      
      private var tf_descript:MyTextField;
      
      private var tf_effect:MyTextField;
      
      public function View_ZFTip()
      {
         super();
      }
      
      override public function Init() : void
      {
         addBorder();
         this.tf_name = ComponentUtil.getTextField("",this,{"x":50});
         this.tf_descript = ComponentUtil.getTextField("",this,{
            "x":10,
            "y":30,
            "width":140,
            "realWidth":140
         });
         this.tf_descript.wordWrap = true;
      }
      
      override public function Show(obj:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         var vo:Vo_BangZF = obj as Vo_BangZF;
         this.tf_name.htmlText = HtmlUtil.font(vo.name,ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),14);
         this.tf_descript.text = vo.descript;
         border.width = 160;
         border.height = this.tf_descript.y + this.tf_descript.height + 5;
      }
   }
}

