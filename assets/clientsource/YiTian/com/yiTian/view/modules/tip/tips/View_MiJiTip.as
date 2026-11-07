package com.yiTian.view.modules.tip.tips
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.Data_lib;
   import com.yiTian.view.modules.guangMingDing.Enum_guangMingDing;
   import com.yiTian.view.modules.guangMingDing.Vo_MiJi;
   import flash.display.DisplayObject;
   
   public class View_MiJiTip extends View_tip
   {
      
      public var tf_name:MyTextField;
      
      public var tf_effect:MyTextField;
      
      public var tf_freeRemain:MyTextField;
      
      public var tf_cost:MyTextField;
      
      private var vBorder:Number = 6;
      
      private var hBorder:Number = 6;
      
      public function View_MiJiTip()
      {
         super();
      }
      
      override public function Init() : void
      {
         addBorder();
         this.tf_name = ComponentUtil.getTextField("",this,{
            "x":this.vBorder,
            "y":6,
            "color":65280
         });
         this.tf_effect = ComponentUtil.getTextField("",this,{
            "x":this.vBorder,
            "y":26
         });
         this.tf_freeRemain = ComponentUtil.getTextField("",this,{
            "x":this.vBorder,
            "y":46
         });
         this.tf_cost = ComponentUtil.getTextField("",this,{
            "x":this.vBorder,
            "y":66
         });
      }
      
      override public function Show(obj:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         var lastObj:DisplayObject = null;
         var vo:Vo_MiJi = obj as Vo_MiJi;
         var label:String = Data_lib.Gmd_mj[vo.id][Enum_guangMingDing.LIB_MJ_NAME];
         if(vo.extraType == 1)
         {
            if(vo.isEffecting)
            {
               label += "<font color=\'#33ff33\'>（已启用）</font>";
            }
            else
            {
               label += "<font color=\'#ff3333\'>（未启用）</font>";
            }
         }
         this.tf_name.htmlText = label;
         this.tf_effect.htmlText = "<font color=\'#ffff00\'>效果：</font>" + Data_lib.Gmd_mj[vo.id][Enum_guangMingDing.LIB_MJ_STRDECRIPT];
         lastObj = this.tf_effect;
         if(vo.freeCount >= 0)
         {
            this.tf_freeRemain.htmlText = "<font color=\'#ffff00\'>免费剩余次数：</font>" + vo.freeCount;
            this.tf_cost.htmlText = "<font color=\'#ffff00\'>消耗：</font>" + Data_lib.Gmd_mj[vo.id][Enum_guangMingDing.LIB_MJ_MEMONYCOST] + "元宝";
            lastObj = this.tf_cost;
            this.tf_freeRemain.visible = true;
            this.tf_cost.visible = true;
         }
         else
         {
            this.tf_freeRemain.visible = false;
            this.tf_cost.visible = false;
         }
         border.width = Math.max(this.tf_name.width,this.tf_effect.width,this.tf_freeRemain.width,this.tf_cost.width) + this.vBorder * 2;
         border.height = lastObj.y + lastObj.height + this.hBorder;
      }
   }
}

