package com.yiTian.view.modules.tip.tips.tianMing
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_TianMing;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_TianMing;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.modules.tip.tips.View_tip;
   
   public class View_MyTianMing_Tip extends View_tip
   {
      
      private var titleTF:MyTextField;
      
      private var contentTF:MyTextField;
      
      private var lockTF:MyTextField;
      
      private var bgTF:MyTextField;
      
      private var itemVo:Vo_TianMing;
      
      public function View_MyTianMing_Tip()
      {
         super();
      }
      
      override public function Init() : void
      {
         addBorder();
         this.titleTF = ComponentUtil.getTextField("",this,{
            "y":5,
            "size":14,
            "realWidth":width
         });
         this.titleTF.align = "center";
         this.bgTF = ComponentUtil.getTextField("",this,{
            "x":5,
            "y":28,
            "leading":3
         });
         this.bgTF.multiline = true;
         this.bgTF.htmlText = LangConfig.getWord("80089",8);
         this.contentTF = ComponentUtil.getTextField("",this,{
            "x":70,
            "y":28,
            "leading":3
         });
         this.contentTF.multiline = true;
         this.lockTF = ComponentUtil.getTextField("",this,{
            "x":10,
            "y":30
         });
      }
      
      override public function Show(vo:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         var color:String = null;
         var name:String = null;
         var typeStr:String = null;
         var maxExp:String = null;
         var exp:String = null;
         var value:String = null;
         var MAX:String = null;
         visible = true;
         if(vo == this.itemVo)
         {
            return;
         }
         this.itemVo = vo as Vo_TianMing;
         this.titleTF.text = Enum_TianMing.TIANMINGGRID_TYPE[this.itemVo.gridId];
         if(!this.itemVo.lock)
         {
            this.bgTF.visible = this.contentTF.visible = true;
            this.lockTF.visible = false;
            color = Model_shop.get_color_arr[this.itemVo.color - 1];
            name = "<font color=\'" + color + "\'>" + this.itemVo.str_name + "LV." + this.itemVo.level + "</font>";
            typeStr = Data_lib.attribute[this.itemVo.type_result][0];
            maxExp = this.itemVo.level >= Enum_TianMing.TIANMING_MAXLEVEL ? Data_lib.tmsj[Enum_TianMing.TIANMING_MAXLEVEL][(this.itemVo.id - Enum_TianMing.FIRSTID) % 5] : Data_lib.tmsj[this.itemVo.level + 1][(this.itemVo.id - Enum_TianMing.FIRSTID) % 5];
            if(this.itemVo.color == 6)
            {
               MAX = Data_lib.tmsj[Enum_TianMing.TIANMING_MAXLEVEL][Enum_TianMing.DIJIE];
               maxExp = this.itemVo.level >= Enum_TianMing.TIANMING_MAXLEVEL ? MAX : Data_lib.tmsj[this.itemVo.level + 1][Enum_TianMing.DIJIE];
            }
            exp = "<font color=\'#0099FF\'>" + this.itemVo.exp + "/" + maxExp + "</font>";
            value = "<font color=\'#FFFF00\'>" + typeStr + "+" + this.itemVo.value + "</font>";
            this.contentTF.htmlText = name + "<br>" + exp + "<br>" + value;
            border.width = this.contentTF.x + this.contentTF.width + 5;
            border.height = this.contentTF.y + this.contentTF.height + 5;
         }
         else
         {
            this.bgTF.visible = this.contentTF.visible = false;
            this.lockTF.visible = true;
            this.lockTF.htmlText = LangConfig.getWord("80090",8,Enum_TianMing.OPEN_LEVEL[this.itemVo.gridId]);
            border.width = this.lockTF.x + this.lockTF.width + 10;
            border.height = this.lockTF.y + this.lockTF.height + 15;
         }
         this.titleTF.realWidth = width;
      }
   }
}

