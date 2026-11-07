package com.yiTian.view.modules.broadcast
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   
   public class StrengthTip
   {
      
      private static var subTf:MyTextField;
      
      public function StrengthTip()
      {
         super();
      }
      
      public static function showADD(src:int, add:int, label:String = "") : void
      {
         var tfC:TFFF = TFFF.getInstance();
         tfC.resetSrc(src,add,label);
         tfC.play();
      }
      
      public static function showSub(add:int, label:String) : void
      {
         var _x:Number;
         var offset:Number;
         if(!subTf)
         {
            subTf = ComponentUtil.getTextField("",null,{"bold":true});
         }
         _x = Global.stage.stageWidth * 0.8;
         subTf.x = _x;
         subTf.y = Global.stage.stageHeight - 100;
         subTf.htmlText = "<font color=\'#ff4400\' size=\'14\'>" + label + add.toString() + "</font>";
         subTf.alpha = 1;
         if(!subTf.parent)
         {
            GameScene.upUILayer.addChild(subTf);
         }
         offset = -150;
         Tween.to(subTf,3500,{
            "y":[subTf.y,subTf.y + offset],
            "alpha":[1,0.3]
         },function():void
         {
            subTf.parent.removeChild(subTf);
         });
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.command.Enum_MsgType;
import com.yiTian.scene.GameScene;
import com.yiTian.utils.ComboTweenStep;
import com.yiTian.utils.Tween;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.geom.ColorTransform;
import flash.text.TextFieldAutoSize;

class TFFF extends Sprite
{
   
   private static var ins:TFFF;
   
   private var tff:MyTextField;
   
   private var _s:int;
   
   private var _add:int;
   
   private var _tmpTF:MyTextField;
   
   private var bmContainer:Sprite;
   
   private var isRun:Boolean = false;
   
   private var tmp:String;
   
   private var constStr1:String;
   
   public function TFFF()
   {
      super();
      this.tff = ComponentUtil.getTextField("",this,{"bold":true});
      this.bmContainer = new SP1();
      this._tmpTF = ComponentUtil.getTextField("",this);
      this.bmContainer.addChild(this._tmpTF);
      addChild(this.bmContainer);
      this.tff.transform.colorTransform = new ColorTransform(1,1,1,1,80,0,0);
   }
   
   public static function getInstance() : TFFF
   {
      if(!ins)
      {
         ins = new TFFF();
      }
      return ins;
   }
   
   private function getX() : Number
   {
      return Global.stage.stageWidth * 0.6;
   }
   
   private function getY1() : Number
   {
      return Global.stage.stageHeight * 0.8;
   }
   
   private function getY2() : Number
   {
      return Global.stage.stageHeight * 0.3;
   }
   
   private function getY3() : Number
   {
      return Global.stage.stageHeight * 0.1;
   }
   
   private function getT1() : uint
   {
      return 360;
   }
   
   private function getT2() : uint
   {
      return 1500;
   }
   
   private function getT3() : uint
   {
      return 700;
   }
   
   private function getT4() : uint
   {
      return 300;
   }
   
   private function getT5() : uint
   {
      return 400;
   }
   
   private function getParent() : DisplayObjectContainer
   {
      return GameScene.upUILayer;
   }
   
   public function resetSrc(s:int, add:int, label:String = "") : void
   {
      x = this.getX();
      this.constStr1 = "<font color=\'#ffff33\' size=\'22\'>" + label + "<font size=\'20\'>";
      this._tmpTF.text = "";
      this.setNum(s,add);
      this._s = s;
      this._add = add;
      if(this.isRun)
      {
         Tween.stop(TFFF.getInstance());
         Tween.stop(this.bmContainer);
      }
      this.isRun = false;
      if(Boolean(parent))
      {
         this.getParent().removeChild(this);
      }
   }
   
   private function onBPPS() : void
   {
      Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_PRE_START,this.onBPPS);
   }
   
   public function play() : void
   {
      var step1:ComboTweenStep;
      var step2:ComboTweenStep;
      var step3:ComboTweenStep;
      if(Global.isInBattle)
      {
         return;
      }
      Tween.stop(TFFF.getInstance());
      Tween.stop(this.tff);
      Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_PRE_START,this.onBPPS);
      this.isRun = true;
      alpha = 1;
      this.getParent().addChild(TFFF.getInstance());
      y = this.getY1();
      step1 = new ComboTweenStep();
      step1.time = this.getT1();
      step1.tweenType = Tween.SIN;
      step1.property = {"y":[this.getY1(),this.getY2()]};
      step2 = new ComboTweenStep();
      step2.time = this.getT2();
      step2.tweenType = Tween.BEE_LINE;
      step2.property = {"persent":[0,1]};
      step3 = new ComboTweenStep();
      step3.time = 180;
      step3.tweenType = Tween.BEE_LINE;
      step3.endFun = function():void
      {
         var hw:Number = NaN;
         var hh:Number = NaN;
         hw = Number(tff.width);
         hh = Number(tff.height);
         _tmpTF.x = -hw / 2;
         _tmpTF.y = -hh / 2;
         var _temp_1:* = bmContainer;
         bmContainer.scaleY = 1;
         _temp_1.scaleX = 1;
         _tmpTF.realWidth = hw;
         _tmpTF.realHeight = hh;
         bmContainer.x = hw / 2;
         bmContainer.y = hh / 2;
         _tmpTF.autoSize = TextFieldAutoSize.CENTER;
         _tmpTF.htmlText = tff.htmlText;
         Tween.to(bmContainer,getT3(),{
            "scaleX":[1,1.6],
            "scaleY":[1,1.6],
            "alpha":[1,0]
         },function():void
         {
            _tmpTF.text = "";
            Tween.to(TFFF.getInstance(),getT4(),[],steppp);
         },null,Tween.SIN);
      };
      step1.next = step2;
      step2.next = step3;
      Tween.playComboStep(TFFF.getInstance(),step1);
   }
   
   private function steppp() : void
   {
      Tween.to(TFFF.getInstance(),this.getT5(),{
         "y":[this.getY2(),this.getY3()],
         "alpha":[1,0]
      },function():void
      {
         getParent().removeChild(TFFF.getInstance());
      });
      Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_PRE_START,this.onBPPS);
   }
   
   private function setNum(s:int, add:int) : void
   {
      this.tmp = this.constStr1 + s.toString();
      if(add > 0)
      {
         this.tmp += "<font color=\'#33ff33\' size=\'18\'> + " + add.toString() + "</font>";
      }
      this.tff.htmlText = this.tmp;
   }
   
   public function set persent(rate:Number) : void
   {
      var add:int = rate * this._add;
      this.setNum(this._s + add,this._add - add);
   }
}

class SP1 extends Sprite
{
   
   private var trans:ColorTransform = new ColorTransform();
   
   public function SP1()
   {
      super();
      this.colorOffset = 255;
   }
   
   public function set colorOffset(value:Number) : void
   {
      this.trans.redOffset = value;
      transform.colorTransform = this.trans;
   }
}
