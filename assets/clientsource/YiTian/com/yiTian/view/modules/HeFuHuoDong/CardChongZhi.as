package com.yiTian.view.modules.HeFuHuoDong
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.net.message.cg.HeFuHuoDongCGMessage;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class CardChongZhi extends Sprite
   {
      
      public var id:int;
      
      private var btn:Button;
      
      private var selectBitmap:Bitmap;
      
      private var selectArrow:Bitmap;
      
      public function CardChongZhi(i:int)
      {
         super();
         this.id = i;
         ComponentUtil.getBitmap("Card_Back",this,{
            "x":0,
            "y":25
         },Global.HeFu_Imgsdm);
         ComponentUtil.getBitmap("grid_ShangCheng",this,{
            "x":16,
            "y":55
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Gift" + i,this,{
            "x":25,
            "y":60
         },Global.HeFu_Imgsdm);
         ComponentUtil.getBitmap("Chong_0" + i,this,{
            "x":24,
            "y":3
         },Global.HeFu_Imgsdm);
         ComponentUtil.getTextField("充值" + Data_lib.hefuchongzhi[i][0] + "元宝",this,{
            "x":50,
            "y":30,
            "color":11525479,
            "size":12,
            "leading":0
         },"center");
         this.selectArrow = ComponentUtil.getBitmap("Card_Select",this,{
            "x":-2,
            "y":22
         },Global.HeFu_Imgsdm);
         this.selectBitmap = ComponentUtil.getBitmap("Card_over",this,{
            "x":-2,
            "y":22
         },Global.HeFu_Imgsdm);
         this.btn = ComponentUtil.getButton("","Button_TwoBule91",this,{
            "x":5,
            "y":128,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn.callBack = this.call;
      }
      
      private function call(e:*) : void
      {
         HeFuHuoDongCGMessage.CG_ChongZhi_GET(this.id);
      }
      
      public function set label(flag:int) : void
      {
         if(flag == 1)
         {
            this.btn.label = "领取";
            this.btn.enabled = true;
         }
         else if(flag == 2)
         {
            this.btn.label = "已领取";
            this.btn.enabled = false;
         }
         else if(flag == 0)
         {
            this.btn.label = "不符合";
            this.btn.enabled = false;
         }
      }
      
      public function set select(value:Boolean) : void
      {
         this.selectBitmap.visible = value;
         this.selectArrow.visible = value;
      }
   }
}

