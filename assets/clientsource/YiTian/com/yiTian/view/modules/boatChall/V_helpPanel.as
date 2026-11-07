package com.yiTian.view.modules.boatChall
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel;
   import flash.geom.Rectangle;
   
   public class V_helpPanel extends Panel
   {
      
      public function V_helpPanel()
      {
         super();
         init();
      }
      
      public static function get instance() : V_helpPanel
      {
         return Singleton.getInstance(V_helpPanel);
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":498 + 80,
            "height":415 + 40
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":450 + 80,
            "height":365 + 40
         },Global.Img_Cdm);
         ComponentUtil.getTextField("凤舞龙舟",this,{
            "x":250,
            "y":5,
            "size":20,
            "color":16043313
         });
         move = new Rectangle(0,0,433,38);
         var tf:MyTextField = ComponentUtil.getTextField("",this,{
            "x":26,
            "y":50,
            "realWidth":522,
            "color":14013809,
            "multiline":true,
            "wordWrap":true,
            "leading":5
         });
         tf.htmlText = LangConfig.getWord("10670",1);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":464 + 80,
            "y":6
         },Global.Img_Cdm);
         super.initDynamicView();
      }
      
      public function show() : void
      {
         visible = visible || true;
      }
      
      public function hide() : void
      {
         visible = visible && false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

