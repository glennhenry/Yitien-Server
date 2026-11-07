package com.yiTian.view.modules.PCU
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import flash.display.Bitmap;
   
   public class OnlineItem extends Online_award_item
   {
      
      public function OnlineItem(id:int)
      {
         ComponentUtil.getScaleBitmap("Back_Green_List",[5,5,1,1],this,{
            "x":0,
            "y":0,
            "width":317,
            "height":58
         },Global.Img_Cdm);
         tf = ComponentUtil.getTextField("未符合",this,{
            "x":240,
            "y":19,
            "color":11523767,
            "size":12,
            "leading":0
         });
         btn = ComponentUtil.getButton("领取","Button_TwoBule91",this,{
            "x":214,
            "y":16,
            "textColor":16184781
         },Global.Img_Cdm);
         has_get_bm = new Bitmap();
         has_get_bm.x = 231;
         has_get_bm.y = 18;
         addChild(has_get_bm);
         super(id);
         initGrid(id,14);
      }
   }
}

