package com.yiTian.view.modules.actions.jiJin
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import flash.display.Sprite;
   
   public class FLItem extends Sprite
   {
      
      private var daySTf:MyTextField;
      
      private var jjTf:MyTextField;
      
      public function FLItem()
      {
         super();
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":0,
            "y":0,
            "width":135,
            "height":19
         },Global.Img_Cdm);
         this.daySTf = ComponentUtil.getTextField("第000天",this,{
            "x":9,
            "y":0,
            "color":11523767,
            "size":12,
            "leading":0
         });
         this.jjTf = ComponentUtil.getTextField("0000基金",this,{
            "x":71,
            "y":0,
            "color":13424242,
            "size":12,
            "leading":0
         });
      }
      
      public function update(dayS:int, _type:int) : void
      {
         if(dayS == 0)
         {
            this.daySTf.text = "当天";
         }
         else
         {
            this.daySTf.text = "第" + dayS + "天";
         }
         var jj:int = int(Data_lib.fundFanLi[dayS][_type - 1]);
         this.jjTf.text = jj + "基金";
      }
   }
}

