package com.yiTian.view.modules.chat
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.Panel;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   
   public class View_chatPrompt4 extends Panel
   {
      
      private var tf_info:MyTextField;
      
      private var btn_ok:Button;
      
      private var btn_cancel:Button;
      
      private var _okCB:Function;
      
      private var bg:DisplayObject;
      
      private var checkBox:CheckBox;
      
      public function View_chatPrompt4()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         bindParent = GameScene.sysLayer;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":308,
            "height":185
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":260,
            "height":110
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_Prompt",this,{
            "x":74,
            "y":5
         },Global.Img_Cdm);
         move = new Rectangle(0,0,308,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":274,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.tf_info = ComponentUtil.getTextField("",this,{
            "x":60,
            "y":67,
            "color":16184781,
            "realWidth":188
         });
         this.tf_info.htmlText = "挑战消耗15元宝，是否花费15元宝？";
         this.tf_info.autoSize = TextFieldAutoSize.CENTER;
         this.btn_ok = ComponentUtil.getButton(LangConfig.getWord("29034",2),"Button_Four",this,{
            "x":55,
            "y":152,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_cancel = ComponentUtil.getButton(LangConfig.getWord("29035",2),"Button_Four",this,{
            "x":175,
            "y":152,
            "textColor":16184781
         },Global.Img_Cdm);
         this.checkBox = ComponentUtil.getCheckBox(LangConfig.getWord("29115",2),"CheckBox01",this,{
            "x":120,
            "y":112
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
         if(this.checkBox.selected)
         {
            okCB();
            return;
         }
         this._okCB = okCB;
         this.visible = true;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      private function okClick(evt:MouseEvent) : void
      {
         if(this._okCB != null)
         {
            if(Boolean(this._okCB.length))
            {
               this._okCB(evt);
            }
            else
            {
               this._okCB();
            }
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

