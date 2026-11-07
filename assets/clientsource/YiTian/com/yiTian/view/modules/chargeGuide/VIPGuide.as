package com.yiTian.view.modules.chargeGuide
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.utils.Util;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ChargeGuideCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import com.yiTian.view.modules.newerGuide.thirdNewerGuide.BtnSpr;
   import com.yiTian.view.modules.newerGuide.thirdNewerGuide.thirdNewerContainer;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class VIPGuide
   {
      
      public static var baseView:BtnSpr;
      
      public static var isMove:Boolean = false;
      
      public static var _numChildArr:Array = [];
      
      public var rect:Boolean;
      
      private var vipUI:MainUIBtn;
      
      private var content:MyTextField;
      
      private var canGet:Boolean;
      
      private var got:Boolean;
      
      private var _sp:Sprite = new Sprite();
      
      private var timer:Timer;
      
      private var timeNum:int;
      
      private var _last:int;
      
      private var btnEff:Effect;
      
      public function VIPGuide()
      {
         super();
      }
      
      public static function resize() : void
      {
         var stx1:int = 0;
         var stx2:int = 0;
         if(_numChildArr.length > 1)
         {
            stx1 = _numChildArr[0].x - 64 / 2 + 2;
            stx2 = _numChildArr[1].x + 64 / 2 + 2;
            Tween.to(_numChildArr[0],300,{"x":[_numChildArr[0].x,stx1]});
            Tween.to(_numChildArr[1],300,{"x":[_numChildArr[1].x,stx2]});
         }
      }
      
      private function init() : void
      {
         baseView = new BtnSpr();
         this.vipUI = new MainUIBtn("resource/image/extralPng/tyvip.png");
         baseView.addChild(this.vipUI);
         this.content = ComponentUtil.getTextField("",baseView,{"y":this.vipUI.y + this.vipUI.height + 10});
         this.content.x = -2;
         TipManager.bind(this.vipUI,LangConfig.getWord("60106",6));
         thirdNewerContainer.instance.addBtn(baseView,1);
         this.vipUI.addEventListener(MouseEvent.CLICK,this.onClick);
         this.vipUI.addEventListener(MouseEvent.MOUSE_OVER,this.overHd);
         this.vipUI.addEventListener(MouseEvent.MOUSE_OUT,this.outHd);
      }
      
      private function overHd(e:MouseEvent) : void
      {
         (e.target as DisplayObject).transform.colorTransform = Util.colorWhite2;
      }
      
      private function outHd(e:MouseEvent) : void
      {
         (e.target as DisplayObject).transform.colorTransform = Util.colorNomal;
      }
      
      public function show() : void
      {
         if(!baseView)
         {
            this.init();
         }
         this.content.htmlText = HtmlUtil.bold(HtmlUtil.font(LangConfig.getWord("60107",6),"#FFFF00",12));
         this.content.x = -2;
      }
      
      private function onClick(event:MouseEvent) : void
      {
         if(this.got)
         {
            UIManager.vipPanel.visible = !UIManager.vipPanel.visible;
            return;
         }
         if(isMove)
         {
            return;
         }
         if(GameUnitManager.hero.level < 20)
         {
            View_Alert.show(LangConfig.getWord("60101",6),1);
            return;
         }
         ChargeGuideCGMessage.CG_GET_TEMP_VIP();
      }
      
      public function backMove() : void
      {
         if(Boolean(_numChildArr.length))
         {
            _numChildArr.shift();
         }
         View_newContainer.isAutoMove = true;
         UIManager.newContainer.addBTN(this._sp);
         this.show_btn(false);
         thirdNewerContainer.instance.moveBtn(baseView,1,1000,thirdNewerContainer.INSIDE_MOVE);
      }
      
      public function move() : void
      {
         if(!baseView)
         {
            this.init();
         }
         this.content.htmlText = "";
         thirdNewerContainer.instance.moveBtn(baseView,2,1500,thirdNewerContainer.INSIDE_MOVE);
         this.content.htmlText = "  " + HtmlUtil.bold(HtmlUtil.font(LangConfig.getWord("60102",6),"#FFFF00",12));
         this.content.x = -10;
         this.show_btn(true);
      }
      
      public function setTime(time:Number) : void
      {
         this.got = true;
         if(!baseView)
         {
            this.init();
         }
         this.timeNum = time;
         this.content.x = -2;
         this.content.htmlText = "  " + HtmlUtil.bold(HtmlUtil.font(DateUtil.getMSBySecond3(this.timeNum),"#FFFF00",12));
         GameScene.instance.addFrameCallBack(this.timeFun);
      }
      
      private function timeFun(interenal:int) : void
      {
         var colorStr:String = null;
         var now:int = getTimer();
         if(now - this._last >= 1000)
         {
            --this.timeNum;
            if(this.timeNum <= 60)
            {
               colorStr = "#fe0000";
            }
            else
            {
               colorStr = "#04ff00";
            }
            this.content.htmlText = "  " + HtmlUtil.bold(HtmlUtil.font(DateUtil.getMSBySecond3(this.timeNum),colorStr,12));
            if(this.timeNum == 0)
            {
               this.stop();
            }
            this._last = now;
         }
      }
      
      public function removeIcon() : void
      {
         if(Boolean(baseView))
         {
            thirdNewerContainer.instance.removeBtn(baseView,baseView.status);
         }
         baseView = null;
      }
      
      public function stop() : void
      {
         GameScene.instance.removeFrameCallBack(this.timeFun);
         ChargeGuideCGMessage.CG_STOP_USE();
      }
      
      public function show_btn(hasEff:Boolean) : void
      {
         if(hasEff)
         {
            if(!this.btnEff)
            {
               this.btnEff = EffectManager.addEffect("35343",baseView,1000,32,29,true);
            }
         }
         else
         {
            if(!this.btnEff)
            {
               return;
            }
            EffectManager.removeEffect(this.btnEff);
            this.btnEff = null;
         }
      }
   }
}

