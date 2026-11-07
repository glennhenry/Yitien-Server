package com.yiTian.view.modules.banhui
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.Panel;
   import flash.display.DisplayObject;
   import flash.text.TextFieldAutoSize;
   
   public class View_BBIntroduce extends Panel
   {
      
      private var _bg:DisplayObject;
      
      private var _tf_title:MyTextField;
      
      private var _tf_introduce:MyTextField;
      
      public function View_BBIntroduce()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":400,
            "height":286
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":25,
            "y":42,
            "width":350,
            "height":233
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":366,
            "y":5,
            "textColor":16184781
         },Global.Img_Cdm);
         this._tf_title = ComponentUtil.getTextField("",this,{
            "y":7,
            "realWidth":width
         });
         this._tf_title.autoSize = TextFieldAutoSize.CENTER;
         this._tf_title.htmlText = LangConfig.getWord("29066",2);
         this._tf_introduce = ComponentUtil.getTextField("",this,{
            "x":35.3,
            "y":48,
            "realWidth":381.4
         });
         this._tf_introduce.leading = 4;
         this._tf_introduce.multiline = true;
         this._tf_introduce.htmlText = LangConfig.getWord("20004",2);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

