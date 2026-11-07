package com.yiTian.view.modules.letter
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flash.text.TextFormatAlign;
   
   public class GoodsNumView extends Panel
   {
      
      private var Button_ok:Button;
      
      private var btnCancel:Button;
      
      private var Button_Num_Up:Button;
      
      private var Button_Num_Down:Button;
      
      private var Enter_Number:MyTextField;
      
      private var enterNumber:int;
      
      private var grid:View_Grid;
      
      public function GoodsNumView()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var back:DisplayObject = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":308,
            "height":170
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":260,
            "height":120
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":144,
            "y":80,
            "width":50,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_PiLiang",this,{
            "x":74,
            "y":5
         },Global.Img_Cdm);
         move = new Rectangle(0,0,back.width,40);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":274,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton.addEventListener(MouseEvent.CLICK,this.cancleHandler);
         ComponentUtil.getTextField(LangConfig.getWord("10230",1),this,{
            "x":121,
            "y":60,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.Button_ok = ComponentUtil.getButton(LangConfig.getWord("10125",1),"Button_Four",this,{
            "x":60,
            "y":120,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_ok.textColor = 14013822;
         this.Button_ok.textOverColor = 14013822;
         this.btnCancel = ComponentUtil.getButton(LangConfig.getWord("10146",1),"Button_Four",this,{
            "x":178,
            "y":120,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btnCancel.addEventListener(MouseEvent.CLICK,this.cancleHandler);
         this.btnCancel.textColor = 14013822;
         this.btnCancel.textOverColor = 14013822;
         this.Button_Num_Up = ComponentUtil.getButton("","Tree_Close",this,{
            "x":198,
            "y":83,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Num_Down = ComponentUtil.getButton("","Tree_Open",this,{
            "x":124,
            "y":83,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Enter_Number = ComponentUtil.getTextField("1",this,{
            "x":150,
            "y":82,
            "color":16184781,
            "realWidth":42
         });
         this.Enter_Number.type = TextFieldType.INPUT;
         this.Enter_Number.restrict = "0-9";
         this.Enter_Number.align = TextFormatAlign.CENTER;
         this.Enter_Number.addEventListener(Event.CHANGE,this.txtChangeHandler);
         this.Button_Num_Up.name = "add";
         this.Button_Num_Down.name = "minus";
         this.Button_Num_Up.addEventListener(MouseEvent.CLICK,this.chanNumHandle);
         this.Button_Num_Down.addEventListener(MouseEvent.CLICK,this.chanNumHandle);
         this.Button_ok.addEventListener(MouseEvent.CLICK,this.okHandler);
         this.grid = new View_Grid();
         this.grid.set_tf_count(true,false,true);
         this.grid.type = Enum_type_grid.NO_DRAG;
         this.grid.set_bmp_bg();
         this.grid.set_bmp_select();
         this.grid.set_bmp_over();
         addChild(this.grid);
         this.grid.x = 62;
         this.grid.y = 65.6;
      }
      
      protected function okHandler(event:MouseEvent) : void
      {
         UIManager.letterEditViewPanel.goodsGrid.count = this.enterNumber;
         UIManager.goodsNumView.visible = false;
      }
      
      protected function cancleHandler(e:MouseEvent) : void
      {
         UIManager.goodsNumView.visible = false;
         UIManager.letterEditViewPanel.clearGoodsGrid();
      }
      
      protected function txtChangeHandler(event:Event) : void
      {
         var max:int = UIManager.letterEditViewPanel.goodsGrid.vo.count;
         this.enterNumber = int(this.Enter_Number.text);
         if(int(this.Enter_Number.text) >= max)
         {
            this.enterNumber = max;
            this.Enter_Number.text = max.toString();
         }
         if(int(this.Enter_Number.text) <= 1)
         {
            this.enterNumber = 1;
            this.Enter_Number.text = "1";
         }
      }
      
      protected function chanNumHandle(e:MouseEvent = null) : void
      {
         var max:int = this.grid.vo.count;
         this.enterNumber = int(this.Enter_Number.text);
         if(e.target.name == "add")
         {
            ++this.enterNumber;
            if(this.enterNumber >= max)
            {
               this.enterNumber = max;
            }
         }
         else if(e.target.name == "minus")
         {
            --this.enterNumber;
            if(this.enterNumber <= 1)
            {
               this.enterNumber = 1;
            }
         }
         this.Enter_Number.text = String(this.enterNumber);
      }
      
      public function reset(vo:Vo_grid) : void
      {
         this.grid.vo = vo;
         this.Enter_Number.text = String(this.grid.vo.count);
         this.enterNumber = this.grid.vo.count;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

