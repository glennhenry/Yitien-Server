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
   
   public class View_TianMing_Tip extends View_tip
   {
      
      private var titleTF:MyTextField;
      
      private var nextTF:MyTextField;
      
      private var contentTF:MyTextField;
      
      private var bgTF:MyTextField;
      
      private var expTianming:Array = [47141,47142,47143,47144,47145];
      
      private var itemVo:Vo_TianMing;
      
      public function View_TianMing_Tip()
      {
         super();
      }
      
      override public function Init() : void
      {
         addBorder();
         this.titleTF = ComponentUtil.getTextField("",this,{
            "x":5,
            "y":5
         });
         this.bgTF = ComponentUtil.getTextField("",this,{
            "x":5,
            "y":28
         });
         this.bgTF.multiline = true;
         this.bgTF.htmlText = LangConfig.getWord("80092",8);
         this.contentTF = ComponentUtil.getTextField("",this,{
            "x":70,
            "y":28
         });
         this.contentTF.multiline = true;
         this.nextTF = ComponentUtil.getTextField("",this,{
            "x":5,
            "y":60,
            "color":16711680
         });
      }
      
      override public function Show(vo:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         var value:String = null;
         var MAX:String = null;
         var levelExp:int = 0;
         var exp1:int = 0;
         var typeStr:String = null;
         visible = true;
         if(vo == this.itemVo)
         {
            return;
         }
         this.itemVo = vo as Vo_TianMing;
         var color:String = Model_shop.get_color_arr[this.itemVo.color - 1];
         this.titleTF.htmlText = "<font color=\'" + color + "\'>" + this.itemVo.str_name + "LV." + this.itemVo.level + "</font>";
         var maxExp:String = this.itemVo.level >= Enum_TianMing.TIANMING_MAXLEVEL ? Data_lib.tmsj[Enum_TianMing.TIANMING_MAXLEVEL][(this.itemVo.id - Enum_TianMing.FIRSTID) % 5] : Data_lib.tmsj[this.itemVo.level + 1][(this.itemVo.id - Enum_TianMing.FIRSTID) % 5];
         if(this.itemVo.color == 6)
         {
            MAX = Data_lib.tmsj[Enum_TianMing.TIANMING_MAXLEVEL][Enum_TianMing.DIJIE];
            maxExp = this.itemVo.level >= Enum_TianMing.TIANMING_MAXLEVEL ? MAX : Data_lib.tmsj[this.itemVo.level + 1][Enum_TianMing.DIJIE];
         }
         var exp:String = "<font color=\'#0099FF\'>" + this.itemVo.exp + "/" + maxExp + "</font>";
         if(this.expTianming.indexOf(this.itemVo.id) != -1)
         {
            this.bgTF.htmlText = "<font color=\'#009900\'>天命经验：<br>被吞噬后可获得天命经验：</font>";
            levelExp = int(Enum_TianMing.TYPE_EXP_EXP[(this.itemVo.id - Enum_TianMing.FIRSTID) % 5]);
            exp1 = this.itemVo.exp + levelExp;
            value = "                   <font color=\'#FFFF00\'>" + exp1 + "点</font>";
         }
         else
         {
            this.bgTF.htmlText = LangConfig.getWord("80092",8);
            typeStr = Data_lib.attribute[this.itemVo.type_result][0];
            value = "<font color=\'#FFFF00\'>" + typeStr + "+" + this.itemVo.value + "</font>";
         }
         this.contentTF.htmlText = exp + "<br>" + value;
         this.nextTF.text = this.itemVo.str_describe;
         var width1:Number = this.nextTF.x + this.nextTF.width;
         var width2:Number = this.contentTF.x + this.contentTF.width;
         border.width = width1 > width2 ? width1 + 5 : width2 + 5;
         if(width2 > width1)
         {
            this.nextTF.x = (border.width - this.nextTF.width) / 2;
         }
         else
         {
            this.nextTF.x = 5;
         }
         border.height = this.nextTF.y + this.nextTF.height + 5;
      }
   }
}

