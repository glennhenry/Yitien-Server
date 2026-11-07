package com.yiTian.view.modules.map
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.Panel;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   
   public class WorldSendPrompt extends Panel
   {
      
      private static var _instance:WorldSendPrompt;
      
      private var tf_info:MyTextField;
      
      private var btn_ok:Button;
      
      private var btn_cancel:Button;
      
      private var _okCB:Function;
      
      private var bg:ScaleBitmap;
      
      private var checkBox:CheckBox;
      
      public function WorldSendPrompt()
      {
         super();
      }
      
      public static function get instance() : WorldSendPrompt
      {
         if(!_instance)
         {
            _instance = new WorldSendPrompt();
            _instance.init();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         this.bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":310,
            "height":175
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":27,
            "y":45,
            "width":263,
            "height":117
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_Prompt",this,{
            "x":73,
            "y":6
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.bg.width,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":this.bg.width - 30,
            "y":4
         },Global.Img_Cdm);
         this.tf_info = ComponentUtil.getTextField("",this,{
            "y":58,
            "realWidth":this.bg.width
         });
         this.tf_info.htmlText = LangConfig.getWord("10531",1);
         this.tf_info.autoSize = TextFieldAutoSize.CENTER;
         this.btn_ok = ComponentUtil.getButton(LangConfig.getWord("10125",1),"Button_Four",this,{
            "x":77,
            "y":129
         },Global.Img_Cdm);
         this.btn_cancel = ComponentUtil.getButton(LangConfig.getWord("10146",1),"Button_Four",this,{
            "x":167,
            "y":129
         },Global.Img_Cdm);
         this.checkBox = ComponentUtil.getCheckBox(LangConfig.getWord("10532",1),"CheckBox01",this,{
            "x":120,
            "y":95
         },Global.Img_Cdm);
      }
      
      override protected function initDynamicView() : void
      {
         this.btn_ok.callBack = this.okClick;
         this.btn_cancel.callBack = this.hide;
         CloseButton.callBack = this.hide;
      }
      
      public function show(okCB:Function) : void
      {
         this._okCB = okCB;
         this.visible = true;
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.mouseX - this.btn_ok.x - 30;
         y = Global.stage.mouseY - this.btn_ok.y - 10;
      }
      
      private function okClick(evt:MouseEvent) : void
      {
         if(this._okCB != null)
         {
            this._okCB(this.checkBox.selected);
         }
         this.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(!value)
         {
            this._okCB = null;
         }
         super.visible = value;
      }
      
      private function hide(e:MouseEvent = null) : void
      {
         this.visible = false;
      }
   }
}

