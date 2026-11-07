package com.yiTian.view.modules.battle
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_QiJu;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.KeyboardManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.GuangMingDingCGMessage;
   import com.yiTian.net.message.cg.BattleCGMessage;
   import com.yiTian.net.message.cg.QiJuCGMessage;
   import com.yiTian.net.message.cg.WanAnSiCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.auto.HandupMgr;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.guangMingDing.Model_guangMingDing;
   import com.yiTian.view.modules.wanansi.WanAnSiVO;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   import flash.utils.getTimer;
   
   public class SiWangFuHuoPanel extends Panel
   {
      
      public static const HIDE:int = 0;
      
      public static const PATA:int = 1;
      
      public static const WANANSI:int = 2;
      
      public static const QIJU:int = 3;
      
      public static const GMD:int = 4;
      
      private var yuanDi:Button;
      
      private var huiCheng:Button;
      
      private var isLock:Boolean;
      
      private var lastTime:int;
      
      private var totalTime:int;
      
      private var DaoJiShi_text:MyTextField;
      
      private var bg:Sprite;
      
      private var tip:Sprite;
      
      private var _lastClickTime:int = -2000;
      
      private var _type:int;
      
      private var isFirstOpen:Boolean = true;
      
      public function SiWangFuHuoPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         bAutoRemove = false;
         this.bg = new Sprite();
         this.bg.graphics.beginFill(0,0.5);
         this.bg.graphics.drawRect(0,0,Global.stage.stageWidth,Global.stage.stageHeight);
         this.bg.graphics.endFill();
         addChild(this.bg);
         this.tip = new Sprite();
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.tip,{
            "x":0,
            "y":0,
            "width":348,
            "height":184
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.tip,{
            "x":24,
            "y":40,
            "width":300,
            "height":134
         },Global.Img_Cdm);
         this.yuanDi = ComponentUtil.getButton(LangConfig.getWord("10599",1),"Button_Four",this.tip,{
            "x":77,
            "y":133,
            "textColor":16184781
         },Global.Img_Cdm);
         this.yuanDi.textColor = 16383744;
         this.yuanDi.textOverColor = 16383744;
         this.huiCheng = ComponentUtil.getButton(LangConfig.getWord("10600",1),"Button_Four",this.tip,{
            "x":198,
            "y":133,
            "textColor":16184781
         },Global.Img_Cdm);
         this.huiCheng.textColor = 13434624;
         this.huiCheng.textOverColor = 13434624;
         this.DaoJiShi_text = ComponentUtil.getTextField("",this.tip,{
            "x":51,
            "y":65,
            "size":14
         });
         this.DaoJiShi_text.realWidth = 218;
         this.DaoJiShi_text.align = TextFormatAlign.CENTER;
         this.DaoJiShi_text.multiline = true;
         addChild(this.tip);
         this.yuanDi.addEventListener(MouseEvent.CLICK,this.yuanDiHandler);
         this.huiCheng.addEventListener(MouseEvent.CLICK,this.huiChengHandler);
         this.yuanDi.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         this.huiCheng.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         this.yuanDi.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         this.huiCheng.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         addEventListener(MouseEvent.MOUSE_DOWN,this.down,false,1);
         bindParent = GameScene.modalLayer;
      }
      
      protected function down(e:MouseEvent) : void
      {
         e.stopImmediatePropagation();
      }
      
      protected function huiChengHandler(e:MouseEvent) : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         if(this._type == PATA)
         {
            BattleCGMessage.CG_SIWANG_FUHUO(2);
         }
         else if(this._type == WANANSI)
         {
            WanAnSiCGMessage.CG_WANANSI_FUHUO(2);
         }
         else if(this._type == QIJU)
         {
            QiJuCGMessage.CG_QIJU_FUHUO(2);
         }
         else if(this._type == GMD)
         {
            GuangMingDingCGMessage.CG_GMD_REVIVE(2);
         }
      }
      
      protected function yuanDiHandler(e:MouseEvent) : void
      {
         var now:int = getTimer();
         if(now - this._lastClickTime < 2000)
         {
            UIManager.centerBroadcast.addMsg("您的操作太频繁，请稍等片刻");
            return;
         }
         this._lastClickTime = now;
         if(GameUnitManager.hero.money >= 20)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
            if(this._type == PATA)
            {
               BattleCGMessage.CG_SIWANG_FUHUO(1);
            }
            else if(this._type == WANANSI)
            {
               WanAnSiCGMessage.CG_WANANSI_FUHUO(1);
            }
            else if(this._type == QIJU)
            {
               QiJuCGMessage.CG_QIJU_FUHUO(1);
            }
            else if(this._type == GMD && Boolean(Model_guangMingDing.reviveTimes))
            {
               GuangMingDingCGMessage.CG_GMD_REVIVE(1);
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10601",1) + "</font>");
         }
      }
      
      protected function onRollOut(e:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      protected function onRollOver(e:MouseEvent) : void
      {
         if(e.target.label.substring(0,2) == LangConfig.getWord("10599",1))
         {
            TipManager.bind(this.yuanDi,LangConfig.getWord("10602",1));
         }
         else if(e.target.label.substring(0,2) == LangConfig.getWord("10600",1))
         {
            TipManager.bind(this.huiCheng,LangConfig.getWord("10603",1));
         }
      }
      
      private function countDown() : void
      {
         this.addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         this.totalTime = 120;
         this.lastTime = getTimer();
         this.huiCheng.label = LangConfig.getWord("10600",1);
         this.huiCheng.mouseEnabled = false;
         this.huiCheng.filters = Util.disabled;
      }
      
      public function show(value:int) : void
      {
         var s:String = null;
         this._type = value;
         this.yuanDi.mouseEnabled = true;
         this.yuanDi.filters = [];
         if(value == PATA)
         {
            this.DaoJiShi_text.htmlText = LangConfig.getWord("10646",1);
            this.visible = true;
            this.countDown();
         }
         else if(value == WANANSI)
         {
            if(WanAnSiVO.fuHuoCiShu == 0)
            {
               this.yuanDi.mouseEnabled = false;
               this.yuanDi.filters = Util.disabled;
            }
            s = LangConfig.getWord("10646",1) + LangConfig.getWord("10646",1,WanAnSiVO.fuHuoCiShu);
            this.DaoJiShi_text.htmlText = LangConfig.getWord("10646",1) + LangConfig.getWord("10647",1,WanAnSiVO.fuHuoCiShu);
            this.visible = true;
            this.countDown();
         }
         else if(value == QIJU)
         {
            if(Model_QiJu.leftTime == 0)
            {
               this.yuanDi.mouseEnabled = false;
               this.yuanDi.filters = Util.disabled;
            }
            s = LangConfig.getWord("10646",1) + LangConfig.getWord("10646",1,Model_QiJu.leftTime);
            this.DaoJiShi_text.htmlText = LangConfig.getWord("10646",1) + LangConfig.getWord("10647",1,Model_QiJu.leftTime);
            if(!this.visible)
            {
               this.visible = true;
            }
            this.countDown();
         }
         else if(value == GMD)
         {
            if(Model_guangMingDing.reviveTimes == 0)
            {
               this.yuanDi.mouseEnabled = false;
               this.yuanDi.filters = Util.disabled;
            }
            s = LangConfig.getWord("10646",1) + LangConfig.getWord("10646",1,Model_guangMingDing.reviveTimes);
            this.DaoJiShi_text.htmlText = LangConfig.getWord("10646",1) + LangConfig.getWord("10647",1,Model_guangMingDing.reviveTimes);
            this.visible = visible || true;
            this.countDown();
         }
         else if(value == HIDE)
         {
            this.visible = false;
            Model_guangMingDing.needShowDeadPnlAfterBattle = false;
         }
         if(value != 0)
         {
            HandupMgr.turnoff();
         }
      }
      
      protected function enterFrameHandler(event:Event) : void
      {
         var t:int = 0;
         var now:int = getTimer();
         t = this.totalTime - Math.ceil((now - this.lastTime) / 1000);
         if(t <= 0)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
            this.huiCheng.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         if(t < 110)
         {
            this.huiCheng.mouseEnabled = true;
            this.huiCheng.filters = [];
            this.huiCheng.label = LangConfig.getWord("10600",1) + String(t);
         }
         else if(this._type == WANANSI && WanAnSiVO.fuHuoCiShu == 0)
         {
            this.huiCheng.mouseEnabled = true;
            this.huiCheng.filters = [];
            this.huiCheng.label = LangConfig.getWord("10600",1) + String(t);
         }
         else
         {
            this.huiCheng.label = LangConfig.getWord("10600",1) + (10 - (120 - t));
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.isFirstOpen)
            {
               this.isFirstOpen = false;
               Utils.loadTitle("lang/ch/WanAnSi_Imgs.swf","fuhuo",new Bitmap(),{
                  "x":94,
                  "y":5
               },this.tip);
            }
            GameScene.uiLayer.addChild(UIManager.chatPanel);
            KeyboardManager.setRestrain("deadPanel",true);
            stopDrag();
            Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,this.resetPosition);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.STAGE_RESIZE,this.resetPosition);
            KeyboardManager.setRestrain("deadPanel",false);
         }
         if(!value && this.hasEventListener(Event.ENTER_FRAME))
         {
            this.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         }
      }
      
      override public function resetPosition() : void
      {
         this.bg.width = Global.stage.stageWidth;
         this.bg.height = Global.stage.stageHeight;
         this.tip.x = (Global.stage.stageWidth - this.tip.width) / 2;
         this.tip.y = (Global.stage.stageHeight - this.tip.height) / 2;
      }
   }
}

