package com.yiTian.view.modules.horse
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.ui.controls.RadioButtonGroup;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.role.Hero;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.net.message.cg.HorseCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.modules.horse.starSign.View_xingZuo;
   import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class Child_horsePartTap extends Sprite
   {
      
      public var _ttUnit:Child_tianTiUnit;
      
      private var _rGroup:RadioButtonGroup;
      
      private var _tfNumStone:MyTextField;
      
      private var _btnLib:Button;
      
      private var checkBox:CheckBox;
      
      private var checkBoxSpr:Sprite;
      
      private var _simpleBtn:Button;
      
      private var _highLvBtn:Button;
      
      private var _stoneTipArea:Sprite;
      
      private var _tfMoveSpeed:MyTextField;
      
      private var _btnStone:Bitmap;
      
      private var _bg:DisplayObject;
      
      private var _starSign:Sprite;
      
      private var openCounter:uint = 0;
      
      private var mc:MovieClip;
      
      private var stoneVo:Vo_item;
      
      private var _last:int;
      
      private var _tweenObj:Object = {};
      
      public function Child_horsePartTap()
      {
         var item:PartBarAndBarItem = null;
         super();
         this._bg = ComponentUtil.getScaleBitmap("Back4",[3,3,1,1],this,{
            "x":0,
            "y":7,
            "width":580,
            "height":289
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("ZuoQi_Back",this,{
            "x":10,
            "y":17
         },Global.ZuoQi_c01_Imgsdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":270,
            "y":19,
            "width":302,
            "height":228
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":272,
            "y":21,
            "width":298,
            "height":26
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_brown",[3,3,3,3],this,{
            "x":277,
            "y":56,
            "width":288,
            "height":52
         },Global.ZuoQi_c01_Imgsdm);
         ComponentUtil.getScaleBitmap("Back_brown",[3,3,3,3],this,{
            "x":277,
            "y":119,
            "width":288,
            "height":52
         },Global.ZuoQi_c01_Imgsdm);
         ComponentUtil.getScaleBitmap("Back_brown",[3,3,3,3],this,{
            "x":277,
            "y":182,
            "width":288,
            "height":52
         },Global.ZuoQi_c01_Imgsdm);
         ComponentUtil.getScaleBitmap("Back_Diamond02",[3,3,1,1],this,{
            "x":278,
            "y":57,
            "width":116,
            "height":50
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Diamond02",[3,3,1,1],this,{
            "x":278,
            "y":120,
            "width":116,
            "height":50
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Diamond02",[3,3,1,1],this,{
            "x":278,
            "y":183,
            "width":116,
            "height":50
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Text_ZQBuJian",this,{
            "x":274,
            "y":25
         },Global.ZuoQi_c01_Imgsdm);
         ComponentUtil.getBitmap("Back_YCZQ",this,{
            "x":41,
            "y":265
         },Global.ZuoQi_c01_Imgsdm);
         ComponentUtil.getTextField("隐藏坐骑模型",this,{
            "x":106,
            "y":266,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this._btnStone = ComponentUtil.getBitmap("SYDuanzaoshi_Back",this,{
            "x":483,
            "y":20
         },Global.ZuoQi_c01_Imgsdm);
         this._ttUnit = new Child_tianTiUnit();
         this._ttUnit.setFrameInterval(120);
         this._ttUnit.way = 3;
         this._ttUnit.type = Child_tianTiUnit.PLAYER;
         this._ttUnit.state = 1;
         this._ttUnit.x = 138;
         var _temp_1:* = this._ttUnit;
         this._ttUnit.y = 220;
         _temp_1.jumpBindY = 220;
         this._ttUnit.jumpPixel = 40;
         this._ttUnit.jumpDuration = 500;
         addChild(this._ttUnit);
         this._btnLib = ComponentUtil.getButton("","Button_Card",this,{
            "x":196,
            "y":24,
            "callBack":this.libClickHd
         },Global.ZuoQi_c01_Imgsdm);
         TipManager.bind(this._btnLib,LangConfig.getWord("29464",2));
         this.checkBox = ComponentUtil.getCheckBox("","CheckBox01",this,{
            "x":86,
            "y":268,
            "color":16772287
         },Global.Img_Cdm);
         this.checkBox.selected = GameUnitManager.hero.horse > 0 ? false : true;
         this.checkBox.mouseEnabled = false;
         this.checkBox.mouseChildren = false;
         this.checkBoxSpr = new Sprite();
         addChild(this.checkBoxSpr);
         this.checkBoxSpr.x = 72;
         this.checkBoxSpr.y = 265;
         this.checkBoxSpr.graphics.beginFill(0,0);
         this.checkBoxSpr.graphics.drawRect(0,0,122,21);
         this.checkBoxSpr.graphics.endFill();
         this.checkBoxSpr.buttonMode = true;
         this.checkBoxSpr.addEventListener(MouseEvent.CLICK,this.onClickCheckBox);
         TipManager.bind(this.checkBoxSpr,"隐藏坐骑后，角色将取消坐骑移动速度");
         this._rGroup = new RadioButtonGroup();
         this._rGroup.direction = RadioButtonGroup.VERTICAL;
         this._rGroup.space = 97;
         this._rGroup.x = 285;
         this._rGroup.y = 73;
         addChild(this._rGroup);
         var i:int = 0;
         while(i < 3)
         {
            item = new PartBarAndBarItem("","CheckBox01",Global.Img_Cdm);
            item._index = i;
            this._rGroup.addItem(item);
            i += 1;
         }
         this._simpleBtn = ComponentUtil.getButton("","Button_PTDuanZao",this,{
            "x":283,
            "y":250,
            "enabled":false,
            "callBack":this.simpleClickHd
         },Global.ZuoQi_c01_Imgsdm);
         this._highLvBtn = ComponentUtil.getButton("","Button_GJDuanZao",this,{
            "x":445,
            "y":250,
            "enabled":false,
            "callBack":this.advanceClickHd
         },Global.ZuoQi_c01_Imgsdm);
         TipManager.bind(this._simpleBtn,LangConfig.getWord("29465",2));
         TipManager.bind(this._highLvBtn,LangConfig.getWord("29466",2));
         this._tfNumStone = ComponentUtil.getTextField("x999",this,{
            "x":524,
            "y":26,
            "color":14671839,
            "size":12
         });
         this._stoneTipArea = new Sprite();
         this._stoneTipArea.graphics.beginFill(255,0);
         this._stoneTipArea.graphics.drawRect(0,0,78,25);
         this._stoneTipArea.x = 486;
         this._stoneTipArea.y = 20;
         addChild(this._stoneTipArea);
         this._tfMoveSpeed = ComponentUtil.getTextField("",this,{
            "x":133,
            "y":242,
            "color":16777011
         });
         this._tfMoveSpeed.autoSize = TextFieldAutoSize.CENTER;
         this._rGroup.selectedIndex = 0;
         this._stoneTipArea.addEventListener(MouseEvent.MOUSE_MOVE,this.onRollOver);
         this._stoneTipArea.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         this.stoneVo = new Vo_item();
         this.stoneVo.id = HorseConfig.FORGESTONE_ID;
         this.stoneVo.Init_lib();
         Global.control.registerCallBack(Model_horse.HORSEPNL_VIS_CHANGE,this.horsePnlChangeHd);
      }
      
      private function tryShowStarSignEffect() : void
      {
         if(this.openCounter == 0 && Model_horse.getSSLevel() >= 5)
         {
            this.showStarSignEffect();
            ++this.openCounter;
         }
         this.tweenStar();
      }
      
      private function tweenStar() : void
      {
      }
      
      public function showStarSignEffect() : void
      {
         this.mc = this.mc || new (Global.ZuoQi_c01_Imgsdm.getDefinition("completeMC") as Class)() as MovieClip;
         this.mc.gotoAndPlay(1);
         this.mc.x = 30;
         this.mc.y = 50;
         addChild(this.mc);
         this.mc.addEventListener(Event.EXIT_FRAME,this.onMCExitFrame);
      }
      
      private function onMCExitFrame(event:Event) : void
      {
         if(this.mc.currentFrame == this.mc.totalFrames)
         {
            this.showStarSignBtn();
            this.hideStarSign();
            this.tweenStar();
         }
      }
      
      private function horsePnlChangeHd(vis:Boolean) : void
      {
         if(vis)
         {
            this.tryShowStarSignEffect();
         }
         else
         {
            this.tryStopSSBtn();
         }
      }
      
      public function tryStopSSBtn() : void
      {
         Tween.stop(this._starSign);
      }
      
      public function showStarSignBtn() : void
      {
         if(!this._starSign)
         {
            this._starSign = new Sprite();
            ComponentUtil.getButton("","Button_XZJR",this._starSign,{
               "x":-24,
               "y":-24.5,
               "callBack":this.starSignClickHandler
            },Global.ZuoQi_c01_Imgsdm);
            TipManager.bind(this._starSign,"点击打开星座坐骑面板");
            this._starSign.x = 42;
            this._starSign.y = 53;
            addChild(this._starSign);
         }
      }
      
      public function hideStarSign() : void
      {
         if(Boolean(this.mc))
         {
            this.mc.stop();
            if(Boolean(this.mc.parent))
            {
               this.mc.parent.removeChild(this.mc);
            }
            this.mc.removeEventListener(Event.EXIT_FRAME,this.onMCExitFrame);
         }
      }
      
      private function starSignClickHandler(e:MouseEvent) : void
      {
         View_xingZuo.instance.show();
      }
      
      private function onClickCheckBox(e:MouseEvent) : void
      {
         this.checkBox.selected = !this.checkBox.selected;
         if(this.checkBox.selected)
         {
            HorseCGMessage.CG_HORSE_SHOW_AND_HIDE(0);
         }
         else
         {
            HorseCGMessage.CG_HORSE_SHOW_AND_HIDE(1);
         }
      }
      
      private function onRollOver(e:MouseEvent) : void
      {
         TipManager.update(this.stoneVo);
         TipManager.view_tip.x = Global.stage.mouseX;
         TipManager.view_tip.y = Global.stage.mouseY;
      }
      
      private function onRollOut(e:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      public function updateParts() : void
      {
         var lv:int = 0;
         var exp:int = 0;
         var pItem:PartBarAndBarItem = null;
         var dic:Dictionary = null;
         var infos:Array = null;
         var exp2:int = 0;
         this.tryShowStarSignEffect();
         var a:Array = Model_horse.partInfos;
         this._simpleBtn.enabled = this._simpleBtn.enabled || true;
         this._highLvBtn.enabled = this._highLvBtn.enabled || true;
         var i:int = 0;
         while(i < 3)
         {
            lv = int(a[i * HorseConfig.PART_DATAINTERVAL + HorseConfig.PART_PER_EXP]);
            exp = int(a[i * HorseConfig.PART_DATAINTERVAL + HorseConfig.PART_FIRST_OFFSET]);
            pItem = this._rGroup.getByIndex(i) as PartBarAndBarItem;
            dic = Data_lib.zqbw;
            infos = Data_lib.zqbw[lv];
            exp2 = int(infos[HorseConfig.PART_EXP]);
            pItem.update({
               "label":LangConfig.getWord("29467",2,HorseConfig.getPartNames()[i] + lv),
               "atbTxts":HorseConfig.getTffs(Data_lib.zqbw,lv.toString(),HorseConfig.PART_FIRST_OFFSET + i),
               "percent":lv + exp / Data_lib.zqbw[lv][HorseConfig.PART_EXP]
            });
            i += 1;
         }
      }
      
      public function updateSpeed() : void
      {
         this._tfMoveSpeed.htmlText = LangConfig.getWord("29468",2,Model_horse.baseMoveSpeed,Model_horse.extraMoveSpeed);
      }
      
      public function showSuccess() : void
      {
         var bm:Bitmap = null;
         bm = ComponentUtil.getBitmap("Text_BJDZCG",this,null,Global.ZuoQi_c01_Imgsdm);
         bm.x = (this._bg.width - bm.width) / 2;
         bm.y = 35;
         EffectManager.addEffect("35063",this,1500,this._bg.width / 2,70);
         Tween.to(bm,3000,{"alpha":[2,0]},this.onBmComplete);
      }
      
      private function onBmComplete(bm:Bitmap) : void
      {
         bm.bitmapData = null;
         if(Boolean(bm.parent))
         {
            bm.parent.removeChild(bm);
         }
      }
      
      public function updateNumStone() : void
      {
         var pnl:View_horsePanel = Singleton.getInstance(View_horsePanel);
         if(!pnl.visible)
         {
            return;
         }
         this._tfNumStone.text = "x" + CommandManager.get_bag_count(HorseConfig.FORGESTONE_ID).toString();
      }
      
      public function updateBody() : void
      {
         var hero:Hero = GameUnitManager.hero;
         this._ttUnit.sex = hero.sex;
         this._ttUnit.job = hero.job;
         this._ttUnit.modelId = hero.body;
         this._ttUnit.weaponDir = hero.weapon.toString();
         this._ttUnit.horse = hero.horse;
         this._ttUnit.wing = hero.wing;
         this._ttUnit.updateHorseLayer();
         this._ttUnit.updateLayer();
      }
      
      public function tapperShowMethod(info:Object) : Boolean
      {
         HorseCGMessage.CG_HORSE_PARTS_INFO();
         Global.control.registerCallBack(HorseConfig.HorsePanelFrame,this.onFrame);
         this.updateNumStone();
         Global.control.registerCallBack(Enum_MsgType.BAG_UPDATE,this.updateNumStone);
         Global.control.registerCallBack(Enum_MsgType.ROLE_MODEL_CHANGE,this.handleBodyUpdate);
         this._ttUnit.way = 3;
         return true;
      }
      
      public function tapperHideMethod(info:Object) : Boolean
      {
         Global.control.removeCallBack(HorseConfig.HorsePanelFrame,this.onFrame);
         Global.control.removeCallBack(Enum_MsgType.BAG_UPDATE,this.updateNumStone);
         Global.control.removeCallBack(Enum_MsgType.ROLE_MODEL_CHANGE,this.handleBodyUpdate);
         return true;
      }
      
      private function handleBodyUpdate() : void
      {
         var pnl:View_horsePanel = Singleton.getInstance(View_horsePanel);
         if(pnl.visible)
         {
            this.updateBody();
         }
      }
      
      private function onFrame(ivl:int) : void
      {
         this._ttUnit.onFrame(ivl);
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            this.tryShowStarSignEffect();
            this.updateBody();
         }
         super.visible = value;
      }
      
      private function simpleClickHd(e:MouseEvent) : void
      {
         var str:String;
         var r1:String;
         var r2:int;
         var numItemNeed:int;
         var has:int;
         var now:int = getTimer();
         if(now - this._last < 300)
         {
            return;
         }
         this._last = now;
         str = HorseConfig.getDuanZaoRep();
         r1 = String(10) + LangConfig.getWord("29469",2);
         r2 = 1;
         numItemNeed = 1;
         has = CommandManager.get_bag_count(HorseConfig.FORGESTONE_ID);
         if(has >= numItemNeed || Boolean(Model_horse.neverNote[0]))
         {
            HorseCGMessage.CG_HORSE_DUANZAO(1,this._rGroup.selectedIndex);
         }
         else
         {
            View_horsePartPromtPnl.instance._cb.selected = false;
            View_horsePartPromtPnl.instance.applyFun(Util.rep(str,r1,r2),function():void
            {
               if(View_horsePartPromtPnl.instance._cb.selected)
               {
                  Model_horse.neverNote[0] = true;
               }
               HorseCGMessage.CG_HORSE_DUANZAO(1,_rGroup.selectedIndex);
            });
         }
      }
      
      private function advanceClickHd(e:MouseEvent) : void
      {
         var str:String;
         var r1:String;
         var r2:int;
         var numItemNeed:int;
         var has:int;
         var now:int = getTimer();
         if(now - this._last < 300)
         {
            return;
         }
         this._last = now;
         str = HorseConfig.getDuanZaoRep();
         r1 = String(100) + LangConfig.getWord("29469",2);
         r2 = 10;
         numItemNeed = 10;
         has = CommandManager.get_bag_count(HorseConfig.FORGESTONE_ID);
         if(has >= numItemNeed || Boolean(Model_horse.neverNote[1]))
         {
            HorseCGMessage.CG_HORSE_DUANZAO(2,this._rGroup.selectedIndex);
         }
         else
         {
            View_horsePartPromtPnl.instance._cb.selected = false;
            View_horsePartPromtPnl.instance.applyFun(Util.rep(str,r1,r2),function():void
            {
               if(View_horsePartPromtPnl.instance._cb.selected)
               {
                  Model_horse.neverNote[1] = true;
               }
               HorseCGMessage.CG_HORSE_DUANZAO(2,_rGroup.selectedIndex);
            });
         }
      }
      
      private function libClickHd(e:MouseEvent) : void
      {
         var libPnl:View_horseLibPanel = Singleton.getInstance(View_horseLibPanel);
         Global.delegate.dosomething(libPnl,libPnl.show);
      }
      
      public function maimeng() : void
      {
         this._ttUnit.setFrameInterval(30);
         Tween.to(this._tweenObj,1000,{},this.fastRunComplete);
      }
      
      private function fastRunComplete() : void
      {
         this._ttUnit.jump();
         this._ttUnit.setFrameInterval(120);
      }
   }
}

import com.ui.controls.MaskProgressBar;
import com.ui.controls.MyTextField;
import com.ui.controls.RadioButton;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.Data_lib;
import com.yiTian.manager.LangConfig;
import com.yiTian.manager.TipManager;
import com.yiTian.utils.Tween;
import com.yiTian.view.modules.horse.HorseConfig;
import com.yiTian.view.modules.horse.Model_horse;
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.system.ApplicationDomain;
import flash.text.TextFieldAutoSize;

class PartBarAndBarItem extends RadioButton
{
   
   private var _tfLabel:MyTextField;
   
   private var _pb:MaskProgressBar;
   
   private var _tfAtb:MyTextField;
   
   private var _tfExp:MyTextField;
   
   public var _p:Number = 0;
   
   public var _index:int;
   
   private var _tfAtbs:Array;
   
   private var _final:Number;
   
   public function PartBarAndBarItem(txt:String, style:String, dm:ApplicationDomain)
   {
      super(txt,style,dm);
      this._tfLabel = ComponentUtil.getTextField("",this,{
         "x":25,
         "y":-10,
         "size":14,
         "color":16768256
      });
      this._tfAtb = ComponentUtil.getTextField("",this,{
         "x":25,
         "y":11
      });
      this._pb = new MaskProgressBar();
      var pbBG:Bitmap = ComponentUtil.getBitmap("Progress170_Back",null,{"x":-21},Global.ZuoQi_c01_Imgsdm);
      var pbBar:Bitmap = ComponentUtil.getBitmap("Progress170",null,{"y":5},Global.ZuoQi_c01_Imgsdm);
      this._pb = new MaskProgressBar();
      this._pb.bar = pbBar;
      this._pb.bg = pbBG;
      ComponentUtil.setPropertie(this._pb,{
         "x":128,
         "y":0,
         "realWidth":pbBar.width
      });
      this._pb.init();
      addChild(this._pb);
      this._tfExp = ComponentUtil.getTextField("",this,{
         "x":193,
         "y":0
      });
      this._tfExp.autoSize = TextFieldAutoSize.CENTER;
      this._pb.addEventListener(MouseEvent.MOUSE_MOVE,this.pbMouseMoveHd);
      this._pb.addEventListener(MouseEvent.ROLL_OUT,this.pbRollOutHd);
      mouseChildren = true;
   }
   
   private function pbMouseMoveHd(e:MouseEvent) : void
   {
      var maxExp:int = 0;
      var curExp:int = 0;
      if(Boolean(Model_horse.partInfos))
      {
         maxExp = int(Data_lib.zqbw[Model_horse.partInfos[this._index * 2]][HorseConfig.PART_EXP]);
         curExp = int(Model_horse.partInfos[this._index * 2 + 1]);
         TipManager.update(LangConfig.getWord("29460",2,Math.max(0,maxExp - curExp)));
      }
   }
   
   private function pbRollOutHd(e:MouseEvent) : void
   {
      TipManager.hide();
   }
   
   public function update(v:Object) : void
   {
      this._tfLabel.htmlText = v.label;
      HorseConfig.clearTffs(this._tfAtbs);
      this._tfAtbs = v.atbTxts;
      this.updateAtbsTf();
      this._final = v.percent;
      if(this._p == v.percent || this._p == 0)
      {
         this._p = v.percent;
         this.updateByModel();
      }
      else
      {
         Tween.to(this,1000,{"p":[this._p,v.percent]},this.updateByModel,null,Tween.SIN);
      }
   }
   
   private function updateAtbsTf() : void
   {
      var i:int = 0;
      while(i < this._tfAtbs.length)
      {
         this._tfAtbs[i].x = 25;
         this._tfAtbs[i].y = 11 + 20 * (i % 2);
         addChild(this._tfAtbs[i] as DisplayObject);
         i += 1;
      }
   }
   
   public function set p(v:Number) : void
   {
      this._p = v;
      var lv:int = int(v);
      var percent:Number = (Math.floor(v * 10000) - Math.floor(v) * 10000) / 10000;
      var maxLv:int = HorseConfig.MAXPARTLV;
      var maxExp:int = int(Data_lib.zqbw[Math.min(lv,maxLv)][HorseConfig.PART_EXP]);
      if(percent == 1)
      {
         percent = 0;
         lv += 1;
      }
      if(lv >= maxLv)
      {
         percent = 1;
         lv = maxLv;
      }
      if(lv < 0)
      {
         percent = 0;
         lv = 1;
      }
      this._pb.persent = percent;
      this._tfExp.htmlText = int(percent * maxExp).toString() + "/" + maxExp.toString();
   }
   
   private function updateByModel() : void
   {
      var infos:Array = Model_horse.partInfos;
      var lv:int = int(infos[this._index * 2]);
      var exp:int = int(infos[this._index * 2 + 1]);
      var maxExp:int = int(Data_lib.zqbw[Math.min(lv,HorseConfig.MAXPARTLV)][HorseConfig.PART_EXP]);
      this._pb.persent = exp / maxExp;
      this._tfExp.htmlText = exp.toString() + "/" + maxExp.toString();
   }
}
