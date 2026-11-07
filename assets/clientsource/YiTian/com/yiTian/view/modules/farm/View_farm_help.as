package com.yiTian.view.modules.farm
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.Panel;
   import flash.geom.Rectangle;
   
   public class View_farm_help extends Panel
   {
      
      private var farmHelp:MyTextField;
      
      private var isLoad:Boolean = false;
      
      public function View_farm_help()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":364,
            "height":473
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":25,
            "y":42,
            "width":314,
            "height":419
         },Global.Img_Cdm);
         move = new Rectangle(0,0,306,36);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":330,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.farmHelp = ComponentUtil.getTextField("",this,{
            "x":35,
            "y":50,
            "color":11904647,
            "size":12,
            "leading":6
         });
         this.farmHelp.multiline = true;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!this.isLoad)
            {
               this.showTl();
               this.isLoad = true;
               this.farmHelp.htmlText = LangConfig.getWord("105",9);
            }
         }
      }
      
      private function showTl() : void
      {
         ComponentUtil.getBitmap("BT_SZBangZu",this,{
            "x":101,
            "y":5
         },Global.ShanZhuang_Imgsdm);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
      }
   }
}

