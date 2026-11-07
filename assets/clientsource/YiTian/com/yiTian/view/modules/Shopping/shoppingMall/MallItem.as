package com.yiTian.view.modules.Shopping.shoppingMall
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_store;
   import com.yiTian.data.vo.Vo_Skill;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_store;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.actions.jiJin.FundMter;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import flashx.textLayout.formats.TextAlign;
   
   public class MallItem extends Sprite
   {
      
      private static var pool:Array = [];
      
      private var nameTxt:MyTextField;
      
      private var numsTxt:MyTextField;
      
      private var numUpBtn:Button;
      
      private var numDownBtn:Button;
      
      private var buyBtn:Button;
      
      private var singlPrice:MyTextField;
      
      private var danWei:Array;
      
      private var grid:View_Grid;
      
      private var hotBmp:Bitmap;
      
      private var tfShouJia:MyTextField;
      
      private var priceType:int;
      
      private var _sellPrice:int;
      
      private var type:int;
      
      private var _sign:int;
      
      public var speLighting:Boolean = false;
      
      private var time1:int;
      
      private var time2:int;
      
      private var _limit:int;
      
      private var canBought:Boolean = true;
      
      public function MallItem()
      {
         this.danWei = ["元宝","礼券"];
         super();
         ComponentUtil.getScaleBitmap("Store_Back2",[50,30,4,1],this,{
            "x":0,
            "y":5,
            "width":208,
            "height":111
         },Global.Store_Imgsdm);
         ComponentUtil.getScaleBitmap("Store_Back3",[3,3,4,4],this,{
            "x":83,
            "y":78,
            "width":62,
            "height":24
         },Global.Store_Imgsdm);
         this.hotBmp = ComponentUtil.getBitmap("Hot",this,{
            "x":0,
            "y":0
         },Global.Store_Imgsdm);
         this.tfShouJia = ComponentUtil.getTextField("售价：",this,{
            "x":87,
            "y":48,
            "color":5757360,
            "size":12,
            "leading":0,
            "realWidth":113,
            "multiline":true,
            "wordWrap":true,
            "realHeight":50
         });
         this.nameTxt = ComponentUtil.getTextField("道具中文名称",this,{
            "x":104,
            "y":8,
            "color":3394815
         });
         this.nameTxt.autoSize = TextFieldAutoSize.CENTER;
         this.numsTxt = ComponentUtil.getTextField("1",this,{
            "x":89,
            "y":80,
            "color":16777215,
            "size":12,
            "leading":0,
            "align":TextAlign.CENTER,
            "maxChars":3,
            "type":TextFieldType.INPUT,
            "realWidth":34,
            "realHeight":18
         });
         this.numsTxt.addEventListener(Event.CHANGE,this.changedHandle);
         this.singlPrice = ComponentUtil.getTextField("0000元宝",this,{
            "x":124,
            "y":48,
            "color":16776960,
            "size":12,
            "leading":0
         });
         this.numUpBtn = ComponentUtil.getButton("","Button_Nup",this,{
            "x":125,
            "y":79,
            "textColor":16184781,
            "name":"up"
         },Global.Store_Imgsdm);
         this.numDownBtn = ComponentUtil.getButton("","Button_Ndown",this,{
            "x":125,
            "y":89,
            "textColor":16184781,
            "name":"down"
         },Global.Store_Imgsdm);
         this.buyBtn = ComponentUtil.getButton("购买","Button_Buy",this,{
            "x":149,
            "y":77,
            "textColor":16777036
         },Global.Store_Imgsdm);
         this.numUpBtn.callBack = this.numDownBtn.callBack = this.btnChangeHd;
         this.buyBtn.callBack = this.buyHd;
         this.grid = new View_Grid(true);
         this.grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
         this.grid.set_bmp_over(true,View_Grid.GRID_BIGGEST_OVER);
         this.grid.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
         this.grid.type = Enum_type_grid.STORE;
         this.grid.mouseEnabled = true;
         this.grid.buttonMode = true;
         this.grid.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            buyBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         });
         ComponentUtil.setPropertie(this.grid,{
            "x":9,
            "y":38
         });
         addChild(this.grid);
         addEventListener(MouseEvent.MOUSE_OVER,function(e:MouseEvent):void
         {
            filters = Util.glowFFff00;
         });
         addEventListener(MouseEvent.MOUSE_OUT,function(e:MouseEvent):void
         {
            filters = [];
         });
      }
      
      public static function get instance() : MallItem
      {
         if(Boolean(pool.length))
         {
            return pool.pop();
         }
         return new MallItem();
      }
      
      private function buyHd(e:MouseEvent) : void
      {
         var skillId:int = 0;
         var temId:int = 0;
         var temVoItem:Vo_item = null;
         var _price_type:int = int(this.priceType / 1000);
         var buy_num:int = int(this.numsTxt.text);
         if(this.priceType == -1)
         {
            if(buy_num * this._sellPrice > FundMter.fundOwn)
            {
               UIManager.centerBroadcast.addMsg("基金不够哦，亲");
               return;
            }
            if(!UIManager.storeTip.visible)
            {
               UIManager.storeTip.visible = true;
            }
            UIManager.storeTip.update(this.grid.vo.id,int(this.numsTxt.text),this._sign,this.priceType,this._sellPrice,9999,this.type,this.nameTxt.text);
            return;
         }
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
            if(this.grid.vo.id >= 46111 && this.grid.vo.id <= 46150)
            {
               skillId = int(String(this.grid.vo.id).substr(-1));
               if(skillId == 0)
               {
                  skillId = 10;
               }
               if(Vo_Skill.data[skillId - 1].current_grade > 0)
               {
                  UIManager.centerBroadcast.addMsg("您已学习过该技能了",1);
                  return;
               }
            }
            if(buy_num * this._sellPrice > GameUnitManager.hero.prestige)
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + LangConfig.getWord("121",0) + "</font></a>");
               return;
            }
         }
         else if(_price_type == 37)
         {
            if(buy_num * this._sellPrice > GameUnitManager.hero.christmasScore)
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#f9ff00\'>" + "积分不够" + "</font></a>");
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
         if(this.speLighting)
         {
            this.speLighting = false;
         }
         if(!UIManager.storeTip.visible)
         {
            UIManager.storeTip.visible = true;
         }
         UIManager.storeTip.update(this.grid.vo.id,int(this.numsTxt.text),this._sign,this.priceType,this._sellPrice,9999,this.type,this.nameTxt.text);
      }
      
      private function changedHandle(e:Event) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         var num:int = int(tf.text);
         num = num > 99 ? 99 : num;
         num = num < 1 ? 1 : num;
         tf.text = num.toString();
      }
      
      private function btnChangeHd(e:MouseEvent) : void
      {
         var _counts:int = int(this.numsTxt.text);
         switch(e.target.name)
         {
            case "up":
               _counts++;
               _counts = _counts > 99 ? 99 : _counts;
               break;
            case "down":
               _counts--;
               _counts = _counts < 1 ? 1 : _counts;
         }
         this.numsTxt.text = _counts.toString();
      }
      
      public function dispose() : void
      {
         this.numsTxt.text = "1";
         this.singlPrice.text = "";
         this.grid.vo = null;
         this.nameTxt.text = "";
         this.hotBmp.visible = false;
         this.speLighting = false;
         filters = [];
         this._limit = 0;
         this.canBought = true;
         this.grid.mouseEnabled = true;
         this.buyBtn.enabled = true;
         this.tfShouJia.text = "售价：";
         this.tfShouJia.y = 48;
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
         pool.push(this);
      }
      
      public function speDill() : void
      {
         this.speLighting = true;
         if(Boolean(this.time2))
         {
            clearTimeout(this.time2);
         }
         if(!this.speLighting)
         {
            return;
         }
         filters = Util.glowBigFFff00;
         this.time1 = setTimeout(this.compBack,300);
      }
      
      public function compBack() : void
      {
         if(Boolean(this.time1))
         {
            clearTimeout(this.time1);
         }
         filters = [];
         if(!this.speLighting)
         {
            return;
         }
         setTimeout(this.speDill,300);
      }
      
      public function end() : void
      {
         this.speLighting = false;
      }
      
      public function get _grid() : View_Grid
      {
         return this.grid;
      }
      
      public function update(vo:Vo_store, _type:int) : void
      {
         var __type:int;
         var name:String;
         var color:int = 0;
         this.priceType = vo.price_type;
         this._sellPrice = vo.now_price;
         this._sign = vo.sign;
         this.type = _type;
         this._limit = vo.boughtLimit;
         if(FundMter.baiJinLvl >= this._limit)
         {
            this.singlPrice.htmlText = this._sellPrice.toString() + " " + Model_mall.getPriceType(this.priceType);
            this.canBought = true;
            if(!this.grid.hasEventListener(MouseEvent.CLICK))
            {
               this.grid.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
               {
                  buyBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               });
            }
            this.buyBtn.enabled = true;
         }
         else
         {
            this.singlPrice.text = "";
            this.tfShouJia.htmlText = HtmlUtil.font(this._limit + "级白金武魂以上开启","#fe0000");
            this.tfShouJia.y = 38;
            if(this.grid.hasEventListener(MouseEvent.CLICK))
            {
               this.grid.removeEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
               {
                  trace("ss");
               });
            }
            this.buyBtn.enabled = false;
            this.canBought = false;
         }
         this.numsTxt.text = "1";
         __type = vo.type;
         name = vo.name;
         this.grid.vo = vo.vo_value;
         if(Boolean(this.hotBmp))
         {
            this.hotBmp.visible = false;
         }
         if(Boolean(vo.isHot))
         {
            this.hotBmp.visible = true;
         }
         this.nameTxt.htmlText = vo.str_name;
      }
   }
}

