package com.yiTian.view.modules.jiaoyi
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.KeyboardManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFieldType;
   
   public class View_trans_num extends Panel
   {
      
      private var Button_OK:Button;
      
      private var Minus:Button;
      
      private var Add:Button;
      
      private var GouMaiZongJiaGe_text:MyTextField;
      
      private var WuPinName_text:MyTextField;
      
      public var Number_text:MyTextField;
      
      private var temNum:int = 1;
      
      private var maxNum:int = 1;
      
      private var grid:View_Grid;
      
      private var shape:Shape;
      
      private var back:DisplayObject;
      
      private var container:Sprite;
      
      private var index:int;
      
      private var _type_str:String = "";
      
      private var f:Boolean = true;
      
      public function View_trans_num()
      {
         super();
         bindParent = GameScene.popupLayer;
         GameScene.popupLayer.addChild(this);
      }
      
      override protected function initStaticView() : void
      {
         this.shape = ComponentUtil.getShape(Global.stage.stageWidth,Global.stage.stageHeight,0,0.2);
         addChildAt(this.shape,0);
         this.container = new Sprite();
         addChild(this.container);
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.container,{
            "x":0,
            "y":0,
            "width":328,
            "height":190
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.container,{
            "x":24,
            "y":40,
            "width":280,
            "height":140
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this.container,{
            "x":163,
            "y":97 + 10,
            "width":50,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60148",6),this.container,{
            "x":103,
            "y":97 + 10,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.Button_OK = ComponentUtil.getButton(LangConfig.getWord("6",0),"Button_Four",this.container,{
            "x":134,
            "y":148,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Add = ComponentUtil.getButton("","Button_NumberUp",this.container,{
            "x":218,
            "y":97 + 10,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Minus = ComponentUtil.getButton("","Button_NumberDown",this.container,{
            "x":137,
            "y":97 + 10,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this.container,{
            "x":294,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.WuPinName_text = ComponentUtil.getTextField(LangConfig.getWord("69",0),this.container,{
            "x":148,
            "y":60 + 10,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.Number_text = ComponentUtil.getTextField("99",this.container,{
            "x":133 + 45,
            "y":97 + 10,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.Number_text.type = TextFieldType.INPUT;
         this.Number_text.restrict = ".0-9";
         this.Number_text.maxChars = 2;
         this.Number_text.textColor = 14013822;
         this.Number_text.addEventListener(Event.CHANGE,this.changeHandle);
         this.Add.name = "add";
         this.Minus.name = "minus";
         this.grid = new View_Grid();
         this.grid.set_bmp_bg();
         this.grid.set_bmp_over(true,null);
         this.grid.set_bmp_select();
         this.grid.x = 98;
         this.grid.y = 50 + 10;
         this.grid.type = Enum_type_grid.SHOP;
         this.container.addChild(this.grid);
         this.Add.addEventListener(MouseEvent.CLICK,this.chanHandle);
         this.Minus.addEventListener(MouseEvent.CLICK,this.chanHandle);
         this.Button_OK.addEventListener(MouseEvent.CLICK,this.sureHandle);
      }
      
      private function changeHandle(e:Event) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         if(int(tf.text) > this.maxNum)
         {
            tf.text = String(this.maxNum);
         }
         else if(int(tf.text) < 1)
         {
            tf.text = "1";
         }
         this.temNum = int(tf.text);
      }
      
      public function chanHandle(e:MouseEvent) : void
      {
         if(e.target.name == "add")
         {
            if(this.temNum == this.maxNum)
            {
               return;
            }
            ++this.temNum;
            if(this.temNum >= this.maxNum)
            {
               this.temNum = this.maxNum;
            }
            this.Number_text.text = String(this.temNum);
         }
         else if(e.target.name == "minus")
         {
            if(this.temNum == 1)
            {
               return;
            }
            --this.temNum;
            if(this.temNum <= 1)
            {
               this.temNum = 1;
            }
            this.Number_text.text = String(this.temNum);
         }
      }
      
      public function update(_grid:View_Grid, _index:int = -1, typeStr:String = "") : void
      {
         this.grid.vo = _grid.vo;
         this.index = _index;
         this._type_str = typeStr;
         this.Number_text.text = String(_grid.vo.count);
         this.maxNum = _grid.vo.count;
         this.temNum = _grid.vo.count;
         this.WuPinName_text.textColor = Model_shop.getColorArr[(_grid.vo as Vo_valuable).color - 1];
         this.WuPinName_text.htmlText = _grid.vo.str_name;
      }
      
      private function sureHandle(e:MouseEvent) : void
      {
         this.visible = false;
         if(this._type_str == "check")
         {
            UIManager.trans_chck.update_num(this.grid.vo,int(this.Number_text.text),this.index);
         }
         else
         {
            UIManager.trans_send_panel.update_num(this.grid.vo,int(this.Number_text.text),this.index);
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.f)
            {
               Utils.loadTitle("lang/ch/JiaoYi_Imgs.swf","Title_JYNumber",new Bitmap(),{
                  "x":84,
                  "y":5
               },this.container);
               this.f = false;
            }
            KeyboardManager.isEnabled = false;
            stopDrag();
         }
         else
         {
            KeyboardManager.isEnabled = true;
         }
      }
      
      override public function resetPosition() : void
      {
         this.shape.width = Global.stage.stageWidth;
         this.shape.height = Global.stage.stageHeight;
         this.container.x = (Global.stage.stageWidth - this.container.width) / 2;
         this.container.y = (Global.stage.stageHeight - this.container.height) / 2;
      }
   }
}

