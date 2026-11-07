package com.yiTian.view.modules.Shopping
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.model.Model_store;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFieldType;
   import flashx.textLayout.formats.TextAlign;
   
   public class View_shoppingItem extends Sprite
   {
      
      private var buy_Button:Button;
      
      private var YB_text:MyTextField;
      
      private var Buy_text:MyTextField;
      
      private var IconName_text:MyTextField;
      
      private var Price_text:MyTextField;
      
      private var back:DisplayObject;
      
      private var Button_Num_Up:Button;
      
      private var Button_Num_Down:Button;
      
      public var Enter_Number:MyTextField;
      
      private var _back:DisplayObject;
      
      public var grid:View_Grid;
      
      private var isFirstOpen:Boolean = true;
      
      public var temNum:int = 1;
      
      public var _wpId:int;
      
      public var _sign:int;
      
      public var _sellprice:int;
      
      public var type:int;
      
      public var _textColor:int;
      
      public var priceType:int;
      
      public var danWei:String;
      
      private var _sellPrice:int;
      
      public function View_shoppingItem()
      {
         super();
         this.init();
      }
      
      public function init() : void
      {
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":0,
            "y":0,
            "width":185,
            "height":75
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":73,
            "y":45,
            "width":60,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60289",6),this,{
            "x":73,
            "y":24,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.buy_Button = ComponentUtil.getButton(LangConfig.getWord("7",0),"Button_Two",this,{
            "x":135,
            "y":45,
            "textColor":16184781
         },Global.Img_Cdm);
         this.IconName_text = ComponentUtil.getTextField(LangConfig.getWord("119",0),this,{
            "x":73,
            "y":4,
            "color":3644132
         });
         this.Price_text = ComponentUtil.getTextField("99,999",this,{
            "x":108,
            "y":24,
            "color":14662240
         });
         this.Button_Num_Up = ComponentUtil.getButton("","Button_NumUp",this,{
            "x":113.35,
            "y":46
         },Global.Img_Cdm);
         this.Button_Num_Down = ComponentUtil.getButton("","Button_NumDown",this,{
            "x":113.35,
            "y":56
         },Global.Img_Cdm);
         this.Button_Num_Up.name = "up";
         this.Button_Num_Down.name = "down";
         this.Button_Num_Up.addEventListener(MouseEvent.CLICK,this.numChangeHandle);
         this.Button_Num_Down.addEventListener(MouseEvent.CLICK,this.numChangeHandle);
         this.Enter_Number = ComponentUtil.getTextField("1",this,{
            "x":78,
            "y":47,
            "color":14662240,
            "realWidth":38
         });
         this.Enter_Number.align = TextAlign.CENTER;
         this.Enter_Number.maxChars = 3;
         this.Enter_Number.type = TextFieldType.INPUT;
         this.Enter_Number.addEventListener(Event.CHANGE,this.changedHandle);
         this.grid = new View_Grid(true);
         this.grid.type = Enum_type_grid.SHOP;
         this.grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
         this.grid.set_bmp_over(true,View_Grid.GRID_BIGGEST_OVER);
         this.grid.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
         this.grid.isAutoLoad = false;
         this.grid.x = 5;
         this.grid.y = 5;
         this.grid.type = Enum_type_grid.STORE;
         addChild(this.grid);
         this.buy_Button.textColor = 3394713;
         this.buy_Button.addEventListener(MouseEvent.CLICK,this.buyHandle);
         this.grid.buttonMode = true;
         this.grid.addEventListener(MouseEvent.CLICK,function():void
         {
            buy_Button.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         });
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.isFirstOpen)
            {
               this.setGridLoad();
               this.isFirstOpen = false;
            }
         }
      }
      
      public function setGridLoad() : void
      {
         this.grid.isAutoLoad = true;
         this.grid.beginLoad();
      }
      
      private function changedHandle(e:Event) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         if(int(tf.text) > 99)
         {
            tf.text = "99";
         }
         else if(int(tf.text) < 1)
         {
            tf.text = "1";
         }
         this.temNum = int(tf.text);
      }
      
      private function numChangeHandle(e:MouseEvent) : void
      {
         var temBtn:Button = e.target as Button;
         if(temBtn.name == "up")
         {
            ++this.temNum;
            if(this.temNum > 99)
            {
               this.temNum = 99;
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
      }
      
      public function buyHandle(e:MouseEvent = null) : void
      {
         var temId:int = 0;
         var temVoItem:Vo_item = null;
         var _price_type:int = int(this.priceType / 1000);
         var buy_num:int = int(this.Enter_Number.text);
         if(_price_type == 16)
         {
            if(buy_num * this._sellPrice > GameUnitManager.hero.money)
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("9",0) + "</font></a>");
               return;
            }
         }
         else if(_price_type == 17)
         {
            if(buy_num * this._sellPrice > GameUnitManager.hero.liquan)
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("120",0) + "</font></a>");
               return;
            }
         }
         else if(_price_type == 18)
         {
            if(buy_num * this._sellPrice > GameUnitManager.hero.silver)
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("97",0) + "</font></a>");
               return;
            }
         }
         else if(_price_type == 21)
         {
            if(buy_num * this._sellPrice > GameUnitManager.hero.prestige)
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("121",0) + "</font></a>");
               return;
            }
         }
         else if(Model_store.getCount(_price_type) < buy_num * this._sellPrice)
         {
            temId = _price_type;
            temVoItem = new Vo_item();
            temVoItem.id = temId;
            temVoItem.Init_lib();
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("122",0) + temVoItem.str_name + LangConfig.getWord("123",0));
            return;
         }
         if(!UIManager.storeTip.visible)
         {
            UIManager.storeTip.visible = true;
         }
         UIManager.storeTip.update(this._wpId,int(this.Enter_Number.text),this._sign,this.priceType,this._sellPrice,9999,this.type,this.IconName_text.text);
      }
      
      public function set wpName(str:String) : void
      {
         this.IconName_text.text = str;
         this.IconName_text.textColor = Model_shop.getColorArr[this._textColor - 1];
      }
      
      public function set price(_price:int) : void
      {
         var temObj:Object = null;
         if(this._sign == 4)
         {
            temObj = this.getName(this.priceType);
            this._sellPrice = _price;
            this.Price_text.htmlText = HtmlUtil.font(String(_price),"#f9ff00") + "" + HtmlUtil.font(temObj.name,Model_shop.get_color_arr[temObj.color - 1]);
            return;
         }
         this._sellprice = _price;
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
         else if(this.priceType == 21000)
         {
            this.danWei = LangConfig.getWord("125",0);
         }
         this._sellPrice = _price;
         this.Price_text.htmlText = HtmlUtil.font(Utils.getGapNum(String(_price)),"#f9ff00") + " " + this.danWei;
      }
      
      public function getName(_price_type:int) : Object
      {
         var tem_vo_item:Vo_item = null;
         var tem_vo_equip:Vo_equip = null;
         var _obj:Object = new Object();
         _obj.name = "";
         _obj.color = 0;
         if(int(this.priceType % 1000) == 1 || int(this.priceType % 1000) == 0)
         {
            tem_vo_item = new Vo_item();
            tem_vo_item.id = int(this.priceType / 1000);
            tem_vo_item.Init_lib();
            _obj.name = tem_vo_item.str_name;
            _obj.color = tem_vo_item.color;
         }
         else if(int(this.priceType % 1000) == 2)
         {
            tem_vo_equip = new Vo_equip();
            tem_vo_equip.id = int(this.priceType / 1000);
            tem_vo_equip.Init_lib();
            _obj.name = tem_vo_equip.str_name;
            _obj.color = tem_vo_equip.color;
         }
         return _obj;
      }
   }
}

