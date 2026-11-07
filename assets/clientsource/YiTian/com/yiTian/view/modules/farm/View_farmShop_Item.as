package com.yiTian.view.modules.farm
{
   import com.ui.controls.Button;
   import com.ui.controls.ComboBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.model.Model_treasureChest;
   import com.yiTian.data.vo.Vo_TuanGouItem;
   import com.yiTian.data.vo.Vo_farmStore;
   import com.yiTian.data.vo.Vo_farm_fruit;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class View_farmShop_Item extends Sprite
   {
      
      private var vo:Vo_item;
      
      private var _Vo:Vo_TuanGouItem;
      
      public var grid:View_Grid;
      
      public var buy_Button:Button;
      
      private var Price_text:MyTextField;
      
      public var IconName_text:MyTextField;
      
      public var shop_downList:ComboBox;
      
      public var moneyText:MyTextField;
      
      private var ripeTime:MyTextField;
      
      private var income:MyTextField;
      
      private var Mytext:MyTextField;
      
      private var _price:int;
      
      private var _gridId:int;
      
      private var index:int;
      
      private var sendName:MyTextField;
      
      private var shape:Shape;
      
      private var isFirstOpen:Boolean = true;
      
      public var _textColor:int;
      
      public function View_farmShop_Item()
      {
         super();
         ComponentUtil.getScaleBitmap("ListBack_Bule01",[7,7,1,1],this,{
            "x":0,
            "y":0,
            "width":263,
            "height":88
         },Global.Img_Cdm);
         this.IconName_text = ComponentUtil.getTextField("",this,{
            "x":42.2,
            "y":2.2
         });
         this.Mytext = ComponentUtil.getTextField(LangConfig.getWord("188",9),this,{
            "x":57,
            "y":33,
            "color":14404503,
            "size":12,
            "leading":0
         });
         this.moneyText = ComponentUtil.getTextField("",this,{
            "x":94,
            "y":33,
            "color":16763904,
            "size":11,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("209",9),this,{
            "x":11,
            "y":61,
            "color":14404503,
            "size":12,
            "leading":0
         });
         this.ripeTime = ComponentUtil.getTextField("",this,{
            "x":71,
            "y":61,
            "color":8896312,
            "size":11,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("210",9),this,{
            "x":121,
            "y":61,
            "color":14404503,
            "size":12,
            "leading":0
         });
         this.income = ComponentUtil.getTextField("",this,{
            "x":181,
            "y":61,
            "color":16763904,
            "size":11,
            "leading":0
         });
         this.buy_Button = ComponentUtil.getButton(LangConfig.getWord("58",9),"Button_Two",this,{
            "x":203,
            "y":13,
            "textColor":16184781
         },Global.Img_Cdm);
         this.shape = ComponentUtil.getShape(124,21,997948);
         this.shape.x = 55;
         this.shape.y = 14;
         addChild(this.shape);
         this.shop_downList = new ComboBox([],this.comboxSelectedHd,100,"Button_PageDown","ComboBox_background","xuanze_over",300);
         ComponentUtil.setPropertie(this.shop_downList,{
            "x":55,
            "y":12,
            "width":125,
            "height":21
         });
         addChild(this.shop_downList);
         this.sendName = ComponentUtil.getTextField("",this,{
            "x":57,
            "y":13,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.grid = new View_Grid();
         this.grid.set_bmp_bg();
         this.grid.set_bmp_over();
         this.grid.set_bmp_select();
         this.grid.isAutoLoad = false;
         this.grid.x = 11;
         this.grid.y = 11;
         this.grid.type = Enum_type_grid.STORE;
         this.grid.index = this._gridId;
         addChild(this.grid);
         this.grid.name = (++Model_treasureChest.pos).toString();
         ComponentUtil.getBitmap("CutLine",this,{
            "x":2,
            "y":55
         },Global.ShanZhuang_Imgsdm);
      }
      
      public function update(comboxArr:Array, selected:int) : void
      {
         this.selectedHandle(selected);
         if(comboxArr.length == 1)
         {
            this.sendName.htmlText = comboxArr[0][0];
            this.sendName.color = 3394815;
            this.shape.visible = false;
            this.sendName.visible = true;
            this.shop_downList.visible = false;
         }
         else
         {
            this.shop_downList.source = comboxArr;
            this.shop_downList.select(selected);
            this.sendName.visible = false;
         }
      }
      
      private function comboxSelectedHd(value:Object) : void
      {
         trace(value);
         this.selectedHandle(int(value));
      }
      
      private function selectedHandle(selected:int) : void
      {
         var incomeArr:Array = [];
         if(Boolean(Data_lib.Farm_store[selected]))
         {
            if(GameUnitManager.hero.level >= Data_lib.Farm_store[selected][Vo_farmStore.SEED_LEVEL])
            {
               this.Mytext.visible = true;
               this.moneyText.x = 94;
               if(Data_lib.Farm_store[selected][Vo_farmStore.SEED_PRICETYPE] == 18)
               {
                  if(GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver >= Data_lib.Farm_store[selected][Vo_farmStore.SEED_PRICE])
                  {
                     this.moneyText.textColor = 11904647;
                     this.buy_Button.enabled = true;
                     this.buy_Button.mouseEnabled = true;
                  }
                  else
                  {
                     this.moneyText.textColor = 16711680;
                     this.buy_Button.enabled = false;
                     this.buy_Button.mouseEnabled = false;
                  }
                  this.Mytext.text = LangConfig.getWord("188",9);
                  this.moneyText.text = Data_lib.Farm_store[selected][Vo_farmStore.SEED_PRICE];
               }
               this._price = Data_lib.Farm_store[selected][Vo_farmStore.SEED_PRICE];
            }
            else
            {
               this.moneyText.text = LangConfig.getWord("189",9,Data_lib.Farm_store[selected][Vo_farmStore.SEED_LEVEL]);
               this.moneyText.textColor = 16711680;
               this.moneyText.x = 57;
               this.Mytext.visible = false;
               this.buy_Button.enabled = false;
               this.buy_Button.mouseEnabled = false;
            }
            this.ripeTime.text = Data_lib.Farm_store[selected][Vo_farmStore.RIPE_TIME] / 3600 + LangConfig.getWord("211",9);
            this.ripeTime.visible = true;
            incomeArr = Model_treasureChest.incomeDic[selected];
            this.income.text = Data_lib.farm_fruit[int(incomeArr[0][0])][Vo_farm_fruit.output] + LangConfig.getWord("212",9);
            this.income.visible = true;
         }
         var temItem:Vo_item = new Vo_item();
         temItem.id = selected;
         temItem.Init_lib();
         this.grid.vo = temItem;
         this._textColor = temItem.color;
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
      
      public function set price(_pri:int) : void
      {
         this._price = _pri;
         this.Price_text.text = String(this._price);
      }
      
      public function get price() : int
      {
         return this._price;
      }
      
      public function set gridId(griId:int) : void
      {
         this._gridId = griId;
      }
      
      public function get gridId() : int
      {
         return this._gridId;
      }
      
      override public function set name(value:String) : void
      {
         super.name = value;
         this.IconName_text.textColor = Model_shop.getColorArr[this._textColor - 1];
         this.IconName_text.text = value;
      }
      
      override public function get name() : String
      {
         return super.name;
      }
   }
}

