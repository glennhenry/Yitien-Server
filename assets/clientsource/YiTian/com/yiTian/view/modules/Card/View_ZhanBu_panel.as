package com.yiTian.view.modules.Card
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.TabButton;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CardCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Alert;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.ui.Mouse;
   import flash.utils.setTimeout;
   
   public class View_ZhanBu_panel extends Sprite
   {
      
      private static var _instance:View_ZhanBu_panel;
      
      private var ZhanBuBtn:Button;
      
      private var ZhanBuCost:int = -1;
      
      private var lastZhanBuCost:int = -1;
      
      private var ZhanBuBtnNeedCheck:Boolean = true;
      
      private var WanFaShuoMingBtn:Button;
      
      private var FenJieBtn:Button;
      
      private var YiJianFenJieBtn:Button;
      
      private var ShiQuBtn:Button;
      
      private var YiJianShiQuBtn:Button;
      
      private var bagBtn:Button;
      
      private var XingZuoBtnArr:Array = [];
      
      private var leftTimesBmArr:Array = [];
      
      private var leftTimesSpr:Sprite;
      
      private var countDownTxt:MyTextField;
      
      private var arrowBm:Bitmap;
      
      private var t:int;
      
      private var tips:Tips = new Tips();
      
      private var _curZhanBuId:int;
      
      private var cardArr:Array = [];
      
      private const cardStartX:int = 35;
      
      private const cardEndX:int = 557;
      
      private const cardTotalInterval:int = 522;
      
      private const cardY:int = 73;
      
      private var mouseFenJieBm:Bitmap;
      
      private var mouseShiQuBm:Bitmap;
      
      private var _mouseFlag:int;
      
      private var needCheckBox:Boolean = true;
      
      private var playID:int;
      
      private var needPlayCard:Boolean;
      
      private var needPlayCardIndex:int;
      
      private var needPlayCardPositionX:int;
      
      public function View_ZhanBu_panel()
      {
         super();
         this.initStaticView();
      }
      
      public static function get instance() : View_ZhanBu_panel
      {
         if(!_instance)
         {
            _instance = new View_ZhanBu_panel();
         }
         return _instance;
      }
      
      private function initStaticView() : void
      {
         var i:int;
         var j:int;
         var xingZuoBtn:XingZuoBtn = null;
         graphics.beginFill(0,0);
         graphics.drawRect(30,69,706,546);
         graphics.endFill();
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":30,
            "y":69,
            "width":706,
            "height":277
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Back_SHAND",this,{
            "x":31,
            "y":302
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Back_KPZBDX",this,{
            "x":29,
            "y":348
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Back_XXD",this,{
            "x":33,
            "y":365
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Back_KPXKD",this,{
            "x":31,
            "y":70
         },Global.KaPaidm);
         this.ZhanBuBtn = ComponentUtil.getButton("","Button_YBZB",this,{
            "x":646,
            "y":398,
            "textColor":16771436
         },Global.KaPaidm);
         TipManager.bind(this.ZhanBuBtn,"今日第N次元宝占卜，花费X元宝");
         this.ZhanBuBtn.callBack = this.onClickZhanBuBtn;
         this.WanFaShuoMingBtn = ComponentUtil.getButton("","Button_WFSM",this,{
            "x":52,
            "y":502,
            "textColor":16771436
         },Global.KaPaidm);
         this.WanFaShuoMingBtn.callBack = function():void
         {
            tips.visible = true;
         };
         this.FenJieBtn = ComponentUtil.getButton("","Button_FenJie",this,{
            "x":207,
            "y":307,
            "textColor":16771436
         },Global.KaPaidm);
         this.YiJianFenJieBtn = ComponentUtil.getButton("","Button_YJFJ",this,{
            "x":290,
            "y":305,
            "textColor":16771436
         },Global.KaPaidm);
         this.ShiQuBtn = ComponentUtil.getButton("","Button_YJSQ",this,{
            "x":411,
            "y":308,
            "textColor":16771436
         },Global.KaPaidm);
         this.YiJianShiQuBtn = ComponentUtil.getButton("","Button_YJFenJie",this,{
            "x":493,
            "y":308,
            "textColor":16771436
         },Global.KaPaidm);
         this.FenJieBtn.callBack = this.onClickFenJie;
         this.YiJianFenJieBtn.callBack = this.onClickYiJianFenJie;
         this.ShiQuBtn.callBack = this.onClickShiQu;
         this.YiJianShiQuBtn.callBack = this.onClickYiJianShiQu;
         this.bagBtn = ComponentUtil.getButton("","Button_KPBB",this,{
            "x":611,
            "y":306,
            "textColor":16771436
         },Global.KaPaidm);
         this.bagBtn.callBack = function():void
         {
            (View_card_panel.instance.tabBtnArr[1] as TabButton).dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         };
         ComponentUtil.getBitmap("Line_DLX",this,{
            "x":242,
            "y":394
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Line_YBDX",this,{
            "x":652,
            "y":383
         },Global.KaPaidm);
         i = 0;
         while(i < 7)
         {
            xingZuoBtn = new XingZuoBtn();
            this.XingZuoBtnArr.push(xingZuoBtn);
            addChild(xingZuoBtn);
            i++;
         }
         this.XingZuoBtnArr[0].x = 224;
         this.XingZuoBtnArr[0].y = 459;
         this.XingZuoBtnArr[1].x = 317;
         this.XingZuoBtnArr[1].y = 405;
         this.XingZuoBtnArr[2].x = 389;
         this.XingZuoBtnArr[2].y = 419;
         this.XingZuoBtnArr[3].x = 476;
         this.XingZuoBtnArr[3].y = 431;
         this.XingZuoBtnArr[4].x = 522;
         this.XingZuoBtnArr[4].y = 495;
         this.XingZuoBtnArr[5].x = 634;
         this.XingZuoBtnArr[5].y = 461;
         this.XingZuoBtnArr[6].x = 630;
         this.XingZuoBtnArr[6].y = 373;
         Global.control.registerCallBack(XingZuoBtn.Event_ZhanBu,this.onClickXingZuoBtn);
         ComponentUtil.getBitmap("Text_KaiYang",this,{
            "x":313,
            "y":388
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Text_TianJi",this,{
            "x":529,
            "y":478
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Text_TianShu",this,{
            "x":597,
            "y":376
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Text_TianXuan",this,{
            "x":601,
            "y":457
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Text_TuabQuan",this,{
            "x":501,
            "y":435
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Text_YaoGuang",this,{
            "x":248,
            "y":463
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Text_YuHeng",this,{
            "x":386,
            "y":401
         },Global.KaPaidm);
         this.leftTimesSpr = new Sprite();
         addChild(this.leftTimesSpr);
         this.leftTimesSpr.x = 44;
         this.leftTimesSpr.y = 368;
         j = 0;
         while(j < 5)
         {
            ComponentUtil.getBitmap("Icon_XXAD",this.leftTimesSpr,{"x":j * 34},Global.KaPaidm);
            this.leftTimesBmArr.push(ComponentUtil.getBitmap("Icon_XXLD",this.leftTimesSpr,{"x":j * 34},Global.KaPaidm));
            j++;
         }
         this.countDownTxt = ComponentUtil.getTextField("00:00",this.leftTimesSpr,{
            "x":178,
            "y":3,
            "color":3407667,
            "size":16,
            "leading":0
         });
         this.arrowBm = ComponentUtil.getBitmap("Icon_XZJT",this,{
            "x":222,
            "y":485
         },Global.KaPaidm);
         this.arrowBm.alpha = 0;
         this.mouseFenJieBm = ComponentUtil.getBitmap("MouseFenJie",null,null,Global.KaPaidm);
         this.mouseShiQuBm = ComponentUtil.getBitmap("MouseShiQu",null,null,Global.KaPaidm);
         Global.control.registerCallBack(CardEvent.UPDATE_ZhanBu,this.updatePanel);
         Global.control.registerCallBack(CardEvent.LEFT_TIME,this.updateLeftTimes);
         Global.control.registerCallBack(CardEvent.RESET_CURRENT_XingZuo,this.onResetXingZuo);
         Global.control.registerCallBack(CardEvent.UPDATE_HAVE_USE_TIME,this.updateHaveUseTime);
         Global.control.registerCallBack(CardEvent.UPDATE_HAVE_USE_MONEY_TIME,this.updateHaveUseMoneyTime);
         Global.control.registerCallBack(CardEvent.UPDATE_COUNT_DOWN,this.updateCountDown);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            Model_card.canUndress = false;
            if(!this.needPlayCard)
            {
               this.needPlayCard = true;
               CardCGMessage.CG_CARD_OPEN_PANEL();
            }
         }
      }
      
      private function get mouseFlag() : int
      {
         return this._mouseFlag;
      }
      
      private function set mouseFlag(value:int) : void
      {
         var point:Point = null;
         this._mouseFlag = value;
         switch(this._mouseFlag)
         {
            case 0:
               Mouse.show();
               if(Boolean(this.mouseFenJieBm.stage))
               {
                  this.mouseFenJieBm.parent.removeChild(this.mouseFenJieBm);
               }
               if(Boolean(this.mouseShiQuBm.stage))
               {
                  this.mouseShiQuBm.parent.removeChild(this.mouseShiQuBm);
               }
               removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
               removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
               break;
            case 1:
               Mouse.hide();
               GameScene.instance.addChild(this.mouseFenJieBm);
               if(Boolean(this.mouseShiQuBm.stage))
               {
                  this.mouseShiQuBm.parent.removeChild(this.mouseShiQuBm);
               }
               point = localToGlobal(new Point(mouseX,mouseY));
               this.mouseFenJieBm.x = point.x;
               this.mouseFenJieBm.y = point.y;
               addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
               addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
               break;
            case 2:
               Mouse.hide();
               GameScene.instance.addChild(this.mouseShiQuBm);
               if(Boolean(this.mouseFenJieBm.stage))
               {
                  this.mouseFenJieBm.parent.removeChild(this.mouseFenJieBm);
               }
               point = localToGlobal(new Point(mouseX,mouseY));
               this.mouseShiQuBm.x = point.x;
               this.mouseShiQuBm.y = point.y;
               addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
               addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         }
      }
      
      private function onRollOut(e:MouseEvent) : void
      {
         this.mouseFlag = 0;
      }
      
      private function onMouseMove(e:MouseEvent) : void
      {
         var point:Point = null;
         point = localToGlobal(new Point(mouseX,mouseY));
         if(this.mouseFlag == 1)
         {
            this.mouseFenJieBm.x = point.x;
            this.mouseFenJieBm.y = point.y;
         }
         else if(this.mouseFlag == 2)
         {
            this.mouseShiQuBm.x = point.x;
            this.mouseShiQuBm.y = point.y;
         }
      }
      
      private function set haveUseTimes(value:int) : void
      {
         TipManager.bind(this.leftTimesSpr,HtmlUtil.fontNoSize("占卜签（" + value + "/25）",ColorConstant.getColorStr(ColorConstant.YELLOW)) + "<br/>每日卜卦次数" + HtmlUtil.fontNoSize("25次",ColorConstant.getColorStr(ColorConstant.GREEN)) + "，每" + HtmlUtil.fontNoSize("在线6分钟",ColorConstant.getColorStr(ColorConstant.GREEN)) + "获得一个占卜签，最高可累计" + HtmlUtil.fontNoSize("5次",ColorConstant.getColorStr(ColorConstant.GREEN)) + "卜卦次数");
      }
      
      private function updatePanel() : void
      {
         this.curZhanBuId = Model_card.curXingZuo;
         this.leftTimes = Model_card.leftTimes;
         this.haveUseTimes = Model_card.haveUseTimes;
         this.setZhanBuBtnTxt(Model_card.haveUseMoneyZhanBuTimes);
         this.setCard(Model_card.ZhanBuCardArray);
      }
      
      private function onResetXingZuo() : void
      {
         this.curZhanBuId = Model_card.curXingZuo;
      }
      
      private function updateHaveUseTime() : void
      {
         this.haveUseTimes = Model_card.haveUseTimes;
      }
      
      private function updateHaveUseMoneyTime() : void
      {
         this.setZhanBuBtnTxt(Model_card.haveUseMoneyZhanBuTimes);
      }
      
      private function updateLeftTimes() : void
      {
         this.leftTimes = Model_card.leftTimes;
      }
      
      private function set curZhanBuId(value:int) : void
      {
         var i:* = undefined;
         this._curZhanBuId = value;
         for(i in this.XingZuoBtnArr)
         {
            if(i > value)
            {
               this.XingZuoBtnArr[i].light = false;
            }
            else
            {
               this.XingZuoBtnArr[i].light = true;
            }
            if(value == i)
            {
               this.arrowBm.x = this.XingZuoBtnArr[i].x - 3;
               this.arrowBm.y = this.XingZuoBtnArr[i].y + 30;
            }
         }
      }
      
      private function get curZhanBuId() : int
      {
         return this._curZhanBuId;
      }
      
      private function set leftTimes(value:int) : void
      {
         var i:* = undefined;
         var k:* = undefined;
         var j:* = undefined;
         for(i in this.leftTimesBmArr)
         {
            if(value > i)
            {
               this.leftTimesBmArr[i].visible = true;
            }
            else
            {
               this.leftTimesBmArr[i].visible = false;
            }
         }
         if(value > 0)
         {
            this.showArrow();
            for(k in this.XingZuoBtnArr)
            {
               if(k == this.curZhanBuId)
               {
                  this.XingZuoBtnArr[k].mouseEnabled = true;
               }
               else
               {
                  this.XingZuoBtnArr[k].mouseEnabled = false;
               }
            }
         }
         else
         {
            this.hideArrow();
            for(j in this.XingZuoBtnArr)
            {
               this.XingZuoBtnArr[j].mouseEnabled = false;
            }
         }
      }
      
      private function updateCountDown() : void
      {
         this.countDownTxt.text = String(Math.floor(Model_card.countDown / 60)) + ":" + String(Model_card.countDown % 60 + 100).substr(-2);
      }
      
      private function showArrow() : void
      {
         if(this.arrowBm.alpha > 0)
         {
            Tween.to(this.arrowBm,500,{"alpha":[1,0]},this.showArrow);
         }
         else
         {
            Tween.to(this.arrowBm,500,{"alpha":[0,1]},this.showArrow);
         }
      }
      
      private function hideArrow() : void
      {
         Tween.stop(this.arrowBm);
         this.arrowBm.alpha = 0;
      }
      
      private function setZhanBuBtnTxt(haveUse:int) : void
      {
         var times:int = haveUse;
         if(times > Data_lib.cardDivineCost.getLength() - 1)
         {
            times = Data_lib.cardDivineCost.getLength() - 1;
         }
         this.lastZhanBuCost = this.ZhanBuCost;
         this.ZhanBuCost = Data_lib.cardDivineCost[times + 1][0];
         this.ZhanBuBtn.label = this.ZhanBuCost.toString();
         this.ZhanBuBtn.labelTF.text = this.ZhanBuCost.toString();
         this.ZhanBuBtn.LabelResize(34 - this.ZhanBuBtn.labelTF.width,8);
         TipManager.bind(this.ZhanBuBtn,"今日第" + HtmlUtil.fontNoSize(String(haveUse + 1),ColorConstant.getColorStr(ColorConstant.GREEN)) + "次元宝占卜，花费" + HtmlUtil.fontNoSize(String(this.ZhanBuCost) + "元宝",ColorConstant.getColorStr(ColorConstant.YELLOW)));
      }
      
      private function setCard(arr:Array) : void
      {
         var i:* = undefined;
         var t_card:View_card = null;
         var card:View_card = null;
         while(Boolean(this.cardArr.length))
         {
            t_card = this.cardArr.shift();
            this.removeChild(t_card);
            t_card.removeEventListener(MouseEvent.CLICK,this.onClickCard);
         }
         this.needPlayCardIndex = -1;
         for(i in arr)
         {
            card = new View_card();
            card.id = arr[i];
            card.star = 1;
            card.level = 1;
            card.exp = 0;
            card.y = this.cardY;
            card.addEventListener(MouseEvent.CLICK,this.onClickCard);
            this.cardArr.push(card);
            if(this.needPlayCard)
            {
               card.alpha = 0;
               card.x = this.cardEndX;
            }
            else if(Model_card.isZhanBuGetCard && this.needPlayCardIndex < 0 && arr[i] == Model_card.ZhanBuCardID)
            {
               this.needPlayCardIndex = i;
               card.alpha = 0;
            }
            addChild(card);
         }
         if(this.needPlayCard)
         {
            this.needPlayCard = false;
            if(Boolean(this.cardArr.length))
            {
               this.startCardMove();
            }
         }
         else
         {
            this.sortCardPosition();
         }
      }
      
      private function startCardMove() : void
      {
         var k:* = undefined;
         var i:* = undefined;
         var interval:int = 0;
         var j:* = undefined;
         Model_card.isPlaying = true;
         var posArr:Array = [];
         if(this.cardArr.length < 5)
         {
            for(i in this.cardArr)
            {
               posArr.push(this.cardStartX + i * 174);
            }
         }
         else
         {
            interval = this.cardTotalInterval / (this.cardArr.length - 1);
            for(j in this.cardArr)
            {
               if(j < this.cardArr.length - 1)
               {
                  posArr.push(this.cardStartX + j * interval);
               }
               else
               {
                  posArr.push(this.cardEndX);
               }
            }
         }
         this.playID = 0;
         for(k in this.cardArr)
         {
            setTimeout(this.cardMove,k * 100,k,posArr[k]);
         }
      }
      
      private function sortCardPosition() : void
      {
         var i:* = undefined;
         var interval:int = 0;
         var j:* = undefined;
         var len:int = int(this.cardArr.length);
         if(len > 15)
         {
            throw new Error("卡牌数量超过15张！");
         }
         if(len < 5)
         {
            for(i in this.cardArr)
            {
               this.cardArr[i].x = this.cardStartX + i * this.cardArr[i].width;
               if(this.needPlayCardIndex == i)
               {
                  this.needPlayCardPositionX = this.cardArr[i].x;
               }
            }
         }
         else
         {
            interval = this.cardTotalInterval / (len - 1);
            for(j in this.cardArr)
            {
               if(j < len - 1)
               {
                  this.cardArr[j].x = this.cardStartX + j * interval;
               }
               else
               {
                  this.cardArr[j].x = this.cardEndX;
               }
               if(this.needPlayCardIndex == j)
               {
                  this.needPlayCardPositionX = this.cardArr[j].x;
               }
            }
         }
         if(!this.needPlayCard && Model_card.isZhanBuGetCard)
         {
            Model_card.isZhanBuGetCard = false;
            Model_card.isPlaying = true;
            Tween.to(this.cardArr[this.needPlayCardIndex],250,{
               "x":[397,this.needPlayCardPositionX],
               "y":[446,this.cardY],
               "alpha":[0,1],
               "scaleX":[0,1],
               "scaleY":[0,1]
            },function():void
            {
               Model_card.isPlaying = false;
            });
         }
      }
      
      private function cardMove(id:int, posX:int) : void
      {
         Tween.curTo(this.cardArr[id],250,{
            "x":posX,
            "alpha":1
         },function():void
         {
            ++playID;
            if(playID == cardArr.length)
            {
               Model_card.isPlaying = false;
            }
         });
      }
      
      private function onClickCard(e:MouseEvent) : void
      {
         var card:View_card = null;
         var LeiJi:int = 0;
         var lv:int = 0;
         if(Model_card.isPlaying)
         {
            UIManager.centerBroadcast.addMsg("动画播放中，请稍等片刻");
            return;
         }
         card = e.currentTarget as View_card;
         switch(this.mouseFlag)
         {
            case 1:
               if(card.color > 2 && this.needCheckBox)
               {
                  LeiJi = 0;
                  lv = 1;
                  while(lv < card.level)
                  {
                     LeiJi += Data_lib.cardLevel[lv][card.color - 1];
                     lv++;
                  }
                  View_Alert.show(HtmlUtil.fontNoSize("确定分解" + HtmlUtil.fontNoSize(Data_lib.card[card.id][2],ColorConstant.getItemColorStr(Data_lib.card[card.id][4])) + "获得" + HtmlUtil.fontNoSize(String(Data_lib.cardDestroy[card.id][1] + card.exp + LeiJi),ColorConstant.getColorStr(ColorConstant.YELLOW)) + HtmlUtil.fontNoSize("卡牌经验",ColorConstant.getColorStr(ColorConstant.GREEN)) + (Data_lib.cardDestroy[card.id][2] > 0 ? "和" + HtmlUtil.fontNoSize(String(Data_lib.cardDestroy[card.id][2]),ColorConstant.getColorStr(ColorConstant.YELLOW)) + HtmlUtil.fontNoSize("卡牌残页",ColorConstant.getColorStr(ColorConstant.GREEN)) : "") + "吗？",ColorConstant.getColorStr(ColorConstant.WHITE)),2,function():void
                  {
                     CardCGMessage.CG_CARD_FenJie(3,1,cardArr.indexOf(card));
                  },function():void
                  {
                     needCheckBox = true;
                  },null,null,340,"","","center",this.needCheckBox);
                  View_Alert.instance.showCheckBox = function():void
                  {
                     needCheckBox = !needCheckBox;
                  };
                  break;
               }
               CardCGMessage.CG_CARD_FenJie(3,1,this.cardArr.indexOf(card));
               break;
            case 2:
               if(Model_card.bagCardVoArray.length > 199)
               {
                  UIManager.centerBroadcast.addMsg("卡牌背包已满",1);
                  return;
               }
               this.removeCard(card);
         }
      }
      
      private function removeCard(card:View_card) : void
      {
         var index:int = 0;
         Model_card.isPlaying = true;
         index = this.cardArr.indexOf(card);
         this.cardArr.splice(index,1);
         addChild(card);
         Tween.curTo(card,500,{
            "scaleX":0,
            "scaleY":0,
            "x":this.bagBtn.x + 20,
            "y":this.bagBtn.y + 23
         },function():void
         {
            Model_card.isPlaying = false;
            card.parent.removeChild(card);
            CardCGMessage.CG_CARD_PICK_UP(1,index);
         });
      }
      
      private function removeAllCard() : void
      {
         var id:int;
         var i:* = undefined;
         Model_card.isPlaying = true;
         this.playID = 0;
         id = 0;
         for(i in this.cardArr)
         {
            setTimeout(function():void
            {
               Tween.curTo(cardArr[id++],500,{
                  "scaleX":0,
                  "scaleY":0,
                  "x":bagBtn.x + 20,
                  "y":bagBtn.y + 23
               },checkPlay);
            },i * 50);
         }
      }
      
      private function checkPlay() : void
      {
         ++this.playID;
         if(this.playID == this.cardArr.length)
         {
            Model_card.isPlaying = false;
            CardCGMessage.CG_CARD_PICK_UP(2,0);
         }
      }
      
      private function onClickXingZuoBtn() : void
      {
         if(this.cardArr.length > 14)
         {
            UIManager.centerBroadcast.addMsg("最多占卜15张卡牌，请先收取卡牌到背包",1);
         }
         else
         {
            CardCGMessage.CG_CARD_ZhanBu(1);
         }
      }
      
      private function onClickZhanBuBtn(e:MouseEvent) : void
      {
         var bool:Boolean = false;
         if(Model_card.isPlaying)
         {
            UIManager.centerBroadcast.addMsg("动画播放中，请稍等片刻");
            return;
         }
         if(this.cardArr.length > 15)
         {
            UIManager.centerBroadcast.addMsg("最多占卜15张卡牌，请先收取卡牌到背包",1);
         }
         else
         {
            if(this.ZhanBuCost > GameUnitManager.hero.money)
            {
               UIManager.centerBroadcast.addMsg("元宝不足");
               return;
            }
            bool = Model_card.haveUseMoneyZhanBuTimes > 3 ? true : false;
            if(this.ZhanBuBtnNeedCheck)
            {
               View_Alert.show(HtmlUtil.fontNoSize("确定要花费",ColorConstant.getColorStr(ColorConstant.WHITE)) + this.ZhanBuCost + "元宝" + HtmlUtil.fontNoSize("来进行占卜吗？",ColorConstant.getColorStr(ColorConstant.WHITE)),2,function():void
               {
                  CardCGMessage.CG_CARD_ZhanBu(2);
               },function():void
               {
                  ZhanBuBtnNeedCheck = true;
               },null,null,310,"","","center",bool);
               View_Alert.instance.showCheckBox = function():void
               {
                  ZhanBuBtnNeedCheck = !ZhanBuBtnNeedCheck;
               };
            }
            else
            {
               CardCGMessage.CG_CARD_ZhanBu(2);
            }
         }
      }
      
      private function onClickFenJie(e:MouseEvent) : void
      {
         this.mouseFlag = 1;
      }
      
      private function onClickYiJianFenJie(e:MouseEvent) : void
      {
         var arr:Array;
         var len:int;
         var exp:int;
         var SuiPian:int;
         var str:String;
         var i:int;
         var j:* = undefined;
         var card:View_card = null;
         var card1:View_card = null;
         var LeiJi:int = 0;
         var lv:int = 0;
         if(Model_card.isPlaying)
         {
            UIManager.centerBroadcast.addMsg("动画播放中，请稍等片刻");
            return;
         }
         this.mouseFlag = 0;
         if(this.cardArr.length == 0)
         {
            UIManager.centerBroadcast.addMsg("已没有卡牌可供分解");
            return;
         }
         arr = this.cardArr.concat();
         arr.sortOn("color",Array.NUMERIC);
         len = int(arr.length);
         exp = 0;
         SuiPian = 0;
         str = "";
         i = len - 1;
         while(i > len - 4 && i >= 0)
         {
            card = arr[i] as View_card;
            str += HtmlUtil.fontNoSize(Data_lib.card[card.id][2],ColorConstant.getItemColorStr(Data_lib.card[card.id][4]));
            if(i > len - 3 && i > 0)
            {
               str += "/";
            }
            i--;
         }
         if(len > 3)
         {
            str += "等";
         }
         for(j in arr)
         {
            card1 = arr[j] as View_card;
            LeiJi = 0;
            lv = 1;
            while(lv < card1.level)
            {
               LeiJi += Data_lib.cardLevel[lv][card1.color - 1];
               lv++;
            }
            exp += Data_lib.cardDestroy[card1.id][1] + card1.exp + LeiJi;
            SuiPian += Data_lib.cardDestroy[card1.id][2];
         }
         View_Alert.show(HtmlUtil.fontNoSize("确定分解" + str + "获得" + HtmlUtil.fontNoSize(String(exp),ColorConstant.getColorStr(ColorConstant.YELLOW)) + HtmlUtil.fontNoSize("卡牌经验",ColorConstant.getColorStr(ColorConstant.GREEN)) + (SuiPian > 0 ? "和" + HtmlUtil.fontNoSize(String(SuiPian),ColorConstant.getColorStr(ColorConstant.YELLOW)) + HtmlUtil.fontNoSize("卡牌残页",ColorConstant.getColorStr(ColorConstant.GREEN)) : "") + "吗？",ColorConstant.getColorStr(ColorConstant.WHITE)),2,function():void
         {
            CardCGMessage.CG_CARD_FenJie(3,2,0);
         },null,null,null,340,"","","center");
      }
      
      private function onClickShiQu(e:MouseEvent) : void
      {
         this.mouseFlag = 2;
      }
      
      private function onClickYiJianShiQu(e:MouseEvent) : void
      {
         if(200 - Model_card.bagCardVoArray.length < this.cardArr.length)
         {
            UIManager.centerBroadcast.addMsg("卡牌背包已满",1);
            return;
         }
         if(Model_card.isPlaying)
         {
            UIManager.centerBroadcast.addMsg("动画播放中，请稍等片刻");
            return;
         }
         if(this.cardArr.length > 0)
         {
            this.removeAllCard();
         }
      }
   }
}

import com.ui.controls.MyTextField;
import com.ui.controls.ScaleBitmap;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.Data_lib;
import com.yiTian.manager.UIManager;
import com.yiTian.view.Panel;
import com.yiTian.view.modules.Card.Model_card;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;

class XingZuoBtn extends Sprite
{
   
   public static const Event_ZhanBu:String = "XingZuoBtn_Event_ZhanBu";
   
   private var XingZuoBmLight:Bitmap;
   
   private var XingZuoBmDark:Bitmap;
   
   private var isLight:Boolean = true;
   
   public function XingZuoBtn()
   {
      super();
      this.XingZuoBmDark = ComponentUtil.getBitmap("Icon_PuTongQ",this,null,Global.KaPaidm);
      this.XingZuoBmLight = ComponentUtil.getBitmap("Icon_FaGuangQ",this,null,Global.KaPaidm);
      this.buttonMode = true;
      this.addEventListener(MouseEvent.CLICK,this.onClick);
   }
   
   private function onClick(e:MouseEvent) : void
   {
      if(Model_card.isPlaying)
      {
         UIManager.centerBroadcast.addMsg("动画播放中，请稍等片刻");
         return;
      }
      Global.control.sendNotification(Event_ZhanBu,null);
   }
   
   public function set light(value:Boolean) : void
   {
      if(this.isLight != value)
      {
         this.isLight = value;
         this.XingZuoBmLight.visible = this.isLight;
      }
   }
}

class Tips extends Panel
{
   
   private var backBm:ScaleBitmap;
   
   private var backBm2:ScaleBitmap;
   
   private var txt:MyTextField;
   
   public function Tips()
   {
      super();
      init();
   }
   
   override protected function initStaticView() : void
   {
      this.backBm = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
         "x":0,
         "y":0,
         "width":450,
         "height":300
      },Global.Img_Cdm);
      this.backBm2 = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
         "x":25,
         "y":40,
         "width":470,
         "height":350
      },Global.Img_Cdm);
      ComponentUtil.getBitmap("Title_WFSM",this,{
         "x":169,
         "y":3
      },Global.Img_Cdm);
      CloseButton = ComponentUtil.getButton("","Button_Close",this,{
         "x":0,
         "y":6,
         "textColor":16771436
      },Global.Img_Cdm);
      this.txt = ComponentUtil.getTextField("",this,{
         "x":33,
         "y":50,
         "color":3407667,
         "size":12,
         "leading":0
      });
      this.txt.multiline = true;
      this.txt.width = 350;
      this.txt.htmlText = Data_lib.lang0[1181][0];
      this.backBm.width = 66 + this.txt.width;
      this.backBm.height = 50 + this.txt.height + 50;
      this.backBm2.width = this.backBm.width - 50;
      this.backBm2.height = this.backBm.height - 50;
      CloseButton.x = this.backBm.width - 40;
   }
   
   override public function resetPosition() : void
   {
      x = (Global.stage.stageWidth - width) / 2;
      y = (Global.stage.stageHeight - height) / 2;
   }
}
