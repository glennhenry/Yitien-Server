package com.yiTian.view.modules.WulinDaHui
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.RadioButton;
   import com.ui.controls.RadioButtonGroup;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.KeyboardManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.text.TextFormatAlign;
   
   public class View_deadthCountPanel extends Panel
   {
      
      private static var isFirstOpen:Boolean = true;
      
      private var checkBoxGroup:RadioButtonGroup;
      
      private var rb_yl:RadioButton;
      
      private var rb_yb:RadioButton;
      
      private var leftTimeTxt:MyTextField;
      
      private var shape:Shape;
      
      private var back:Sprite;
      
      private var scBmp1:ScaleBitmap;
      
      private var scBmp2:ScaleBitmap;
      
      private var titleBm:Bitmap;
      
      public function View_deadthCountPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.back = new Sprite();
         this.back.graphics.beginFill(0,0);
         this.back.graphics.drawRect(0,0,240,170);
         this.back.graphics.endFill();
         addChild(this.back);
         this.scBmp1 = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":300,
            "height":180
         },Global.Img_Cdm);
         this.scBmp2 = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":252,
            "height":130
         },Global.Img_Cdm);
         this.back.visible = false;
         this.leftTimeTxt = ComponentUtil.getTextField("34",this,{
            "x":126.8,
            "y":75,
            "realWidth":100,
            "size":16,
            "bold":true
         });
         this.leftTimeTxt.align = TextFormatAlign.CENTER;
         this.leftTimeTxt.textColor = 16383744;
         this.getCheckBoxGroup();
         this.showB();
         this.shape = ComponentUtil.getShape(Global.stage.stageWidth,Global.stage.stageHeight,0,0.2);
         addChild(this.shape);
      }
      
      private function getCheckBoxGroup() : void
      {
         this.checkBoxGroup = new RadioButtonGroup();
         addChild(this.checkBoxGroup);
         this.checkBoxGroup.x = 92 + (Global.stage.stageWidth - this.back.width) / 2;
         this.checkBoxGroup.y = 131.75 + (Global.stage.stageHeight - this.back.height) / 2;
         this.checkBoxGroup.space = 80;
         this.checkBoxGroup.direction = RadioButtonGroup.HORIZONTAL;
         this.rb_yl = ComponentUtil.getRadioButton(LangConfig.getWord("882",0),"CheckBox",this.checkBoxGroup,{"value":"All"});
         this.rb_yb = ComponentUtil.getRadioButton(LangConfig.getWord("883",0),"CheckBox",this.checkBoxGroup,{"value":"times"});
         this.checkBoxGroup.selectedItem = this.rb_yl;
         this.checkBoxGroup.addEventListener(RadioButtonGroup.SELECTED_CHANGE,function():void
         {
            var value:Object = null;
            if(Boolean(checkBoxGroup.selectedItem))
            {
               value = checkBoxGroup.selectedItem.value;
            }
         });
      }
      
      public function getType() : int
      {
         if(this.checkBoxGroup.selectedItem == this.rb_yl)
         {
            return 1;
         }
         if(this.checkBoxGroup.selectedItem == this.rb_yb)
         {
            return 2;
         }
         return 1;
      }
      
      public function getTxt(_num:int) : void
      {
         this.leftTimeTxt.text = String(_num);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!value)
         {
            if(Boolean(this.leftTimeTxt))
            {
               this.leftTimeTxt.text = "";
            }
            KeyboardManager.isEnabled = true;
         }
         else
         {
            KeyboardManager.isEnabled = false;
         }
      }
      
      private function showB() : void
      {
         this.titleBm = ComponentUtil.getBitmap("Title_FuHuo",this,{
            "x":104 - 24,
            "y":6
         },Global.Img_Cdm);
      }
      
      override public function resetPosition() : void
      {
         var temX:int = 0;
         var temY:int = 0;
         temX = (Global.stage.stageWidth - this.back.width) / 2;
         temY = (Global.stage.stageHeight - this.back.height) / 2;
         this.shape.width = Global.stage.stageWidth;
         this.shape.height = Global.stage.stageHeight;
         this.back.x = temX;
         this.back.y = temY;
         this.leftTimeTxt.x = temX + 94.8;
         this.leftTimeTxt.y = 75 + temY;
         this.scBmp1.x = temX;
         this.scBmp1.y = temY;
         this.scBmp2.x = temX + 24;
         this.scBmp2.y = 40 + temY;
         this.titleBm.x = temX + 104 - 24;
         this.titleBm.y = temY + 6;
         this.checkBoxGroup.x = 82 + temX;
         this.checkBoxGroup.y = 131.75 + temY;
      }
   }
}

