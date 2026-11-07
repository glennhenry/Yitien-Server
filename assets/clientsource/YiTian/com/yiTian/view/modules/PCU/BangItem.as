package com.yiTian.view.modules.PCU
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import flash.display.Bitmap;
   
   public class BangItem extends Online_award_item
   {
      
      public function BangItem(id:int)
      {
         ComponentUtil.getScaleBitmap("Back_Green_List",[5,5,1,1],this,{
            "x":0,
            "y":0,
            "width":375,
            "height":58
         },Global.Img_Cdm);
         ComponentUtil.getTextField("帮会在线",this,{
            "x":14,
            "y":10,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(Data_lib.banghuifuli[id - 4][0] + "%",this,{
            "x":27,
            "y":30,
            "color":13424242,
            "size":12,
            "leading":0
         });
         tf = ComponentUtil.getTextField("未符合",this,{
            "x":298,
            "y":19,
            "color":11523767,
            "size":12,
            "leading":0
         });
         btn = ComponentUtil.getButton("领取","Button_TwoBule91",this,{
            "x":272,
            "y":16,
            "textColor":16184781
         },Global.Img_Cdm);
         has_get_bm = new Bitmap();
         has_get_bm.x = 289;
         has_get_bm.y = 18;
         addChild(has_get_bm);
         super(id);
         initGrid(id,73);
      }
   }
}

