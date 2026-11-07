package com.yiTian.view.modules.shenMiShop
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.data.model.Model_sms;
   import com.yiTian.data.vo.Vo_SMS;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.SMSCGMessage;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class View_shenMiShop extends Panel
   {
      
      public static var isSearch:Boolean = false;
      
      public static var isMulSearch:Boolean = false;
      
      private static var isFirstOpen:Boolean = true;
      
      private var Button_Refresh:Button;
      
      private var checkBox_tishi:DisplayObject;
      
      private var sell_item_arr:Array = [];
      
      private var sell_item:SellsItems;
      
      private var baoWu_item_arr:Array = [];
      
      private var baoWu_item:BaoWuItems;
      
      private var text_item_arr:Array = [];
      
      private var text_item:TextItems;
      
      private var back_item_arr:Array = [];
      
      private var back_item:BackItem;
      
      private var Button_Autofresh:Button;
      
      private var boughtLink:BoughtItem;
      
      private var back:DisplayObject;
      
      private var point:Point;
      
      public var isGetObj:Boolean = false;
      
      public var SMS_CheckBox:CheckBox;
      
      private var refresh_tm:int;
      
      private var btnEff:Effect;
      
      public var is_expens_wp:Boolean;
      
      public var get_exp_wp:Array;
      
      private var lineEff:Effect;
      
      private var lineEff_arr:Array = [];
      
      private var _lst:int;
      
      private var _now:int;
      
      private var effectTime:Boolean = false;
      
      public function View_shenMiShop()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var j:int = 0;
         var i:int = 0;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":798,
            "height":528
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":750,
            "height":478
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":29,
            "y":45,
            "width":190,
            "height":250
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":29,
            "y":299,
            "width":190,
            "height":214
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":30,
            "y":46,
            "width":188,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60286",6),this,{
            "x":96,
            "y":47,
            "color":16777215,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60287",6),this,{
            "x":235,
            "y":488,
            "color":16764206,
            "size":12,
            "leading":0
         });
         move = new Rectangle(0,0,767,38);
         this.Button_Refresh = ComponentUtil.getButton(LangConfig.getWord("32",0),"Button_Four",this,{
            "x":678,
            "y":486,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Autofresh = ComponentUtil.getButton(LangConfig.getWord("33",0),"Button_Four",this,{
            "x":585,
            "y":486,
            "textColor":16184781
         },Global.Img_Cdm);
         j = 0;
         while(j < 10)
         {
            this.text_item = new TextItems();
            this.text_item.x = 35;
            this.text_item.y = 300 + 18.5 * j;
            this.text_item.visible = false;
            addChild(this.text_item);
            this.text_item_arr.push(this.text_item);
            j++;
         }
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":764,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Autofresh.callBack = this.autoFHandle;
         this.Button_Autofresh.addEventListener(MouseEvent.MOUSE_DOWN,this.mHandle);
         i = 0;
         while(i < 6)
         {
            this.sell_item = new SellsItems();
            this.sell_item.x = 229 + 271 * int(i % 2);
            this.sell_item.y = 45 + 147 * int(i / 2);
            this.sell_item.visible = false;
            addChild(this.sell_item);
            this.sell_item_arr.push(this.sell_item);
            i++;
         }
         i = 0;
         while(i < 6)
         {
            this.baoWu_item = new BaoWuItems();
            this.baoWu_item.x = 39 + 90 * int(i % 2);
            this.baoWu_item.y = 74 + 74 * int(i / 2);
            addChild(this.baoWu_item);
            this.baoWu_item_arr.push(this.baoWu_item);
            this.baoWu_item.visible = false;
            i++;
         }
         i = 0;
         while(i < 6)
         {
            this.back_item = new BackItem();
            this.back_item.x = 229 + 271 * int(i % 2);
            this.back_item.y = 45 + 147 * int(i / 2);
            this.back_item.visible = false;
            addChild(this.back_item);
            this.back_item_arr.push(this.back_item);
            i++;
         }
         this.boughtLink = new BoughtItem();
         this.boughtLink.x = 476;
         this.boughtLink.y = 489;
         addChild(this.boughtLink);
         this.Button_Refresh.addEventListener(MouseEvent.CLICK,this.refreHandle);
         isRuning = false;
      }
      
      private function comp() : void
      {
         super.visible = false;
         isRuning = false;
         UIManager.special_btn.getEff(0);
      }
      
      public function getObj() : void
      {
         this.point = UIManager.special_btn.getPos(0);
         this.isGetObj = true;
      }
      
      private function showBmp() : void
      {
         ComponentUtil.getBitmap("Title_SMShop",this,{
            "x":319,
            "y":5
         },Global.SMShop_Imgsdm);
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
         {
            UIManager.bagPwdPutIn.visible = true;
            return;
         }
         if(value)
         {
            scaleX = 1;
            scaleY = 1;
            super.visible = value;
            SMSCGMessage.CG_OPEN_SMS_SHOP();
            Tween.to(this,300,{"alpha":[0,1]});
            if(isFirstOpen)
            {
               isFirstOpen = false;
               SingleLoader.add("lang/ch/SMShop_Imgs.swf",function(info:Object):void
               {
                  Global.SMShop_Imgsdm = info.applicationDomain;
                  showBmp();
               });
            }
            this.btnEffFun();
         }
         else
         {
            if(isRuning)
            {
               return;
            }
            if(!this.isGetObj)
            {
               this.getObj();
            }
            isRuning = true;
            Tween.to(this,300,{
               "scaleX":[1,0],
               "scaleY":[1,0],
               "x":[this.x,this.point.x],
               "y":[this.y,this.point.y]
            },this.comp);
            this.disBtnEff();
         }
      }
      
      private function mHandle(e:MouseEvent) : void
      {
         e.stopPropagation();
      }
      
      private function autoFHandle(e:MouseEvent) : void
      {
         UIManager.sms_mulTips.visible = !UIManager.sms_mulTips.visible;
      }
      
      public function update_onSells_and_txt(on_sells_arr:Array, txt_arr:Array, _refresh_tm:int) : void
      {
         var sold_item:SellsItems = null;
         var vo_item_onSells:Vo_SMS = null;
         var back_it:BackItem = null;
         var i:int = 0;
         var txt_item:TextItems = null;
         var str_item:Array = null;
         this.refresh_tm = _refresh_tm;
         var temI:int = 0;
         while(temI < 6)
         {
            this.sell_item_arr[temI].visible = false;
            this.back_item_arr[temI].visible = false;
            temI++;
         }
         temI = 0;
         while(temI < 10)
         {
            this.text_item_arr[temI].visible = false;
            temI++;
         }
         this.get_exp_wp = [];
         this.is_expens_wp = false;
         i = 0;
         while(i < on_sells_arr.length)
         {
            sold_item = this.sell_item_arr[i];
            vo_item_onSells = on_sells_arr[i];
            back_it = this.back_item_arr[i];
            back_it.visible = false;
            sold_item.visible = true;
            if(!on_sells_arr[i])
            {
               sold_item.visible = false;
               back_it.visible = true;
            }
            else if(vo_item_onSells.nums == 0)
            {
               sold_item.visible = false;
               back_it.visible = true;
            }
            else
            {
               sold_item.update(vo_item_onSells);
               if(Boolean(vo_item_onSells.is_expen_wp))
               {
                  this.is_expens_wp = true;
                  this.get_exp_wp.push([sold_item.getName(vo_item_onSells.wp_id,vo_item_onSells.type).name + ",",sold_item.getName(vo_item_onSells.wp_id,vo_item_onSells.type).color]);
               }
            }
            i++;
         }
         Model_sms.showGuide = this.refresh_tm == 0 ? true : false;
         this.btnEffFun();
         if(!txt_arr.length)
         {
            return;
         }
         i = 0;
         while(i < txt_arr.length)
         {
            if(Boolean(this.text_item_arr[i]) && Boolean(this.text_item_arr[i - 1]))
            {
               this.text_item_arr[i].y = this.text_item_arr[i - 1].y + this.text_item_arr[i - 1].height;
            }
            txt_item = this.text_item_arr[i];
            str_item = txt_arr[txt_arr.length - i - 1];
            if(Boolean(txt_item))
            {
               txt_item.visible = true;
               txt_item.update(str_item);
               if(txt_item.y + txt_item.height > 510)
               {
                  txt_item.removeItem();
               }
            }
            i++;
         }
      }
      
      private function btnEffFun() : void
      {
         var dir:String = null;
         var px:Number = NaN;
         var py:Number = NaN;
         var _bx:Number = NaN;
         var _by:Number = NaN;
         if(Model_sms.showGuide)
         {
            if(!this.btnEff)
            {
               dir = "35075";
               px = 37;
               py = 11;
               _bx = this.Button_Refresh.x;
               _by = this.Button_Refresh.y;
               this.btnEff = EffectManager.addEffect(dir,this,1000,_bx + px,_by + py,true);
               this.Button_Refresh.label = LangConfig.getWord("80220",8);
            }
         }
         else
         {
            this.disBtnEff();
            this.Button_Refresh.label = LangConfig.getWord("32",0);
         }
      }
      
      private function disBtnEff() : void
      {
         if(Boolean(this.btnEff))
         {
            EffectManager.removeEffect(this.btnEff);
            this.btnEff = null;
         }
      }
      
      public function getEffect() : void
      {
         this.setEnable(false);
         var i:int = 0;
         while(i < 6)
         {
            this.lineEff = EffectManager.addEffect("35021",this,300,345 + 270 * int(i % 2),120 + 144 * int(i / 2),true);
            this.lineEff_arr.push(this.lineEff);
            i++;
         }
         this._lst = getTimer();
         this.effectTime = true;
         addEventListener(Event.ENTER_FRAME,this.frameHandle);
      }
      
      private function setEnable(value:Boolean) : void
      {
         this.Button_Refresh.mouseChildren = value;
         this.Button_Refresh.mouseEnabled = value;
         this.Button_Refresh.useHandCursor = value;
         this.Button_Refresh.enabled = value;
      }
      
      private function frameHandle(e:Event) : void
      {
         this._now = getTimer();
         if(this._now - this._lst > 300 && this.effectTime == true)
         {
            this.effectTime = false;
            this.removeEffect();
            SMSCGMessage.CG_SMS_SHOP_REFRESH();
         }
         if(this._now - this._lst >= 3000)
         {
            removeEventListener(Event.ENTER_FRAME,this.frameHandle);
            this._lst = 0;
            this._now = 0;
            this.setEnable(true);
         }
      }
      
      public function removeEffect() : void
      {
         var i:int = 0;
         while(i < 6)
         {
            EffectManager.removeEffect(this.lineEff_arr[i]);
            this.lineEff_arr[i] = null;
            i++;
         }
         this.lineEff_arr = [];
      }
      
      public function refreHandle(e:MouseEvent = null) : void
      {
         if(Model_sms.selection)
         {
            if(this.is_expens_wp)
            {
               if(!UIManager.tishi_sms.visible)
               {
                  UIManager.tishi_sms.visible = true;
               }
               UIManager.tishi_sms.update_1txt(this.get_exp_wp,-1);
               UIManager.tishi_sms.setSelectVis(false);
               return;
            }
            if(GameUnitManager.hero.money < 10)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("29",0));
               return;
            }
            this.getEffect();
            return;
         }
         if(this.is_expens_wp)
         {
            if(!UIManager.tishi_sms.visible)
            {
               UIManager.tishi_sms.visible = true;
            }
            UIManager.tishi_sms.update_1txt(this.get_exp_wp,this.refresh_tm);
            return;
         }
         if(this.refresh_tm == 0)
         {
            this.getEffect();
            return;
         }
         if(!UIManager.tishi_sms.visible)
         {
            UIManager.tishi_sms.visible = true;
         }
         UIManager.tishi_sms.update_2txt(LangConfig.getWord("34",0),this.refresh_tm);
      }
      
      public function dispose() : void
      {
         this.is_expens_wp = false;
      }
      
      public function update_title(arr:Array) : void
      {
         var baoWu_item:BaoWuItems = null;
         var vo_baoWu:Vo_SMS = null;
         var temI:int = 0;
         while(temI < 6)
         {
            this.baoWu_item_arr[temI].visible = false;
            temI++;
         }
         var temNum:int = int(arr.length);
         if(temNum > 6)
         {
            temNum = 6;
         }
         var i:int = 0;
         while(i < temNum)
         {
            baoWu_item = this.baoWu_item_arr[i];
            vo_baoWu = arr[i];
            baoWu_item.visible = true;
            baoWu_item.update(vo_baoWu);
            i++;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - 527) / 2;
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.Enum_type_grid;
import com.yiTian.data.model.Model_shop;
import com.yiTian.data.vo.Vo_SMS;
import com.yiTian.data.vo.Vo_equip;
import com.yiTian.data.vo.Vo_item;
import com.yiTian.manager.CommandManager;
import com.yiTian.manager.GameUnitManager;
import com.yiTian.manager.LangConfig;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.SMSCGMessage;
import com.yiTian.utils.HtmlUtil;
import com.yiTian.utils.SingleLoader;
import com.yiTian.view.comp.View_Grid;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flashx.textLayout.formats.TextAlign;

class SellsItems extends Sprite
{
   
   private var Name_text:MyTextField;
   
   private var Number_text:MyTextField;
   
   private var Unit_text:MyTextField;
   
   private var Button_Buy:Button;
   
   private var Informat_text:MyTextField;
   
   private var grid:View_Grid;
   
   private var isFirstOpen:Boolean = true;
   
   public var money_type_arr:Array = [LangConfig.getWord("21",0),LangConfig.getWord("39",0),LangConfig.getWord("21",0)];
   
   private var _textColor:int;
   
   private var _goods_id:int;
   
   private var _price:int;
   
   private var _max_num:int;
   
   public function SellsItems()
   {
      super();
      ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
         "x":0,
         "y":0,
         "width":264,
         "height":140
      },Global.Img_Cdm);
      ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
         "x":1,
         "y":1,
         "width":262,
         "height":22
      },Global.Img_Cdm);
      this.Name_text = ComponentUtil.getTextField(LangConfig.getWord("35",0),this,{
         "x":93,
         "y":2,
         "color":6938422
      });
      this.Name_text.size = 15;
      this.Number_text = ComponentUtil.getTextField("0000",this,{
         "x":10,
         "y":105,
         "color":14662240,
         "size":14
      });
      this.Button_Buy = ComponentUtil.getButton(LangConfig.getWord("36",0),"Button_store",this,{
         "x":155,
         "y":95,
         "textColor":16184781
      },Global.Img_Cdm);
      this.Button_Buy.labelSize = 14;
      this.Button_Buy.textColor = 16383744;
      this.Informat_text = ComponentUtil.getTextField(LangConfig.getWord("37",0),this,{
         "x":85,
         "y":40,
         "color":11904647,
         "width":170,
         "height":55,
         "realWidth":170,
         "realHeight":55,
         "multiline":true,
         "wordWrap":true,
         "leading":3
      });
      this.grid = new View_Grid(true);
      this.grid.type = Enum_type_grid.SHOP;
      this.grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
      this.grid.set_bmp_over(true,null);
      this.grid.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
      this.grid.x = 10;
      this.grid.y = 30;
      addChild(this.grid);
      this.Button_Buy.addEventListener(MouseEvent.CLICK,this.buyHandle);
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
   
   public function buyHandle(e:MouseEvent = null) : void
   {
      if(GameUnitManager.hero.money < this._price)
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("9",0));
         return;
      }
      if(CommandManager.get_bag_canUse() - CommandManager.get_bag_used() == 0)
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("38",0));
         return;
      }
      SMSCGMessage.CG_SMS_SHOP_BUY(this._goods_id,1);
   }
   
   public function update(vo_item_onSells:Vo_SMS) : void
   {
      this.Name_text.text = this.getName(vo_item_onSells.wp_id,vo_item_onSells.type).name;
      this.Name_text.textColor = Model_shop.getColorArr[this._textColor - 1];
      this.Number_text.textColor = 16383744;
      this._goods_id = vo_item_onSells.goods_id;
      this._price = vo_item_onSells.price;
      this._max_num = vo_item_onSells.nums;
      this.Number_text.text = LangConfig.getWord("60288",6) + String(vo_item_onSells.price) + " " + this.money_type_arr[vo_item_onSells.money_type - 16];
      this.Informat_text.text = vo_item_onSells.descrip;
   }
   
   private function resetVo() : void
   {
      this.grid.vo = null;
   }
   
   public function getName(wpId:int, _type:int) : Object
   {
      var voItem:Vo_item = null;
      var voEquit:Vo_equip = null;
      this.resetVo();
      var temObj:Object = new Object();
      temObj.name = "";
      temObj.color = 0;
      if(_type == 1)
      {
         voItem = new Vo_item();
         voItem.id = wpId;
         voItem.Init_lib();
         this.grid.vo = voItem;
         this._textColor = voItem.color;
         temObj.name = voItem.str_name;
         temObj.color = voItem.color;
      }
      else if(_type == 2)
      {
         voEquit = new Vo_equip();
         voEquit.id = wpId;
         voEquit.Init_lib();
         this.grid.vo = voEquit;
         this._textColor = voEquit.color;
         temObj.name = voEquit.str_name;
         temObj.color = voEquit.color;
      }
      return temObj;
   }
}

class BaoWuItems extends Sprite
{
   
   private var Name_text:MyTextField;
   
   private var Icon_Board_Default_instance:Bitmap;
   
   private var grid:View_Grid;
   
   private var _textColor:int;
   
   public function BaoWuItems()
   {
      super();
      this.Name_text = ComponentUtil.getTextField(LangConfig.getWord("35",0),this,{
         "x":-4,
         "y":45,
         "width":80,
         "realWidth":80
      });
      this.Name_text.align = TextAlign.CENTER;
      this.grid = new View_Grid();
      this.grid.type = Enum_type_grid.SHOP;
      this.grid.set_bmp_bg();
      this.grid.set_bmp_over(true,null);
      this.grid.set_bmp_select();
      this.grid.x = 18.1;
      this.grid.y = 0;
      addChild(this.grid);
   }
   
   public function update(vo_baoWu:Vo_SMS) : void
   {
      this.Name_text.text = this.getname(vo_baoWu.wp_id,vo_baoWu.type);
      this.Name_text.textColor = Model_shop.getColorArr[this._textColor - 1];
   }
   
   private function getname(wpId:int, _type:int) : String
   {
      var temStr:String = null;
      var voItem:Vo_item = null;
      var voEquit:Vo_equip = null;
      if(_type == 1)
      {
         voItem = new Vo_item();
         voItem.id = wpId;
         voItem.Init_lib();
         temStr = voItem.str_name;
         this.grid.vo = voItem;
         this._textColor = voItem.color;
      }
      else if(_type == 2)
      {
         voEquit = new Vo_equip();
         voEquit.id = wpId;
         voEquit.Init_lib();
         temStr = voEquit.str_name;
         this.grid.vo = voEquit;
         this._textColor = voEquit.color;
      }
      return temStr;
   }
}

class TextItems extends Sprite
{
   
   private var Informat01_text:MyTextField;
   
   private var _textColor:int;
   
   public function TextItems()
   {
      super();
      this.Informat01_text = ComponentUtil.getTextField(LangConfig.getWord("40",0),this,{
         "x":0,
         "y":0,
         "realWidth":180,
         "multiline":true,
         "wordWrap":true
      });
      this.Informat01_text.size = 14;
      this.height = this.Informat01_text.height;
   }
   
   public function update(arr:Array) : void
   {
      this.Informat01_text.htmlText = HtmlUtil.font(arr[0],"#f9ff00",14) + LangConfig.getWord("7",0) + HtmlUtil.font(this.getname(arr[1],arr[2]) + arr[3] + LangConfig.getWord("95",0),Model_shop.get_color_arr[this._textColor - 1],14);
      this.height = this.Informat01_text.height;
   }
   
   public function removeItem() : void
   {
      visible = false;
   }
   
   private function getname(wpId:int, _type:int) : String
   {
      var temStr:String = null;
      var voItem:Vo_item = null;
      var voEquit:Vo_equip = null;
      if(_type == 1)
      {
         voItem = new Vo_item();
         voItem.id = wpId;
         voItem.Init_lib();
         temStr = voItem.str_name;
         this._textColor = voItem.color;
      }
      else if(_type == 2)
      {
         voEquit = new Vo_equip();
         voEquit.id = wpId;
         voEquit.Init_lib();
         temStr = voEquit.str_name;
         this._textColor = voEquit.color;
      }
      return temStr;
   }
}

class BackItem extends Sprite
{
   
   private var url_str:String = "resource/image/mestry_shop/Card_Back.jpg";
   
   private var bmp_bg:Bitmap;
   
   public function BackItem()
   {
      super();
      if(Boolean(Global.SMShop_Imgsdm))
      {
         this.show();
      }
      else
      {
         SingleLoader.add("lang/ch/SMShop_Imgs.swf",function(info:Object):void
         {
            Global.SMShop_Imgsdm = info.applicationDomain;
            show();
         });
      }
   }
   
   private function show() : void
   {
      ComponentUtil.getBitmap("CardBack",this,null,Global.SMShop_Imgsdm);
   }
}

class BoughtItem extends Sprite
{
   
   private var YiTao_text:MyTextField;
   
   private var bmp:Bitmap;
   
   public function BoughtItem()
   {
      super();
      this.bmp = ComponentUtil.getBitmap("GoWuChe",this,{"y":-5});
      this.YiTao_text = ComponentUtil.getTextField(LangConfig.getWord("41",0),this,{
         "x":33,
         "y":1
      });
      this.YiTao_text.underline = true;
      this.YiTao_text.textColor = 16383744;
      buttonMode = true;
      addEventListener(MouseEvent.CLICK,this.cliHandle);
   }
   
   private function cliHandle(e:MouseEvent) : void
   {
      UIManager.search.visible = !UIManager.search.visible;
   }
}
