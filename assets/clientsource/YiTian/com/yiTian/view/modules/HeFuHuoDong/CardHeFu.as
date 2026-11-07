package com.yiTian.view.modules.HeFuHuoDong
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.net.message.cg.HeFuHuoDongCGMessage;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class CardHeFu extends Sprite
   {
      
      private var type:int;
      
      public var id:int;
      
      private var btn:Button;
      
      private var selectBitmap:Bitmap;
      
      private var selectArrow:Bitmap;
      
      public function CardHeFu(_type:int, i:int)
      {
         super();
         this.id = i;
         this.type = _type;
         ComponentUtil.getBitmap("Card_Back",this,{
            "x":0,
            "y":0
         },Global.HeFu_Imgsdm);
         ComponentUtil.getBitmap("Day_0" + i,this,{
            "x":24,
            "y":3
         },Global.HeFu_Imgsdm);
         ComponentUtil.getBitmap("grid_ShangCheng",this,{
            "x":16,
            "y":30
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Gift" + i,this,{
            "x":25,
            "y":35
         },Global.HeFu_Imgsdm);
         this.selectArrow = ComponentUtil.getBitmap("Card_Select",this,{
            "x":-2,
            "y":-3
         },Global.HeFu_Imgsdm);
         this.selectBitmap = ComponentUtil.getBitmap("Card_over",this,{
            "x":-2,
            "y":-3
         },Global.HeFu_Imgsdm);
         this.btn = ComponentUtil.getButton("","Button_TwoBule91",this,{
            "x":5,
            "y":103,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn.callBack = this.call;
      }
      
      private function call(e:*) : void
      {
         switch(this.type)
         {
            case 0:
               HeFuHuoDongCGMessage.CG_HeFu_GET(this.id);
               break;
            case 1:
               HeFuHuoDongCGMessage.CG_HuiGui_GET(this.id);
         }
      }
      
      public function set label(flag:int) : void
      {
         if(flag > 0 && flag < 7)
         {
            this.btn.label = "剩余" + flag + "天";
            this.btn.enabled = false;
         }
         else if(flag == 7)
         {
            this.btn.label = "领取";
            this.btn.enabled = true;
         }
         else if(flag == 8)
         {
            this.btn.label = "已领取";
            this.btn.enabled = false;
         }
         else if(flag == -1)
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

