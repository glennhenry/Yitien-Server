package com.yiTian.view.modules.shenMiShop
{
   import com.ui.containers.list.IListItem;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.SMSCGMessage;
   import com.yiTian.view.comp.View_Grid;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFieldType;
   import flash.text.TextFormatAlign;
   
   public class View_searchItem extends IListItem
   {
      
      private var Button_Buy:Button;
      
      private var DanJia_text:MyTextField;
      
      private var Number_text:MyTextField;
      
      private var Cost_text:MyTextField;
      
      private var Name_text:MyTextField;
      
      private var EnterNumber_text:MyTextField;
      
      private var grid:View_Grid;
      
      private var _data:Object;
      
      private var _type:int;
      
      private var _wpId:int;
      
      private var _index:int;
      
      private var per_price:int;
      
      private var _totalPrice:int;
      
      private var dataNumber:int;
      
      private var boughtNum:int;
      
      private var _leftTime:int;
      
      private var countNum:int = 2;
      
      public function View_searchItem()
      {
         super();
         this.init();
         this.buttonMode = false;
         this.mouseChildren = true;
         addShape();
      }
      
      private function init() : void
      {
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":422,
            "y":11,
            "width":60,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":0,
            "y":43,
            "width":586,
            "height":2
         },Global.Img_Cdm);
         this.Button_Buy = ComponentUtil.getButton(LangConfig.getWord("7",0),"Button_Four",this,{
            "x":495,
            "y":11,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Name_text = ComponentUtil.getTextField(LangConfig.getWord("28",0),this,{
            "x":57,
            "y":12,
            "color":6938422,
            "size":14
         });
         this.DanJia_text = ComponentUtil.getTextField(LangConfig.getWord("26",0),this,{
            "x":162 - 7,
            "y":12,
            "color":14662240,
            "size":14,
            "realWidth":80,
            "align":TextFormatAlign.CENTER,
            "textColor":16043313
         });
         this.Number_text = ComponentUtil.getTextField("99",this,{
            "x":254,
            "y":12,
            "color":11904647,
            "size":14,
            "realWidth":30,
            "align":TextFormatAlign.CENTER
         });
         this.Cost_text = ComponentUtil.getTextField(LangConfig.getWord("27",0),this,{
            "x":315,
            "y":12,
            "color":14662240,
            "size":14,
            "realWidth":95,
            "align":TextFormatAlign.CENTER,
            "textColor":16383744
         });
         this.EnterNumber_text = ComponentUtil.getTextField("000",this,{
            "x":431,
            "y":12,
            "color":11904647,
            "realWidth":44,
            "realHeight":21,
            "size":14
         });
         this.EnterNumber_text.type = TextFieldType.INPUT;
         this.EnterNumber_text.maxChars = 4;
         this.EnterNumber_text.restrict = ".0-9";
         this.EnterNumber_text.align = TextFormatAlign.CENTER;
         this.grid = new View_Grid();
         this.grid.set_bmp_bg();
         this.grid.set_bmp_over(true,null);
         this.grid.x = 13;
         this.grid.y = 3;
         this.grid.type = Enum_type_grid.SHOP;
         addChild(this.grid);
         this.Button_Buy.callBack = this.boughtHandle;
         this.EnterNumber_text.addEventListener(Event.CHANGE,this.changeHandle);
      }
      
      private function setBtn(_value:Boolean) : void
      {
         this.Button_Buy.enabled = _value;
         this.Button_Buy.buttonMode = _value;
      }
      
      override public function set data(value:Object) : void
      {
         var temItem:Vo_item = null;
         var temEquip:Vo_equip = null;
         this._data = value;
         this._wpId = value._vo_id;
         this._type = value._type;
         this._index = value._index;
         this.setBtn(true);
         if(this._type == 1)
         {
            temItem = new Vo_item();
            temItem.id = this._wpId;
            temItem.Init_lib();
            this.grid.vo = temItem;
            this.Name_text.text = temItem.str_name;
            this.Name_text.textColor = Model_shop.getColorArr[temItem.color - 1];
         }
         else if(this._type == 2)
         {
            temEquip = new Vo_equip();
            temEquip.id = this._wpId;
            temEquip.Init_lib();
            this.grid.vo = temEquip;
            this.Name_text.text = temEquip.str_name;
            this.Name_text.textColor = Model_shop.getColorArr[temEquip.color - 1];
         }
         this.per_price = value.price;
         this.DanJia_text.text = String(value.price) + LangConfig.getWord("94",0);
         if(value.totalPrice > GameUnitManager.hero.money)
         {
            this.Cost_text.textColor = 16711680;
         }
         else
         {
            this.Cost_text.textColor = 16043313;
         }
         if(value.num == 0)
         {
            this.Button_Buy.enabled = false;
            this.Button_Buy.buttonMode = false;
         }
         this.Cost_text.text = String(value.totalPrice) + LangConfig.getWord("94",0);
         this._totalPrice = value.totalPrice;
         this.Number_text.text = String(value.num);
         this.dataNumber = value.num;
         this.EnterNumber_text.text = String(value.boughtNum);
         this.boughtNum = value.boughtNum;
      }
      
      private function changeHandle(e:Event) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         var tempNum:int = int(tf.text);
         var temp_total_num:int = int(this.Number_text.text);
         if(tempNum > temp_total_num)
         {
            tempNum = temp_total_num;
         }
         else if(tempNum < 1)
         {
            tempNum = 1;
         }
         if(tempNum * this.per_price > GameUnitManager.hero.money)
         {
            this.Cost_text.textColor = 16711680;
         }
         else
         {
            this.Cost_text.textColor = 16043313;
         }
         this.Cost_text.text = String(tempNum * this.per_price) + LangConfig.getWord("94",0);
         this._totalPrice = tempNum * this.per_price;
         tf.text = String(tempNum);
      }
      
      override public function updata() : void
      {
         this.EnterNumber_text.text = "1";
      }
      
      private function boughtHandle(e:MouseEvent) : void
      {
         var temCost:int = this._totalPrice;
         if(this._totalPrice > GameUnitManager.hero.money)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29",0));
            return;
         }
         var temN:int = CommandManager.get_bag_canUse() - CommandManager.get_bag_used();
         if(Math.ceil(int(this.EnterNumber_text.text) / 99) > temN)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30",0));
            return;
         }
         if(int(this.EnterNumber_text.text) > this.dataNumber)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("31",0));
            return;
         }
         SMSCGMessage.CG_SMS_MUL_BUY(this._wpId,this._type,int(this.EnterNumber_text.text));
      }
      
      override public function get height() : Number
      {
         return 45;
      }
   }
}

