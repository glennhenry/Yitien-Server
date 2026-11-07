package com.yiTian.view.modules.ZaHuoDian
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_quest_step_type;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.data.model.Model_quest;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.QuestGuiManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ZaHuoDianCGMessage;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.NpcPanel;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFormatAlign;
   
   public class View_ZaHuoDianPanel extends NpcPanel
   {
      
      private static var nowGrid:View_Grid;
      
      private var Button_Sold:Button;
      
      public var Button_Page_Back:Button;
      
      public var Button_Page_Next:Button;
      
      public var Total_text:MyTextField;
      
      public var Page_text:MyTextField;
      
      public var titleBmp:Bitmap;
      
      public var data_icons_arr:Array = [];
      
      private var _visibleNum:int;
      
      public var _totalPage:int;
      
      public var _curPage:int = 1;
      
      public var str_title:String;
      
      public var gridIdSave:Array = [];
      
      public var sellGridNumSave:Array = [];
      
      public var grids_arr:Array = [];
      
      private var _type:int;
      
      private var back:DisplayObject;
      
      public function View_ZaHuoDianPanel()
      {
         super();
      }
      
      public static function buyShop(e:MouseEvent) : void
      {
         var grid:View_Grid = e.target as View_Grid;
         if(Boolean(nowGrid))
         {
            nowGrid.bSelect = false;
         }
         nowGrid = grid;
         nowGrid.bSelect = true;
         if(GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver < e.target.parent.price)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("97",0));
            return;
         }
         if(!UIManager.bought_num.visible)
         {
            UIManager.bought_num.visible = true;
         }
         UIManager.bought_num.bought_type = 1;
         UIManager.bought_num.update(nowGrid.vo,e.target.parent.price,e.target.parent._textColor,e.target.parent.gridId);
         UIManager.bought_num.parent.setChildIndex(UIManager.bought_num,UIManager.bought_num.parent.numChildren - 1);
      }
      
      override protected function initStaticView() : void
      {
         var grid:View_Grid = null;
         var i:int = 0;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":369,
            "height":435
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":321,
            "height":276
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":322,
            "width":321,
            "height":103
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":144,
            "y":289,
            "width":80,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":32,
            "y":47,
            "width":150,
            "height":46
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":187,
            "y":47,
            "width":150,
            "height":46
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":32,
            "y":95,
            "width":150,
            "height":46
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":32,
            "y":239,
            "width":150,
            "height":46
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":32,
            "y":143,
            "width":150,
            "height":46
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":32,
            "y":191,
            "width":150,
            "height":46
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":187,
            "y":95,
            "width":150,
            "height":46
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":187,
            "y":143,
            "width":150,
            "height":46
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":187,
            "y":239,
            "width":150,
            "height":46
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":187,
            "y":191,
            "width":150,
            "height":46
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60208",6),this,{
            "x":39,
            "y":327,
            "color":16184781,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60209",6),this,{
            "x":129,
            "y":327,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60210",6),this,{
            "x":38,
            "y":400,
            "color":14662240,
            "size":12,
            "leading":0
         });
         move = new Rectangle(0,0,305,38);
         this.Button_Sold = ComponentUtil.getButton(LangConfig.getWord("15",0),"Button_Two64",this,{
            "x":266,
            "y":396,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":335,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Page_Back = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":121,
            "y":289,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Page_Next = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":226,
            "y":289,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Total_text = ComponentUtil.getTextField("0.00",this,{
            "x":97,
            "y":400
         });
         this.Page_text = ComponentUtil.getTextField("000/000",this,{
            "x":160,
            "y":290,
            "color":14662240,
            "size":12,
            "leading":0,
            "realWidth":45
         });
         this.Page_text.align = TextFormatAlign.CENTER;
         this.Button_Page_Next.name = "next";
         this.Button_Page_Back.name = "back";
         this.Button_Page_Next.callBack = this.Button_Page_Back.callBack = this.nextHandle;
         this.Button_Sold.addEventListener(MouseEvent.CLICK,this.soldhandle);
         super.CloseButton.addEventListener(MouseEvent.CLICK,this.clZHDHandle);
         i = 0;
         while(i < 6)
         {
            grid = new View_Grid();
            grid.type = Enum_type_grid.SHOP;
            grid.set_bmp_bg();
            grid.set_bmp_over();
            grid.set_bmp_select();
            grid.set_tf_count(true,false,false);
            grid.index = i;
            grid.x = 40 + i * 50;
            grid.y = 353;
            if(i < 6)
            {
               grid.addEventListener(MouseEvent.MOUSE_DOWN,UIManager.startDrag);
               grid.addEventListener(MouseEvent.MOUSE_UP,this.on_Up);
               grid.addEventListener(MouseEvent.CLICK,this.cliHandle);
            }
            addChild(grid);
            this.grids_arr.push(grid);
            i++;
         }
      }
      
      override protected function initDynamicView() : void
      {
         var _i:int = 0;
         var iconsPanel:View_IconsPanel = null;
         _i = 0;
         while(_i <= 9)
         {
            iconsPanel = new View_IconsPanel();
            addChild(iconsPanel);
            iconsPanel.price = 100 + _i;
            iconsPanel.x = 35 + 155 * (_i % 2);
            iconsPanel.y = 49 + 48 * int(_i / 2);
            iconsPanel.visible = false;
            this.data_icons_arr.push(iconsPanel);
            iconsPanel = null;
            _i++;
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
         if(!value)
         {
            this.Page_text.text = "1/1";
            this.dispose();
            this.sell_dispose();
         }
         else
         {
            if(!UIManager.bagPanel.visible)
            {
               UIManager.bagPanel.visible = true;
            }
            if(UIManager.long_way_shop.visible)
            {
               UIManager.long_way_shop.visible = false;
            }
            this.showQuestGuide();
         }
      }
      
      public function showQuestGuide() : void
      {
         if(bindNpc.sysId == 52301 && Model_quest.checkCurMainQStepType(Enum_quest_step_type.BUY_SKILL_BOOK))
         {
            QuestGuiManager.addKuang(this,32,48,45,45);
            QuestGuiManager.addJian(this,37,70,0);
         }
      }
      
      public function showCloseGuide() : void
      {
         QuestGuiManager.addKuang(this,CloseButton.x - 5,CloseButton.y - 5,CloseButton.width + 10,CloseButton.height + 10);
         QuestGuiManager.addJian(this,CloseButton.width + CloseButton.x + 3,CloseButton.height / 2 + CloseButton.y,180);
      }
      
      private function clZHDHandle(e:MouseEvent) : void
      {
         this.dispose();
         this.visible = false;
      }
      
      private function cliHandle(e:MouseEvent) : void
      {
         var tem_grid:View_Grid = e.target as View_Grid;
         if(Boolean(tem_grid.vo))
         {
            this.replace_grid(tem_grid.index);
         }
      }
      
      public function soldhandle(e:MouseEvent) : void
      {
         var temNum:int = this.get_empty_grid();
         if(temNum == 0)
         {
            UIManager.selfBroadcast.addMsg(LangConfig.getWord("16",0));
            return;
         }
         ZaHuoDianCGMessage.CG_ZAHUODIAN_SELL(this.gridIdSave,this.sellGridNumSave);
         this.sell_dispose();
      }
      
      private function nextHandle(e:MouseEvent) : void
      {
         this.dispose();
         if(e.target.name == "next")
         {
            if(this._curPage < this._totalPage)
            {
               if(this._curPage == this._totalPage)
               {
                  return;
               }
               ++this._curPage;
               this.Page_text.text = String(this._curPage) + "/" + String(this._totalPage);
            }
         }
         else if(e.target.name == "back")
         {
            if(this._curPage == 1)
            {
               return;
            }
            if(this._curPage > 1)
            {
               --this._curPage;
               this.Page_text.text = String(this._curPage) + "/" + String(this._totalPage);
            }
         }
         this.update(this._curPage,this._type);
      }
      
      public function set_title(str:String) : void
      {
         if(Boolean(this.titleBmp))
         {
            removeChild(this.titleBmp);
            this.titleBmp.bitmapData = null;
            this.titleBmp = null;
         }
         if(!Global.NPC_Imgsdm)
         {
            SingleLoader.add("lang/ch/NPC_Imgs.swf",function(info:Object):void
            {
               Global.NPC_Imgsdm = info.applicationDomain;
               showB(str);
            });
         }
         else
         {
            this.showB(str);
         }
         Model_shop.title_str = str;
      }
      
      private function showB(str:String) : void
      {
         if(str == "ZAHUODIAN")
         {
            this.titleBmp = ComponentUtil.getBitmap("Title_ZHShop",this,{
               "x":107.85,
               "y":6.05
            },Global.NPC_Imgsdm);
         }
         else if(str == "ZBDIAN")
         {
            this.titleBmp = ComponentUtil.getBitmap("Title_ZBShop",this,{
               "x":107.85,
               "y":6.05
            },Global.NPC_Imgsdm);
         }
         else if(str == "YPDIAN")
         {
            this.titleBmp = ComponentUtil.getBitmap("Title_YPShop",this,{
               "x":107.85,
               "y":6.05
            },Global.NPC_Imgsdm);
         }
      }
      
      public function update(_num:int, ty_pe:int) : void
      {
         var temN_ZHD:int = 0;
         var temN_ZB:int = 0;
         var temItem:View_IconsPanel = null;
         var tem_arr:Array = null;
         var voItem:Vo_item = null;
         var _i:int = 0;
         var i:int = 0;
         var temArr:Array = null;
         var voEquit:Vo_equip = null;
         this.dispose();
         this._curPage = _num;
         this._type = ty_pe;
         var tempI:int = 0;
         while(tempI <= 9)
         {
            this.data_icons_arr[tempI].visible = false;
            this.data_icons_arr[tempI].grid.vo = null;
            tempI++;
         }
         if(this._type == 1)
         {
            tem_arr = [];
            if(Model_shop.title_str == "ZAHUODIAN")
            {
               tem_arr = Model_shop.ZHD_data_arr[Model_shop.get_shop_id];
            }
            else if(Model_shop.title_str == "YPDIAN")
            {
               if(Model_shop.longShopType)
               {
                  tem_arr = Model_shop.longShopData;
               }
               else
               {
                  tem_arr = Model_shop.YP_data_arr[Model_shop.get_shop_id];
               }
            }
            if(!tem_arr.length)
            {
               return;
            }
            temN_ZHD = tem_arr.length % 10 + 10 * int(tem_arr.length % 10 == 0);
            this._totalPage = int(tem_arr.length / 10) + int(tem_arr.length % 10 != 0);
            if(_num == this._totalPage)
            {
               _i = 0;
               while(_i <= temN_ZHD - 1)
               {
                  temItem = this.data_icons_arr[_i];
                  voItem = tem_arr[_i + (_num - 1) * 10];
                  temItem.visible = true;
                  temItem.grid_icon = voItem;
                  temItem._textColor = voItem.color;
                  temItem.name = voItem.str_name;
                  temItem.price = voItem.shopPrice;
                  temItem.gridId = voItem.gridId;
                  _i++;
               }
            }
            else
            {
               i = 0;
               while(i <= 9)
               {
                  temItem = this.data_icons_arr[i];
                  voItem = tem_arr[i + (_num - 1) * 10];
                  temItem.visible = true;
                  temItem.grid_icon = voItem;
                  temItem._textColor = voItem.color;
                  temItem.name = voItem.str_name;
                  temItem.price = voItem.shopPrice;
                  temItem.gridId = voItem.gridId;
                  i++;
               }
            }
         }
         else if(this._type == 2)
         {
            temArr = Model_shop.ZB_data_arr[Model_shop.get_shop_id];
            this._totalPage = int(temArr.length / 10) + int(temArr.length % 10 != 0);
            temN_ZB = temArr.length % 10;
            if(_num == this._totalPage)
            {
               _i = 0;
               while(_i <= temN_ZB - 1)
               {
                  temItem = this.data_icons_arr[_i];
                  voEquit = temArr[_i + (_num - 1) * 10];
                  temItem.visible = true;
                  temItem.grid_icon = voEquit;
                  temItem._textColor = voEquit.color;
                  temItem.name = voEquit.str_name;
                  temItem.price = voEquit.shopPrice;
                  temItem.gridId = voEquit.gridId;
                  _i++;
               }
            }
            else
            {
               i = 0;
               while(i <= 9)
               {
                  temItem = this.data_icons_arr[i];
                  voEquit = temArr[i + (_num - 1) * 10];
                  temItem.visible = true;
                  temItem.grid_icon = voEquit;
                  temItem._textColor = voEquit.color;
                  temItem.name = voEquit.str_name;
                  temItem.price = voEquit.shopPrice;
                  temItem.gridId = voEquit.gridId;
                  i++;
               }
            }
         }
         this.Page_text.text = String(_num) + "/" + String(this._totalPage);
      }
      
      private function getGrid(disp:DisplayObject) : View_Grid
      {
         if(disp is View_Grid)
         {
            return disp as View_Grid;
         }
         return this.getGrid(disp.parent);
      }
      
      private function on_Up(e:MouseEvent) : void
      {
         var dragGrid:View_Grid = null;
         var temp:Vo_valuable = null;
         var upGrid:View_Grid = this.getGrid(e.target as DisplayObject);
         if(UIManager.isDrag)
         {
            dragGrid = UIManager.dragObj.grid;
            if(dragGrid.type == Enum_type_grid.BAG)
            {
               if(dragGrid.vo is Vo_valuable)
               {
                  temp = dragGrid.vo as Vo_valuable;
               }
               if(temp.price == 0)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("17",0));
                  return;
               }
               if(temp.count > 1)
               {
                  if(!UIManager.sold_num_shop.visible)
                  {
                     UIManager.sold_num_shop.visible = true;
                  }
                  UIManager.sold_num_shop.update(temp,upGrid.index);
               }
               else
               {
                  this.update_sold_item(dragGrid.vo,1,(dragGrid.vo as Vo_valuable).price,upGrid.index);
               }
            }
         }
      }
      
      public function get_empty_grid() : int
      {
         var i:int = 0;
         while(i < 6)
         {
            if(this.grids_arr[i].vo == null)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      public function dispose() : void
      {
         if(UIManager.bought_num.visible)
         {
            UIManager.bought_num.visible = false;
         }
         var i:int = 0;
         while(i < this.data_icons_arr.length)
         {
            this.data_icons_arr[i].grid.bSelect = false;
            i++;
         }
      }
      
      public function update_sold_item(vo:Vo_grid, _num:int, _price:int, _index:int = 0) : void
      {
         this.Total_text.text = String(int(this.Total_text.text) + _price);
         var tem_N:int = this.get_empty_grid();
         if(tem_N == -1)
         {
            tem_N = this.replace_grid(_index);
         }
         this.gridIdSave.push(vo.gridId);
         UIManager.bagPanel.set_mask(vo.gridId,true);
         this.grids_arr[tem_N].vo = vo;
         this.grids_arr[tem_N].count = _num;
         this.sellGridNumSave.push(_num);
      }
      
      private function replace_grid(_index:int) : int
      {
         var temNum:int = int(this.grids_arr[_index].count);
         if(temNum == 0)
         {
            temNum = 1;
         }
         var tem_price:int = int(this.grids_arr[_index].vo.price);
         UIManager.bagPanel.set_mask(this.gridIdSave[_index],false);
         this.Total_text.text = String(int(this.Total_text.text) - temNum * tem_price);
         this.grids_arr[_index].vo = null;
         this.gridIdSave.splice(_index,1);
         this.sellGridNumSave.splice(_index,1);
         var i:int = _index;
         while(i < this.gridIdSave.length)
         {
            this.grids_arr[i].vo = this.grids_arr[i + 1].vo;
            this.grids_arr[i + 1].vo = null;
            i++;
         }
         return 5;
      }
      
      public function sell_dispose() : void
      {
         this.Total_text.text = "0";
         var i:int = 0;
         while(i < 6)
         {
            this.grids_arr[i].vo = null;
            i++;
         }
         i = 0;
         while(i < this.gridIdSave.length)
         {
            UIManager.bagPanel.set_mask(this.gridIdSave[i],false);
            i++;
         }
         this.gridIdSave = [];
         this.sellGridNumSave = [];
      }
      
      public function add_goods_to_shop(grid_from_bag:View_Grid) : void
      {
         var temp:Vo_valuable = null;
         if(this.get_empty_grid() == -1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("18",0));
            return;
         }
         if(grid_from_bag.vo is Vo_valuable)
         {
            temp = grid_from_bag.vo as Vo_valuable;
         }
         if(temp.price == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("17",0));
            return;
         }
         if(temp.count > 1)
         {
            if(!UIManager.sold_num_shop.visible)
            {
               UIManager.sold_num_shop.visible = true;
            }
            UIManager.sold_num_shop.update(temp);
         }
         else
         {
            this.update_sold_item(temp,1,temp.price);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 314) / 2 - 140;
         y = (Global.stage.stageHeight - 432) / 2;
      }
   }
}

