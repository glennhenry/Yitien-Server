package com.yiTian.view.modules.tianmingjj
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_TianmingJJ;
   import com.yiTian.data.model.Model_TianmingJJ;
   import com.yiTian.data.vo.Vo_DynamicTip;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.net.message.cg.TianmingJJCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.tianMing.View_TianMing;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   
   public class View_TianmingJJ extends Panel123
   {
      
      private static const MAX:int = 6;
      
      private var isEffect:Boolean;
      
      private var _targetY:int;
      
      private var isFirst:Boolean;
      
      private var tms:MyTextField;
      
      public var tmd:MyTextField;
      
      private var jinjieBtn:Button;
      
      private var tipBtn:Button;
      
      private var helpContiner:Sprite;
      
      private var resultPan:Child_TMJJ_Result;
      
      public var cc:Child_TMSZContiner;
      
      private var tipsLayer:Sprite;
      
      private var tipWin:Sprite;
      
      private var myTextFiled_4:MyTextField;
      
      private var shape:Sprite;
      
      private var numSpr:Sprite;
      
      private var numberRunTimer:Timer;
      
      private var currentTM_plus:MyTextField;
      
      private var isDo:Boolean;
      
      private var currentTMD:int;
      
      private var add:int;
      
      public function View_TianmingJJ()
      {
         super();
         regResource("lang/ch/TianMing.swf","TianMingdm");
      }
      
      public static function get instance() : View_TianmingJJ
      {
         return Singleton.getInstance(View_TianmingJJ);
      }
      
      override protected function initUI2() : void
      {
         var vo:Vo_DynamicTip;
         var ss:Shape;
         var s:Shape;
         var tt:MyTextField;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":788,
            "height":496
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":738,
            "height":446
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":52,
            "width":714,
            "height":422
         },Global.TianMingdm);
         ComponentUtil.getBitmap("Back_TMTZ",this,{
            "x":44,
            "y":59
         },Global.TianMingdm);
         ComponentUtil.getBitmap("Title_TMTZ",this,{
            "x":314,
            "y":5
         },Global.TianMingdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":753,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         ComponentUtil.getTextField("当前天命石：",this,{
            "x":68,
            "y":81,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.tms = ComponentUtil.getTextField("8",this,{
            "x":141,
            "y":79,
            "color":16383744,
            "size":15,
            "leading":0,
            "bold":true
         });
         ComponentUtil.getTextField("当前天命点：",this,{
            "x":68,
            "y":103,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.tmd = ComponentUtil.getTextField("1234567890",this,{
            "x":141,
            "y":101,
            "color":327424,
            "size":15,
            "leading":0,
            "bold":true
         });
         this.myTextFiled_4 = ComponentUtil.getTextField("奖励规则",this,{
            "x":69,
            "y":133,
            "color":16383744,
            "size":12,
            "leading":0
         });
         this.myTextFiled_4.mouseEnabled = true;
         ComponentUtil.getTextField("投掷骰子获得天命点，改运增加获得天命点",this,{
            "x":266,
            "y":431,
            "color":16777215,
            "size":14,
            "leading":0
         });
         this.jinjieBtn = ComponentUtil.getButton("","Button_TMJJ",this,{
            "x":70,
            "y":385,
            "textColor":16771436
         },Global.TianMingdm);
         this.jinjieBtn.callBack = function():void
         {
            View_TianMing.instance.visible = true;
         };
         vo = new Vo_DynamicTip();
         vo._w = 310;
         vo.info = Enum_TianmingJJ.getTip;
         TipManager.bind(this.myTextFiled_4,vo);
         this.cc = new Child_TMSZContiner();
         ComponentUtil.setPropertie(this.cc,{
            "x":120,
            "y":60
         });
         this.addChild(this.cc);
         this.shape = new Sprite();
         this.addChild(this.shape);
         ss = new Shape();
         ss.graphics.beginFill(0,0.1);
         ss.graphics.drawRect(0,0,this.width,this.height);
         ss.graphics.endFill();
         this.shape.addChild(ss);
         this.shape.visible = false;
         this.resultPan = new Child_TMJJ_Result();
         this.resultPan.visible = false;
         ComponentUtil.setPropertie(this.resultPan,{
            "x":200,
            "y":140
         });
         this.addChild(this.resultPan);
         CloseButton.callBack = function():void
         {
            visible = false;
         };
         move = new Rectangle(0,0,750,36);
         this.tipsLayer = new Sprite();
         this.addChild(this.tipsLayer);
         this.tipBtn = ComponentUtil.getButton("","Button_DJSZ",this.tipsLayer,{
            "x":348,
            "y":110,
            "textColor":16771436
         },Global.TianMingdm);
         this.tweenTip();
         this.helpContiner = new Sprite();
         s = new Shape();
         s.graphics.beginFill(0,0.1);
         s.graphics.drawRect(0,0,this.width,this.height);
         s.graphics.endFill();
         this.helpContiner.addChild(s);
         this.addChild(this.helpContiner);
         this.tipWin = new Sprite();
         ComponentUtil.getScaleBitmap("Back_Floating",[8,9,4,2],this.tipWin,{
            "x":242,
            "y":180,
            "width":310,
            "height":150
         },Global.Img_Cdm);
         tt = ComponentUtil.getTextField("",this.tipWin,{
            "x":248,
            "y":206 - 20,
            "align":"left",
            "leading":3,
            "wordWrap":true,
            "multiline":true,
            "realWidth":300
         });
         tt.htmlText = Enum_TianmingJJ.getTip;
         this.helpContiner.addChild(this.tipWin);
         setTimeout(this.helpEff,5000);
         this.numSpr = new Sprite();
         this.addChild(this.numSpr);
         this.currentTM_plus = ComponentUtil.getTextField("",this.numSpr,{
            "x":350,
            "y":260,
            "color":16776960,
            "size":20,
            "leading":0
         });
         this.numberRunTimer = new Timer(100,20);
         this.numberRunTimer.addEventListener(TimerEvent.TIMER,this.numberRunTimerHandler);
         Global.stage.addEventListener(MouseEvent.CLICK,function():void
         {
            helpEff();
         });
         Global.control.registerCallBack(Child_TMSZContiner.PLAY_END,this.effectEnd);
         Global.control.registerCallBack(Child_TMSZContiner.PLAY_START,this.playEffect);
      }
      
      private function helpEff() : void
      {
         if(this.isDo)
         {
            return;
         }
         this.isDo = true;
         if(this.helpContiner.visible)
         {
            Tween.to(this.tipWin,500,{
               "scaleX":[1,0],
               "scaleY":[1,0],
               "x":[this.tipWin.x,this.myTextFiled_4.x],
               "y":[this.tipWin.y,this.myTextFiled_4.y]
            },function():void
            {
               helpContiner.visible = false;
            });
         }
      }
      
      private function tweenTip() : void
      {
         this._targetY = this._targetY == 110 ? 130 : 110;
         Tween.curTo(this.tipBtn,600,{"y":this._targetY},this.tweenTip);
      }
      
      public function playEffect() : void
      {
         this.isFirst = true;
         this.tms.text = CommandManager.get_bag_count(Model_TianmingJJ.TOOLID).toString();
         this.tipBtn.visible = false;
         Tween.stop(this.tipBtn);
         Model_TianmingJJ.isEffect = true;
      }
      
      public function effectEnd() : void
      {
         Model_TianmingJJ.isEffect = false;
         this.resultPan.visible = true;
         this.shape.visible = true;
         this.resultPan.setdate();
      }
      
      public function update() : void
      {
         this.tms.text = CommandManager.get_bag_count(Model_TianmingJJ.TOOLID).toString();
         TxtNumRoll.getInstance().addTimeTic(this.tmd,int(this.tmd.text),Model_TianmingJJ.currentTMD);
         this.resultPan.visible = false;
         this.shape.visible = false;
         this.cc.resetPos();
         if(!this.isFirst)
         {
            this.tipBtn.visible = true;
         }
      }
      
      public function setRoll() : void
      {
         this.playEffect();
         this.cc.play();
      }
      
      public function playEff() : void
      {
         var eff:Effect = null;
         if(visible)
         {
            eff = EffectManager.addEffect("35040",this,1500,11,11);
            Tween.to(eff,1500,{
               "y":[this.height / 2,this.tmd.y],
               "x":[this.width / 2,this.tmd.x]
            },function(eff:Effect):void
            {
               if(Boolean(eff))
               {
                  EffectManager.removeEffect(eff);
               }
            });
         }
      }
      
      public function numPlay() : void
      {
         EffectManager.addEffect("56918",this.numSpr,700,280,280);
         this.add = (Model_TianmingJJ.currentTMD - this.currentTMD) / 21;
         if(this.add == 0)
         {
            this.add = 1;
         }
         this.numberRunTimer.reset();
         this.numberRunTimer.start();
      }
      
      private function numberRunTimerHandler(e:TimerEvent) : void
      {
         this.currentTM_plus.htmlText = "<font color=\'#ffffff\'>天命点</font>+" + (Model_TianmingJJ.currentTMD - this.currentTMD - this.add * this.numberRunTimer.currentCount);
         if(this.numberRunTimer.currentCount == 20)
         {
            this.currentTM_plus.text = "";
            this.currentTMD = Model_TianmingJJ.currentTMD;
         }
         else if(Model_TianmingJJ.currentTMD - this.currentTMD - this.add * this.numberRunTimer.currentCount <= 0)
         {
            this.numberRunTimer.stop();
            this.currentTM_plus.text = "";
            this.currentTMD = Model_TianmingJJ.currentTMD;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.tms.text = CommandManager.get_bag_count(Model_TianmingJJ.TOOLID).toString();
            this.currentTMD = int(this.tmd.text);
            if(Model_TianmingJJ.currentTMD - this.currentTMD > 0)
            {
               this.numPlay();
            }
            else
            {
               this.tmd.text = Model_TianmingJJ.currentTMD.toString();
            }
            TxtNumRoll.getInstance().addTimeTic(this.tmd,int(this.tmd.text),Model_TianmingJJ.currentTMD);
         }
         else if(this.resultPan.visible)
         {
            TianmingJJCGMessage.CG_TMJJ_LQ(Enum_TianmingJJ.LQ);
            this.resultPan.visible = false;
            this.shape.visible = false;
         }
      }
   }
}

