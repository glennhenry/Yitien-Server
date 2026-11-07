package com.yiTian.view.modules.Card
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.TipManager;
   import com.yiTian.net.message.cg.CardCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Alert;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_cardShop_panel extends Panel
   {
      
      private static var _instance:View_cardShop_panel;
      
      private var prevBtn:Button;
      
      private var nextBtn:Button;
      
      private var pageTxt:MyTextField;
      
      private var _curPage:int;
      
      private var totalPage:int;
      
      private var SuiPianTxt:MyTextField;
      
      private var DuiHuanJingYanBtn:Button;
      
      private var listItemArr:Array;
      
      private var playID:int = 0;
      
      private var setTimeOutID:Array = [];
      
      private var needCheckBox:Boolean = true;
      
      public function View_cardShop_panel()
      {
         super();
         init();
      }
      
      public static function get instance() : View_cardShop_panel
      {
         if(!_instance)
         {
            _instance = new View_cardShop_panel();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         var i:int = 0;
         var listItem:ListItem = null;
         move = new Rectangle(0,0,858,30);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":858,
            "height":613
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":808,
            "height":563
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":50,
            "width":784,
            "height":525
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Title_KPDH",this,{
            "x":349,
            "y":5
         },Global.KaPaidm);
         ComponentUtil.getScaleBitmap("Text_Back",[6,6,4,4],this,{
            "x":401,
            "y":579,
            "width":58,
            "height":18
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":823,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         this.SuiPianTxt = ComponentUtil.getTextField("卡牌残页：-1",this,{
            "x":71,
            "y":579,
            "color":16383744,
            "size":12,
            "leading":0
         },"center");
         this.prevBtn = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":376,
            "y":578,
            "textColor":16771436
         },Global.Img_Cdm);
         this.prevBtn.callBack = this.onPrevBtn;
         this.nextBtn = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":464,
            "y":578,
            "textColor":16771436
         },Global.Img_Cdm);
         this.nextBtn.callBack = this.onNextBtn;
         this.pageTxt = ComponentUtil.getTextField("1/1",this,{
            "x":428,
            "y":579,
            "color":14662240,
            "size":12,
            "leading":0
         },"center");
         this.totalPage = Math.ceil(Data_lib.cardShop.getLength() / 8);
         this.listItemArr = [];
         i = 0;
         while(i < 8)
         {
            listItem = new ListItem();
            addChild(listItem);
            listItem.x = 41 + i % 4 * 196;
            listItem.y = 56 + Math.floor(i / 4) * 259;
            this.listItemArr.push(listItem);
            listItem.alpha = 0;
            i++;
         }
         this.curPage = 1;
         this.DuiHuanJingYanBtn = ComponentUtil.getButton("","Button_DHJY",this,{
            "x":706,
            "y":570,
            "textColor":16771436
         },Global.KaPaidm);
         this.DuiHuanJingYanBtn.callBack = this.onDuiHuanBtn;
         TipManager.bind(this.DuiHuanJingYanBtn,"卡牌残页可兑换卡牌经验");
         Global.control.registerCallBack(CardEvent.PIECE,this.updatePiece);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.updatePiece();
            this.allCardMove();
         }
      }
      
      private function updatePiece() : void
      {
         this.SuiPianTxt.text = "卡牌残页：" + String(Model_card.piece);
      }
      
      private function onPrevBtn(e:MouseEvent) : void
      {
         --this.curPage;
      }
      
      private function onNextBtn(e:MouseEvent) : void
      {
         ++this.curPage;
      }
      
      public function get curPage() : int
      {
         return this._curPage;
      }
      
      public function set curPage(value:int) : void
      {
         this._curPage = value;
         this.pageTxt.text = this.curPage + "/" + this.totalPage;
         if(this.curPage == this.totalPage)
         {
            this.nextBtn.enabled = false;
         }
         else
         {
            this.nextBtn.enabled = true;
         }
         if(this.curPage == 1)
         {
            this.prevBtn.enabled = false;
         }
         else
         {
            this.prevBtn.enabled = true;
         }
         this.setCurPage();
         this.allCardMove();
      }
      
      private function setCurPage() : void
      {
         var tableID:int = 0;
         var i:int = 0;
         while(i < 8)
         {
            tableID = (this.curPage - 1) * 8 + i + 1;
            if(Boolean(Data_lib.cardShop[tableID]))
            {
               this.listItemArr[i].visible = true;
               this.listItemArr[i].setCard(Data_lib.cardShop[tableID][0],Data_lib.cardShop[tableID][1]);
            }
            else
            {
               this.listItemArr[i].visible = false;
            }
            i++;
         }
      }
      
      private function allCardMove() : void
      {
         while(Boolean(this.setTimeOutID.length))
         {
            clearTimeout(this.setTimeOutID.pop());
         }
         var i:int = 0;
         while(i < 8)
         {
            Tween.stop(this.listItemArr[i]);
            this.listItemArr[i].alpha = 0;
            this.setTimeOutID.push(setTimeout(this.cardMove,i * 100,i));
            i++;
         }
      }
      
      private function cardMove(id:int) : void
      {
         Tween.to(this.listItemArr[id],250,{
            "x":[629,41 + id % 4 * 196],
            "alpha":[0,1]
         },this.checkMove);
      }
      
      private function checkMove() : void
      {
         if(++this.playID == 8)
         {
            this.playID = 0;
         }
      }
      
      private function onDuiHuanBtn(e:MouseEvent) : void
      {
         if(this.needCheckBox)
         {
            View_Alert.show(HtmlUtil.fontNoSize("是否花费" + HtmlUtil.fontNoSize("1个",ColorConstant.getColorStr(ColorConstant.YELLOW)) + "卡牌残页兑换" + HtmlUtil.fontNoSize(Data_lib.cardShop[0][1] + "点",ColorConstant.getColorStr(ColorConstant.YELLOW)) + "卡牌经验？",ColorConstant.getColorStr(ColorConstant.WHITE)),2,function():void
            {
               CardCGMessage.CG_CARD_BUY(0);
            },function():void
            {
               needCheckBox = true;
            },null,null,310,"","","center",this.needCheckBox);
            View_Alert.instance.showCheckBox = function():void
            {
               needCheckBox = !needCheckBox;
            };
         }
         else
         {
            CardCGMessage.CG_CARD_BUY(0);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ColorConstant;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.Data_lib;
import com.yiTian.net.message.cg.CardCGMessage;
import com.yiTian.utils.HtmlUtil;
import com.yiTian.view.comp.View_Alert;
import com.yiTian.view.modules.Card.View_card;
import flash.display.Sprite;
import flash.events.MouseEvent;

class ListItem extends Sprite
{
   
   private var _card:View_card;
   
   private var pieceTxt:MyTextField;
   
   private var buyBtn:Button;
   
   public function ListItem()
   {
      super();
      ComponentUtil.getScaleBitmap("Back_KPDHD",[8,8,1,1],this,{
         "x":0,
         "y":0,
         "width":188,
         "height":258
      },Global.KaPaidm);
      ComponentUtil.getBitmap("Icon_KPCP",this,{
         "x":12,
         "y":231
      },Global.KaPaidm);
      this._card = new View_card();
      this.card.x = 7;
      this.card.y = 4;
      addChild(this.card);
      this.pieceTxt = ComponentUtil.getTextField("1234567",this,{
         "x":38,
         "y":232,
         "color":16383744,
         "size":12,
         "leading":0
      });
      this.buyBtn = ComponentUtil.getButton("","Button_DuiHuan",this,{
         "x":109,
         "y":229,
         "textColor":16771436
      },Global.KaPaidm);
      this.buyBtn.callBack = this.onClickBuyBtn;
   }
   
   public function setCard(cardID:int, cost:int) : void
   {
      this.card.id = cardID;
      this.card.star = 1;
      this.card.level = 1;
      this.card.exp = 0;
      this.pieceTxt.text = cost.toString();
   }
   
   private function onClickBuyBtn(e:MouseEvent) : void
   {
      var i:* = undefined;
      var cardID:int = int(this.card.id);
      var name:String = Data_lib.card[cardID][2];
      var piece:String = "";
      for(i in Data_lib.cardShop)
      {
         if(Data_lib.cardShop[i][0] == cardID)
         {
            piece = "卡牌残页*" + Data_lib.cardShop[i][1];
         }
      }
      View_Alert.show(HtmlUtil.fontNoSize("确认花费" + HtmlUtil.fontNoSize(piece,ColorConstant.getColorStr(ColorConstant.GREEN)) + "兑换" + HtmlUtil.fontNoSize(name,ColorConstant.getItemColorStr(Data_lib.card[cardID][4])) + "吗？",ColorConstant.getColorStr(ColorConstant.WHITE)),2,function():void
      {
         CardCGMessage.CG_CARD_BUY(card.id);
      },null,null,null,340,"","","center");
   }
   
   public function get card() : View_card
   {
      return this._card;
   }
}
