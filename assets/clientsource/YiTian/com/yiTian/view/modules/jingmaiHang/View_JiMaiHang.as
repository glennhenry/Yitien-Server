package com.yiTian.view.modules.jingmaiHang
{
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.MartCGMessage;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.Panel;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class View_JiMaiHang extends Panel
   {
      
      public static var searchPrice:Dictionary = new Dictionary();
      
      public static var isSearched:Dictionary = new Dictionary();
      
      public static var isSearchType:int = 0;
      
      public static var mart_type:int = 1;
      
      private static var isLoadBmp:Boolean = false;
      
      private var Button_MartSold:TabButton;
      
      private var Button_MartBuy:TabButton;
      
      private var Button_MySold:TabButton;
      
      private var Button_MyBuy:TabButton;
      
      public var _mart_sold_buy:MartSold;
      
      public var _my_sold_buy:MartMyBuy;
      
      private var hotPane:Child_HotSearch;
      
      private var alignY:int = 6;
      
      public var now:TabButton;
      
      private var isFirstOpen:Boolean = true;
      
      public function View_JiMaiHang()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":709,
            "height":470 + this.alignY
         },Global.Img_Cdm);
         move = new Rectangle(0,0,580,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":670,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_MartSold = ComponentUtil.getTabButton(LangConfig.getWord("367",0),"TabButton_Four",this,{
            "x":34,
            "y":48 + this.alignY,
            "textColor":12232795,
            "chooseColor":16383744
         },Global.Img_Cdm);
         this.Button_MartBuy = ComponentUtil.getTabButton(LangConfig.getWord("368",0),"TabButton_Four",this,{
            "x":110,
            "y":48 + this.alignY,
            "textColor":12232795,
            "chooseColor":16383744
         },Global.Img_Cdm);
         this.Button_MySold = ComponentUtil.getTabButton(LangConfig.getWord("369",0),"TabButton_Four",this,{
            "x":186,
            "y":48 + this.alignY,
            "textColor":12232795,
            "chooseColor":16383744
         },Global.Img_Cdm);
         this.Button_MyBuy = ComponentUtil.getTabButton(LangConfig.getWord("370",0),"TabButton_Four",this,{
            "x":262,
            "y":48 + this.alignY,
            "textColor":12232795,
            "chooseColor":16383744
         },Global.Img_Cdm);
         this.Button_MartSold.choose = true;
         this.now = this.Button_MartSold;
         this.Button_MyBuy.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.Button_MySold.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.Button_MartBuy.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.Button_MartSold.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this._mart_sold_buy = new MartSold();
         this._mart_sold_buy.y = this.alignY;
         addChild(this._mart_sold_buy);
         this._my_sold_buy = new MartMyBuy();
         this._my_sold_buy.y = this.alignY;
         addChild(this._my_sold_buy);
         this._my_sold_buy.visible = false;
         super.CloseButton.addEventListener(MouseEvent.CLICK,this.cloHandle);
         searchPrice["sell"] = 0;
         searchPrice["buy"] = 0;
         this.hotPane = new Child_HotSearch();
         this.hotPane.x = 341;
         this.hotPane.y = 37 + this.alignY - 3;
         this.addChild(this.hotPane);
      }
      
      private function cliHandle(e:MouseEvent) : void
      {
         var btn:TabButton = e.target as TabButton;
         if(this.now == btn)
         {
            return;
         }
         if(Boolean(this.now))
         {
            this.now.choose = false;
         }
         btn.choose = true;
         this.now = btn;
         this.sign_changed_handle();
         if(e.target.text == LangConfig.getWord("367",0))
         {
            this.hotPane.visible = true;
            this._mart_sold_buy.visible = true;
            this._mart_sold_buy.buy_sell_host.text = LangConfig.getWord("371",0);
            mart_type = 1;
            MartCGMessage.CG_MARTSOLD(0,1,View_JiMaiHang.searchPrice["sell"]);
         }
         else if(e.target.text == LangConfig.getWord("368",0))
         {
            this.hotPane.visible = true;
            this._mart_sold_buy.visible = true;
            this._mart_sold_buy.buy_sell_host.text = LangConfig.getWord("372",0);
            mart_type = 2;
            MartCGMessage.CG_MARTBUY(0,1,View_JiMaiHang.searchPrice["buy"]);
         }
         else if(e.target.text == LangConfig.getWord("369",0))
         {
            this.hotPane.visible = false;
            this._my_sold_buy.visible = true;
            this._my_sold_buy.update_title(1);
            MartCGMessage.CG_MY_SOLD();
         }
         else
         {
            this.hotPane.visible = false;
            this._my_sold_buy.visible = true;
            this._my_sold_buy.update_title(2);
            MartCGMessage.CG_MY_BUY();
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
         {
            UIManager.bagPwdPutIn.visible = true;
            return;
         }
         super.visible = value;
         if(value)
         {
            if(this.isFirstOpen)
            {
               this.isFirstOpen = false;
               bind_target = Enum_explor.bind(Enum_explor.BTN_MART);
               if(!Global.Mart_Imgsdm)
               {
                  SingleLoader.add("lang/ch/Mart_Imgs.swf",function(info:Object):void
                  {
                     Global.Mart_Imgsdm = info.applicationDomain;
                     showTl();
                  });
               }
               else if(!isLoadBmp)
               {
                  this.showTl();
               }
            }
            this.close_reset();
            this._mart_sold_buy.reset();
            this._my_sold_buy.reset();
         }
         else
         {
            mart_type = 1;
            this._mart_sold_buy.visible = false;
            this._my_sold_buy.visible = false;
            this.hotPane.visible = true;
         }
      }
      
      private function showTl() : void
      {
         ComponentUtil.getBitmap("Title_Mart",this,{
            "x":272,
            "y":5
         },Global.Mart_Imgsdm);
         isLoadBmp = true;
      }
      
      private function sign_changed_handle() : void
      {
         this._mart_sold_buy.visible = false;
         this._my_sold_buy.visible = false;
         if(UIManager.sold_set.visible)
         {
            UIManager.sold_set.visible = false;
         }
         if(UIManager.buy_set.visible)
         {
            UIManager.buy_set.visible = false;
         }
         this._mart_sold_buy.reset();
         this._my_sold_buy.reset();
      }
      
      public function cloHandle(e:MouseEvent) : void
      {
         this.visible = false;
         this.close_reset();
      }
      
      public function close_reset() : void
      {
         if(this.now != this.Button_MartSold)
         {
            this.now.choose = false;
         }
         if(this._my_sold_buy.visible)
         {
            this._my_sold_buy.visible = false;
         }
         this.Button_MartSold.choose = true;
         this.now = this.Button_MartSold;
      }
      
      public function update_sold_item(eve_num:int, totalPage:int, typeArr:Array, items_arr:Array, equips_arr:Array, dataArr:Array) : void
      {
         this._mart_sold_buy.visible = true;
         this._mart_sold_buy.getSelfInfo();
         this._mart_sold_buy.updateSoldItem(eve_num,totalPage,typeArr,items_arr,equips_arr,dataArr);
      }
      
      public function update_money() : void
      {
         this._mart_sold_buy.updateM();
      }
      
      public function update_my_sold_item(eve_num:int, typeArr:Array, items_arr:Array, equips_arr:Array, temArr:Array) : void
      {
         this._my_sold_buy.visible = true;
         if(this.Button_MySold != this.now)
         {
            this.now.choose = false;
            this.Button_MySold.choose = true;
            this.now = this.Button_MySold;
         }
         this._my_sold_buy.update(typeArr,items_arr,equips_arr,eve_num,temArr);
      }
      
      public function update_mart_buy_item(arr:Array, totalPage:int, eve_num:int) : void
      {
         this._mart_sold_buy.visible = true;
         this._mart_sold_buy.getSelfInfo();
         this._mart_sold_buy.updateBoughtItem(arr,totalPage,eve_num);
      }
      
      public function update_my_buy_item(mart_myBuy_arr:Array, eve_num:int) : void
      {
         this._my_sold_buy.visible = true;
         if(this.Button_MyBuy != this.now)
         {
            this.now.choose = false;
            this.Button_MyBuy.choose = true;
            this.now = this.Button_MyBuy;
         }
         this._my_sold_buy.update_my_buy_item(mart_myBuy_arr,eve_num);
      }
      
      public function cancle_update_my_sold() : void
      {
         this._my_sold_buy.cancle_update_item();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.ComboBox;
import com.ui.controls.MyTextField;
import com.ui.controls.TabButton;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.model.Model_mart;
import com.yiTian.data.vo.Vo_Mart;
import com.yiTian.manager.GameUnitManager;
import com.yiTian.manager.LangConfig;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.MartCGMessage;
import com.yiTian.utils.SingleLoader;
import com.yiTian.utils.Utils;
import com.yiTian.view.comp.View_Grid;
import com.yiTian.view.modules.jingmaiHang.Child_HotSearch;
import com.yiTian.view.modules.jingmaiHang.View_JiMaiHang;
import com.yiTian.view.modules.jingmaiHang.View_SoldItems;
import com.yiTian.view.modules.jingmaiHang.View_mySoldItem;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.MouseEvent;
import flash.text.TextFieldType;
import flash.text.TextFormatAlign;

class MartSold extends Sprite
{
   
   public static const timeSear:int = 0;
   
   public static const priceSear:int = 1;
   
   public static var typeArr:Array = new Array();
   
   private static var isShow:Boolean = false;
   
   private var Button_Team:Button;
   
   private var Button_Near:Button;
   
   private var Button_Gang:Button;
   
   private var Button_SendMessige:Button;
   
   private var Button_World:Button;
   
   private var Button_HaoYouLieBiao:Button;
   
   private var Button_All:TabButton;
   
   private var Button_Weapon:TabButton;
   
   private var Button_Armor:TabButton;
   
   private var Button_Jewelry:TabButton;
   
   private var Button_Material:TabButton;
   
   private var Button_Other:TabButton;
   
   private var Button_Gem:TabButton;
   
   private var Button_Pet:TabButton;
   
   private var Button_Seach:Button;
   
   private var Button_PageBack:Button;
   
   private var Button_PageNext:Button;
   
   private var Seach_Profession_text:MyTextField;
   
   private var Seach_Category_tect:MyTextField;
   
   private var Seach_Order_text:MyTextField;
   
   private var Seach_Lever_text:MyTextField;
   
   public var Seach_Name_text:MyTextField;
   
   public var Seach_Name_txt:MyTextField;
   
   private var Number01_text:MyTextField;
   
   private var SellerName01_text:MyTextField;
   
   private var Time06_text:MyTextField;
   
   public var PageNumber_text:MyTextField;
   
   public var JumpPage_text:MyTextField;
   
   private var Versus_text:MyTextField;
   
   private var Ingot_text:MyTextField;
   
   private var Money01_text:MyTextField;
   
   private var MoneyStyle01_text:MyTextField;
   
   private var Button_Job:Button;
   
   private var Button_Type:Button;
   
   private var Button_PinJie:Button;
   
   private var Button_Level:Button;
   
   private var ButtonOK:Button;
   
   public var job:Array = [[LangConfig.getWord("375",0),0],[LangConfig.getWord("305",0),1],[LangConfig.getWord("306",0),2],[LangConfig.getWord("307",0),3],[LangConfig.getWord("308",0),4],[LangConfig.getWord("373",0),5]];
   
   public var type:Array = [[LangConfig.getWord("374",0),0],[LangConfig.getWord("354",0),1],[LangConfig.getWord("355",0),2],[LangConfig.getWord("356",0),3],[LangConfig.getWord("181",0),4],[LangConfig.getWord("303",0),5],[LangConfig.getWord("271",0),6],[LangConfig.getWord("357",0),7]];
   
   public var pin_jie:Array = [[LangConfig.getWord("376",0),0],[LangConfig.getWord("359",0),1],[LangConfig.getWord("360",0),2],[LangConfig.getWord("361",0),3],[LangConfig.getWord("362",0),4]];
   
   public var level:Array = [[LangConfig.getWord("377",0),0],["1-10",1],["11-20",2],["21-30",3],["31-40",4],["41-50",5],["51-60",6],["61-70",7]];
   
   private var _totalPage:int = 1;
   
   private var _solditem:View_SoldItems;
   
   private var mart_buy_item_arr:Array = [];
   
   public var buy_sell_host:MyTextField;
   
   private var price_time_search:Button;
   
   private var searchArr:Vector.<SearchItem> = new Vector.<SearchItem>();
   
   private var nowSearIm:SearchItem;
   
   private var jop_combobox:ComboBox;
   
   private var type_combobox:ComboBox;
   
   private var pinJie_combobox:ComboBox;
   
   private var level_combobox:ComboBox;
   
   public var _curPage:int = 1;
   
   private var isSearCh:Boolean = false;
   
   private var str:String = "sell";
   
   private var temTF:MyTextField;
   
   public var _type:int;
   
   private var now:TabButton;
   
   public function MartSold()
   {
      super();
      this.init();
   }
   
   private function init() : void
   {
      var i:int = 0;
      var searchIm:SearchItem = null;
      ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
         "x":24,
         "y":70,
         "width":661,
         "height":370
      },Global.Img_Cdm);
      ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
         "x":135,
         "y":80,
         "width":540,
         "height":310
      },Global.Img_Cdm);
      ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
         "x":136,
         "y":81,
         "width":536,
         "height":20
      },Global.Img_Cdm);
      ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
         "x":353,
         "y":403,
         "width":80,
         "height":20
      },Global.Img_Cdm);
      ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
         "x":534,
         "y":403,
         "width":60,
         "height":20
      },Global.Img_Cdm);
      ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
         "x":514.75,
         "y":48.75,
         "width":93,
         "height":20
      },Global.Img_Cdm);
      ComponentUtil.getTextField(LangConfig.getWord("60168",6),this,{
         "x":189,
         "y":80,
         "color":16764206,
         "size":12,
         "leading":0
      });
      ComponentUtil.getTextField(LangConfig.getWord("60148",6),this,{
         "x":293,
         "y":80,
         "color":16764206,
         "size":12,
         "leading":0
      });
      ComponentUtil.getTextField(LangConfig.getWord("60023",6),this,{
         "x":613,
         "y":80,
         "color":16764206,
         "size":12,
         "leading":0
      });
      ComponentUtil.getTextField(LangConfig.getWord("60169",6),this,{
         "x":490,
         "y":403,
         "color":11904647,
         "size":12,
         "leading":0
      });
      ComponentUtil.getTextField(LangConfig.getWord("60170",6),this,{
         "x":230,
         "y":442,
         "color":11904647,
         "size":12,
         "leading":0
      });
      ComponentUtil.getTextField(LangConfig.getWord("60171",6),this,{
         "x":50,
         "y":442,
         "color":11904647,
         "size":12,
         "leading":0
      });
      this.Button_All = ComponentUtil.getTabButton(LangConfig.getWord("353",0),"ClassButton",this,{
         "x":34,
         "y":90,
         "textColor":14006150,
         "chooseColor":16773818
      },Global.Img_Cdm);
      this.Button_Weapon = ComponentUtil.getTabButton(LangConfig.getWord("354",0),"ClassButton",this,{
         "x":34,
         "y":128,
         "textColor":14006150,
         "chooseColor":16773818
      },Global.Img_Cdm);
      this.Button_Armor = ComponentUtil.getTabButton(LangConfig.getWord("355",0),"ClassButton",this,{
         "x":34,
         "y":166,
         "textColor":14006150,
         "chooseColor":16773818
      },Global.Img_Cdm);
      this.Button_Jewelry = ComponentUtil.getTabButton(LangConfig.getWord("356",0),"ClassButton",this,{
         "x":34,
         "y":204,
         "textColor":14006150,
         "chooseColor":16773818
      },Global.Img_Cdm);
      this.Button_Gem = ComponentUtil.getTabButton(LangConfig.getWord("181",0),"ClassButton",this,{
         "x":34,
         "y":242,
         "textColor":14006150,
         "chooseColor":16773818
      },Global.Img_Cdm);
      this.Button_Pet = ComponentUtil.getTabButton(LangConfig.getWord("303",0),"ClassButton",this,{
         "x":34,
         "y":280,
         "textColor":14006150,
         "chooseColor":16773818
      },Global.Img_Cdm);
      this.Button_Material = ComponentUtil.getTabButton(LangConfig.getWord("271",0),"ClassButton",this,{
         "x":34,
         "y":318,
         "textColor":14006150,
         "chooseColor":16773818
      },Global.Img_Cdm);
      this.Button_Other = ComponentUtil.getTabButton(LangConfig.getWord("357",0),"ClassButton",this,{
         "x":34,
         "y":356,
         "textColor":14006150,
         "chooseColor":16773818
      },Global.Img_Cdm);
      this.Button_All.choose = true;
      this.now = this.Button_All;
      typeArr = [LangConfig.getWord("935",0),LangConfig.getWord("936",0)];
      this.Button_All.name = "0";
      this.Button_Weapon.name = "1";
      this.Button_Armor.name = "2";
      this.Button_Jewelry.name = "3";
      this.Button_Gem.name = "4";
      this.Button_Pet.name = "5";
      this.Button_Material.name = "6";
      this.Button_Other.name = "7";
      this.Button_All.addEventListener(MouseEvent.CLICK,this.seleteHandle);
      this.Button_Weapon.addEventListener(MouseEvent.CLICK,this.seleteHandle);
      this.Button_Armor.addEventListener(MouseEvent.CLICK,this.seleteHandle);
      this.Button_Jewelry.addEventListener(MouseEvent.CLICK,this.seleteHandle);
      this.Button_Gem.addEventListener(MouseEvent.CLICK,this.seleteHandle);
      this.Button_Pet.addEventListener(MouseEvent.CLICK,this.seleteHandle);
      this.Button_Material.addEventListener(MouseEvent.CLICK,this.seleteHandle);
      this.Button_Other.addEventListener(MouseEvent.CLICK,this.seleteHandle);
      this.Button_Seach = ComponentUtil.getButton(LangConfig.getWord("378",0),"Button_Two",this,{
         "x":612,
         "y":43
      },Global.Img_Cdm);
      this.Button_Seach.textColor = 13434624;
      this.PageNumber_text = ComponentUtil.getTextField(String(this._curPage) + "/" + String(this._totalPage),this,{
         "x":357.7,
         "y":404,
         "realWidth":72,
         "color":12877056
      });
      this.PageNumber_text.align = TextFormatAlign.CENTER;
      this.Button_PageBack = ComponentUtil.getButton("","Button_PageLeft",this,{
         "x":329,
         "y":403,
         "textColor":16184781
      },Global.Img_Cdm);
      this.Button_PageNext = ComponentUtil.getButton("","Button_PageRight",this,{
         "x":436,
         "y":403,
         "textColor":16184781
      },Global.Img_Cdm);
      this.Seach_Name_text = ComponentUtil.getTextField(LangConfig.getWord("69",0),this,{
         "x":514.75,
         "y":48.75,
         "realWidth":93,
         "realHeight":18.5
      });
      this.Seach_Name_text.type = TextFieldType.INPUT;
      this.Seach_Name_text.maxChars = 6;
      this.Seach_Name_text.align = TextFormatAlign.CENTER;
      this.Seach_Name_text.textColor = 14013808;
      this.Seach_Name_text.addEventListener(FocusEvent.FOCUS_IN,this.m_inHandle);
      this.Seach_Name_text.addEventListener(FocusEvent.FOCUS_OUT,this.m_outHandle);
      this.Button_PageBack.name = "prev";
      this.Button_PageNext.name = "next";
      this.Button_PageBack.addEventListener(MouseEvent.CLICK,this.chanHandle);
      this.Button_PageNext.addEventListener(MouseEvent.CLICK,this.chanHandle);
      this.buy_sell_host = ComponentUtil.getTextField(LangConfig.getWord("371",0),this,{
         "x":533.8,
         "y":80,
         "color":16764206
      });
      this.buy_sell_host.textColor = 10338946;
      i = 0;
      while(i < 6)
      {
         this._solditem = new View_SoldItems();
         addChild(this._solditem);
         this._solditem.x = 144;
         this._solditem.y = 100 + i * 47;
         this.mart_buy_item_arr.push(this._solditem);
         this._solditem.visible = false;
         i++;
      }
      this.JumpPage_text = ComponentUtil.getTextField("1",this,{
         "x":546.95,
         "y":403,
         "realWidth":36,
         "realHeight":18,
         "color":12877056
      });
      this.JumpPage_text.align = TextFormatAlign.CENTER;
      this.ButtonOK = ComponentUtil.getButton(LangConfig.getWord("6",0),"Button_Two64",this,{
         "x":599,
         "y":401,
         "textColor":16184781
      },Global.Img_Cdm);
      this.Versus_text = ComponentUtil.getTextField(String(GameUnitManager.hero.silver),this,{
         "x":288.15,
         "y":442
      });
      this.Ingot_text = ComponentUtil.getTextField(String(GameUnitManager.hero.money),this,{
         "x":108.15,
         "y":442
      });
      this.Versus_text.textColor = 16755712;
      this.Ingot_text.textColor = 16383744;
      this.JumpPage_text.type = TextFieldType.INPUT;
      this.JumpPage_text.restrict = ".0-9";
      this.JumpPage_text.maxChars = 3;
      this.JumpPage_text.addEventListener(Event.CHANGE,this.JumpHandle);
      this.ButtonOK.addEventListener(MouseEvent.CLICK,this.jumpOKHandle);
      this.Button_Seach.addEventListener(MouseEvent.CLICK,this.searchHandle);
      i = 0;
      while(i < 2)
      {
         searchIm = new SearchItem(typeArr[i]);
         searchIm.x = 335 + 84 * i;
         searchIm.y = 80;
         searchIm.searType = i;
         addChild(searchIm);
         this.searchArr.push(searchIm);
         searchIm.selected = false;
         searchIm.addEventListener(MouseEvent.CLICK,this.searType);
         i++;
      }
   }
   
   private function searType(e:MouseEvent) : void
   {
      var searIm:SearchItem = e.target as SearchItem;
      if(this.nowSearIm == searIm)
      {
         return;
      }
      if(Boolean(this.nowSearIm))
      {
         this.nowSearIm.selected = false;
      }
      this.nowSearIm = searIm;
      this.nowSearIm.selected = true;
      View_JiMaiHang.searchPrice[this.str] = this.nowSearIm.searType;
      if(UIManager.JMH_panel.now.text == LangConfig.getWord("367",0))
      {
         if(Boolean(View_JiMaiHang.isSearched["sell"]))
         {
            if(View_JiMaiHang.isSearchType == 0)
            {
               MartCGMessage.CG_SEARCH(1,this.Seach_Name_text.text,0,0,0,0,this._curPage,View_JiMaiHang.searchPrice[this.str]);
            }
            else
            {
               MartCGMessage.CG_SEARCH(1,Child_HotSearch.Seach_Name_text,0,0,0,0,this._curPage,View_JiMaiHang.searchPrice[this.str]);
            }
         }
         else
         {
            MartCGMessage.CG_MARTSOLD(this._type,this._curPage,View_JiMaiHang.searchPrice[this.str]);
         }
      }
      else if(UIManager.JMH_panel.now.text == LangConfig.getWord("368",0))
      {
         if(Boolean(View_JiMaiHang.isSearched["buy"]))
         {
            if(View_JiMaiHang.isSearchType == 0)
            {
               MartCGMessage.CG_SEARCH(2,this.Seach_Name_text.text,0,0,0,0,this._curPage,View_JiMaiHang.searchPrice[this.str]);
            }
            else
            {
               MartCGMessage.CG_SEARCH(2,Child_HotSearch.Seach_Name_text,0,0,0,0,this._curPage,View_JiMaiHang.searchPrice[this.str]);
            }
         }
         else
         {
            MartCGMessage.CG_MARTBUY(this._type,this._curPage,View_JiMaiHang.searchPrice[this.str]);
         }
      }
   }
   
   private function searTypeHandle(e:MouseEvent) : void
   {
      var btn:Button = e.target as Button;
      View_JiMaiHang.searchPrice[this.str] = View_JiMaiHang.searchPrice[this.str] == 1 ? 0 : 1;
      this.setSearType(View_JiMaiHang.searchPrice[this.str]);
      if(UIManager.JMH_panel.now.text == LangConfig.getWord("367",0))
      {
         if(Boolean(View_JiMaiHang.isSearched["sell"]))
         {
            if(View_JiMaiHang.isSearchType == 0)
            {
               MartCGMessage.CG_SEARCH(1,this.Seach_Name_text.text,0,0,0,0,this._curPage,View_JiMaiHang.searchPrice[this.str]);
            }
            else
            {
               MartCGMessage.CG_SEARCH(1,Child_HotSearch.Seach_Name_text,0,0,0,0,this._curPage,View_JiMaiHang.searchPrice[this.str]);
            }
         }
         else
         {
            MartCGMessage.CG_MARTSOLD(this._type,this._curPage,View_JiMaiHang.searchPrice[this.str]);
         }
      }
      else if(UIManager.JMH_panel.now.text == LangConfig.getWord("368",0))
      {
         if(Boolean(View_JiMaiHang.isSearched["buy"]))
         {
            if(View_JiMaiHang.isSearchType == 0)
            {
               MartCGMessage.CG_SEARCH(2,this.Seach_Name_text.text,0,0,0,0,this._curPage,View_JiMaiHang.searchPrice[this.str]);
            }
            else
            {
               MartCGMessage.CG_SEARCH(2,Child_HotSearch.Seach_Name_text,0,0,0,0,this._curPage,View_JiMaiHang.searchPrice[this.str]);
            }
         }
         else
         {
            MartCGMessage.CG_MARTBUY(this._type,this._curPage,View_JiMaiHang.searchPrice[this.str]);
         }
      }
   }
   
   private function addComboBox() : void
   {
      this.jop_combobox = new ComboBox(this.job,function(value:Object):void
      {
         trace("value..",value);
      },75,"Button_PageDown","ComboBox_background","_up");
      addChild(this.jop_combobox);
      this.type_combobox = new ComboBox(this.type,function(value:Object):void
      {
         trace("value..",value);
      },75,"Button_PageDown","ComboBox_background","_up");
      addChild(this.type_combobox);
      this.pinJie_combobox = new ComboBox(this.pin_jie,function(value:Object):void
      {
         trace("value..",value);
      },75,"Button_PageDown","ComboBox_background","_up");
      addChild(this.pinJie_combobox);
      this.level_combobox = new ComboBox(this.level,function(value:Object):void
      {
         trace("value..",value);
      },75,"Button_PageDown","ComboBox_background","_up");
      addChild(this.level_combobox);
      this.jop_combobox.x = 248.55 - 59;
      this.jop_combobox.y = 78.55 - 2;
      this.type_combobox.x = 324.75 - 59;
      this.type_combobox.y = 78.55 - 2;
      this.pinJie_combobox.x = 400.95 - 59;
      this.pinJie_combobox.y = 78.55 - 2;
      this.level_combobox.x = 477.15 - 59;
      this.level_combobox.y = 78.55 - 2;
      this.reset();
   }
   
   private function chanHandle(e:MouseEvent) : void
   {
      if(e.target.name == "prev")
      {
         this._curPage -= 1;
         if(this._curPage < 1)
         {
            this._curPage = 1;
         }
         if(UIManager.JMH_panel.now.text == LangConfig.getWord("367",0))
         {
            if(Boolean(View_JiMaiHang.isSearched["sell"]))
            {
               if(View_JiMaiHang.isSearchType == 0)
               {
                  MartCGMessage.CG_SEARCH(1,this.Seach_Name_text.text,0,0,0,0,this._curPage,View_JiMaiHang.searchPrice["sell"]);
               }
               else
               {
                  MartCGMessage.CG_SEARCH(1,Child_HotSearch.Seach_Name_text,0,0,0,0,this._curPage,View_JiMaiHang.searchPrice["sell"]);
               }
            }
            else
            {
               MartCGMessage.CG_MARTSOLD(this._type,this._curPage,View_JiMaiHang.searchPrice["sell"]);
            }
         }
         else if(UIManager.JMH_panel.now.text == LangConfig.getWord("368",0))
         {
            if(Boolean(View_JiMaiHang.isSearched["buy"]))
            {
               if(View_JiMaiHang.isSearchType == 0)
               {
                  MartCGMessage.CG_SEARCH(2,this.Seach_Name_text.text,0,0,0,0,this._curPage,View_JiMaiHang.searchPrice["buy"]);
               }
               else
               {
                  MartCGMessage.CG_SEARCH(2,Child_HotSearch.Seach_Name_text,0,0,0,0,this._curPage,View_JiMaiHang.searchPrice["buy"]);
               }
            }
            else
            {
               MartCGMessage.CG_MARTBUY(this._type,this._curPage,View_JiMaiHang.searchPrice["buy"]);
            }
         }
         this.PageNumber_text.text = String(this._curPage) + "/" + String(this._totalPage);
      }
      else
      {
         this._curPage += 1;
         if(this._curPage > this._totalPage)
         {
            this._curPage = this._totalPage;
         }
         if(UIManager.JMH_panel.now.text == LangConfig.getWord("367",0))
         {
            if(Boolean(View_JiMaiHang.isSearched["sell"]))
            {
               if(View_JiMaiHang.isSearchType == 0)
               {
                  MartCGMessage.CG_SEARCH(1,this.Seach_Name_text.text,0,0,0,0,this._curPage,View_JiMaiHang.searchPrice["sell"]);
               }
               else
               {
                  MartCGMessage.CG_SEARCH(1,Child_HotSearch.Seach_Name_text,0,0,0,0,this._curPage,View_JiMaiHang.searchPrice["sell"]);
               }
            }
            else
            {
               MartCGMessage.CG_MARTSOLD(this._type,this._curPage,View_JiMaiHang.searchPrice["sell"]);
            }
         }
         else if(UIManager.JMH_panel.now.text == LangConfig.getWord("368",0))
         {
            if(Boolean(View_JiMaiHang.isSearched["buy"]))
            {
               if(View_JiMaiHang.isSearchType == 0)
               {
                  MartCGMessage.CG_SEARCH(2,this.Seach_Name_text.text,0,0,0,0,this._curPage,View_JiMaiHang.searchPrice["buy"]);
               }
               else
               {
                  MartCGMessage.CG_SEARCH(2,Child_HotSearch.Seach_Name_text,0,0,0,0,this._curPage,View_JiMaiHang.searchPrice["buy"]);
               }
            }
            else
            {
               MartCGMessage.CG_MARTBUY(this._type,this._curPage,View_JiMaiHang.searchPrice["buy"]);
            }
         }
      }
   }
   
   private function searchHandle(e:MouseEvent) : void
   {
      if(this.Seach_Name_text.text == "" || this.Seach_Name_text.text == LangConfig.getWord("69",0) || this.Seach_Name_text.text == "0")
      {
         UIManager.centerBroadcast.addMsg("<font color=\'#ff0000\'>" + LangConfig.getWord("379",0) + "</font></a>");
         return;
      }
      if(View_JiMaiHang.mart_type == 1)
      {
         View_JiMaiHang.isSearched["sell"] = true;
      }
      else if(View_JiMaiHang.mart_type == 2)
      {
         View_JiMaiHang.isSearched["buy"] = true;
      }
      this._totalPage = 1;
      this._curPage = 1;
      this.PageNumber_text.text = String(this._curPage) + "/" + String(this._totalPage);
      if(UIManager.JMH_panel.now.text == LangConfig.getWord("367",0))
      {
         MartCGMessage.CG_SEARCH(1,this.Seach_Name_text.text,0,0,0,0,1,View_JiMaiHang.searchPrice["sell"]);
      }
      else if(UIManager.JMH_panel.now.text == LangConfig.getWord("368",0))
      {
         MartCGMessage.CG_SEARCH(2,this.Seach_Name_text.text,0,0,0,0,1,View_JiMaiHang.searchPrice["buy"]);
      }
      View_JiMaiHang.isSearchType = 0;
   }
   
   private function setSearType(_type:int) : void
   {
      if(Boolean(this.nowSearIm))
      {
         this.nowSearIm.selected = false;
      }
      if(_type == 0)
      {
         this.searchArr[timeSear].selected = true;
         this.nowSearIm = this.searchArr[timeSear];
      }
      else if(_type == 1)
      {
         this.searchArr[priceSear].selected = true;
         this.nowSearIm = this.searchArr[priceSear];
      }
   }
   
   private function showBmp() : void
   {
      isShow = true;
   }
   
   override public function set visible(value:Boolean) : void
   {
      super.visible = value;
      if(!value)
      {
         View_JiMaiHang.isSearched["sell"] = false;
         View_JiMaiHang.isSearched["buy"] = false;
         this._type = 0;
      }
      else if(!Global.Mart_Imgsdm)
      {
         SingleLoader.add("lang/ch/Mart_Imgs.swf",function(info:Object):void
         {
            Global.Mart_Imgsdm = info.applicationDomain;
            showBmp();
         });
      }
      else if(!isShow)
      {
         this.showBmp();
      }
   }
   
   public function updateSoldItem(ever_num:int, totalPage:int, typeArr:Array, items:Array, equips:Array, data_arr:Array) : void
   {
      var temItem:View_SoldItems = null;
      this.str = "sell";
      this.setSearType(View_JiMaiHang.searchPrice[this.str]);
      var j:int = 0;
      var m:int = 0;
      this.page_changed_handle();
      if(ever_num < 1)
      {
         this._totalPage = totalPage;
         this.PageNumber_text.text = String(this._curPage) + "/" + String(totalPage);
         return;
      }
      var i:int = 0;
      while(i <= ever_num - 1)
      {
         trace("数据长度",ever_num);
         temItem = this.mart_buy_item_arr[i];
         temItem.visible = true;
         temItem.bought_sold_label = LangConfig.getWord("7",0);
         temItem.currentPage = this._curPage;
         temItem.update(data_arr[i]);
         if(typeArr[i] == 1)
         {
            temItem.set_vec_item(items[j]);
            j++;
         }
         else
         {
            temItem.set_vec_equip(equips[m]);
            m++;
         }
         i++;
      }
      this._totalPage = totalPage;
      this.PageNumber_text.text = String(this._curPage) + "/" + String(this._totalPage);
      this.JumpPage_text.text = String(this._curPage);
   }
   
   public function updateM() : void
   {
      this.Versus_text.text = Utils.getGapNum(String(GameUnitManager.hero.silver));
      this.Ingot_text.text = Utils.getGapNum(String(GameUnitManager.hero.money));
   }
   
   public function updata_single(mart_id:Number, _num:int) : void
   {
      var tem_item:View_SoldItems = null;
      var i:int = 0;
      while(i < this.mart_buy_item_arr.length)
      {
         tem_item = this.mart_buy_item_arr[i];
         if(tem_item._martId == mart_id)
         {
            tem_item.update_num(_num);
            return;
         }
         i++;
      }
   }
   
   public function updateBoughtItem(arr:Array, totalPage:int, eve_num:int) : void
   {
      var temItem:View_SoldItems = null;
      this.str = "buy";
      this.setSearType(View_JiMaiHang.searchPrice[this.str]);
      this.page_changed_handle();
      var temII:int = 0;
      while(temII < 6)
      {
         this.mart_buy_item_arr[temII].visible = false;
         temII++;
      }
      this._totalPage = totalPage;
      this.PageNumber_text.text = String(this._curPage) + "/" + String(this._totalPage);
      this.JumpPage_text.text = String(this._curPage);
      var i:int = 0;
      while(i < eve_num)
      {
         temItem = this.mart_buy_item_arr[i];
         temItem.bought_sold_label = LangConfig.getWord("15",0);
         temItem.visible = true;
         temItem.currentPage = this._curPage;
         temItem.update_bought_item(arr[i]);
         i++;
      }
      this._totalPage = totalPage;
      this.PageNumber_text.text = String(this._curPage) + "/" + String(this._totalPage);
      this.JumpPage_text.text = String(this._curPage);
   }
   
   private function jumpOKHandle(e:MouseEvent) : void
   {
      if(int(this.JumpPage_text.text) == this._curPage)
      {
         return;
      }
      this.page_changed_handle();
      this._curPage = int(this.JumpPage_text.text);
      this.PageNumber_text.text = String(this._curPage) + "/" + String(this._totalPage);
      if(UIManager.JMH_panel.now.text == LangConfig.getWord("367",0))
      {
         if(Boolean(View_JiMaiHang.isSearched["sell"]))
         {
            if(View_JiMaiHang.isSearchType == 0)
            {
               MartCGMessage.CG_SEARCH(1,this.Seach_Name_text.text,0,0,0,0,this._curPage,View_JiMaiHang.searchPrice["sell"]);
            }
            else
            {
               MartCGMessage.CG_SEARCH(1,Child_HotSearch.Seach_Name_text,0,0,0,0,this._curPage,View_JiMaiHang.searchPrice["sell"]);
            }
         }
         else
         {
            MartCGMessage.CG_MARTSOLD(this._type,int(this.JumpPage_text.text),View_JiMaiHang.searchPrice["sell"]);
         }
      }
      else if(UIManager.JMH_panel.now.text == LangConfig.getWord("368",0))
      {
         if(Boolean(View_JiMaiHang.isSearched["buy"]))
         {
            MartCGMessage.CG_SEARCH(2,this.Seach_Name_text.text,0,0,0,0,this._curPage,View_JiMaiHang.searchPrice["buy"]);
         }
         else
         {
            MartCGMessage.CG_MARTBUY(this._type,int(this.JumpPage_text.text),View_JiMaiHang.searchPrice["buy"]);
         }
      }
   }
   
   public function JumpHandle(e:Event) : void
   {
      this.temTF = e.target as MyTextField;
      if(int(this.temTF.text) >= this._totalPage)
      {
         this.temTF.text = String(this._totalPage);
      }
      else if(int(this.temTF.text) <= 1)
      {
         this.temTF.text = "1";
      }
   }
   
   private function seleteHandle(e:MouseEvent) : void
   {
      var btn:TabButton = e.target as TabButton;
      if(this.now == btn)
      {
         return;
      }
      if(Boolean(this.now))
      {
         this.now.choose = false;
      }
      btn.choose = true;
      this.now = btn;
      View_JiMaiHang.isSearched["sell"] = false;
      View_JiMaiHang.isSearched["buy"] = false;
      this.page_changed_handle();
      var temNum:int = int(e.target.name);
      this._type = temNum;
      if(UIManager.JMH_panel.now.text == LangConfig.getWord("367",0))
      {
         MartCGMessage.CG_MARTSOLD(temNum,1,View_JiMaiHang.searchPrice["sell"]);
      }
      else if(UIManager.JMH_panel.now.text == LangConfig.getWord("368",0))
      {
         MartCGMessage.CG_MARTBUY(temNum,1,View_JiMaiHang.searchPrice["buy"]);
      }
      this._curPage = 1;
      this.PageNumber_text.text = String(this._curPage) + "/" + String(this._totalPage);
   }
   
   public function getSelfInfo() : void
   {
      this.Versus_text.text = Utils.getGapNum(String(GameUnitManager.hero.silver));
      this.Ingot_text.text = Utils.getGapNum(String(GameUnitManager.hero.money));
   }
   
   private function m_inHandle(e:FocusEvent) : void
   {
      var tf:MyTextField = e.target as MyTextField;
      if(tf.text == LangConfig.getWord("69",0))
      {
         tf.text = "";
      }
   }
   
   private function m_outHandle(e:FocusEvent) : void
   {
      var tf:MyTextField = e.target as MyTextField;
      if(tf.text == "")
      {
         tf.text = LangConfig.getWord("69",0);
      }
   }
   
   private function page_changed_handle() : void
   {
      var i:int = 0;
      while(i < this.mart_buy_item_arr.length)
      {
         this.mart_buy_item_arr[i].visible = false;
         i++;
      }
   }
   
   public function reset() : void
   {
      var i:int = 0;
      while(i < 6)
      {
         this.mart_buy_item_arr[i].visible = false;
         i++;
      }
      this.PageNumber_text.text = "1/1";
      this.JumpPage_text.text = "1";
      this._curPage = 1;
      if(Boolean(this.now))
      {
         this.now.choose = false;
      }
      this.Button_All.choose = true;
      this.now = this.Button_All;
   }
}

class MartMyBuy extends Sprite
{
   
   private var Button_PageBack:Button;
   
   private var Button_PageNext:Button;
   
   private var Button_Sold:Button;
   
   private var Button_Buy:Button;
   
   private var JumpPage_text:MyTextField;
   
   private var PageNumber_text:MyTextField;
   
   private var Total01_text:MyTextField;
   
   private var Total02_text:MyTextField;
   
   private var Already02_text:MyTextField;
   
   private var Total03_text:MyTextField;
   
   private var Already03_text:MyTextField;
   
   private var Total04_text:MyTextField;
   
   private var Already04_text:MyTextField;
   
   private var Total05_text:MyTextField;
   
   private var Already05_text:MyTextField;
   
   private var Name06_text:MyTextField;
   
   private var Time06_text:MyTextField;
   
   private var Money06_text:MyTextField;
   
   private var MoneyStyle06_text:MyTextField;
   
   private var Total06_text:MyTextField;
   
   private var Already06_text:MyTextField;
   
   private var boughtTotal_text:MyTextField;
   
   private var buyTotal_text:MyTextField;
   
   private var grid:View_Grid;
   
   public var my_itemArr:Array = [];
   
   public var _my_sold_item:View_mySoldItem;
   
   public function MartMyBuy()
   {
      super();
      this.init();
   }
   
   private function init() : void
   {
      ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
         "x":24,
         "y":70,
         "width":656,
         "height":390
      },Global.Img_Cdm);
      ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
         "x":29,
         "y":75,
         "width":646,
         "height":350
      },Global.Img_Cdm);
      ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
         "x":30,
         "y":76,
         "width":644,
         "height":20
      },Global.Img_Cdm);
      ComponentUtil.getTextField(LangConfig.getWord("60168",6),this,{
         "x":80,
         "y":76,
         "color":16764206,
         "size":12,
         "leading":0
      });
      ComponentUtil.getTextField(LangConfig.getWord("60172",6),this,{
         "x":209,
         "y":76,
         "color":16764206,
         "size":12,
         "leading":0
      });
      ComponentUtil.getTextField(LangConfig.getWord("60173",6),this,{
         "x":310,
         "y":76,
         "color":16764206,
         "size":12,
         "leading":0
      });
      ComponentUtil.getTextField(LangConfig.getWord("60023",6),this,{
         "x":600,
         "y":76,
         "color":16764206,
         "size":12,
         "leading":0
      });
      this.Button_Buy = ComponentUtil.getButton(LangConfig.getWord("381",0),"Button_Four",this,{
         "x":114.05,
         "y":411 + 42
      },Global.Img_Cdm);
      this.Button_Sold = ComponentUtil.getButton(LangConfig.getWord("380",0),"Button_Four",this,{
         "x":581,
         "y":430,
         "textColor":16184781
      },Global.Img_Cdm);
      this.Button_Buy.visible = false;
      this.boughtTotal_text = ComponentUtil.getTextField(LangConfig.getWord("382",0),this,{
         "x":427.6 + 70,
         "y":76,
         "textColor":10338946
      });
      this.buyTotal_text = ComponentUtil.getTextField(LangConfig.getWord("383",0),this,{
         "x":343 + 70,
         "y":76,
         "textColor":10338946
      });
      var i:int = 0;
      while(i <= 6)
      {
         this._my_sold_item = new View_mySoldItem();
         addChild(this._my_sold_item);
         this._my_sold_item.x = 32;
         this._my_sold_item.y = 99 + i * 46;
         this.my_itemArr.push(this._my_sold_item);
         this._my_sold_item.visible = false;
         this._my_sold_item = null;
         i++;
      }
      this.Button_Sold.addEventListener(MouseEvent.CLICK,this.soldHandle);
      this.Button_Sold.addEventListener(MouseEvent.MOUSE_DOWN,this.soldDown);
      this.Button_Buy.addEventListener(MouseEvent.MOUSE_DOWN,this.buyDown);
      this.Button_Buy.addEventListener(MouseEvent.CLICK,this.buyHandle);
   }
   
   private function soldDown(e:MouseEvent) : void
   {
      e.stopPropagation();
   }
   
   private function soldHandle(e:MouseEvent) : void
   {
      Model_mart.martSoldHandle(e.target.label);
   }
   
   public function update_title(_type:int) : void
   {
      if(_type == 1)
      {
         this.boughtTotal_text.text = LangConfig.getWord("382",0);
         this.buyTotal_text.text = LangConfig.getWord("383",0);
         this.setBtn(LangConfig.getWord("380",0));
      }
      else if(_type == 2)
      {
         this.boughtTotal_text.text = LangConfig.getWord("384",0);
         this.buyTotal_text.text = LangConfig.getWord("385",0);
         this.setBtn(LangConfig.getWord("381",0));
      }
   }
   
   private function setBtn(str:String) : void
   {
      this.Button_Sold.label = str;
   }
   
   private function buyDown(e:MouseEvent) : void
   {
      e.stopPropagation();
   }
   
   private function buyHandle(e:MouseEvent) : void
   {
      if(UIManager.sold_set.visible)
      {
         UIManager.sold_set.visible = false;
      }
   }
   
   public function update(typeArr:Array, items:Array, equips:Array, eve_num:int, data_arr:Array) : void
   {
      var temItem:View_mySoldItem = null;
      var temMart:Vo_Mart = null;
      this.cancle_update_item();
      if(!eve_num)
      {
         return;
      }
      var j:int = 0;
      var m:int = 0;
      if(eve_num > 7)
      {
         eve_num = 7;
      }
      var i:int = 0;
      while(i < eve_num)
      {
         temItem = this.my_itemArr[i];
         temItem.visible = true;
         if(typeArr[i] == 1)
         {
            temItem.set_vec_item(items[j]);
            j++;
         }
         else
         {
            temItem.set_vec_equip(equips[m]);
            m++;
         }
         temMart = data_arr[i];
         temItem._costType = temMart.price_type;
         temItem._martId = temMart.mart_id;
         temItem.timeLeft = temMart.left_time;
         temItem.money = temMart.price;
         temItem.tatolNum = temMart.good_num;
         temItem.soldNum = temMart.sold_bought_num;
         i++;
      }
   }
   
   public function update_my_buy_item(mart_myBuy_arr:Array, eve_num:int) : void
   {
      var temItem:View_mySoldItem = null;
      var i:int = 0;
      while(i < eve_num)
      {
         temItem = this.my_itemArr[i];
         temItem.visible = true;
         temItem.update(mart_myBuy_arr[i]);
         i++;
      }
   }
   
   public function cancle_update_item() : void
   {
      var i:int = 0;
      while(i < 7)
      {
         this.my_itemArr[i].visible = false;
         i++;
      }
   }
   
   public function reset() : void
   {
      if(UIManager.sold_set.visible)
      {
         UIManager.sold_set.visible = false;
      }
      if(UIManager.buy_set.visible)
      {
         UIManager.buy_set.visible = false;
      }
      var i:int = 0;
      while(i < 7)
      {
         this.my_itemArr[i].visible = false;
         i++;
      }
   }
}

class SearchItem extends Sprite
{
   
   private var tf:MyTextField;
   
   private var bmp:Bitmap = new Bitmap();
   
   private var property:Object = new Object();
   
   private var disUrl:String = "resource/image/mart/nunChoose.png";
   
   private var url:String = "resource/image/mart/choose.png";
   
   private var _searType:int;
   
   private var _selected:Boolean;
   
   public function SearchItem(str:String)
   {
      super();
      buttonMode = true;
      mouseChildren = true;
      mouseEnabled = true;
      this.tf = ComponentUtil.getTextField("",this,{"color":16184781});
      this.tf.htmlText = str;
      this._searType = this.searType;
      this.bmp.x = this.tf.x + this.tf.width;
      addChild(this.bmp);
   }
   
   public function set selected(value:Boolean) : void
   {
      this._selected = value;
      this.bmp.bitmapData = null;
      if(value)
      {
         this.bmp = Utils.getLoadBitmap(this.url,this.bmp,this.property);
      }
      else
      {
         this.bmp = Utils.getLoadBitmap(this.disUrl,this.bmp,this.property);
      }
   }
   
   public function set searType(value:int) : void
   {
      this._searType = value;
   }
   
   public function get searType() : int
   {
      return this._searType;
   }
   
   public function get selected() : Boolean
   {
      return this._selected;
   }
}
