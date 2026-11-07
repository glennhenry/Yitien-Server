package com.yiTian.view.modules.Shopping
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_jingJiChang;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.model.Model_store;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FundCGMessage;
   import com.yiTian.net.message.cg.JingJiChangCGMessage;
   import com.yiTian.net.message.cg.StoreCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.KFHomeland.HomeLandCGMessage;
   import com.yiTian.view.modules.actions.jiJin.FundMter;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFormatAlign;
   
   public class View_tishi extends Panel
   {
      
      private var Button_No:Button;
      
      private var Button_Yes:Button;
      
      public var Imformate_text:MyTextField;
      
      private var Imformate1_text:MyTextField;
      
      public var price:int;
      
      public var danwei:Array = new Array();
      
      public var _roleId:Number;
      
      public var _pai_ming:int;
      
      public var _nameStr:String;
      
      public var _type:String;
      
      public var temPay:int = 25;
      
      private var wp_id:int;
      
      public var tiaoZhan_cost:int;
      
      public var wpid:int;
      
      private var bought_num:int;
      
      private var sign:int;
      
      public var isStore_youhui:Boolean = false;
      
      public var isStore:Boolean = false;
      
      private var ty_pe:int;
      
      private var sold_price:int;
      
      public var _price_type:int;
      
      private var left_num:int;
      
      private var wp_type:int;
      
      private var need_wp_id:int;
      
      public function View_tishi()
      {
         super();
         bindParent = GameScene.popupLayer;
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":348,
            "height":179
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":29,
            "y":45,
            "width":290,
            "height":120
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_Prompt",this,{
            "x":94,
            "y":5
         },Global.Img_Cdm);
         move = new Rectangle(0,0,286,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":314,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_No = ComponentUtil.getButton(LangConfig.getWord("5",0),"Button_Four",this,{
            "x":210,
            "y":115,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Yes = ComponentUtil.getButton(LangConfig.getWord("6",0),"Button_Four",this,{
            "x":65,
            "y":115,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Imformate_text = ComponentUtil.getTextField(LangConfig.getWord("132",0) + String(this.bought_num) + LangConfig.getWord("133",0) + String(this.price) + LangConfig.getWord("134",0),this,{
            "x":52,
            "y":72,
            "color":16184781,
            "realWidth":245,
            "multiline":true,
            "wordWrap":true,
            "leading":6
         });
         GameScene.popupLayer.addChild(this);
         this.Imformate_text.align = TextFormatAlign.CENTER;
         this.Button_No.addEventListener(MouseEvent.CLICK,this.cloHandle);
         this.Button_Yes.addEventListener(MouseEvent.CLICK,this.coolTHandle);
         super.CloseButton.addEventListener(MouseEvent.CLICK,this.cloHandle);
      }
      
      private function cloHandle(e:MouseEvent) : void
      {
         this.reset();
      }
      
      public function reset() : void
      {
         this.visible = false;
         this.isStore_youhui = false;
         this.isStore = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!value)
         {
            this.isStore_youhui = false;
            this.isStore = false;
         }
         else
         {
            this.setDanWei();
         }
      }
      
      private function setDanWei() : void
      {
         this.danwei = [LangConfig.getWord("21",0),LangConfig.getWord("39",0),LangConfig.getWord("124",0),LangConfig.getWord("143",0),LangConfig.getWord("143",0),LangConfig.getWord("144",0),"积分","基金"];
      }
      
      private function coolTHandle(e:MouseEvent) : void
      {
         var num:int = 0;
         var can_use_grid:int = 0;
         var temVo:Vo_item = null;
         if(this.wpid == 987654)
         {
            HomeLandCGMessage.CG_ASK_SURE_GET(this.bought_num,0);
            this.visible = false;
            this.wpid = 0;
            return;
         }
         if(this._price_type == 23)
         {
            num = CommandManager.get_bag_canUse() - CommandManager.get_bag_used();
            if(num == 0)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10",0));
               return;
            }
            FundMter.fundOwn -= this.bought_num * this.sold_price;
            FundCGMessage.CG_FUND_PAY(this.wpid,this.bought_num);
            this.visible = false;
            return;
         }
         if(this.isStore_youhui || this.isStore)
         {
            can_use_grid = CommandManager.get_bag_canUse() - CommandManager.get_bag_used();
            if(this._price_type == 16)
            {
               if(can_use_grid == 0)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("135",0));
                  return;
               }
               if(this.bought_num * this.sold_price > GameUnitManager.hero.money)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("9",0));
                  return;
               }
            }
            else if(this._price_type == 17)
            {
               if(can_use_grid == 0)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("135",0));
                  return;
               }
               if(this.bought_num * this.sold_price > GameUnitManager.hero.liquan)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("120",0));
                  return;
               }
            }
            else if(this._price_type == 18)
            {
               if(can_use_grid == 0)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("135",0));
                  return;
               }
               if(this.bought_num * this.sold_price > GameUnitManager.hero.silver)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("97",0));
                  return;
               }
            }
            else if(this._price_type == -1)
            {
               if(can_use_grid < this.bought_num)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("135",0));
                  return;
               }
               if(Model_store.getCount(this.need_wp_id) < this.bought_num * this.sold_price)
               {
                  temVo = new Vo_item();
                  temVo.id = this.need_wp_id;
                  temVo.Init_lib();
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("122",0) + temVo.str_name + LangConfig.getWord("123",0));
                  return;
               }
            }
            StoreCGMessage.CG_BUY_GOODS(this.wpid,this.bought_num,this.sign);
            if(this.isStore_youhui)
            {
               UIManager.shoppingMall.youHuiItem_arr[int(this.ty_pe % 2)].update_num(this.bought_num);
               StoreCGMessage.CG_PLAZA(6);
            }
            else if(this.isStore)
            {
               UIManager.shoppingMall.dataItem_arr[int(this.ty_pe % 12)].Enter_Number.text = "1";
               UIManager.shoppingMall.dataItem_arr[int(this.ty_pe % 12)].temNum = 1;
            }
            this.reset();
            return;
         }
         if(this.Imformate_text.text == LangConfig.getWord("136",0) + String(20) + LangConfig.getWord("137",0))
         {
            UIManager.jjc_panel.RYPaiMing_text.text = "1";
         }
         if(this._type == LangConfig.getWord("138",0))
         {
            if(GameUnitManager.hero.money < this.tiaoZhan_cost)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("139",0));
               return;
            }
            JingJiChangCGMessage.CG_DEKARON(this._roleId,this._pai_ming,this._nameStr);
            --Model_jingJiChang.canWar;
            UIManager.jjc_panel.TXChiShu_text.text = String(Model_jingJiChang.canWar);
            this.visible = false;
         }
         else if(this._type == LangConfig.getWord("140",0))
         {
            if(!visible)
            {
               this.visible = true;
            }
            this.tiaoZhan_cost = 35;
            this.Imformate_text.text = LangConfig.getWord("136",0) + String(20) + LangConfig.getWord("137",0);
            this._type = LangConfig.getWord("141",0);
         }
         else if(this._type == LangConfig.getWord("141",0))
         {
            if(GameUnitManager.hero.money < this.tiaoZhan_cost)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("139",0));
               return;
            }
            JingJiChangCGMessage.CG_DEKARON_RANDOM(this._pai_ming);
            --Model_jingJiChang.canWar;
            UIManager.jjc_panel.TXChiShu_text.text = String(Model_jingJiChang.canWar);
            this.visible = false;
         }
      }
      
      public function update(_wpId:int, _num:int, _sign:int, priceType:int, _sellPrice:int, leftNum:int, type:int, name_str:String) : void
      {
         var temVo:Vo_item = null;
         var temEo:Vo_equip = null;
         if(_wpId == 987654)
         {
            this.wpid = _wpId;
            this.bought_num = _num;
            this.Imformate_text.x = 52;
            this.Imformate_text.y = 62;
            this.Imformate_text.htmlText = name_str;
            return;
         }
         this.Imformate_text.x = 52;
         this.Imformate_text.y = 72;
         this.ty_pe = type;
         this.wpid = _wpId;
         this.bought_num = _num;
         this.sign = _sign;
         if(this.sign != 6)
         {
            this.isStore = true;
         }
         else
         {
            this.isStore_youhui = true;
         }
         this._price_type = int(priceType / 1000);
         if(priceType == 37000)
         {
            this._price_type = int(37000 / 1000) - 15;
         }
         else if(priceType == -1)
         {
            this._price_type = int(38000 / 1000) - 15;
         }
         this.sold_price = _sellPrice;
         if(priceType % 1000 != 0 && priceType != -1)
         {
            this.specialHandle(priceType,_num,name_str,_sellPrice);
            this.wp_type = int(priceType / 1000);
            this._price_type = -1;
            return;
         }
         this.left_num = leftNum;
         if(this.wpid < 90000)
         {
            temVo = new Vo_item();
            temVo.id = this.wpid;
            temVo.Init_lib();
            this.Imformate_text.htmlText = LangConfig.getWord("132",0) + HtmlUtil.font(String(this.bought_num),"#f9ff00") + LangConfig.getWord("95",0) + HtmlUtil.font(name_str,Model_shop.get_color_arr[temVo.color - 1]) + LangConfig.getWord("142",0) + HtmlUtil.font(Utils.getGapNum(String(_sellPrice * _num)),"#f9ff00") + "" + this.danwei[this._price_type - 16];
         }
         else
         {
            temEo = new Vo_equip();
            temEo.id = this.wpid;
            temEo.Init_lib();
            this.Imformate_text.htmlText = LangConfig.getWord("132",0) + HtmlUtil.font(String(this.bought_num),"#f9ff00") + LangConfig.getWord("95",0) + HtmlUtil.font(name_str,Model_shop.get_color_arr[temEo.color - 1]) + LangConfig.getWord("142",0) + HtmlUtil.font(Utils.getGapNum(String(_sellPrice * _num)),"#f9ff00") + "" + this.danwei[this._price_type - 16];
         }
      }
      
      private function specialHandle(pri_type:int, numbers:int, name_str:String, _pri:int) : void
      {
         var temN:int = int(pri_type / 1000);
         this.need_wp_id = temN;
         var temVoItem:Vo_item = new Vo_item();
         temVoItem.id = temN;
         temVoItem.Init_lib();
         var temStr:String = temVoItem.str_name;
         this.Imformate_text.htmlText = LangConfig.getWord("132",0) + HtmlUtil.font(String(this.bought_num),"#f9ff00") + LangConfig.getWord("95",0) + name_str + LangConfig.getWord("142",0) + String(numbers * _pri) + LangConfig.getWord("903",0) + HtmlUtil.font(temStr,Model_shop.get_color_arr[temVoItem.color - 1]);
      }
      
      public function update_store(_wp_Id:int, _buy_num:int, _sign:int, _sell_price:int, _price_type:int) : void
      {
         this.isStore = true;
         this.Imformate_text.text = LangConfig.getWord("132",0) + HtmlUtil.font(String(_buy_num),"#f9ff00") + LangConfig.getWord("133",0) + HtmlUtil.font(Utils.getGapNum(String(_sell_price * _buy_num)),"#f9ff00") + "" + this.danwei[_price_type - 16];
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

