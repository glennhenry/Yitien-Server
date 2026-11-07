package com.yiTian.view.modules.jingmaiHang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.model.Model_mart;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_Mart;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_mart_buy;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.utils.getTimer;
   import flashx.textLayout.formats.TextAlign;
   
   public class View_SoldItems extends Sprite
   {
      
      public static var pool:Array = [];
      
      private static var isInit:Boolean = false;
      
      public var Button_Buy01:Button;
      
      private var Number01_text:MyTextField;
      
      private var SellerName01_text:MyTextField;
      
      private var Name01_text:MyTextField;
      
      public var Time01_text:MyTextField;
      
      private var Money01_text:MyTextField;
      
      private var MoneyStyle01_text:MyTextField;
      
      public var Company:Array = [LangConfig.getWord("124",0),LangConfig.getWord("21",0)];
      
      private var grid:View_Grid;
      
      private var good_num:int;
      
      private var good_price:int;
      
      public var _martId:Number;
      
      private var role_id:Number = 0;
      
      private var bmpArr:Array = [];
      
      private var bmpUrl:Array = ["resource/image/priceTypes/silver.png","resource/image/priceTypes/gold.png"];
      
      public var currentPage:int;
      
      public var _griId:int;
      
      private var _costType:int = 1;
      
      private var _leftTime:int;
      
      private var lastTime:int;
      
      private var vis_signed:Boolean = true;
      
      public function View_SoldItems()
      {
         super();
         this.init();
      }
      
      public static function getInstance() : View_SoldItems
      {
         var temIns:View_SoldItems = null;
         if(Boolean(pool.length))
         {
            return pool.pop();
         }
         temIns = new View_SoldItems();
         pool.push(temIns);
         return temIns;
      }
      
      public function init() : void
      {
         var bm:Bmp = null;
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":0,
            "y":42,
            "width":523,
            "height":2
         },Global.Img_Cdm);
         var i:int = 0;
         while(i < 2)
         {
            bm = new Bmp(this.bmpUrl[i]);
            bm.y = 11.5;
            addChild(bm);
            this.bmpArr.push(bm);
            i++;
         }
         TipManager.bind(this.bmpArr[0],LangConfig.getWord("124",0));
         TipManager.bind(this.bmpArr[1],LangConfig.getWord("21",0));
         this.Button_Buy01 = ComponentUtil.getButton(LangConfig.getWord("7",0),"Button_Two",this,{
            "x":459,
            "y":9
         },Global.Img_Cdm);
         this.Name01_text = ComponentUtil.getTextField(LangConfig.getWord("60174",6),this,{
            "x":45,
            "y":12,
            "color":6938422,
            "size":12,
            "leading":0
         });
         this.Number01_text = ComponentUtil.getTextField("00",this,{
            "x":150,
            "y":12,
            "color":16184781,
            "size":12,
            "leading":0,
            "realWidth":24,
            "align":TextAlign.CENTER
         });
         this.Time01_text = ComponentUtil.getTextField("00:00:00",this,{
            "x":182,
            "y":12,
            "color":16184781,
            "size":12,
            "leading":0,
            "realWidth":76
         });
         this.Money01_text = ComponentUtil.getTextField("000",this,{
            "x":266,
            "y":12,
            "color":16184781,
            "size":12,
            "leading":0,
            "realWidth":76
         });
         this.SellerName01_text = ComponentUtil.getTextField(LangConfig.getWord("60175",6),this,{
            "x":349,
            "y":12,
            "color":16184781,
            "size":12,
            "leading":0,
            "realWidth":106
         });
         this.SellerName01_text.align = TextAlign.CENTER;
         this.SellerName01_text.mouseEnabled = true;
         this.Time01_text.align = TextAlign.CENTER;
         this.Money01_text.align = TextAlign.CENTER;
         this.grid = new View_Grid();
         this.grid.set_bmp_bg();
         this.grid.set_bmp_over(true,null);
         this.grid.x = 3;
         this.grid.y = 4;
         this.grid.type = Enum_type_grid.MART;
         addChild(this.grid);
         this.Button_Buy01.addEventListener(MouseEvent.CLICK,this.buyHandle);
         this.Button_Buy01.addEventListener(MouseEvent.MOUSE_DOWN,this.downHandle);
      }
      
      public function getMoneyType(type:int) : void
      {
         var temdis:Sprite = null;
         this.bmpArr[0].visible = false;
         this.bmpArr[1].visible = false;
         if(type == 1)
         {
            temdis = this.bmpArr[0];
         }
         else if(type == 2)
         {
            temdis = this.bmpArr[1];
         }
         temdis.visible = true;
         temdis.x = this.Money01_text.x + this.Money01_text.width / 2 + this.Money01_text.textWidth / 2 + 4;
      }
      
      private function downHandle(e:MouseEvent) : void
      {
         e.stopPropagation();
      }
      
      public function buyHandle(e:MouseEvent) : void
      {
         var vec:Vector.<Vo_valuable> = null;
         var i:int = 0;
         var temN:int = 0;
         var btn:Button = e.target as Button;
         var tem_num:int = int(this.Number01_text.text);
         if(btn.label == LangConfig.getWord("7",0))
         {
            View_martSelectNum.setType(1);
            UIManager.selectNum.updata(tem_num,this._martId,this.good_price,this._costType,this.grid.vo);
         }
         else if(btn.label == LangConfig.getWord("15",0))
         {
            View_martSelectNum.setType(2);
            vec = CommandManager.get_bag_vec(Enum_filter.ID,null,[this.grid.vo.id]);
            if(!vec.length)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("400",0));
               return;
            }
            vec = this.getNoBind(vec);
            if(!vec || !vec.length)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("400",0));
               return;
            }
            i = 0;
            while(i < vec.length)
            {
               temN = vec[i].count;
               if(temN < 1)
               {
                  temN = 1;
               }
               Model_mart.max += temN;
               i++;
            }
            UIManager.selectNum.updata(this.good_num,this._martId,this.good_price,this._costType,this.grid.vo);
         }
         UIManager.selectNum.visible = !UIManager.selectNum.visible;
      }
      
      private function getNoBind(vec:Vector.<Vo_valuable>) : Vector.<Vo_valuable>
      {
         if(!vec.length)
         {
            return null;
         }
         var i:int = 0;
         while(i < vec.length)
         {
            if(vec[i].bBind)
            {
               vec.splice(i,1);
               i--;
            }
            i++;
         }
         return vec;
      }
      
      public function init_info(items:Array, equips:Array) : void
      {
         this.set_vec_item(items);
         this.set_vec_equip(equips);
      }
      
      public function update(mart_vo:Vo_Mart) : void
      {
         this._costType = mart_vo.price_type;
         this.leftTime = mart_vo.left_time;
         this.cost = mart_vo.price;
         this.sold_buy_name = mart_vo.sold_buy_host;
         this.Number01_text.text = String(mart_vo.good_num);
         this._martId = mart_vo.mart_id;
         this.role_id = mart_vo.sold_buy_host_id;
      }
      
      public function update_num(_num:int) : void
      {
         this.Number01_text.text = String(_num);
         this.good_num = _num;
         if(_num == 0)
         {
            this.visible = false;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.vis_signed)
            {
               GameScene.instance.addFrameCallBack(this.frameHandle);
            }
         }
         else
         {
            GameScene.instance.removeFrameCallBack(this.frameHandle);
            this.reset();
         }
      }
      
      private function reset() : void
      {
         this._leftTime = 0;
         this.grid.vo = null;
         this.good_num = 0;
         this.good_price = 0;
         this._martId = 0;
         this._costType = 1;
         this.sold_buy_name = "";
      }
      
      public function set_vec_item(items:Array) : void
      {
         var tem_item:Vo_item = null;
         if(!items)
         {
            return;
         }
         this.Name01_text.htmlText = HtmlUtil.font(LangConfig.getWord("401",0),"#ff0000");
         trace("道具:",items);
         tem_item = new Vo_item();
         tem_item.id = items[0];
         if(tem_item.id > 49999 || tem_item.id < 40000)
         {
            return;
         }
         tem_item.Init_lib();
         this.grid.vo = tem_item;
         this.Name01_text.text = tem_item.str_name;
         trace("颜色：",tem_item.color);
         this.Name01_text.textColor = Model_shop.getColorArr[tem_item.color - 1];
      }
      
      public function set_vec_equip(equips:Array) : void
      {
         var tem_equip:Vo_equip = null;
         if(!equips)
         {
            return;
         }
         this.Name01_text.htmlText = HtmlUtil.font(LangConfig.getWord("401",0),"#ff0000");
         trace("武器：",equips);
         tem_equip = new Vo_equip();
         tem_equip.Init_sever_bag(equips);
         (this.grid as View_Grid).vo = tem_equip;
         this.Name01_text.text = tem_equip.str_name;
         trace("颜色：",tem_equip.color);
         this.Name01_text.textColor = Model_shop.getColorArr[tem_equip.color - 1];
      }
      
      public function set sold_buy_name(Str:String) : void
      {
         if(Str != "")
         {
            Str = Model_heFu.repNameByHero(Str);
         }
         if(Str != GameUnitManager.hero.name)
         {
            this.set_bought_btn(true);
            this.SellerName01_text.htmlText = "<u>" + HtmlUtil.link(Str,"") + "</u>";
            this.SellerName01_text.addEventListener(TextEvent.LINK,this.linkHandler);
            this.SellerName01_text.addEventListener(MouseEvent.MOUSE_DOWN,this.mDownHandle);
         }
         else
         {
            this.set_bought_btn(false);
            this.SellerName01_text.text = Str;
         }
      }
      
      public function update_bought_item(mart_vo_bought:Vo_mart_buy) : void
      {
         var tem_item:Vo_item = null;
         var tem_equip:Vo_equip = null;
         if(mart_vo_bought.wp_type == 1)
         {
            tem_item = new Vo_item();
            tem_item.id = mart_vo_bought.wp_id;
            tem_item.Init_lib();
            this.grid.vo = tem_item;
            this.Name01_text.text = tem_item.str_name;
            this.Name01_text.textColor = Model_shop.getColorArr[tem_item.color - 1];
         }
         else if(mart_vo_bought.wp_type == 2)
         {
            tem_equip = new Vo_equip();
            tem_equip.id = mart_vo_bought.wp_id;
            tem_equip.Init_lib();
            this.grid.vo = tem_equip;
            this.Name01_text.text = tem_equip.str_name;
            this.Name01_text.textColor = Model_shop.getColorArr[tem_equip.color - 1];
         }
         this.leftTime = mart_vo_bought.left_time;
         this.Number01_text.text = String(mart_vo_bought.good_num);
         this.good_num = mart_vo_bought.good_num;
         this._costType = mart_vo_bought.price_type;
         this.Money01_text.text = Utils.getGapNum(String(mart_vo_bought.price)) + " ";
         this.good_price = mart_vo_bought.price;
         this.getMoneyType(this._costType);
         this.sold_buy_name = mart_vo_bought.sold_buy_host;
         this.role_id = mart_vo_bought.sold_buy_host_id;
         this._martId = mart_vo_bought.mart_id;
      }
      
      private function set_bought_btn(value:Boolean) : void
      {
         this.Button_Buy01.enabled = value;
         this.Button_Buy01.useHandCursor = value;
         this.Button_Buy01.mouseChildren = value;
         this.Button_Buy01.mouseEnabled = value;
      }
      
      public function set bought_sold_label(str:String) : void
      {
         this.Button_Buy01.label = str;
      }
      
      private function mDownHandle(e:MouseEvent) : void
      {
         e.stopPropagation();
      }
      
      public function linkHandler(e:TextEvent) : void
      {
         var tem:int = 0;
         UIManager.ch_info_board.visible = true;
         UIManager.ch_info_board.update(this.role_id,this.SellerName01_text.text);
         UIManager.ch_info_board.x = Global.stage.mouseX;
         UIManager.ch_info_board.y = Global.stage.mouseY;
         if(UIManager.ch_info_board.y + UIManager.ch_info_board.height > Global.stage.stageHeight)
         {
            tem = UIManager.ch_info_board.y + UIManager.ch_info_board.height - Global.stage.stageHeight;
            UIManager.ch_info_board.y = Global.stage.mouseY - tem;
         }
      }
      
      public function set leftTime(LFTime:int) : void
      {
         this._leftTime = LFTime;
         trace("--",String(DateUtil.getMSBySecond2(this._leftTime)));
         this.Time01_text.text = String(DateUtil.getMSBySecond2(this._leftTime));
      }
      
      public function frameHandle(instanc:int) : void
      {
         var now:int = getTimer();
         if(now - this.lastTime >= 1000)
         {
            --this._leftTime;
            this.Time01_text.text = String(DateUtil.getMSBySecond2(this._leftTime));
            this.lastTime = now;
         }
         if(this._leftTime < 1)
         {
            this.vis_signed = false;
            GameScene.instance.removeFrameCallBack(this.frameHandle);
            this.Button_Buy01.enabled = false;
            this.Button_Buy01.mouseChildren = false;
            this.Button_Buy01.mouseEnabled = false;
         }
      }
      
      private function set cost(_num:int) : void
      {
         this.good_price = _num;
         this.Money01_text.text = String(Utils.getGapNum(String(_num)));
         this.getMoneyType(this._costType);
         this.set_bought_btn(false);
      }
   }
}

import com.yiTian.utils.Utils;
import flash.display.Bitmap;
import flash.display.Sprite;

class Bmp extends Sprite
{
   
   private var bmp:Bitmap = new Bitmap();
   
   public function Bmp(utl:String)
   {
      super();
      this.bmp = Utils.getLoadBitmap(utl,this.bmp,this);
      addChild(this.bmp);
   }
}
