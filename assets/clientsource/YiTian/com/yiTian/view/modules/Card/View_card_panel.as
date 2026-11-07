package com.yiTian.view.modules.Card
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.TabButton;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class View_card_panel extends Panel123
   {
      
      private static var _instance:View_card_panel;
      
      private var _icon:MainUIBtn;
      
      private var _tabBtnArr:Array = [];
      
      private var panelArr:Array = [];
      
      private var getCardBtn:Button;
      
      private var YuanBaoTxt:MyTextField;
      
      private var JingYanTxt:MyTextField;
      
      private var SuiPianTxt:MyTextField;
      
      private var JingYanTipsSpr:Sprite;
      
      private var SuiPianTipsSpr:Sprite;
      
      private var expEff:Sprite;
      
      public function View_card_panel()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/KaPai.swf","KaPaidm");
      }
      
      public static function get instance() : View_card_panel
      {
         if(!_instance)
         {
            _instance = new View_card_panel();
         }
         return _instance;
      }
      
      public function showIcon() : void
      {
         if(GameUnitManager.hero.level < 45)
         {
            Model_card.firstPlay = true;
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,this.showIcon2);
         }
      }
      
      public function showIcon2() : void
      {
         if(GameUnitManager.hero.level < 45)
         {
            return;
         }
         if(Global.control.hasCallBack(Enum_MsgType.MSG_LV_UP_2,this.showIcon2))
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,this.showIcon2);
         }
         if(!this.icon)
         {
            this._icon = new MainUIBtn("resource/image/card/icon.png");
            this.icon.addEventListener(MouseEvent.CLICK,this.onClickIcon);
            this.icon.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
            this.icon.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         }
         if(Model_card.firstPlay)
         {
            Model_card.firstPlay = false;
            GameScene.uiLayer.addChild(this.icon);
            this.icon.x = Global.stage.stageWidth / 2;
            this.icon.y = 200;
            if(Boolean(this.icon.bmp.bitmapData))
            {
               this.onIconMove();
            }
            else
            {
               this.icon.bmp.complete = this.onIconMove;
            }
         }
         else
         {
            this.icon.y = -20;
            UIManager.special_btn.appendItem(this.icon,2);
         }
      }
      
      private function onIconMove(... arg) : void
      {
         var p:Point = UIManager.special_btn.getPos(0);
         Tween.curTo(this.icon,1500,{
            "x":p.x,
            "y":p.y
         },this.onIconMoveCom);
      }
      
      private function onIconMoveCom() : void
      {
         this.icon.x = 0;
         this.icon.y = -20;
         UIManager.special_btn.appendItem(this.icon,2);
      }
      
      private function onClickIcon(e:MouseEvent) : void
      {
         if(Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
         {
            UIManager.bagPwdPutIn.visible = true;
            return;
         }
         Global.delegate.dosomething(View_card_panel.instance,function():void
         {
            visible = !visible;
         });
      }
      
      override protected function initStaticView() : void
      {
         var i:* = undefined;
         move = new Rectangle(0,0,766,30);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":766,
            "height":560
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":25,
            "y":40,
            "width":716,
            "height":510
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_KPDS",this,{
            "x":303,
            "y":5
         },Global.KaPaidm);
         ComponentUtil.getBitmap("Icon_YuanBao",this,{
            "x":387,
            "y":50
         },Global.KaPaidm);
         this.JingYanTipsSpr = new Sprite();
         addChild(this.JingYanTipsSpr);
         this.JingYanTipsSpr.x = 472;
         this.JingYanTipsSpr.y = 43;
         ComponentUtil.getBitmap("Icon_CPSP",this.JingYanTipsSpr,null,Global.KaPaidm);
         TipManager.bind(this.JingYanTipsSpr,HtmlUtil.fontNoSize("卡牌经验",ColorConstant.getColorStr(ColorConstant.GREEN)) + "<br/>" + HtmlUtil.fontNoSize("来源",ColorConstant.getColorStr(ColorConstant.GREEN)) + "：占卜卡牌、分解卡牌获得<br/>" + HtmlUtil.fontNoSize("用途",ColorConstant.getColorStr(ColorConstant.GREEN)) + "：卡牌升级吞噬的材料");
         this.SuiPianTipsSpr = new Sprite();
         addChild(this.SuiPianTipsSpr);
         this.SuiPianTipsSpr.x = 564;
         this.SuiPianTipsSpr.y = 44;
         ComponentUtil.getBitmap("Icon_KPCP",this.SuiPianTipsSpr,null,Global.KaPaidm);
         TipManager.bind(this.SuiPianTipsSpr,HtmlUtil.fontNoSize("卡牌残页",ColorConstant.getColorStr(ColorConstant.GREEN)) + "<br/>" + HtmlUtil.fontNoSize("来源",ColorConstant.getColorStr(ColorConstant.GREEN)) + "：占卜卡牌获得<br/>" + HtmlUtil.fontNoSize("用途",ColorConstant.getColorStr(ColorConstant.GREEN)) + "：兑换橙色卡牌的材料");
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":407,
            "y":47,
            "width":59,
            "height":19
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":498,
            "y":47,
            "width":59,
            "height":19
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":589,
            "y":47,
            "width":59,
            "height":19
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":731,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         this.tabBtnArr.push(ComponentUtil.getTabButton("卡牌占卜","TabButton_Four",this,{
            "x":39,
            "y":48,
            "textColor":16772813,
            "chooseColor":16771436
         },Global.Img_Cdm));
         this.tabBtnArr.push(ComponentUtil.getTabButton("卡牌附身","TabButton_Four",this,{
            "x":116,
            "y":48,
            "textColor":16772813,
            "chooseColor":16771436
         },Global.Img_Cdm));
         this.tabBtnArr.push(ComponentUtil.getTabButton("卡牌吞噬","TabButton_Four",this,{
            "x":193,
            "y":48,
            "textColor":16772813,
            "chooseColor":16771436
         },Global.Img_Cdm));
         this.tabBtnArr.push(ComponentUtil.getTabButton("卡牌升星","TabButton_Four",this,{
            "x":270,
            "y":48,
            "textColor":16772813,
            "chooseColor":16771436
         },Global.Img_Cdm));
         this.panelArr.push(new View_ZhanBu_panel());
         this.panelArr.push(new View_FuShen_panel());
         this.panelArr.push(new View_TunShi_panel());
         this.panelArr.push(new View_ShengXing_panel());
         for(i in this.tabBtnArr)
         {
            addChild(this.panelArr[i]);
            (this.tabBtnArr[i] as TabButton).binding = this.panelArr[i];
            this.tabBtnArr[i].addEventListener(MouseEvent.CLICK,this.onClickTabBtn);
            if(i == 0)
            {
               this.tabBtnArr[i].choose = true;
            }
            else
            {
               this.tabBtnArr[i].choose = false;
            }
         }
         this.getCardBtn = ComponentUtil.getButton("卡牌兑换","Button_Orange",this,{
            "x":659,
            "y":44,
            "textColor":16771436
         },Global.Img_Cdm);
         this.getCardBtn.callBack = function():void
         {
            View_cardShop_panel.instance.visible = true;
         };
         this.YuanBaoTxt = ComponentUtil.getTextField(GameUnitManager.hero.money.toString(),this,{
            "x":436,
            "y":47,
            "color":16383744,
            "size":12,
            "leading":0
         },"center");
         this.JingYanTxt = ComponentUtil.getTextField("-1",this,{
            "x":527,
            "y":47,
            "color":16383744,
            "size":12,
            "leading":0
         },"center");
         this.SuiPianTxt = ComponentUtil.getTextField("-1",this,{
            "x":617,
            "y":47,
            "color":16383744,
            "size":12,
            "leading":0
         },"center");
         Model_card.dragCard = new View_card_small();
         Model_card.dragCard.alpha = 0.5;
         Model_card.dragCard.mouseEnabled = false;
         Model_card.dragCard.mouseChildren = false;
         Global.control.registerCallBack(Enum_MsgType.ROLE_PAN_UPDATE,this.updateMoney);
         Global.control.registerCallBack(CardEvent.EXP,this.updateExp);
         Global.control.registerCallBack(CardEvent.PIECE,this.updatePiece);
         Global.control.registerCallBack(CardEvent.START_DRAG,this.onStartDrag);
         Global.control.registerCallBack(CardEvent.EXP_EFFECT,this.expEffect);
      }
      
      private function updateExp() : void
      {
         this.JingYanTxt.text = String(Model_card.exp);
      }
      
      private function updatePiece() : void
      {
         this.SuiPianTxt.text = String(Model_card.piece);
      }
      
      private function onStartDrag(vo:Vo_card) : void
      {
         Model_card.dragCard.vo = vo;
         Model_card.dragCard.x = mouseX - 65;
         Model_card.dragCard.y = mouseY - 65;
         addChild(Model_card.dragCard);
         addEventListener(MouseEvent.MOUSE_MOVE,this.onDragMouseMove);
         addEventListener(MouseEvent.MOUSE_UP,this.onDragMouseUp);
      }
      
      private function onDragMouseMove(e:MouseEvent) : void
      {
         Model_card.dragCard.x = mouseX - 65;
         Model_card.dragCard.y = mouseY - 65;
      }
      
      private function onDragMouseUp(e:MouseEvent) : void
      {
         removeChild(Model_card.dragCard);
         removeEventListener(MouseEvent.MOUSE_MOVE,this.onDragMouseMove);
         removeEventListener(MouseEvent.MOUSE_UP,this.onDragMouseUp);
      }
      
      override public function set visible(value:Boolean) : void
      {
         var i:* = undefined;
         super.visible = value;
         if(value)
         {
            this.updateMoney();
            this.updateExp();
            this.updatePiece();
            for(i in this.tabBtnArr)
            {
               if(i == 0)
               {
                  this.tabBtnArr[i].choose = true;
               }
               else
               {
                  this.tabBtnArr[i].choose = false;
               }
            }
         }
         else
         {
            View_cardBag_panel.instance.visible = false;
         }
      }
      
      private function onClickTabBtn(e:MouseEvent) : void
      {
         var i:* = undefined;
         if(Model_card.isPlaying)
         {
            UIManager.centerBroadcast.addMsg("动画播放中，请稍等片刻");
            return;
         }
         for(i in this.tabBtnArr)
         {
            if(this.tabBtnArr[i] == e.currentTarget)
            {
               this.tabBtnArr[i].choose = true;
            }
            else
            {
               this.tabBtnArr[i].choose = false;
            }
         }
      }
      
      private function onRollOver(e:MouseEvent) : void
      {
         this.icon.filters = Util.glowBigFFff00;
      }
      
      private function onRollOut(e:MouseEvent) : void
      {
         this.icon.filters = null;
      }
      
      private function updateMoney() : void
      {
         this.YuanBaoTxt.text = GameUnitManager.hero.money.toString();
      }
      
      public function get tabBtnArr() : Array
      {
         return this._tabBtnArr;
      }
      
      private function expEffect(type:int) : void
      {
         var tarX:int = 0;
         if(!this.expEff)
         {
            this.expEff = new Sprite();
            addChild(this.expEff);
            EffectManager.addEffect("35040",this.expEff,1000,0,60,true);
         }
         this.expEff.visible = true;
         if(type == 1)
         {
            tarX = 576;
         }
         else
         {
            tarX = 486;
         }
         Tween.to(this.expEff,1000,{
            "x":[380,tarX],
            "y":[186,56]
         },function():void
         {
            expEff.visible = false;
         });
      }
      
      public function get icon() : MainUIBtn
      {
         return this._icon;
      }
   }
}

