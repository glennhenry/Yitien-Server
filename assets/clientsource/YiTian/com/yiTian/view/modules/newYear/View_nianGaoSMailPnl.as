package com.yiTian.view.modules.newYear
{
   import Layout.GridGroup;
   import Layout.ILayout;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.NewYearCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import flash.geom.Rectangle;
   
   public class View_nianGaoSMailPnl extends Panel123
   {
      
      private var tf_nianGaoCount:MyTextField;
      
      private var items:Array = [];
      
      private var nianGaoCount:int;
      
      public function View_nianGaoSMailPnl()
      {
         regResource("lang/ch/ChunJie_Imgs.swf","ChunJie_Imgsdm");
         super();
      }
      
      override public function get width() : Number
      {
         return 710;
      }
      
      override public function get height() : Number
      {
         return 580;
      }
      
      public function show() : void
      {
         Global.control.registerCallBack(Enum_MsgType.BAG_UPDATE,this.checkBag);
         this.checkBag();
         visible = true;
         pop(0.4,0.4);
      }
      
      public function hide() : void
      {
         Global.control.removeCallBack(Enum_MsgType.BAG_UPDATE,this.checkBag);
         visible = false;
      }
      
      private function checkBag() : void
      {
         this.setNianGaoCount(this.nianGaoCount = CommandManager.get_bag_count(Config_NewYear.NIANGAOID));
      }
      
      override protected function initUI2() : void
      {
         var item:Item = null;
         ComponentUtil.getScaleBitmap("Store_Back1",[229,44,2,3],this,{
            "x":0,
            "y":3,
            "width":710,
            "height":578
         },Global.ChunJie_Imgsdm);
         ComponentUtil.getBitmap("Store_Title",this,{
            "x":229,
            "y":0
         },Global.ChunJie_Imgsdm);
         ComponentUtil.getScaleBitmap("Store_Back4",[2,2,4,4],this,{
            "x":28,
            "y":47,
            "width":654,
            "height":524
         },Global.ChunJie_Imgsdm);
         ComponentUtil.getBitmap("Store_Img",this,{
            "x":38,
            "y":57
         },Global.ChunJie_Imgsdm);
         move = new Rectangle(0,0,this.width,38);
         CloseButton = ComponentUtil.getButton("","Button_SClose",this,{
            "x":658,
            "y":14,
            "textColor":16184781
         },Global.ChunJie_Imgsdm);
         var g:ILayout = new GridGroup(38,191,0,0,0,116,0,213,3);
         var i:int = 0;
         while(i < 9)
         {
            item = new Item();
            g.appendItem(item);
            this.items.push(item);
            addChild(item);
            item.setBtnClick(this.buyHd);
            i += 1;
         }
         g.align();
         g.dispose();
         this.tf_nianGaoCount = ComponentUtil.getTextField("",this,{
            "x":45,
            "y":542,
            "color":16383744
         });
         ComponentUtil.getScaleBitmap("Store_Back3",[3,3,4,4],this,{
            "x":327,
            "y":539,
            "width":57,
            "height":23
         },Global.ChunJie_Imgsdm);
         ComponentUtil.getButton("","Button_PageL",this,{
            "x":299,
            "y":539,
            "textColor":16184781
         },Global.ChunJie_Imgsdm);
         ComponentUtil.getButton("","Button_PageR",this,{
            "x":388,
            "y":539,
            "textColor":16184781
         },Global.ChunJie_Imgsdm);
         ComponentUtil.getTextField("1/1",this,{
            "x":344,
            "y":541,
            "color":16777215
         });
         super.initDynamicView();
         this.updateSellItemsVo(Config_NewYear.getDefaultMailVos());
         this.setItemsPrice(Config_NewYear.getDefualtPrices());
      }
      
      private function buyHd(item:Item) : void
      {
         var num:int = 0;
         var rep:String = null;
         var tip:String = null;
         var price:int = int(item.getPrice());
         num = item.getNum();
         if(this.nianGaoCount < num * price)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29433",2));
         }
         else
         {
            rep = LangConfig.getWord("29432",2);
            tip = Util.rep(rep,HtmlUtil.fontNoSize(num.toString(),"#ffff00") + LangConfig.getWord("903",0) + Enum_BroadCastTool.instance.getItemText(item.getSellItemVo().id),HtmlUtil.fontNoSize((num * price).toString(),"#ffff00") + LangConfig.getWord("903",0) + Data_lib.item[Config_NewYear.NIANGAOID][Enum_lib_item.STR_NAME]);
            View_Alert.show(HtmlUtil.font(tip,"#dddd99"),View_Alert.OK_CANCAL,function():void
            {
               NewYearCGMessage.CG_NIANGAOMAIL_BUY_ITEM(item.getSellItemVo().id,num);
            });
         }
      }
      
      public function setNianGaoCount(v:uint) : void
      {
         this.tf_nianGaoCount.htmlText = HtmlUtil.fontNoSize(Data_lib.item[Config_NewYear.NIANGAOID][Enum_lib_item.STR_NAME] + "：","#33ff33") + v.toString();
      }
      
      public function updateSellItemsVo(itemVos:Array) : void
      {
         var i:int = 0;
         while(i < itemVos.length)
         {
            (this.items[i] as Item).setSellItemVo(itemVos[i]);
            i += 1;
         }
      }
      
      public function setItemsPrice(prices:Array) : void
      {
         var i:int = 0;
         while(i < prices.length)
         {
            (this.items[i] as Item).setPrice(prices[i]);
            i += 1;
         }
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.Data_lib;
import com.yiTian.data.config.valuable.Enum_lib_item;
import com.yiTian.data.vo.Vo_valuable;
import com.yiTian.manager.LangConfig;
import com.yiTian.utils.HtmlUtil;
import com.yiTian.view.comp.View_Grid;
import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
import com.yiTian.view.modules.newYear.Config_NewYear;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;

class Item extends Sprite
{
   
   private var tf_itemName:MyTextField;
   
   private var gd_item:View_Grid;
   
   private var tf_num:MyTextField;
   
   private var btn_buy:Button;
   
   private var tf_price:MyTextField;
   
   private var _price:uint;
   
   private var _buyEventFun:Function;
   
   public function Item()
   {
      super();
      ComponentUtil.getScaleBitmap("Store_Back2",[50,30,4,1],this,{
         "x":0,
         "y":0,
         "width":208,
         "height":111
      },Global.ChunJie_Imgsdm);
      this.tf_itemName = ComponentUtil.getTextField("",this,{
         "x":104,
         "y":3,
         "color":3394815,
         "realWidth":0
      });
      this.tf_itemName.autoSize = TextFieldAutoSize.CENTER;
      this.gd_item = new View_Grid(true);
      this.gd_item.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
      this.gd_item.set_bmp_over(true,null);
      this.gd_item.x = 9;
      this.gd_item.y = 32;
      addChild(this.gd_item);
      this.tf_price = ComponentUtil.getTextField("",this,{
         "x":88,
         "y":46,
         "color":5757360
      });
      ComponentUtil.getScaleBitmap("Store_Back3",[3,3,4,4],this,{
         "x":83,
         "y":73,
         "width":62,
         "height":24
      },Global.ChunJie_Imgsdm);
      this.tf_num = ComponentUtil.getTextField("1",this,{
         "x":82,
         "realWidth":50,
         "y":76,
         "color":16777215,
         "restrict":"0-9",
         "maxChars":2
      });
      this.tf_num.type = TextFieldType.INPUT;
      this.tf_num.autoSize = TextFieldAutoSize.CENTER;
      this.tf_num.addEventListener(Event.CHANGE,this.numInputHd);
      ComponentUtil.getButton(LangConfig.getWord("7",0),"Button_Buy",this,{
         "x":149,
         "y":72,
         "textColor":16184781,
         "callBack":this.buyClickHd
      },Global.ChunJie_Imgsdm);
      ComponentUtil.getButton("","Button_Nup",this,{
         "x":124,
         "y":74,
         "callBack":this.addClickHd
      },Global.ChunJie_Imgsdm);
      ComponentUtil.getButton("","Button_Ndown",this,{
         "x":124,
         "y":84,
         "callBack":this.subClickHd
      },Global.ChunJie_Imgsdm);
   }
   
   public function getSellItemVo() : Vo_valuable
   {
      return this.gd_item.vo as Vo_valuable;
   }
   
   public function setSellItemVo(vo:Vo_valuable) : void
   {
      this.tf_itemName.htmlText = Enum_BroadCastTool.instance.getItemText(vo.id);
      this.gd_item.vo = vo;
   }
   
   public function setNum(v:int) : void
   {
      if(v > 99)
      {
         v = 99;
      }
      if(v < 1)
      {
         v = 1;
      }
      this.tf_num.text = v.toString();
   }
   
   public function getNum() : int
   {
      return int(this.tf_num.text);
   }
   
   public function getPrice() : uint
   {
      return this._price;
   }
   
   public function setPrice(v:uint) : void
   {
      this._price = v;
      this.tf_price.htmlText = LangConfig.getWord("311",0) + HtmlUtil.fontNoSize(v.toString(),"#ffff00") + Data_lib.item[Config_NewYear.NIANGAOID][Enum_lib_item.STR_NAME];
   }
   
   public function getElementByDef(n:String) : Object
   {
      return this[n];
   }
   
   public function setBtnClick(fun:Function) : void
   {
      this._buyEventFun = fun;
   }
   
   private function numInputHd(e:Event) : void
   {
      this.setNum(this.getNum());
   }
   
   private function subClickHd(e:MouseEvent) : void
   {
      this.setNum(this.getNum() - 1);
   }
   
   private function addClickHd(e:MouseEvent) : void
   {
      this.setNum(this.getNum() + 1);
   }
   
   private function buyClickHd(e:MouseEvent) : void
   {
      this._buyEventFun(this);
   }
}
