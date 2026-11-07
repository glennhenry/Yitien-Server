package com.yiTian.view.modules.Shopping
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_store;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_store;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.StoreCGMessage;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.Panel;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_shoppingMall extends Panel
   {
      
      public static var YUANBAO_STORE:int = 0;
      
      public static var LIQUAN_STORE:int = 1;
      
      public static var CHONGZHI_FANDIAN:int = 2;
      
      public static var LINGPAI_SHANGCHENG:int = 3;
      
      public static var SHIXIAO_SHANGCHENG:int = 4;
      
      public static var YUANBAO:int = 1;
      
      public static var LIJUAN:int = 2;
      
      public static var CHONGZHI:int = 3;
      
      public static var SHIXIAO:int = 4;
      
      public static var LINGPAI:int = 5;
      
      public static var VIP:int = 6;
      
      public static var HUODONG:int = 7;
      
      public static var YOUHUI:int = 8;
      
      public static var extralOpenPage:int = 0;
      
      private static var isLoad:Boolean = false;
      
      public static var _curPage:int = 1;
      
      public var yuanBao_Shangcheng:TabButton;
      
      private var liJuan_Shangcheng:TabButton;
      
      private var chongzhi_fanDian:TabButton;
      
      private var shixiao_Shangcheng:TabButton;
      
      private var lingPai_Shangcheng:TabButton;
      
      private var VIP_Shangcheng:TabButton;
      
      private var action_Shangcheng:TabButton;
      
      private var YBchongzhi_Button:Button;
      
      private var pageLeft_Button:Button;
      
      private var pageRight_Button:Button;
      
      private var page1_text:MyTextField;
      
      private var pageL_Button:Button;
      
      private var pageR_Button:Button;
      
      private var page2_text:MyTextField;
      
      private var youhui_back:DisplayObject;
      
      public var dataItem_arr:Array = [];
      
      public var youHuiItem_arr:Array = [];
      
      private var items_got_arr:Array = [];
      
      private var items_got:View_items_got;
      
      private var btn_vec:Vector.<TabButton> = new Vector.<TabButton>();
      
      public var now:TabButton;
      
      public var _sign:int;
      
      public var _totalPage:int;
      
      public var _YH_curPage:int = 1;
      
      public var _YH_totalPage:int;
      
      private var wp_id_arr:Array = [46252,46253,46254,46255];
      
      public var YH_arr:Array = [];
      
      public function View_shoppingMall()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var i:int = 0;
         var k:int = 0;
         var storeItem:View_shoppingItem = null;
         var youHuiItem:View_StoreYouHui = null;
         isTween = true;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":846,
            "height":463
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":29,
            "y":70,
            "width":583,
            "height":360
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":518,
            "y":400,
            "width":60,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":617,
            "y":70,
            "width":200,
            "height":360
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_TouZi",[13,13,2,2],this,{
            "x":620,
            "y":73,
            "width":194,
            "height":354
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60290",6),this,{
            "x":680,
            "y":44,
            "color":16777011,
            "size":16,
            "leading":0
         });
         move = new Rectangle(0,0,750,38);
         this.yuanBao_Shangcheng = ComponentUtil.getTabButton(LangConfig.getWord("126",0),"TabButton_Four",this,{
            "x":34,
            "y":49,
            "textColor":16773818,
            "chooseColor":16383744,
            "name":"3"
         },Global.Img_Cdm);
         this.liJuan_Shangcheng = ComponentUtil.getTabButton(LangConfig.getWord("127",0),"TabButton_Four",this,{
            "x":110,
            "y":49,
            "textColor":16773818,
            "chooseColor":16383744,
            "name":"4"
         },Global.Img_Cdm);
         this.chongzhi_fanDian = ComponentUtil.getTabButton(LangConfig.getWord("128",0),"TabButton_Four",this,{
            "x":186,
            "y":49,
            "textColor":16773818,
            "chooseColor":16383744,
            "name":"5"
         },Global.Img_Cdm);
         this.shixiao_Shangcheng = ComponentUtil.getTabButton(LangConfig.getWord("983",0),"TabButton_Four",this,{
            "x":262,
            "y":49,
            "textColor":16773818,
            "chooseColor":16383744,
            "name":"7"
         },Global.Img_Cdm);
         this.lingPai_Shangcheng = ComponentUtil.getTabButton(LangConfig.getWord("129",0),"TabButton_Four",this,{
            "x":338,
            "y":49,
            "textColor":16773818,
            "chooseColor":16383744,
            "name":"1"
         },Global.Img_Cdm);
         this.yuanBao_Shangcheng.choose = true;
         this.now = this.yuanBao_Shangcheng;
         this.btn_vec[YUANBAO_STORE] = this.yuanBao_Shangcheng;
         this.btn_vec[LIQUAN_STORE] = this.liJuan_Shangcheng;
         this.btn_vec[CHONGZHI_FANDIAN] = this.chongzhi_fanDian;
         this.btn_vec[LINGPAI_SHANGCHENG] = this.lingPai_Shangcheng;
         this.btn_vec[SHIXIAO_SHANGCHENG] = this.shixiao_Shangcheng;
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":812,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.YBchongzhi_Button = ComponentUtil.getButton(LangConfig.getWord("130",0),"Button_Four",this,{
            "x":735,
            "y":433,
            "textColor":16184781
         },Global.Img_Cdm);
         this.page1_text = ComponentUtil.getTextField("00/00",this,{
            "x":536,
            "y":401,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.pageRight_Button = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":580,
            "y":400,
            "textColor":16184781
         },Global.Img_Cdm);
         this.pageLeft_Button = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":495,
            "y":400,
            "textColor":16184781
         },Global.Img_Cdm);
         this.page2_text = ComponentUtil.getTextField("00/00",this,{
            "x":530,
            "y":401,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.page2_text.visible = false;
         i = 0;
         while(i < 12)
         {
            storeItem = new View_shoppingItem();
            addChild(storeItem);
            storeItem.x = 37 + 190 * int(i % 3);
            storeItem.y = 78 + 81 * int(i / 3);
            this.dataItem_arr.push(storeItem);
            storeItem.visible = false;
            storeItem = null;
            i++;
         }
         k = 0;
         while(k < 2)
         {
            youHuiItem = new View_StoreYouHui();
            addChild(youHuiItem);
            youHuiItem.x = 617;
            youHuiItem.y = 86 + 171 * k;
            this.youHuiItem_arr.push(youHuiItem);
            youHuiItem.visible = false;
            youHuiItem = null;
            k++;
         }
         var j:int = 0;
         while(j < 4)
         {
            this.items_got = new View_items_got();
            addChild(this.items_got);
            this.items_got.x = 30 + j * 163;
            this.items_got.y = 434;
            this.items_got_arr.push(this.items_got);
            this.items_got.visible = false;
            this.items_got = null;
            j++;
         }
         this.yuanBao_Shangcheng.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.liJuan_Shangcheng.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.chongzhi_fanDian.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.shixiao_Shangcheng.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.lingPai_Shangcheng.addEventListener(MouseEvent.CLICK,this.cliHandle);
         this.pageLeft_Button.name = "minus";
         this.pageRight_Button.name = "add";
         this.pageLeft_Button.addEventListener(MouseEvent.CLICK,this.pageChangeHandle);
         this.pageRight_Button.addEventListener(MouseEvent.CLICK,this.pageChangeHandle);
         this.YBchongzhi_Button.callBack = this.chongZhiHandle;
      }
      
      private function chongZhiHandle(e:MouseEvent) : void
      {
         UIManager.yuanBaoXiang.visible = !UIManager.yuanBaoXiang.visible;
      }
      
      public function initStore() : void
      {
         _curPage = 1;
         this._sign = 1;
         extralOpenPage = 0;
         var i:int = 0;
         while(i < 12)
         {
            this.dataItem_arr[i].temNum = 1;
            this.dataItem_arr[i].Enter_Number.text = "1";
            i++;
         }
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
         this.page1_changed_reset();
         extralOpenPage = 0;
         if(btn.name == "1")
         {
            this._sign = 1;
            StoreCGMessage.CG_PLAZA(6);
            if(!Boolean(Model_store.store_data_sava[YUANBAO]))
            {
               StoreCGMessage.CG_PLAZA(1);
               return;
            }
            trace("缓存数据:",Model_store.store_data_sava[YUANBAO]);
         }
         else if(btn.name == "2")
         {
            this._sign = 2;
            StoreCGMessage.CG_PLAZA(6);
            if(!Boolean(Model_store.store_data_sava[LIJUAN]))
            {
               StoreCGMessage.CG_PLAZA(2);
               return;
            }
            trace("缓存数据:",Model_store.store_data_sava[LIJUAN]);
         }
         else if(btn.name == "3")
         {
            this._sign = 3;
            StoreCGMessage.CG_PLAZA(6);
            if(!Boolean(Model_store.store_data_sava[CHONGZHI]))
            {
               StoreCGMessage.CG_PLAZA(3);
               return;
            }
            trace("缓存数据:",Model_store.store_data_sava[CHONGZHI]);
         }
         else if(btn.name == "4")
         {
            this._sign = 4;
            StoreCGMessage.CG_PLAZA(6);
            if(!Boolean(Model_store.store_data_sava[SHIXIAO]))
            {
               StoreCGMessage.CG_PLAZA(4);
               return;
            }
            trace("缓存数据:",Model_store.store_data_sava[SHIXIAO]);
         }
         else if(btn.name == "5")
         {
            this._sign = 5;
            StoreCGMessage.CG_PLAZA(6);
            if(!Boolean(Model_store.store_data_sava[LINGPAI]))
            {
               StoreCGMessage.CG_PLAZA(5);
               return;
            }
            trace("缓存数据:",Model_store.store_data_sava[LINGPAI]);
         }
         else if(btn.name == "6")
         {
            this._sign = 6;
            StoreCGMessage.CG_PLAZA(6);
            if(!Boolean(Model_store.store_data_sava[VIP]))
            {
               StoreCGMessage.CG_PLAZA(6);
               return;
            }
            trace("缓存数据:",Model_store.store_data_sava[VIP]);
         }
         else if(btn.name == "7")
         {
            this._sign = 7;
            StoreCGMessage.CG_PLAZA(6);
            if(!Boolean(Model_store.store_data_sava[7]))
            {
               StoreCGMessage.CG_PLAZA(7);
               return;
            }
            trace("缓存数据:",Model_store.store_data_sava[7]);
         }
         UIManager.shoppingMall.update(1,this._YH_curPage,this.YH_arr);
      }
      
      public function getShoppingMall() : void
      {
         this.liJuan_Shangcheng.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      public function openView(typeIndex:int, page:int) : void
      {
         if(!visible)
         {
            this.visible = true;
         }
         this.btn_vec[typeIndex].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         extralOpenPage = page;
      }
      
      private function page1_changed_reset() : void
      {
         var temI:int = 0;
         while(temI < 12)
         {
            this.dataItem_arr[temI].visible = false;
            this.dataItem_arr[temI].temNum = 1;
            this.dataItem_arr[temI].Enter_Number.text = "1";
            temI++;
         }
         temI = 0;
         while(temI < 4)
         {
            this.items_got_arr[temI].visible = false;
            temI++;
         }
         if(UIManager.storeTip.visible)
         {
            UIManager.storeTip.visible = false;
         }
      }
      
      public function pageChangeHandle(e:MouseEvent) : void
      {
         var temBtn:Button = e.target as Button;
         if(temBtn.name == "add")
         {
            if(_curPage == this._totalPage)
            {
               return;
            }
            ++_curPage;
            if(_curPage > this._totalPage)
            {
               _curPage = this._totalPage;
            }
         }
         else
         {
            if(_curPage == 1)
            {
               return;
            }
            --_curPage;
            if(_curPage < 1)
            {
               _curPage = 1;
            }
         }
         var i:int = 0;
         while(i < 12)
         {
            this.dataItem_arr[i].temNum = 1;
            this.dataItem_arr[i].Enter_Number.text = "1";
            i++;
         }
         this.update(_curPage,this._YH_curPage,this.YH_arr);
      }
      
      public function page2ChangeHandle(e:MouseEvent) : void
      {
         var temBtn:Button = e.target as Button;
         if(temBtn.name == "add")
         {
            if(this._YH_curPage == this._YH_totalPage)
            {
               return;
            }
            ++this._YH_curPage;
            if(this._YH_curPage > this._YH_totalPage)
            {
               this._YH_curPage = this._YH_totalPage;
            }
         }
         else
         {
            if(this._YH_curPage == 1)
            {
               return;
            }
            --this._YH_curPage;
            if(this._YH_curPage < 1)
            {
               this._YH_curPage = 1;
            }
         }
         var i:int = 0;
         while(i < 2)
         {
            this.youHuiItem_arr[i].temNum = 1;
            this.youHuiItem_arr[i].Enter_Number.text = "1";
            i++;
         }
         this.update(_curPage,this._YH_curPage,this.YH_arr);
      }
      
      public function getSpecialLingPai() : void
      {
         this.visible = !visible;
         if(visible)
         {
            this.liJuan_Shangcheng.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         var i:int = 0;
         super.visible = value;
         if(!value)
         {
            this.yuanBao_Shangcheng.choose = false;
            this.liJuan_Shangcheng.choose = false;
            this.chongzhi_fanDian.choose = false;
            this.shixiao_Shangcheng.choose = false;
            this.lingPai_Shangcheng.choose = false;
            i = 0;
            while(i < 12)
            {
               this.dataItem_arr[i].temNum = 1;
               this.dataItem_arr[i].Enter_Number.text = "1";
               this.dataItem_arr[i].visible = false;
               i++;
            }
            i = 0;
            while(i < 4)
            {
               this.items_got_arr[i].visible = false;
               i++;
            }
            i = 0;
            while(i < 2)
            {
               this.youHuiItem_arr[i].temNum = 1;
               this.youHuiItem_arr[i].Enter_Number.text = "1";
               i++;
            }
            this.yuanBao_Shangcheng.choose = true;
            this.now = this.yuanBao_Shangcheng;
            _curPage = 1;
            Global.control.removeCallBack(Enum_MsgType.BAG_UPDATE,this.updateMon);
         }
         else
         {
            Global.control.registerCallBack(Enum_MsgType.BAG_UPDATE,this.updateMon);
            _curPage = 1;
            this.initData();
            if(!isLoad)
            {
               SingleLoader.add("lang/ch/NPC_Imgs.swf",function(info:Object):void
               {
                  Global.NPC_Imgsdm = info.applicationDomain;
                  showTl();
               });
            }
         }
      }
      
      private function showTl() : void
      {
         ComponentUtil.getBitmap("Title_ShangCheng",this,{
            "x":343,
            "y":5
         },Global.NPC_Imgsdm);
      }
      
      private function updateMon() : void
      {
         this.updateMoney(this._sign);
      }
      
      public function initData() : void
      {
         if(Boolean(Model_store.store_data_sava[3]))
         {
            UIManager.shoppingMall.initStore();
            StoreCGMessage.CG_PLAZA(6);
            UIManager.shoppingMall._sign = 3;
            UIManager.shoppingMall.update(_curPage,1,UIManager.shoppingMall.YH_arr);
         }
         else
         {
            UIManager.shoppingMall.initStore();
            StoreCGMessage.CG_PLAZA(6);
            StoreCGMessage.CG_PLAZA(3);
         }
      }
      
      public function update(_curP:int, _curP2:int, yh_arr:Array) : void
      {
         _curPage = _curP;
         this._YH_curPage = _curP2;
         this.updateMoney(this._sign);
         var temI:int = 0;
         while(temI < 12)
         {
            this.dataItem_arr[temI].visible = false;
            temI++;
         }
         this.init_YH_data(_curP,_curP2,yh_arr);
         this.init_ST_data(_curP,_curP2,yh_arr);
      }
      
      private function init_YH_data(_curP:int, _curP2:int, yh_arr:Array) : void
      {
         var temYHItem:View_StoreYouHui = null;
         var temYHItemData:Vo_store = null;
         var voItem:Vo_item = null;
         var voEquit:Vo_equip = null;
         this.YH_arr = yh_arr;
         if(!this.YH_arr.length)
         {
            return;
         }
         Model_store.store_youhui_data[6] = this.YH_arr;
         this._YH_totalPage = this.YH_arr.length / 2 + int(this.YH_arr.length % 2 != 0);
         this.page2_text.text = String(this._YH_curPage) + "/" + String(this._YH_totalPage);
         var _i:int = 0;
         while(_i < this.YH_arr.length)
         {
            temYHItem = this.youHuiItem_arr[_i];
            temYHItem.visible = true;
            temYHItemData = this.YH_arr[_i];
            if(temYHItemData.type == 1)
            {
               voItem = new Vo_item();
               voItem.id = temYHItemData.wpid;
               voItem.Init_lib();
               temYHItem.update(voItem,temYHItemData,_i);
            }
            else if(temYHItemData.type == 2)
            {
               voEquit = new Vo_equip();
               voEquit.id = temYHItemData.wpid;
               voEquit.Init_lib();
               temYHItem.update(voEquit,temYHItemData,_i);
            }
            _i++;
         }
      }
      
      private function init_ST_data(_curP:int, _curP2:int, yh_arr:Array) : void
      {
         var temData:View_shoppingItem = null;
         var i:int = 0;
         var temStoreData:Vo_store = null;
         var temItem:Vo_item = null;
         var temEquit:Vo_equip = null;
         var temN:int = 0;
         var k:int = 0;
         var LstemData:View_shoppingItem = null;
         var LstemStoreData:Vo_store = null;
         var LstemItem:Vo_item = null;
         var LstemEquit:Vo_equip = null;
         if(!Model_store.store_data_sava[this._sign])
         {
            return;
         }
         if(!Model_store.store_data_sava[this._sign].length)
         {
            return;
         }
         if(Model_store.store_data_sava[this._sign].length % 12 == 0)
         {
            this._totalPage = Model_store.store_data_sava[this._sign].length / 12;
         }
         else
         {
            this._totalPage = Model_store.store_data_sava[this._sign].length / 12 + 1;
         }
         this.page1_text.text = String(_curPage) + "/" + String(this._totalPage);
         var temArr:Array = Model_store.store_data_sava[this._sign];
         if(_curPage != this._totalPage)
         {
            i = 0;
            while(i < 12)
            {
               temData = this.dataItem_arr[i];
               temData.visible = true;
               temStoreData = Model_store.store_data_sava[this._sign][i + (_curP - 1) * 12];
               if(temStoreData.type == 1)
               {
                  temItem = new Vo_item();
                  temItem.id = temStoreData.wpid;
                  temData._sign = temStoreData.sign;
                  temItem.Init_lib();
                  temData.grid.vo = temItem;
                  temData._textColor = temItem.color;
                  temData.wpName = temItem.str_name;
                  temData.priceType = temStoreData.price_type;
                  temData.price = temStoreData.now_price;
               }
               else if(temStoreData.type == 2)
               {
                  temEquit = new Vo_equip();
                  temEquit.id = temStoreData.wpid;
                  temData._sign = temStoreData.sign;
                  temEquit.Init_lib();
                  temData.grid.vo = temEquit;
                  temData._textColor = temEquit.color;
                  temData.wpName = temEquit.str_name;
                  temData.priceType = temStoreData.price_type;
                  temData.price = temStoreData.now_price;
               }
               temData.type = i + (_curP - 1) * 12;
               temData._wpId = temStoreData.wpid;
               i++;
            }
         }
         else
         {
            temN = Model_store.store_data_sava[this._sign].length % 12 + 12 * int(Model_store.store_data_sava[this._sign].length % 12 == 0);
            k = 0;
            while(k < temN)
            {
               LstemData = this.dataItem_arr[k];
               LstemData.visible = true;
               LstemStoreData = Model_store.store_data_sava[this._sign][k + (_curP - 1) * 12];
               if(LstemStoreData.type == 1)
               {
                  LstemItem = new Vo_item();
                  LstemItem.id = LstemStoreData.wpid;
                  LstemData._sign = LstemStoreData.sign;
                  LstemItem.Init_lib();
                  LstemData.grid.vo = LstemItem;
                  LstemData._textColor = LstemItem.color;
                  LstemData.wpName = LstemItem.str_name;
                  LstemData.priceType = LstemStoreData.price_type;
                  LstemData.price = LstemStoreData.now_price;
               }
               else if(LstemStoreData.type == 2)
               {
                  LstemEquit = new Vo_equip();
                  LstemEquit.id = LstemStoreData.wpid;
                  LstemData._sign = LstemStoreData.sign;
                  LstemEquit.Init_lib();
                  LstemData.grid.vo = LstemEquit;
                  LstemData._textColor = LstemEquit.color;
                  LstemData.wpName = LstemEquit.str_name;
                  LstemData.priceType = LstemStoreData.price_type;
                  LstemData.price = LstemStoreData.now_price;
               }
               LstemData.type = k + (_curP - 1) * 12;
               LstemData._wpId = LstemStoreData.wpid;
               k++;
            }
         }
      }
      
      public function updateMoney(_sign_type:int) : void
      {
         var i_i:int = 0;
         if(_sign_type == 4)
         {
            i_i = 0;
            while(i_i < 4)
            {
               this.items_got_arr[i_i].visible = true;
               this.items_got_arr[i_i].update_txt(this.wp_id_arr[i_i]);
               i_i++;
            }
         }
         else
         {
            this.items_got_arr[0].visible = true;
            this.items_got_arr[0].update(_sign_type);
         }
      }
      
      private function specialHandle() : void
      {
         var tem_vo:Vo_store = null;
         var i:int = 0;
         if(Boolean(Model_store.store_data_sava[4].length))
         {
            i = 0;
            while(i < Model_store.store_data_sava[4].length)
            {
               tem_vo = Model_store.store_data_sava[4][i];
               i++;
            }
         }
      }
      
      public function get_txt_num(_pri_type:int) : int
      {
         return 0;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

