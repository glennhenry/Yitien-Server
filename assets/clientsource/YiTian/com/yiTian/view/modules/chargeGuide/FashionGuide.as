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
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import com.yiTian.view.modules.newerGuide.thirdNewerGuide.BtnSpr;
   import com.yiTian.view.modules.newerGuide.thirdNewerGuide.thirdNewerContainer;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class FashionGuide
   {
      
      public static var isMove:Boolean = false;
      
      private var fashionUI:MainUIBtn;
      
      private var content:MyTextField;
      
      public var baseView:BtnSpr;
      
      private var canGet:Boolean;
      
      private var got:Boolean;
      
      private var sp:Sprite = new Sprite();
      
      public var stx:int;
      
      public var sty:int;
      
      private var timer:Timer;
      
      private var timeNum:int;
      
      private var _last:int;
      
      private var btnEff:Effect;
      
      public function FashionGuide()
      {
         super();
      }
      
      private function init() : void
      {
         this.baseView = new BtnSpr();
         this.fashionUI = new MainUIBtn("resource/image/extralPng/tysz.png");
         this.baseView.addChild(this.fashionUI);
         this.content = ComponentUtil.getTextField("",this.baseView,{"y":this.fashionUI.y + this.fashionUI.height + 10});
         this.content.x = -2;
         TipManager.bind(this.fashionUI,LangConfig.getWord("60099",6));
         thirdNewerContainer.instance.addBtn(this.baseView,1);
         this.fashionUI.addEventListener(MouseEvent.CLICK,this.onClick);
         this.fashionUI.addEventListener(MouseEvent.MOUSE_OVER,this.overHd);
         this.fashionUI.addEventListener(MouseEvent.MOUSE_OUT,this.outHd);
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
         if(!this.baseView)
         {
            this.init();
         }
         this.content.x = -2;
         this.content.htmlText = HtmlUtil.bold(HtmlUtil.font(LangConfig.getWord("60100",6),"#FFFF00",12));
      }
      
      private function onClick(event:MouseEvent) : void
      {
         var pan:View_Fashions = null;
         if(this.got)
         {
            pan = Singleton.getInstance(View_Fashions) as View_Fashions;
            pan.visible = !pan.visible;
            return;
         }
         if(isMove)
         {
            return;
         }
         if(GameUnitManager.hero.level < 10)
         {
            View_Alert.show(LangConfig.getWord("60101",6),1);
            return;
         }
         ChargeGuideCGMessage.CG_GET_TEMP_FASHION();
      }
      
      public function backMove() : void
      {
         if(Boolean(VIPGuide._numChildArr.length))
         {
            VIPGuide._numChildArr.shift();
         }
         View_newContainer.isAutoMove = true;
         UIManager.newContainer.addBTN(this.sp);
         this.show_btn(false);
         thirdNewerContainer.instance.moveBtn(this.baseView,1,1000,thirdNewerContainer.INSIDE_MOVE);
      }
      
      public function move() : void
      {
         if(!this.baseView)
         {
            this.init();
         }
         this.content.htmlText = "";
         thirdNewerContainer.instance.moveBtn(this.baseView,2,2000,thirdNewerContainer.INSIDE_MOVE);
         this.content.htmlText = "  " + HtmlUtil.bold(HtmlUtil.font(LangConfig.getWord("60102",6),"#FFFF00",12));
         this.content.x = -10;
         this.show_btn(true);
      }
      
      public function setTime(time:Number) : void
      {
         this.got = true;
         if(!this.baseView)
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
      
      public function stop() : void
      {
         GameScene.instance.removeFrameCallBack(this.timeFun);
         this.removeIcon();
      }
      
      public function removeIcon() : void
      {
         if(Boolean(this.baseView))
         {
            thirdNewerContainer.instance.removeBtn(this.baseView,this.baseView.status);
         }
      }
      
      public function show_btn(hasEff:Boolean) : void
      {
         hasEff = false;
         if(hasEff)
         {
            if(!this.btnEff)
            {
               this.btnEff = EffectManager.addEffect("35343",this.baseView,1000,32,29,true);
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

