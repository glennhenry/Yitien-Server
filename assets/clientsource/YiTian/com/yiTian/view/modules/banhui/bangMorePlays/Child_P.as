package com.yiTian.view.modules.banhui.bangMorePlays
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import flash.display.Sprite;
   
   public class Child_P extends Sprite
   {
      
      public function Child_P()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         ComponentUtil.getBitmap("Back_BangHuiZhan",this,{
            "x":0,
            "y":0
         },Global.Bang_Imgsdm);
         ComponentUtil.getBitmap("Back_FWLZ",this,{
            "x":0,
            "y":190
         },Global.Bang_Imgsdm);
         ComponentUtil.getBitmap("Back_JZLC",this,{
            "x":337,
            "y":190
         },Global.Bang_Imgsdm);
         ComponentUtil.getBitmap("Back_XBTX",this,{
            "x":337,
            "y":0
         },Global.Bang_Imgsdm);
      }
   }
}

