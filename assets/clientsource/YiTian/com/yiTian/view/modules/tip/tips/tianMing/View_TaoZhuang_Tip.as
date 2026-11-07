package com.yiTian.view.modules.tip.tips.tianMing
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_TianMing;
   import com.yiTian.data.model.Model_Tianming;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.handler.TianMingHandler;
   import com.yiTian.view.modules.tip.tips.View_tip;
   import flash.display.DisplayObject;
   
   public class View_TaoZhuang_Tip extends View_tip
   {
      
      private static const BORDER_OFFSET:int = 5;
      
      private static const INFO_OFFSET_X:int = 7;
      
      private var tf_title:MyTextField;
      
      private var tf_info1:MyTextField;
      
      private var tf_info2:MyTextField;
      
      private var line1:DisplayObject;
      
      private var line2:DisplayObject;
      
      public function View_TaoZhuang_Tip()
      {
         super();
      }
      
      override public function Init() : void
      {
         addBorder();
         this.tf_title = ComponentUtil.getTextField(LangConfig.getWord("80091",8),this,{
            "x":INFO_OFFSET_X,
            "y":BORDER_OFFSET,
            "bold":true,
            "color":16763904
         });
         this.tf_info1 = ComponentUtil.getTextField("",this,{
            "x":INFO_OFFSET_X,
            "leading":3
         });
         this.tf_info1.multiline = true;
         this.tf_info2 = ComponentUtil.getTextField("",this,{
            "x":INFO_OFFSET_X,
            "leading":3
         });
         this.tf_info2.multiline = true;
         this.line1 = ComponentUtil.getDisplayObject("Lines",this,{"x":INFO_OFFSET_X});
         this.line2 = ComponentUtil.getDisplayObject("Lines",this,{"x":INFO_OFFSET_X});
      }
      
      override public function Show(obj:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         var data2:Array = null;
         var level:int = int(obj.level);
         var id:int = Math.floor(level / 10);
         if(id == 0)
         {
            id = 1;
         }
         var data1:Array = Data_lib.tftz[id];
         this.tf_info1.htmlText = Model_Tianming.tianFuLevel >= 10 ? TianMingHandler.makeTip(data1,0) : TianMingHandler.makeTip(data1,1);
         if(level >= Enum_TianMing.TAOZHUANG_MAXLEVEL)
         {
            this.tf_info2.htmlText = "<br><font color=\'#FF0000\' size=\'14\'>" + LangConfig.getWord("80106",8) + "</font><br>&nbsp;";
         }
         else
         {
            data2 = Data_lib.tftz[id + 1];
            this.tf_info2.htmlText = TianMingHandler.makeTip(data2,1);
         }
         this.line1.width = this.line2.width = this.tf_info1.width + this.tf_info1.x;
         this.line1.y = this.tf_title.y + this.tf_title.height + 5;
         this.tf_info1.y = this.line1.y + this.line2.height + 5;
         this.line2.width = this.line2.width = this.tf_info1.width + this.tf_info1.x;
         this.line2.y = this.tf_info1.y + this.tf_info1.height + 5;
         this.tf_info2.y = this.line2.y + 5;
         border.width = BORDER_OFFSET * 3 + this.tf_info2.width + 3;
         border.height = BORDER_OFFSET + this.tf_info2.y + this.tf_info2.height;
      }
   }
}

