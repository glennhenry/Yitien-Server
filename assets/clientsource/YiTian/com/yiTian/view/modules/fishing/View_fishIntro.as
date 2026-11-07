package com.yiTian.view.modules.fishing
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.Panel;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class View_fishIntro extends Panel
   {
      
      private static var instance:View_fishIntro;
      
      private static var isLoad:Boolean = false;
      
      private var title:DisplayObject;
      
      private var tf_content:MyTextField;
      
      private var bg:DisplayObject;
      
      private var isInitB:Boolean = false;
      
      public function View_fishIntro()
      {
         super();
      }
      
      private function initB() : void
      {
         super.initStaticView();
         if(this.isInitB)
         {
            return;
         }
         this.isInitB = true;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":433,
            "height":374
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":29,
            "y":45,
            "width":375,
            "height":315
         },Global.Img_Cdm);
         move = new Rectangle(0,0,433,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":391,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.tf_content = ComponentUtil.getTextField("",this,{
            "x":36,
            "y":58,
            "realWidth":370,
            "size":14,
            "color":14013809,
            "leading":6
         });
         this.tf_content.wordWrap = true;
         this.tf_content.multiline = true;
         this.tf_content.htmlText = LangConfig.getWord("20005",2);
         super.initDynamicView();
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            this.initB();
            if(!Global.Fishing_Imgsdm)
            {
               SingleLoader.add("lang/ch/Fishing_Imgs.swf",function(info:Object):void
               {
                  Global.Fishing_Imgsdm = info.applicationDomain;
                  show();
               });
            }
            else if(!isLoad)
            {
               this.show();
            }
         }
         super.visible = value;
      }
      
      private function show() : void
      {
         ComponentUtil.getBitmap("Title_FishingRule",this,{
            "x":137,
            "y":5
         },Global.Fishing_Imgsdm);
         isLoad = true;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 433) / 2;
         y = (Global.stage.stageHeight - 374) / 2;
      }
   }
}

