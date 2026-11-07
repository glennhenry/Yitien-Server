package com.yiTian.view.modules.jianghulixian
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_Jianghulixian;
   import com.yiTian.data.model.Model_Jianghulixian;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.JianghulixianCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.newRolePan.View_rolePan;
   import com.yiTian.view.modules.panel.Enum_panel_role;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   
   public class View_Jianghulixian_menu extends Panel123
   {
      
      public static var IsInit:Boolean;
      
      public static var inGame:Boolean;
      
      private static var _instance:View_Jianghulixian_menu;
      
      private var _currentOpenTime:int = 1;
      
      private var cardType_0:View_Jianghulixian_left;
      
      private var cardType_1:View_Jianghulixian_left;
      
      private var cardType_2:View_Jianghulixian_left;
      
      private var cardType_3:View_Jianghulixian_left;
      
      private var cardType_4:View_Jianghulixian_left;
      
      private var cardType_5:View_Jianghulixian_left;
      
      private var cardType_6:View_Jianghulixian_left;
      
      private var cardType_7:View_Jianghulixian_left;
      
      private var cardType_8:View_Jianghulixian_left;
      
      private var cardType_9:View_Jianghulixian_left;
      
      private var card_0:View_Jianghulixian_card;
      
      private var card_1:View_Jianghulixian_card;
      
      private var card_2:View_Jianghulixian_card;
      
      private var card_3:View_Jianghulixian_card;
      
      private var card_4:View_Jianghulixian_card;
      
      private var cardPositionArray:Array = [];
      
      private var countPlayedCard:int = 0;
      
      private var topTxt:View_Jianghulixian_top;
      
      public var leftTimes:MyTextField;
      
      private var oneKey:Button;
      
      private var oneKeyAllOpened_flag:int = -1;
      
      private var getPrizeBtn:Button;
      
      private var _getPrizeBtnStatus:int;
      
      private var costTxt:MyTextField;
      
      private var changeCardArr:Array = [];
      
      private var currentBangyinSpr:Sprite;
      
      private var currentBangyin:MyTextField;
      
      private var currentBangyin_plus:MyTextField;
      
      private var currentYueliSpr:Sprite;
      
      private var currentYueli:MyTextField;
      
      private var currentYueli_plus:MyTextField;
      
      private var numberRunTimer:Timer;
      
      private var prevBangYin:int;
      
      private var prevYueLi:int;
      
      private var perRunTimeNumber_B:int;
      
      private var perRunTimeNumber_Y:int;
      
      private var upgradeTitleBtn:Button;
      
      private var pleaseChangeTxt:MyTextField;
      
      private var inMovieArray:Array = [0,0,0,0,0];
      
      private var closeBtn:Button;
      
      private var helBtn:Button;
      
      private var startTips:View_Jianghulixian_StartTips;
      
      public function View_Jianghulixian_menu()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/LiXian_Imgs.swf","LiXian_Imgsdm");
      }
      
      public static function get instance() : View_Jianghulixian_menu
      {
         if(!_instance)
         {
            _instance = new View_Jianghulixian_menu();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         move = new Rectangle(0,0,883,30);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":883,
            "height":549
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":835,
            "height":500
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Back_Img",this,{
            "x":34,
            "y":50
         },Global.LiXian_Imgsdm);
         this.cardType_0 = new View_Jianghulixian_left(0);
         this.cardType_0.x = 44;
         this.cardType_0.y = 80;
         this.addChild(this.cardType_0);
         this.cardType_7 = new View_Jianghulixian_left(7);
         this.cardType_7.x = 44;
         this.cardType_7.y = 374;
         this.addChild(this.cardType_7);
         this.cardType_9 = new View_Jianghulixian_left(9);
         this.cardType_9.x = 44;
         this.cardType_9.y = 458;
         this.addChild(this.cardType_9);
         this.cardType_8 = new View_Jianghulixian_left(8);
         this.cardType_8.x = 44;
         this.cardType_8.y = 416;
         this.addChild(this.cardType_8);
         this.cardType_6 = new View_Jianghulixian_left(6);
         this.cardType_6.x = 44;
         this.cardType_6.y = 332;
         this.addChild(this.cardType_6);
         this.cardType_5 = new View_Jianghulixian_left(5);
         this.cardType_5.x = 44;
         this.cardType_5.y = 290;
         this.addChild(this.cardType_5);
         this.cardType_4 = new View_Jianghulixian_left(4);
         this.cardType_4.x = 44;
         this.cardType_4.y = 248;
         this.addChild(this.cardType_4);
         this.cardType_2 = new View_Jianghulixian_left(2);
         this.cardType_2.x = 44;
         this.cardType_2.y = 164;
         this.addChild(this.cardType_2);
         this.cardType_1 = new View_Jianghulixian_left(1);
         this.cardType_1.x = 44;
         this.cardType_1.y = 122;
         this.addChild(this.cardType_1);
         this.cardType_3 = new View_Jianghulixian_left(3);
         this.cardType_3.x = 44;
         this.cardType_3.y = 206;
         this.addChild(this.cardType_3);
         ComponentUtil.getBitmap("Title_JLGuiZe",this,{
            "x":55,
            "y":58
         },Global.LiXian_Imgsdm);
         this.card_0 = new View_Jianghulixian_card(0);
         this.card_1 = new View_Jianghulixian_card(1);
         this.card_2 = new View_Jianghulixian_card(2);
         this.card_3 = new View_Jianghulixian_card(3);
         this.card_4 = new View_Jianghulixian_card(4);
         this.card_0.x = 245;
         this.card_0.y = 129;
         this.card_1.x = 362;
         this.card_1.y = 129;
         this.card_2.x = 479;
         this.card_2.y = 129;
         this.card_3.x = 596;
         this.card_3.y = 129;
         this.card_4.x = 713;
         this.card_4.y = 129;
         this.addChild(this.card_0);
         this.addChild(this.card_1);
         this.addChild(this.card_2);
         this.addChild(this.card_3);
         this.addChild(this.card_4);
         this.cardPositionArray = [new Point(245,129),new Point(362,129),new Point(479,129),new Point(596,129),new Point(713,129)];
         this.topTxt = new View_Jianghulixian_top();
         this.topTxt.x = -206 + 442;
         this.topTxt.y = -207 + 275;
         this.addChild(this.topTxt);
         this.pleaseChangeTxt = ComponentUtil.getTextField("请选择需要更换的牌",this,{
            "x":481,
            "y":380,
            "color":52224,
            "size":12,
            "leading":0
         });
         this.getPrizeBtn = ComponentUtil.getButton("","Button_Change",this,{
            "x":461,
            "y":407,
            "textColor":16777215
         },Global.LiXian_Imgsdm);
         this.getPrizeBtn.callBack = this.onGetPrizeBtnClick;
         this.getPrizeBtn.labelTF.multiline = true;
         this.getPrizeBtn.labelTF.align = "center";
         this.getPrizeBtn.labelSize = 16;
         this.costTxt = ComponentUtil.getTextField("",this,{
            "x":480,
            "y":468,
            "color":16764206,
            "size":12,
            "leading":0,
            "realWidth":104
         });
         this.costTxt.autoSize = TextFieldAutoSize.CENTER;
         this.oneKey = ComponentUtil.getButton("","Button_Five",this,{
            "x":715,
            "y":413,
            "textColor":16184781
         },Global.LiXian_Imgsdm);
         this.oneKey.callBack = this.oneKeyHandler;
         TipManager.bind(this.oneKey,"必定开出5张相同的牌");
         this.currentBangyinSpr = new Sprite();
         ComponentUtil.getBitmap("Bangyin",this.currentBangyinSpr,{
            "x":-410 + 442,
            "y":240 + 275
         },Global.LiXian_Imgsdm);
         this.currentBangyin = ComponentUtil.getTextField("0",this,{
            "x":-390 + 442,
            "y":238 + 275,
            "color":52224,
            "size":12,
            "leading":0
         });
         this.addChild(this.currentBangyinSpr);
         TipManager.bind(this.currentBangyinSpr,"当前绑银");
         this.currentBangyin_plus = ComponentUtil.getTextField("",this,{
            "x":-390 + 385 + 442,
            "y":238 - 20 - 230 + 275,
            "color":16776960,
            "size":20,
            "leading":0
         });
         this.currentYueliSpr = new Sprite();
         ComponentUtil.getBitmap("Yueli",this.currentYueliSpr,{
            "x":-300 + 442,
            "y":240 + 275
         },Global.LiXian_Imgsdm);
         this.currentYueli = ComponentUtil.getTextField("0",this,{
            "x":-277 + 442,
            "y":238 + 275,
            "color":11363483,
            "size":12,
            "leading":0
         });
         this.addChild(this.currentYueliSpr);
         TipManager.bind(this.currentYueliSpr,"当前阅历");
         this.currentYueli_plus = ComponentUtil.getTextField("",this,{
            "x":-277 + 385 + 442,
            "y":238 - 20 - 230 + 275,
            "color":16776960,
            "size":20,
            "leading":0
         });
         this.numberRunTimer = new Timer(100,20);
         this.numberRunTimer.addEventListener(TimerEvent.TIMER,this.numberRunTimerHandler);
         this.upgradeTitleBtn = ComponentUtil.getButton("提升称号","Button_Four",this,{
            "x":220 - 422 + 442,
            "y":510 + 275,
            "textColor":16184781
         },Global.Img_Cdm);
         this.upgradeTitleBtn.callBack = this.onClickUpgradeTitle;
         ComponentUtil.getBitmap("Title_LiXian",this,{
            "x":361,
            "y":5
         },Global.LiXian_Imgsdm);
         ComponentUtil.getScaleBitmap("Back_Alpha50",[6,6,1,1],this,{
            "x":715,
            "y":75,
            "width":110,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getTextField("今日剩余次数：",this,{
            "x":719,
            "y":77,
            "color":11523767,
            "size":12,
            "leading":0
         });
         this.leftTimes = ComponentUtil.getTextField("",this,{
            "x":803,
            "y":77,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.closeBtn = ComponentUtil.getButton("","Button_Close",this,{
            "x":849,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.closeBtn.callBack = this.closeMenu;
         this.helBtn = ComponentUtil.getButton("","Button_HDTips",this,{
            "x":849 - 28,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         TipManager.bind(this.helBtn,"1.根据左边的<font color=\'#ffff00\'>评分规则</font>，通过换牌来获得<font color=\'#ffff00\'>更好的牌型</font><br/>" + "2.每次历险都有<font color=\'#ffff00\'>2次免费换牌</font>的机会<br/>" + "3.免费换牌用完后，可以花费<font color=\'#ffff00\'>元宝</font>来换牌<br/>" + "4.当玩家翻出<font color=\'#ffff00\'>【五张相同】</font>时，直接获得奖励<br/>" + "5.花费<font color=\'#ffff00\'>100元宝</font>进行<font color=\'#ffff00\'>一键五张相同</font>可必定翻出五张相同");
         this.startTips = new View_Jianghulixian_StartTips();
         this.startTips.Init();
         this.startTips.x = 442;
         this.startTips.y = 275;
         this.addChild(this.startTips);
         var i:int = 1;
         while(i <= 10)
         {
            Enum_Jianghulixian.NamePrizeArray.push(Data_lib.paixingbiao[i][0]);
            Enum_Jianghulixian.MoneyPrizeArray.push(Number(String(Data_lib.paixingbiao[i][1]).split("_")[0]));
            Enum_Jianghulixian.YueliPrizeArrar.push(Number(String(Data_lib.paixingbiao[i][1]).split("_")[1]));
            i++;
         }
         Global.control.registerCallBack(Enum_Jianghulixian.Jianghulixian_UPDATE_LEFT_TIME,this.updateLeftTime);
         Global.control.registerCallBack(Enum_Jianghulixian.Jianghulixian_GAME_START,this.gameStart);
         Global.control.registerCallBack(Enum_Jianghulixian.Jianghulixian_CHECK_CHANGE_CARD,this.checkChangeCard);
         Global.control.registerCallBack(Enum_Jianghulixian.Jianghulixian_CARD_OPENED,this.onOneKeyAllOpened);
         Global.control.registerCallBack(Enum_Jianghulixian.Jianghulixian_UPDATE_Yueli,this.updateYueli_roll);
      }
      
      private function openMenu() : void
      {
         var i:* = undefined;
         var j:int = 0;
         inGame = false;
         this.startTips.Show("点击开始游戏");
         this.startTips.x = 37 + 58 + 442;
         this.startTips.y = -146 + 152 - this.startTips.height + 275;
         this.topTxt.visible = false;
         this.updateYueli();
         this.getPrizeBtn.visible = false;
         this.costTxt.visible = false;
         this.oneKey.visible = false;
         this.pleaseChangeTxt.visible = false;
         this.getPrizeBtn.enabled = true;
         this.oneKey.enabled = true;
         for(i in this.cardPositionArray)
         {
            this["card_" + i].x = this.cardPositionArray[2].x;
            this["card_" + i].y = this.cardPositionArray[2].y;
            Enum_Jianghulixian.GameStatus = 0;
         }
         j = 0;
         while(j < 10)
         {
            this["cardType_" + j].setSelect(false);
            j++;
         }
      }
      
      private function gameStart(e:* = null) : void
      {
         this.startTips.visible = false;
         this.setAllCard(Model_Jianghulixian.cardArr);
         if(Enum_Jianghulixian.GameStatus == 0)
         {
            this.breakUp();
         }
         else if(Enum_Jianghulixian.GameStatus == 2)
         {
            this.restart();
         }
      }
      
      private function restart() : void
      {
         this.allCardClose();
         this.topTxt.visible = false;
         this.getPrizeBtn.visible = false;
         this.costTxt.visible = false;
         this.oneKey.visible = false;
         this.pleaseChangeTxt.visible = false;
         var j:int = 0;
         while(j < 10)
         {
            this["cardType_" + j].setSelect(false);
            j++;
         }
      }
      
      private function allCardClose() : void
      {
         var i:int = 0;
         while(i < 5)
         {
            View_Jianghulixian_card(this["card_" + i]).CloseCard();
            i++;
         }
         setTimeout(this.getTogetherAndBreakUp,300);
      }
      
      private function getTogetherAndBreakUp() : void
      {
         var i:* = undefined;
         for(i in this.cardPositionArray)
         {
            Tween.curTo(this["card_" + i],1000,{"x":this.cardPositionArray[2].x},function():void
            {
               ++countPlayedCard;
               if(countPlayedCard == 5)
               {
                  countPlayedCard = 0;
                  breakUp();
               }
            });
         }
      }
      
      private function breakUp() : void
      {
         var i:* = undefined;
         for(i in this.cardPositionArray)
         {
            Tween.curTo(this["card_" + i],1000,{"x":this.cardPositionArray[i].x},function():void
            {
               ++countPlayedCard;
               if(countPlayedCard == 5)
               {
                  countPlayedCard = 0;
                  showCard();
               }
            });
         }
      }
      
      private function showCard() : void
      {
         var j:int = 0;
         while(j < 5)
         {
            this["card_" + j].OpenCard();
            j++;
         }
         setTimeout(this.firstUpdate,300);
      }
      
      private function firstUpdate() : void
      {
         this.topTxt.visible = true;
         this.oneKey.visible = true;
         this.currentOpenTime = 1;
         this.pleaseChangeTxt.visible = true;
         this.getPrizeBtn.visible = true;
         this.getPrizeBtnStatus = 0;
         this.costTxt.visible = true;
         this.setTopAndCardType(Model_Jianghulixian.cardTypeArr);
         Enum_Jianghulixian.GameStatus = 1;
      }
      
      public function setAllCard(_cardArr:Array) : void
      {
         var j:* = undefined;
         for(j in _cardArr)
         {
            this["card_" + j].setCard(int(_cardArr[j]));
         }
      }
      
      public function setTopAndCardType(_cardType:Array) : void
      {
         var i:* = undefined;
         var j:int = 0;
         while(j < 10)
         {
            for(i in _cardType)
            {
               if(j == int(_cardType[i]) - 1)
               {
                  this["cardType_" + j].setSelect(true);
                  break;
               }
               this["cardType_" + j].setSelect(false);
            }
            j++;
         }
         this.topTxt.setPrizeText(_cardType);
      }
      
      public function GameOver() : void
      {
         var i:int;
         EffectManager.addEffect("56918",this,500,100 + 442,275);
         Enum_Jianghulixian.GameStatus = 2;
         this.getPrizeBtnStatus = -1;
         this.outPutPrizeTips(Model_Jianghulixian.cardTypeArr);
         this.costTxt.visible = false;
         this.pleaseChangeTxt.visible = false;
         i = 0;
         while(i < 10)
         {
            this["cardType_" + i].setSelect(false);
            i++;
         }
         inGame = false;
         if(Model_Jianghulixian.cardTypeArr[0] == "1")
         {
            setTimeout(function():void
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#F169DB\' size=\'20\'>恭喜你中了【五张相同】</font>");
            },500);
         }
         if(Model_Jianghulixian.leftTimes <= 0)
         {
            this.getPrizeBtn.enabled = false;
            this.oneKey.enabled = false;
         }
      }
      
      override public function set visible(_value:Boolean) : void
      {
         if(_value)
         {
            this.openMenu();
            super.visible = _value;
         }
         else if(inGame)
         {
            View_Alert.show("游戏未结束，确定退出？",2,function():void
            {
               if(UIManager.jianghulixian_tips.visible)
               {
                  UIManager.jianghulixian_tips.visible = false;
               }
               if(UIManager.jianghulixian_onekey_tips.visible)
               {
                  UIManager.jianghulixian_onekey_tips.visible = false;
               }
               JianghulixianCGMessage.CG_Jianghulixian_GET_RESULT(2);
               inGame = false;
            });
         }
         else
         {
            super.visible = false;
         }
      }
      
      override public function resetPosition() : void
      {
         this.x = (Global.stage.stageWidth - 883) / 2;
         this.y = (Global.stage.stageHeight - 549) / 2;
      }
      
      private function updateLeftTime() : void
      {
         if(IsInit)
         {
            this.leftTimes.text = Model_Jianghulixian.leftTimes.toString();
         }
      }
      
      public function updateYueli() : void
      {
         this.currentYueli.text = GameUnitManager.hero.yeLi.toString();
         this.currentBangyin.text = GameUnitManager.hero.bingSilver.toString();
      }
      
      private function updateYueli_roll() : void
      {
         if(GameUnitManager.hero.yeLi - int(this.currentYueli.text) <= 0)
         {
            this.currentYueli.text = GameUnitManager.hero.yeLi.toString();
         }
         if(GameUnitManager.hero.bingSilver - int(this.currentBangyin.text) <= 0)
         {
            this.currentBangyin.text = GameUnitManager.hero.bingSilver.toString();
         }
      }
      
      private function numberRunTimerHandler(e:TimerEvent) : void
      {
         this.currentBangyin.text = String(int(this.currentBangyin.text) + this.perRunTimeNumber_B);
         this.currentYueli.text = String(int(this.currentYueli.text) + this.perRunTimeNumber_Y);
         this.currentBangyin_plus.htmlText = "<font color=\'#ffffff\'>绑银</font>+" + (this.prevBangYin - this.perRunTimeNumber_B * this.numberRunTimer.currentCount);
         this.currentYueli_plus.htmlText = "<font color=\'#ffffff\'>阅历</font>+" + (this.prevYueLi - this.perRunTimeNumber_Y * this.numberRunTimer.currentCount);
         if(this.numberRunTimer.currentCount == 20)
         {
            this.currentYueli.text = GameUnitManager.hero.yeLi.toString();
            this.currentBangyin.text = GameUnitManager.hero.bingSilver.toString();
            this.currentBangyin_plus.text = "";
            this.currentYueli_plus.text = "";
         }
      }
      
      private function cardIsMoving() : Boolean
      {
         var i:* = undefined;
         for(i in this.inMovieArray)
         {
            if(this.inMovieArray[i] == 1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function oneKeyHandler(e:* = null) : void
      {
         var i:int;
         if(this.cardIsMoving() || this.countPlayedCard != 0)
         {
            UIManager.centerBroadcast.addMsg("请等待动画播放完毕...");
            return;
         }
         i = 0;
         while(i < 5)
         {
            if(Boolean(this["card_" + i].isPlay))
            {
               UIManager.centerBroadcast.addMsg("请等待动画播放完毕...");
               return;
            }
            i++;
         }
         if(Model_Jianghulixian.leftTimes == 0 && (Enum_Jianghulixian.GameStatus == 0 || Enum_Jianghulixian.GameStatus == 2))
         {
            UIManager.centerBroadcast.addMsg("今天翻牌次数已用尽，请明天再来");
            return;
         }
         UIManager.jianghulixian_onekey_tips.SetOneKeyTips();
         UIManager.jianghulixian_onekey_tips.show(function():void
         {
            if(GameUnitManager.hero.money < 100)
            {
               UIManager.centerBroadcast.addMsg("元宝不足");
               return;
            }
            inGame = true;
            JianghulixianCGMessage.CG_Jianghulixian_GET_RESULT(3);
         });
      }
      
      public function OneKeyHandler() : void
      {
         var i:int = 0;
         while(i < 5)
         {
            this.inMovieArray[i] = 1;
            this.Tween1(i);
            i++;
         }
      }
      
      private function Tween1(i:int) : void
      {
         Tween.curTo(this["card_" + i],200,{
            "y":550 - this["card_" + i].height + 100,
            "alpha":0
         },function():void
         {
            inMovieArray[i] = 0;
            if(!cardIsMoving())
            {
               setAllCard(Model_Jianghulixian.cardArr);
               onOneKeyCardDrop();
            }
         });
      }
      
      private function onOneKeyCardDrop() : void
      {
         this.oneKeyAllOpened_flag = 0;
         var i:int = 0;
         while(i < 5)
         {
            this.inMovieArray[i] = 1;
            this["card_" + i].SetOneKeyResult();
            this.Tween2(i);
            i++;
         }
      }
      
      private function Tween2(i:int) : void
      {
         Tween.to(this["card_" + i],200,{
            "y":[0,this.cardPositionArray[i].y],
            "alpha":[0,1]
         },function():void
         {
            inMovieArray[i] = 0;
            if(!cardIsMoving())
            {
               onekeyCard();
            }
         });
      }
      
      private function onekeyCard() : void
      {
         var j:int = 0;
         while(j < 5)
         {
            this["card_" + j].OpenCard();
            j++;
         }
      }
      
      private function onOneKeyAllOpened(e:* = null) : void
      {
         if(this.oneKeyAllOpened_flag == -1)
         {
            return;
         }
         ++this.oneKeyAllOpened_flag;
         if(this.oneKeyAllOpened_flag == 5)
         {
            this.oneKeyAllOpened_flag = -1;
            this.setTopAndCardType(Model_Jianghulixian.cardTypeArr);
            this.GameOver();
         }
      }
      
      public function outPutPrizeTips(_cardType:Array) : void
      {
         var i:* = undefined;
         var money:int = 0;
         var yueli:int = 0;
         for(i in _cardType)
         {
            money += Enum_Jianghulixian.MoneyPrizeArray[int(_cardType[i]) - 1];
            yueli += Enum_Jianghulixian.YueliPrizeArrar[int(_cardType[i]) - 1];
         }
         if(GameUnitManager.hero.bingSilver - int(this.currentBangyin.text) > 0 && GameUnitManager.hero.yeLi - int(this.currentYueli.text) > 0)
         {
            this.perRunTimeNumber_B = int((GameUnitManager.hero.bingSilver - int(this.currentBangyin.text)) / 21);
            this.perRunTimeNumber_Y = int((GameUnitManager.hero.yeLi - int(this.currentYueli.text)) / 21);
            this.currentBangyin_plus.text = "+" + String(GameUnitManager.hero.bingSilver - int(this.currentBangyin.text));
            this.currentYueli_plus.text = "+" + String(GameUnitManager.hero.yeLi - int(this.currentYueli.text));
            this.prevBangYin = GameUnitManager.hero.bingSilver - int(this.currentBangyin.text);
            this.prevYueLi = GameUnitManager.hero.yeLi - int(this.currentYueli.text);
            this.numberRunTimer.reset();
            this.numberRunTimer.start();
         }
      }
      
      private function onGetPrizeBtnClick(e:* = null) : void
      {
         var i:int;
         if(this.cardIsMoving() || this.countPlayedCard != 0)
         {
            UIManager.centerBroadcast.addMsg("请等待动画播放完毕...");
            return;
         }
         i = 0;
         while(i < 5)
         {
            if(Boolean(this["card_" + i].isPlay))
            {
               UIManager.centerBroadcast.addMsg("请等待动画播放完毕...");
               return;
            }
            i++;
         }
         if(this.getPrizeBtnStatus == 0)
         {
            JianghulixianCGMessage.CG_Jianghulixian_GET_RESULT(2);
         }
         else if(this.getPrizeBtnStatus == -1)
         {
            inGame = true;
            JianghulixianCGMessage.CG_Jianghulixian_GET_RESULT(1);
            if(Model_Jianghulixian.leftTimes < 1)
            {
               inGame = false;
               UIManager.centerBroadcast.addMsg("今天翻牌次数已用尽，请明天再来");
            }
         }
         else if(this.currentOpenTime < 3)
         {
            JianghulixianCGMessage.CG_Jianghulixian_CHANGE_CARD(this.changeCardArr);
         }
         else
         {
            if(this.currentOpenTime > 200)
            {
               this.currentOpenTime = 200;
            }
            UIManager.jianghulixian_tips.UpdateTipsTxt(this.currentOpenTime - 2);
            if(this.currentOpenTime == 200)
            {
               View_Alert.show(LangConfig.reTxt("<font color=\'#ffffff\'>确定花费</font><font color=\'#ffff00\'>{0}元宝</font>" + "<font color=\'#ffffff\'>换牌？</font><br/>此次必定开出</font><font color=\'#ffff00\'>【五张相同】</font>",Data_lib.huanpai[this.currentOpenTime - 2][0]),2,function():void
               {
                  JianghulixianCGMessage.CG_Jianghulixian_CHANGE_CARD(changeCardArr);
               });
            }
            else
            {
               UIManager.jianghulixian_tips.show(function():void
               {
                  if(GameUnitManager.hero.money < int(Data_lib.huanpai[currentOpenTime - 2][0]))
                  {
                     UIManager.centerBroadcast.addMsg("元宝不足");
                     return;
                  }
                  JianghulixianCGMessage.CG_Jianghulixian_CHANGE_CARD(changeCardArr);
               });
            }
         }
      }
      
      public function changeCard() : void
      {
         this.costTxt.visible = false;
         ++this.currentOpenTime;
         this.setAllCard(Model_Jianghulixian.cardArr);
         Tween.curTo(this.topTxt,500,{
            "y":0,
            "alpha":0
         });
         var i:int = 0;
         while(i < 5)
         {
            this["card_" + i].buttonMode = false;
            this["card_" + i].mouseEnabled = false;
            if(View_Jianghulixian_card(this["card_" + i]).status == 0)
            {
               this.inMovieArray[i] = 1;
               this.Tween3(i);
            }
            i++;
         }
      }
      
      private function Tween3(i:int) : void
      {
         Tween.curTo(this["card_" + i],500,{
            "y":550 - this["card_" + i].height + 100,
            "alpha":0
         },function():void
         {
            inMovieArray[i] = 0;
            if(!cardIsMoving())
            {
               dropCard();
            }
         });
      }
      
      private function dropCard() : void
      {
         var i:int = 0;
         while(i < 5)
         {
            if(View_Jianghulixian_card(this["card_" + i]).status == 0)
            {
               this.inMovieArray[i] = 1;
               this.Tween4(i);
            }
            i++;
         }
      }
      
      private function Tween4(i:int) : void
      {
         Tween.to(this["card_" + i],500,{
            "y":[0,this.cardPositionArray[i].y],
            "alpha":[0,1]
         },function():void
         {
            inMovieArray[i] = 0;
            if(!cardIsMoving())
            {
               dropCarded();
            }
         });
      }
      
      private function dropCarded() : void
      {
         var i:int;
         Tween.curTo(this.topTxt,500,{
            "y":68,
            "alpha":1
         });
         i = 0;
         while(i < 5)
         {
            if(View_Jianghulixian_card(this["card_" + i]).status == 0)
            {
               View_Jianghulixian_card(this["card_" + i]).OpenCard();
            }
            i++;
         }
         this.setTopAndCardType(Model_Jianghulixian.cardTypeArr);
         setTimeout(function():void
         {
            setAllCardEnabled(true);
         },300);
         if(Model_Jianghulixian.cardTypeArr[0] == "1")
         {
            JianghulixianCGMessage.CG_Jianghulixian_GET_RESULT(2);
         }
      }
      
      private function setAllCardEnabled(_bool:Boolean) : void
      {
         var i:int = 0;
         while(i < 5)
         {
            View_Jianghulixian_card(this["card_" + i]).buttonMode = _bool;
            View_Jianghulixian_card(this["card_" + i]).mouseEnabled = _bool;
            i++;
         }
      }
      
      private function onClickUpgradeTitle(e:* = null) : void
      {
         var pan:View_rolePan = Singleton.getInstance(View_rolePan);
         if(pan.visible)
         {
            pan.visible = false;
         }
         else
         {
            UIManager.rolePanel.openView(Enum_panel_role.EQUIP);
            this.updateYueli();
         }
      }
      
      private function closeMenu(e:* = null) : void
      {
         if(inGame)
         {
            View_Alert.show("游戏未结束，确定退出？",2,function():void
            {
               JianghulixianCGMessage.CG_Jianghulixian_GET_RESULT(2);
               inGame = false;
            });
         }
         else
         {
            this.visible = false;
         }
      }
      
      private function get getPrizeBtnStatus() : int
      {
         return this._getPrizeBtnStatus;
      }
      
      private function set getPrizeBtnStatus(value:int) : void
      {
         this._getPrizeBtnStatus = value;
         switch(this._getPrizeBtnStatus)
         {
            case -1:
               this.getPrizeBtn.label = "<font color=\'#ccd672\' size=\'16\'><b>再翻一次</b></font>";
               this.costTxt.visible = false;
               break;
            case 0:
               this.getPrizeBtn.label = "<font color=\'#ccd672\' size=\'16\'><b>不换牌</b></font><br/>" + "<font color=\'#aed6b6\' size=\'12\'>领取当前奖励</font>";
               this.costTxt.visible = false;
               break;
            default:
               this.getPrizeBtn.label = LangConfig.reTxt("<font color=\'#ccd672\' size=\'16\'><b>换{0}张</b></font>",this._getPrizeBtnStatus);
               this.costTxt.visible = true;
         }
      }
      
      private function checkChangeCard(e:* = null) : void
      {
         this.changeCardArr = [];
         var i:int = 0;
         while(i < 5)
         {
            if(this["card_" + i].status == 0)
            {
               this.changeCardArr.push(i);
            }
            i++;
         }
         this.getPrizeBtnStatus = this.changeCardArr.length;
      }
      
      private function get currentOpenTime() : int
      {
         return this._currentOpenTime;
      }
      
      private function set currentOpenTime(value:int) : void
      {
         this._currentOpenTime = value;
         if(value < 3)
         {
            this.costTxt.text = "本次换牌免费";
         }
         else
         {
            this.costTxt.text = LangConfig.reTxt("本次换牌需要{0}元宝",Data_lib.huanpai[this._currentOpenTime - 2][0]);
         }
      }
   }
}

