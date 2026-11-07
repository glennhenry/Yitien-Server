package com.yiTian.view.modules.Shopping
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_store;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.StoreCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFieldType;
   import flash.utils.getTimer;
   import flashx.textLayout.formats.TextAlign;
   
   public class View_StoreYouHui extends Sprite
   {
      
      private var IconName_text:MyTextField;
      
      private var liji_Button:Button;
      
      private var Buy_text:MyTextField;
      
      private var pre:MyTextField;
      
      private var now:MyTextField;
      
      private var leftNum_text:MyTextField;
      
      private var leftTime_text:MyTextField;
      
      private var Button_Num_Up:Button;
      
      private var Button_Num_Down:Button;
      
      public var Enter_Number:MyTextField;
      
      private var _back:DisplayObject;
      
      private var grid:View_Grid;
      
      private var type:int;
      
      public var temNum:int = 1;
      
      private var _wpId:int;
      
      private var _sign:int;
      
      public var _sellPrice:int;
      
      public var _txtColor:int;
      
      private var priceType:int;
      
      public var danWei:String;
      
      private var _leftTime:int;
      
      private var lastTime:int;
      
      public function View_StoreYouHui()
      {
         super();
         this.init();
      }
      
      public function init() : void
      {
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":34,
            "y":131,
            "width":80,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60291",6),this,{
            "x":78,
            "y":33,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60292",6),this,{
            "x":78,
            "y":54,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60293",6),this,{
            "x":15,
            "y":83,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60294",6),this,{
            "x":15,
            "y":106,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.IconName_text = ComponentUtil.getTextField(LangConfig.getWord("119",0),this,{
            "x":79.9,
            "y":10
         });
         this.liji_Button = ComponentUtil.getButton(LangConfig.getWord("131",0),"Button_Orange",this,{
            "x":115,
            "y":131,
            "textColor":16184781
         },Global.Img_Cdm);
         this.pre = ComponentUtil.getTextField("99,999",this,{
            "x":112.55,
            "y":39.85 - 6
         });
         this.now = ComponentUtil.getTextField("99,999",this,{
            "x":112.55,
            "y":59.15 - 6
         });
         this.leftNum_text = ComponentUtil.getTextField("000",this,{
            "x":89.95,
            "y":81
         });
         this.leftNum_text.textColor = 6724095;
         this.leftTime_text = ComponentUtil.getTextField("00:00:00",this,{
            "x":89.35,
            "y":102
         });
         this.leftTime_text.textColor = 6724095;
         this.Button_Num_Up = ComponentUtil.getButton("","Button_NumUp",this,{
            "x":93.85,
            "y":132
         },Global.Img_Cdm);
         this.Button_Num_Down = ComponentUtil.getButton("","Button_NumDown",this,{
            "x":93.85,
            "y":142
         },Global.Img_Cdm);
         this.Button_Num_Up.name = "up";
         this.Button_Num_Down.name = "down";
         this.Button_Num_Up.addEventListener(MouseEvent.CLICK,this.numChangeHandle);
         this.Button_Num_Down.addEventListener(MouseEvent.CLICK,this.numChangeHandle);
         this.Enter_Number = ComponentUtil.getTextField("1",this,{
            "x":46.2,
            "y":133.75,
            "realWidth":38
         });
         this.Enter_Number.align = TextAlign.CENTER;
         this.Enter_Number.maxChars = 2;
         this.Enter_Number.type = TextFieldType.INPUT;
         this.Enter_Number.addEventListener(Event.CHANGE,this.changedHandle);
         this.grid = new View_Grid(true);
         this.grid.type = Enum_type_grid.SHOP;
         this.grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
         this.grid.set_bmp_over(true,View_Grid.GRID_BIGGEST_OVER);
         this.grid.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
         this.grid.x = 10;
         this.grid.y = 10;
         this.grid.type = Enum_type_grid.STORE;
         addChild(this.grid);
         this.liji_Button.textColor = 3394713;
         this.liji_Button.addEventListener(MouseEvent.CLICK,this.buyHandle);
         this.grid.buttonMode = true;
         this.grid.addEventListener(MouseEvent.CLICK,function():void
         {
            liji_Button.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         });
      }
      
      private function changedHandle(e:Event) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         if(int(tf.text) > int(this.leftNum_text.text))
         {
            tf.text = this.leftNum_text.text;
         }
         else if(int(tf.text) < 1)
         {
            tf.text = "1";
         }
      }
      
      private function numChangeHandle(e:MouseEvent) : void
      {
         var temBtn:Button = e.target as Button;
         if(temBtn.name == "up")
         {
            ++this.temNum;
            if(this.temNum > int(this.leftNum_text.text))
            {
               this.temNum = int(this.leftNum_text.text);
            }
         }
         else
         {
            --this.temNum;
            if(this.temNum < 1)
            {
               this.temNum = 1;
            }
         }
         this.Enter_Number.text = String(this.temNum);
         if(UIManager.storeTip.visible)
         {
            UIManager.storeTip.update(this._wpId,int(this.Enter_Number.text),this._sign,this.priceType,this._sellPrice,int(this.leftNum_text.text),this.type,this.IconName_text.text);
         }
      }
      
      private function buyHandle(e:MouseEvent) : void
      {
         if(!UIManager.storeTip.visible)
         {
            UIManager.storeTip.visible = true;
         }
         UIManager.storeTip.update(this._wpId,int(this.Enter_Number.text),this._sign,this.priceType,this._sellPrice,int(this.leftNum_text.text),this.type,this.IconName_text.text);
      }
      
      public function set wpName(str:String) : void
      {
         this.IconName_text.text = str;
         this.IconName_text.textColor = Model_shop.getColorArr[this._txtColor - 1];
      }
      
      private function set pre_price(_pre:int) : void
      {
         if(this.priceType == 16000)
         {
            this.danWei = LangConfig.getWord("21",0);
         }
         else if(this.priceType == 17000)
         {
            this.danWei = LangConfig.getWord("39",0);
         }
         else if(this.priceType == 18000)
         {
            this.danWei = LangConfig.getWord("124",0);
         }
         this.pre.htmlText = HtmlUtil.font(Utils.getGapNum(String(_pre)),"#f9ff00") + " " + this.danWei;
         var spri:Shape = new Shape();
         spri.graphics.lineStyle(2,16383744,1);
         spri.graphics.moveTo(this.pre.x + 1,this.pre.y + 8);
         spri.graphics.lineTo(this.pre.x + this.pre.width - 29,this.pre.y + this.pre.height - 8);
         addChild(spri);
      }
      
      private function set now_price(_now:int) : void
      {
         this.now.htmlText = HtmlUtil.font(Utils.getGapNum(String(_now)),"#f9ff00") + " " + this.danWei;
         this._sellPrice = _now;
      }
      
      public function set leftNum(_lfNum:int) : void
      {
         this.leftNum_text.text = String(_lfNum);
         this.Enter_Number.text = "1";
         this.temNum = 1;
      }
      
      public function update_num(bought_num:int) : void
      {
         this.leftNum_text.text = String(int(this.leftNum_text.text) - bought_num);
         this.temNum = 1;
         this.Enter_Number.text = "1";
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            GameScene.instance.addFrameCallBack(this.frameHandle);
         }
         else
         {
            GameScene.instance.removeFrameCallBack(this.frameHandle);
         }
      }
      
      private function set leftTime(_lfTime:int) : void
      {
         this._leftTime = _lfTime;
         this.leftTime_text.text = String(DateUtil.getMSBySecond2(_lfTime));
      }
      
      public function frameHandle(interval:int) : void
      {
         var now:int = getTimer();
         if(now - this.lastTime >= 1000)
         {
            --this._leftTime;
            this.leftTime_text.text = String(DateUtil.getMSBySecond2(this._leftTime));
            this.lastTime = now;
         }
         if(this._leftTime == 0)
         {
            StoreCGMessage.CG_PLAZA(6);
            GameScene.instance.removeFrameCallBack(this.frameHandle);
         }
      }
      
      public function update(vo_tem_item_equit:Vo_valuable, vo_temStore:Vo_store, _type:int) : void
      {
         this.grid.vo = vo_tem_item_equit;
         this._txtColor = vo_tem_item_equit.color;
         this.IconName_text.textColor = Model_shop.getColorArr[this._txtColor - 1];
         this.IconName_text.text = vo_tem_item_equit.str_name;
         this.type = _type;
         this.priceType = vo_temStore.price_type;
         this.pre_price = vo_temStore.pre_price;
         this.now_price = vo_temStore.now_price;
         this.leftNum_text.text = String(vo_temStore.sold_num);
         this.leftTime = vo_temStore.left_time;
         this._wpId = vo_temStore.wpid;
         this._sign = vo_temStore.sign;
         if(vo_temStore.sold_num == 0)
         {
            this.liji_Button.enabled = false;
            this.liji_Button.mouseEnabled = false;
            this.liji_Button.useHandCursor = false;
         }
         else
         {
            this.liji_Button.enabled = true;
            this.liji_Button.mouseEnabled = true;
            this.liji_Button.useHandCursor = true;
         }
      }
   }
}

