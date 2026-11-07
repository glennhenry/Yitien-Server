package com.yiTian.view.modules.jingmaiHang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_mart;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flash.text.TextFormatAlign;
   
   public class View_mart_sold_num extends Panel
   {
      
      private var Button_OK:Button;
      
      private var Button_Cancel:Button;
      
      public var Sold_Number_text:MyTextField;
      
      private var grid:View_Grid;
      
      private var tfSoldWp:MyTextField;
      
      private var tfSoldNum:MyTextField;
      
      private var shape:Shape;
      
      private var back:Sprite;
      
      private var max_num:int;
      
      public function View_mart_sold_num()
      {
         super();
         bindParent = GameScene.popupLayer;
      }
      
      override protected function initStaticView() : void
      {
         GameScene.popupLayer.addChild(this);
         GameScene.popupLayer.setChildIndex(this,GameScene.popupLayer.numChildren - 1);
         this.shape = ComponentUtil.getShape(Global.stage.stageWidth,Global.stage.stageHeight,0,0.2);
         addChildAt(this.shape,0);
         this.back = new Sprite();
         this.back.graphics.beginFill(0,0);
         this.back.graphics.drawRect(0,0,300,197);
         this.back.graphics.endFill();
         addChild(this.back);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.back,{
            "x":0,
            "y":0,
            "width":300,
            "height":197
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.back,{
            "x":24,
            "y":40,
            "width":256,
            "height":120
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this.back,{
            "x":145,
            "y":125,
            "width":60,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_Prompt",this.back,{
            "x":70,
            "y":5
         },Global.Img_Cdm);
         move = new Rectangle(0,0,248,1);
         this.tfSoldWp = ComponentUtil.getTextField("1",this,{
            "x":79.95,
            "y":58.8,
            "textColor":11515029
         });
         this.tfSoldNum = ComponentUtil.getTextField("1",this,{
            "x":79.95,
            "y":95.2,
            "textColor":11515029
         });
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":266,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_OK = ComponentUtil.getButton(LangConfig.getWord("6",0),"Button_Two",this,{
            "x":55,
            "y":129,
            "width":49.05,
            "height":24
         },Global.Img_Cdm);
         this.Button_Cancel = ComponentUtil.getButton(LangConfig.getWord("5",0),"Button_Two",this,{
            "x":145.95,
            "y":129,
            "width":49.05,
            "height":24
         },Global.Img_Cdm);
         this.Sold_Number_text = ComponentUtil.getTextField("1",this,{
            "x":139.4,
            "y":96.2,
            "realWidth":38
         });
         this.Sold_Number_text.type = TextFieldType.INPUT;
         this.Sold_Number_text.align = TextFormatAlign.CENTER;
         this.grid = new View_Grid();
         this.grid.x = 140.7;
         this.grid.y = 50;
         this.grid.set_bmp_bg();
         this.grid.set_bmp_over();
         this.grid.set_bmp_select();
         this.grid.type = Enum_type_grid.MART;
         addChild(this.grid);
         this.Sold_Number_text.maxChars = 3;
         this.Sold_Number_text.restrict = ".0-9";
         Global.focus = this.Sold_Number_text;
         this.Sold_Number_text.addEventListener(Event.CHANGE,this.txtChangeHandle);
         this.Button_OK.addEventListener(MouseEvent.CLICK,this.OKHandle);
         this.Button_Cancel.addEventListener(MouseEvent.CLICK,this.cloHandle);
         CloseButton.addEventListener(MouseEvent.CLICK,this.cloHandle);
      }
      
      public function txtChangeHandle(e:Event) : void
      {
         var temTF:MyTextField = e.target as MyTextField;
         if(Model_mart.martType == 1)
         {
            if(int(temTF.text) >= this.max_num)
            {
               temTF.text = String(this.max_num);
            }
            else if(int(temTF.text) < 1)
            {
               temTF.text = String(1);
            }
         }
         else if(Model_mart.martType == 2)
         {
            if(int(temTF.text) >= 99)
            {
               temTF.text = String(99);
            }
            else if(int(temTF.text) < 1)
            {
               temTF.text = String(1);
            }
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(Model_mart.martType == 1)
            {
               this.tfSoldWp.text = LangConfig.getWord("386",0);
               this.tfSoldNum.text = LangConfig.getWord("387",0);
            }
            else if(Model_mart.martType == 2)
            {
               this.tfSoldWp.text = LangConfig.getWord("388",0);
               this.tfSoldNum.text = LangConfig.getWord("389",0);
            }
         }
      }
      
      public function update_goods(_grid:View_Grid) : void
      {
         this.max_num = _grid.vo.count;
         if(Model_mart.martType == 1)
         {
            this.Sold_Number_text.text = String(_grid.vo.count);
         }
         else if(Model_mart.martType == 2)
         {
            this.Sold_Number_text.text = "1";
         }
         this.grid.vo = _grid.vo;
      }
      
      private function cloHandle(e:MouseEvent) : void
      {
         this.dispose();
      }
      
      private function OKHandle(e:MouseEvent) : void
      {
         this.visible = false;
         UIManager.sold_set.update_vo(this.grid,int(this.Sold_Number_text.text));
      }
      
      public function dispose() : void
      {
         this.visible = false;
      }
      
      override public function resetPosition() : void
      {
         var temX:int = 0;
         var temY:int = 0;
         this.shape.width = Global.stage.stageWidth;
         this.shape.height = Global.stage.stageHeight;
         this.back.x = (Global.stage.stageWidth - this.back.width) / 2;
         this.back.y = (Global.stage.stageHeight - this.back.height) / 2;
         temX = (Global.stage.stageWidth - this.back.width) / 2;
         temY = (Global.stage.stageHeight - this.back.height) / 2;
         this.tfSoldWp.x = temX + 85.95;
         this.tfSoldWp.y = temY + 88.8;
         this.tfSoldNum.x = temX + 85.95;
         this.tfSoldNum.y = temY + 125.2;
         CloseButton.x = temX + 266;
         CloseButton.y = temY + 6;
         this.Button_OK.x = temX + 70;
         this.Button_OK.y = temY + 164;
         this.Button_Cancel.x = temX + 170;
         this.Button_Cancel.y = temY + 164;
         this.Sold_Number_text.x = temX + 157.4;
         this.Sold_Number_text.y = temY + 126.2;
         this.grid.x = temX + 150.7;
         this.grid.y = temY + 80;
      }
   }
}

