package com.yiTian.view.modules.HeFuHuoDong
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class CardBang extends Sprite
   {
      
      public var id:int;
      
      private var selectBitmap:Bitmap;
      
      private var selectArrow:Bitmap;
      
      public function CardBang(i:int)
      {
         super();
         this.id = i;
         ComponentUtil.getBitmap("Card_Back",this,{
            "x":0,
            "y":0
         },Global.HeFu_Imgsdm);
         ComponentUtil.getBitmap("grid_ShangCheng",this,{
            "x":16,
            "y":46
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Text_Bang_0" + this.id,this,{
            "x":7,
            "y":3
         },Global.HeFu_Imgsdm);
         ComponentUtil.getBitmap("Gift" + (4 - this.id),this,{
            "x":25,
            "y":51
         },Global.HeFu_Imgsdm);
         this.selectArrow = ComponentUtil.getBitmap("Card_Select",this,{
            "x":-2,
            "y":-3
         },Global.HeFu_Imgsdm);
         this.selectBitmap = ComponentUtil.getBitmap("Card_over",this,{
            "x":-2,
            "y":-3
         },Global.HeFu_Imgsdm);
      }
      
      public function set select(value:Boolean) : void
      {
         this.selectBitmap.visible = value;
         this.selectArrow.visible = value;
      }
   }
}

