package com.yiTian.view.modules.farm
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_treasureChest;
   import com.yiTian.data.vo.Vo_farmStore;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.manager.FarmGuideManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.TreasureChestCGMssage;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.Panel;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flash.utils.Dictionary;
   import flashx.textLayout.formats.TextAlign;
   
   public class View_buy_seed extends Panel
   {
      
      private static var isLoad:Boolean = false;
      
      private var Button_Cancel:Button;
      
      public var Button_Buy:Button;
      
      private var Number_text:MyTextField;
      
      private var Money_text:MyTextField;
      
      private var total:MyTextField;
      
      public var bought_item:BoughtItem;
      
      private var isFirstOpen:Boolean = true;
      
      private var nowName:String;
      
      private var pos:int;
      
      private var _curPage:int;
      
      private var _price:int;
      
      private var _gridId:int;
      
      private var _vo:Vo_grid;
      
      public var maxNum:int;
      
      public function View_buy_seed()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":304,
            "height":210
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":256,
            "height":130
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":130,
            "y":111,
            "width":80,
            "height":20
         },Global.Img_Cdm);
         move = new Rectangle(0,0,246,38);
         ComponentUtil.getTextField(LangConfig.getWord("68",9),this,{
            "x":65,
            "y":111,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.Button_Buy = ComponentUtil.getButton(LangConfig.getWord("66",9),"Button_Two64",this,{
            "x":68,
            "y":174,
            "textColor":16773818
         },Global.Img_Cdm);
         this.Button_Cancel = ComponentUtil.getButton(LangConfig.getWord("67",9),"Button_Two64",this,{
            "x":175,
            "y":174,
            "textColor":16773818
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":270,
            "y":6,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         this.total = ComponentUtil.getTextField(LangConfig.getWord("69",9),this,{
            "x":65,
            "y":136,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.bought_item = new BoughtItem();
         this.bought_item.x = 75;
         this.bought_item.y = 55;
         addChild(this.bought_item);
         this.Number_text = ComponentUtil.getTextField("1",this,{
            "x":140,
            "y":111,
            "color":14662240,
            "size":12,
            "leading":0,
            "realWidth":58
         });
         this.Money_text = ComponentUtil.getTextField("1",this,{
            "x":140,
            "y":136,
            "color":14662240,
            "size":12,
            "leading":0,
            "realWidth":55
         });
         this.Number_text.align = TextAlign.CENTER;
         this.Money_text.align = TextAlign.CENTER;
         this.Number_text.type = TextFieldType.INPUT;
         this.Number_text.restrict = ".0-9";
         this.Number_text.maxChars = 3;
         this.Number_text.addEventListener(Event.CHANGE,this.changedHanle);
         this.Button_Cancel.callBack = this.cliHandle;
         this.Button_Buy.addEventListener(MouseEvent.CLICK,this.boughthandle);
      }
      
      private function boughthandle(e:MouseEvent) : void
      {
         if(Data_lib.Farm_store[this._vo.id][Vo_farmStore.SEED_PRICETYPE] == 18)
         {
            if(GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver < int(this.Money_text.text))
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("71",9));
               return;
            }
         }
         TreasureChestCGMssage.cg_buySeed_data(this._curPage,this.pos,this._vo.id,int(this.Number_text.text));
         this.visible = false;
         FarmGuideManager.instance.nextStep(4);
         if(!Model_treasureChest.dic1[this._curPage])
         {
            Model_treasureChest.dic1[this._curPage] = new Dictionary();
         }
         var obj:Object = new Object();
         obj.pos = this.pos;
         obj.id = this._vo.id;
         Model_treasureChest.dic1[this._curPage][this.pos] = obj;
      }
      
      private function cliHandle(e:MouseEvent = null) : void
      {
         this.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.isFirstOpen)
            {
               this.isFirstOpen = false;
               if(!Global.NPC_Imgsdm)
               {
                  SingleLoader.add("lang/ch/NPC_Imgs.swf",function(info:Object):void
                  {
                     Global.NPC_Imgsdm = info.applicationDomain;
                     showBmp();
                  });
               }
               else if(!isLoad)
               {
                  this.showBmp();
               }
            }
         }
      }
      
      private function showBmp() : void
      {
         ComponentUtil.getBitmap("Title_BuyNum",this,{
            "x":72,
            "y":5
         },Global.NPC_Imgsdm);
         isLoad = true;
      }
      
      private function changedHanle(e:Event) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         if(tf.text == "")
         {
            tf.text = "1";
         }
         if(int(tf.text) < 1)
         {
            tf.text = "1";
         }
         else if(int(tf.text) > 99)
         {
            tf.text = "99";
         }
         this.Money_text.text = String(int(tf.text) * this._price);
      }
      
      public function update(vo:Vo_grid, _pri:int, textColor:int, gri_id:int, curPage:int, _pos:int) : void
      {
         this.dispose();
         this.bought_item.update(vo,textColor);
         this._price = _pri;
         this._gridId = gri_id;
         this._vo = vo;
         this._curPage = curPage;
         this.pos = _pos;
         this.nowName = name;
         this.Money_text.text = String(this._price);
         if(Data_lib.Farm_store[this._vo.id][Vo_farmStore.SEED_PRICETYPE] == 18)
         {
            this.total.htmlText = LangConfig.getWord("69",9);
         }
         else if(Data_lib.Farm_store[this._vo.id][Vo_farmStore.SEED_PRICETYPE] == 36)
         {
            this.total.htmlText = LangConfig.getWord("72",9);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      public function dispose() : void
      {
         this.Number_text.text = "1";
         this.Money_text.text = "1";
         this.bought_item.grid.vo = null;
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.data.model.Model_shop;
import com.yiTian.data.vo.Vo_grid;
import com.yiTian.view.comp.View_Grid;
import flash.display.Sprite;

class BoughtItem extends Sprite
{
   
   public var IconName_text:MyTextField;
   
   public var grid:View_Grid;
   
   public function BoughtItem()
   {
      super();
      this.IconName_text = ComponentUtil.getTextField("",this,{
         "x":44.05,
         "y":2.2
      });
      this.grid = new View_Grid();
      this.grid.set_bmp_bg();
      this.grid.set_bmp_over();
      this.grid.set_bmp_select();
      this.grid.x = 3;
      this.grid.y = 2;
      addChild(this.grid);
   }
   
   public function update(vo:Vo_grid, textColor:int) : void
   {
      this.grid.vo = vo;
      this.IconName_text.text = vo.str_name;
      this.IconName_text.textColor = Model_shop.getColorArr[textColor - 1];
   }
}
