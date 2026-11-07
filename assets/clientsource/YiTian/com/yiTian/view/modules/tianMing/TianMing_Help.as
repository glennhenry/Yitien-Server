package com.yiTian.view.modules.tianMing
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_TianMing;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   
   public class TianMing_Help extends Panel123
   {
      
      private static var _instance:TianMing_Help;
      
      private var titleBg:Bitmap;
      
      public function TianMing_Help()
      {
         super();
         init();
      }
      
      public static function get instance() : TianMing_Help
      {
         if(!_instance)
         {
            _instance = new TianMing_Help();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":498,
            "height":300
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":450,
            "height":250
         },Global.Img_Cdm);
         var content:MyTextField = ComponentUtil.getTextField("",this,{
            "x":44,
            "y":50,
            "size":12,
            "leading":6
         });
         content.multiline = true;
         content.htmlText = LangConfig.getWord("80065",8);
         move = new Rectangle(0,0,498,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":464,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(visible)
         {
            if(!Global.TianMing_Imgsdm)
            {
               regResource(Enum_TianMing.TIANMINGSOURCE,"TianMing_Imgsdm");
               preFun();
            }
            else if(!this.titleBg)
            {
               this.initUI2();
            }
         }
      }
      
      override protected function initUI2() : void
      {
         this.titleBg = ComponentUtil.getBitmap("Title_TMJieShao",this,{
            "x":169,
            "y":5
         },Global.TianMing_Imgsdm);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

