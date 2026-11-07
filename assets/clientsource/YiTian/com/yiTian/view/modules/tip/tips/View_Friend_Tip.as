package com.yiTian.view.modules.tip.tips
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.vo.Vo_unit;
   import com.yiTian.manager.LangConfig;
   
   public class View_Friend_Tip extends View_tip
   {
      
      private static const BORDER_OFFSET:int = 5;
      
      private static const INFO_OFFSET_X:int = 7;
      
      private var tf_info:MyTextField;
      
      private var data:Vo_unit;
      
      public function View_Friend_Tip()
      {
         super();
      }
      
      override public function Init() : void
      {
         addBorder();
         this.tf_info = ComponentUtil.getTextField("",this,{"bold":true});
         this.tf_info.x = INFO_OFFSET_X;
         this.tf_info.y = BORDER_OFFSET;
      }
      
      override public function Show(vo:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         var areaName:String = null;
         visible = true;
         this.data = vo as Vo_unit;
         if(Boolean(Data_lib.map[this.data.areaid]))
         {
            areaName = Data_lib.map[this.data.areaid][0];
         }
         else
         {
            areaName = "副本中";
         }
         var tmp:String = "<font color =\'#AFB495\'>" + LangConfig.getWord("29108",2) + " ： " + "<font color=\'#f9ff00\'>" + this.data.name + "</font>" + "\n" + LangConfig.getWord("29109",2) + "  ： " + "<font color=\'#D5D57E\'>" + this.data.level.toString() + "</font>" + "\n" + LangConfig.getWord("29110",2) + "  ： " + "<font color=\'#D5D57E\'>" + Enum_job.getJob(this.data.job) + "</font>" + "\n" + LangConfig.getWord("29111",2) + "  ： " + "<font color=\'#D5D57E\'>" + this.data.banghui + "</font>" + "\n" + LangConfig.getWord("29112",2) + "  ： " + "<font color=\'#D5D57E\'>" + areaName + "</font>";
         this.tf_info.htmlText = tmp;
         border.width = BORDER_OFFSET * 3 + this.tf_info.width;
         border.height = BORDER_OFFSET + this.tf_info.y + this.tf_info.height;
      }
   }
}

