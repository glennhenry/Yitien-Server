package com.yiTian.view.modules.newYear
{
   import Layout.ILayout;
   import Layout.VGroup;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.ResObj;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ResourceManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.NewYearCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class View_nianShouPnl extends Panel123
   {
      
      private var _bg:DisplayObject;
      
      private var items:Array = [];
      
      private var tipArea:Sprite;
      
      private var jfItems:Array = [];
      
      private var effLayer:Sprite;
      
      private var _effCilcle:MovieClip;
      
      private var _nianShou:Child_tianTiUnit;
      
      private var _lv:int;
      
      private var nianShouEffSp:Child_tianTiUnit;
      
      private var _target:CHOOSEITEM;
      
      private var lastTime:int;
      
      private var voId:String = "46439";
      
      private var aimPoint:Point;
      
      private var cont:int = 0;
      
      private var _flyCont:int;
      
      private var _timer:Timer;
      
      private var _tmindex:int;
      
      private var _remian:int = 0;
      
      private var tf_remain:MyTextField;
      
      private var ngVo:Vo_item;
      
      private var tmp:Object;
      
      private var _runTime:int;
      
      private var _curjf:int;
      
      private var itemFlowerNumVec:Vector.<int> = new <int>[0,1,2,4,8];
      
      private var powerMC:MovieClip;
      
      public function View_nianShouPnl()
      {
         super();
         regResource("lang/ch/NianShou_Imgs.swf","NianShou_Imgsdm");
      }
      
      public function getNianShou() : Child_tianTiUnit
      {
         return this._nianShou;
      }
      
      override public function get width() : Number
      {
         return this._bg.width;
      }
      
      override public function get height() : Number
      {
         return this._bg.height;
      }
      
      public function show() : void
      {
         visible = true;
         pop(0.6,0.4);
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this._nianShou.onFrame);
         this._effCilcle.play();
      }
      
      public function hide(e:MouseEvent = null) : void
      {
         visible = false;
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this._nianShou.onFrame);
         this._effCilcle.stop();
      }
      
      public function updateItemsExp() : void
      {
         var i:int = 0;
         while(i < this.items.length)
         {
            (this.items[i] as CHOOSEITEM).setGainExp(Config_NewYear.getGainExp(i));
            i += 1;
         }
      }
      
      public function showNianShouEff(lv:int) : void
      {
         var url:String = this._nianShou.getModelUrl();
         var res:ResObj = ResourceManager.resourceIndex[url];
         if(Boolean(res) && res.isLoad)
         {
            this.nianShouEffSp = this.nianShouEffSp || new Child_tianTiUnit();
            this.nianShouEffSp.modelId = this._nianShou.modelId;
            this.nianShouEffSp.state = this._nianShou.state;
            this.nianShouEffSp.way = this._nianShou.way;
            this.nianShouEffSp.alpha = 0.3;
            this.nianShouEffSp.updateViewer();
            this.nianShouEffSp.scaleX = this._nianShou.scaleX;
            this.nianShouEffSp.scaleY = this._nianShou.scaleY;
            this._nianShou.addChild(this.nianShouEffSp);
            Tween.curTo(this.nianShouEffSp,1000,{
               "scaleX":1 + lv * 0.3,
               "scaleY":1 + lv * 0.3,
               "alpha":0.1
            },this.effComplete);
         }
      }
      
      private function effComplete() : void
      {
         if(Boolean(this.nianShouEffSp.parent))
         {
            this.nianShouEffSp.parent.removeChild(this.nianShouEffSp);
         }
      }
      
      public function maimeng(time:int) : void
      {
         this._nianShou.state = 1;
         Tween.to(this.tmp = this.tmp || {},time,{"x":[1,1]},this.onRunComplete);
      }
      
      private function nianShouClick(e:MouseEvent) : void
      {
         UIManager.centerBroadcast.addMsg("O(∩_∩)O。。");
         this.maimeng(3000);
      }
      
      private function itemBtnClick(target:CHOOSEITEM) : void
      {
         var count:int = 0;
         if(this._tmindex != 0)
         {
            return;
         }
         this._target = target;
         var need:int = target.getCostId();
         if(need != 0)
         {
            count = GameUnitManager.hero.money;
            if(need > count)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("20241",2));
            }
            else
            {
               NewYearCGMessage.CG_USENIANSHOUTOKEN(need);
               this._tmindex = setTimeout(this.onTimeout,1000);
            }
         }
         else
         {
            NewYearCGMessage.CG_USENIANSHOUTOKEN(need);
            this._tmindex = setTimeout(this.onTimeout,1000);
         }
      }
      
      public function flyToBag() : void
      {
         if(this._target != null && this._target._flowerNum > 0)
         {
            this._timer = this._timer || new Timer(150);
            this._timer.reset();
            this._timer.repeatCount = this._target._flowerNum;
            this._timer.addEventListener(TimerEvent.TIMER,this.onTimer);
            this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
            this._timer.start();
         }
      }
      
      protected function onTimerComplete(event:TimerEvent) : void
      {
         this._timer.stop();
      }
      
      private function onTimer(e:TimerEvent) : void
      {
         this.flyOneMooncake();
      }
      
      private function flyOneMooncake() : void
      {
         var steps:ComboTweenStep;
         var bm:Bitmap = null;
         var p:Point = null;
         var timeOutIndex:int = 0;
         bm = new Bitmap();
         bm.bitmapData = ComponentUtil.getBitmapData("Icon_YueBing",Global.NianShou_Imgsdm);
         p = localToGlobal(new Point(this._target.x + 75,this._target.y));
         bm.x = p.x;
         bm.y = p.y;
         GameScene.sysLayer.addChild(bm);
         steps = ComboTweenStep.getUpAndToBag(bm);
         Tween.playComboStep(bm,steps);
         timeOutIndex = int(setTimeout(function():void
         {
            if(Boolean(bm.parent))
            {
               bm.parent.removeChild(bm);
            }
            bm.bitmapData = null;
            clearTimeout(timeOutIndex);
         },1700));
      }
      
      private function flyGift() : void
      {
         var p:Point = new Point(this.aimPoint.x,this.aimPoint.y);
         if(getTimer() - this.lastTime >= 100)
         {
            this.lastTime = getTimer();
            if(this.cont > this._flyCont + 5)
            {
               GameScene.instance.removeFrameCallBack(this.flyGift);
               return;
            }
            if(this.cont >= 6)
            {
               Tween.gridToBagBezierFuncDef(this.voId,-1,p.x,p.y);
            }
            ++this.cont;
         }
      }
      
      private function onTimeout() : void
      {
         clearTimeout(this._tmindex);
         this._tmindex = 0;
      }
      
      public function updateRemain(v:Object) : void
      {
         var item:CHOOSEITEM = null;
         this._remian = v as int;
         for each(item in this.items)
         {
            item.setBtnEnable(this._remian > 0);
         }
         this.tf_remain.htmlText = LangConfig.getWord("70029",7) + HtmlUtil.fontNoSize(v.toString(),"#22ff22");
      }
      
      public function showAdd(v:int) : void
      {
         if(v <= 0 || v > 5)
         {
            return;
         }
         this._lv = v;
         this.showPowerEff();
      }
      
      private function onRunComplete() : void
      {
         this._nianShou.state = 0;
      }
      
      public function updateJiFen(v:Object) : void
      {
         var jfItem:JFItem = null;
         this.updateItemsExp();
         if(this._curjf == v)
         {
            return;
         }
         this._curjf = v as int;
         if(v == 0)
         {
            for each(jfItem in this.jfItems)
            {
               jfItem.stateZero();
            }
            return;
         }
         var jiFenStr:String = uint(v).toString();
         var l:int = jiFenStr.length;
         var sIndex:int = this.jfItems.length - l;
         JFItem.tt1 = 0;
         var i:int = 0;
         while(i < l)
         {
            (this.jfItems[i + sIndex] as JFItem).start(int(jiFenStr.charAt(i)));
            i += 1;
         }
         var ii:int = 0;
         while(ii < sIndex)
         {
            (this.jfItems[ii] as JFItem).stateZero();
            ii += 1;
         }
      }
      
      override protected function initUI2() : void
      {
         var url:String = null;
         var item:CHOOSEITEM = null;
         var jfItem:JFItem = null;
         this._bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":733,
            "height":565
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this._bg.width,this._bg.height);
         ComponentUtil.getBitmap("NianShou_Back",this,{
            "x":24,
            "y":40
         },Global.NianShou_Imgsdm);
         ComponentUtil.getBitmap("Num_Text",this,{
            "x":244,
            "y":311
         },Global.NianShou_Imgsdm);
         ComponentUtil.getBitmap("Title_NianShou",this,{
            "x":286,
            "y":5
         },Global.NianShou_Imgsdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":699,
            "y":6,
            "callBack":this.hide
         },Global.Img_Cdm);
         var itemsLayoutImpl:ILayout = new VGroup(66,355,0,0,0,120);
         var styls:Array = [null,"Song1","Song2","Song3","Song4"];
         var i:int = 0;
         while(i < 5)
         {
            url = "resource/image/zhuoGui/" + (i + 1).toString() + ".png";
            item = new CHOOSEITEM(styls[i]);
            item.iconUrl = url;
            item.iconLv = i;
            item.setCostId(Config_NewYear.NIANSHOUTOKENID[i]);
            item.setBtnClick(this.itemBtnClick);
            item.setFlowerNum(this.itemFlowerNumVec[i]);
            this.items.push(item);
            itemsLayoutImpl.appendItem(item);
            addChild(item);
            i += 1;
         }
         itemsLayoutImpl.align();
         itemsLayoutImpl.dispose();
         this.tf_remain = ComponentUtil.getTextField("",this,{
            "x":34,
            "y":50,
            "size":12,
            "color":16776960,
            "bold":true
         });
         itemsLayoutImpl = new VGroup(357,310,0,0,0,12);
         var ii:int = 0;
         while(ii < 10)
         {
            jfItem = new JFItem();
            this.jfItems.push(jfItem);
            itemsLayoutImpl.appendItem(jfItem);
            addChild(jfItem);
            ii += 1;
         }
         itemsLayoutImpl.align();
         itemsLayoutImpl.dispose();
         this.effLayer = new Sprite();
         addChild(this.effLayer);
         this._effCilcle = new (Global.NianShou_Imgsdm.getDefinition("nianShouEff") as Class)() as MovieClip;
         this._effCilcle.x = 365;
         this._effCilcle.y = 396;
         this.effLayer.addChild(this._effCilcle);
         this._nianShou = new Child_tianTiUnit();
         this._nianShou.modelId = Config_NewYear.NIANSHOUMODELID;
         this._nianShou.way = Config_NewYear.NIANSHOUDIRECTION;
         this._nianShou.scaleX = this._nianShou.scaleY = Config_NewYear.NIANSHOUSCALE;
         this._nianShou._state = 0;
         this._nianShou.buttonMode = true;
         this._nianShou.addEventListener(MouseEvent.CLICK,this.nianShouClick);
         this._nianShou.filters = [new DropShadowFilter(4,270 - 45,16777011,0.7)];
         ComponentUtil.setPropertie(this._nianShou,{
            "x":380,
            "y":270
         });
         addChild(this._nianShou);
         this.tipArea = new Sprite();
         this.tipArea.graphics.beginFill(255,0);
         this.tipArea.graphics.drawRect(0,0,250,30);
         this.tipArea.x = 240;
         this.tipArea.y = 308;
         addChild(this.tipArea);
         TipManager.bind(this.tipArea,LangConfig.getWord("70027",7));
      }
      
      private function showPowerEff() : void
      {
         if(visible)
         {
            this.showNianShouEff(this._lv);
         }
         if(!this.powerMC)
         {
            this.powerMC = new (Global.NianShou_Imgsdm.getDefinition("nianShouEff2") as Class)() as MovieClip;
            this.powerMC.x = 365;
            this.powerMC.y = 348;
         }
         this.effLayer.addChild(this.powerMC);
         this.powerMC.gotoAndPlay(0);
         this.powerMC.addEventListener(Event.EXIT_FRAME,this.onExitFrame);
      }
      
      private function onExitFrame(e:Event) : void
      {
         if(this.powerMC.currentFrame == this.powerMC.totalFrames)
         {
            if(Boolean(this.powerMC.parent))
            {
               this.powerMC.parent.removeChild(this.powerMC);
            }
            this.powerMC.stop();
            this.powerMC.removeEventListener(Event.EXIT_FRAME,this.onExitFrame);
         }
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.vo.Vo_valuable;
import com.yiTian.manager.LangConfig;
import com.yiTian.utils.Tween;
import com.yiTian.utils.Utils;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;

class CHOOSEITEM extends Sprite
{
   
   public static var floweUrl:String = "resource/image/zhuoGui/Ico_Hua.png";
   
   private var costItemId:int;
   
   private var _gridVo:Vo_valuable;
   
   private var _tfCost:MyTextField;
   
   private var _btnClick:Function;
   
   private var _icon:Bitmap;
   
   private var _bgColor:Bitmap;
   
   private var _tfExp:MyTextField;
   
   private var btn:Button;
   
   private var _isEnabled:Boolean;
   
   private var flowerBit:Bitmap;
   
   private var flowerNumTxt:MyTextField;
   
   public var _flowerNum:int;
   
   public function CHOOSEITEM(titleSty:String)
   {
      super();
      ComponentUtil.getBitmap("Card_Back",this,{
         "x":0,
         "y":0
      },Global.NianShou_Imgsdm);
      ComponentUtil.getBitmap("grid_ShangCheng",this,{
         "x":22,
         "y":13
      },Global.Img_Cdm);
      this._bgColor = new Bitmap();
      ComponentUtil.setPropertie(this._bgColor,{
         "x":24,
         "y":15
      });
      addChild(this._bgColor);
      this._icon = new Bitmap();
      ComponentUtil.setPropertie(this._icon,{
         "x":24,
         "y":15
      });
      addChild(this._icon);
      this.flowerBit = new Bitmap();
      addChild(this.flowerBit);
      ComponentUtil.setPropertie(this.flowerBit,{
         "x":73,
         "y":7
      });
      this.flowerBit.bitmapData = ComponentUtil.getBitmapData("Icon_YueBing",Global.NianShou_Imgsdm);
      this.flowerNumTxt = ComponentUtil.getTextField("",this,{
         "x":86,
         "y":16,
         "color":16777215,
         "size":13
      });
      this._tfExp = ComponentUtil.getTextField("",this,{
         "x":12,
         "y":100,
         "color":16770560
      });
      this._tfCost = ComponentUtil.getTextField("",this,{
         "x":12 + 7,
         "y":100,
         "color":16776960
      });
      this.btn = ComponentUtil.getButton(LangConfig.getWord("70028",7),"Button_Two30",this,{
         "x":22,
         "y":128,
         "textColor":16184781,
         "callBack":this.btnClickHd
      },Global.Img_Cdm);
   }
   
   public function get isEnabled() : Boolean
   {
      return this._isEnabled;
   }
   
   public function getCostId() : int
   {
      return this.costItemId;
   }
   
   public function set iconUrl(url:String) : void
   {
      Utils.getLoadBitmap(url,this._icon);
   }
   
   public function set iconLv(v:uint) : void
   {
      if(v == 0)
      {
         return;
      }
      var url:String = "resource/image/iconBg60/" + v + ".png";
      Utils.getLoadBitmap(url,this._bgColor);
   }
   
   public function setGainExp(v:uint) : void
   {
      this._tfExp.htmlText = LangConfig.getWord("519",0) + v.toString();
   }
   
   public function setCostItemTxt(v:String) : void
   {
      this._tfCost.htmlText = v;
   }
   
   public function setCostId(v:int) : void
   {
      this.costItemId = v;
      if(v > 0)
      {
         this.btn.label = "<font color=\'#55dd55\'>" + v.toString() + LangConfig.getWord("21",0) + "</font>";
      }
      else
      {
         this.btn.label = "<font color=\'#999999\'>" + LangConfig.getWord("60357",6) + "</font>";
      }
   }
   
   public function setBtnClick(v:Function) : void
   {
      this._btnClick = v;
   }
   
   public function setFlowerNum(num:int) : void
   {
      this.flowerNumTxt.visible = false;
      this.flowerBit.visible = false;
   }
   
   private function btnClickHd(e:MouseEvent) : void
   {
      this._btnClick(this);
   }
   
   public function setBtnEnable(v:Boolean) : void
   {
      this._isEnabled = this.btn.enabled = v;
   }
   
   public function timeOutFun(v:Boolean) : void
   {
      if(this._isEnabled)
      {
         this.btn.enabled = v;
      }
   }
}

class JFItem extends Sprite
{
   
   private static var counter:int;
   
   private static const OFFSET:Number = 25;
   
   private static const ITEMNUM:int = 2;
   
   public static var tt1:int = 0;
   
   private var vec:Vector.<Bitmap>;
   
   private var container:Sprite;
   
   private var _mask:Shape;
   
   private var _curNum:int;
   
   private var _s:Number;
   
   private var rnd:int;
   
   private var d:uint;
   
   private var index:int;
   
   private var total:Number;
   
   private var startNum:Number;
   
   private var temp:Number;
   
   public function JFItem()
   {
      super();
      this.init();
   }
   
   public function init() : void
   {
      var bm:Bitmap = null;
      this.container = new Sprite();
      addChild(this.container);
      this._mask = ComponentUtil.getShape(20,20,65280,0.3);
      this._mask.y = 5;
      addChild(this._mask);
      mask = this._mask;
      this.vec = new Vector.<Bitmap>();
      var i:int = 0;
      while(i < ITEMNUM)
      {
         bm = new Bitmap();
         bm.y = OFFSET * i + 3;
         bm.bitmapData = this.getBmdTxt(0);
         this.container.addChild(bm);
         this.vec.push(bm);
         i += 1;
      }
   }
   
   public function stateZero() : void
   {
      Tween.stop(this.container);
      this.container.y = 0;
      var i:int = 0;
      while(i < ITEMNUM)
      {
         this.vec[i].y = OFFSET * i + 3;
         i += 1;
      }
      this.vec[0].bitmapData = this.getBmdTxt(0);
   }
   
   public function setCurNum(v:int) : void
   {
      this._curNum = v;
   }
   
   public function start(dis:uint) : void
   {
      this.container.y = 0;
      var i:int = 0;
      while(i < ITEMNUM)
      {
         this.vec[i].y = OFFSET * i + 3;
         i += 1;
      }
      counter = 0;
      this.rnd = tt1 + 4;
      tt1 += 1;
      this.d = dis;
      var offset:Number = this.rnd * OFFSET;
      this.index = 1;
      this.total = 0;
      this.temp = this.startNum = this.container.y;
      var timeCost:int = this.rnd * 200;
      Tween.to(this.container,timeCost,{"y":[this.container.y,this.container.y - offset]},this.onC,this.onStep,Tween.EASYINOUT);
   }
   
   private function onStep() : void
   {
      this.total = this.startNum - this.container.y;
      while(this.index <= this.total / OFFSET)
      {
         this.index += 1;
         this.vec[0].y = this.vec[this.vec.length - 1].y + OFFSET;
         this.vec.push(this.vec.shift());
         if(this.index == this.rnd)
         {
            this.vec[1].bitmapData = this.getBmdTxt(this.d);
            this._curNum = (this.d + 1) % 10;
         }
         else
         {
            this.vec[1].bitmapData = this.getBmdTxt(this._curNum % 10);
            this._curNum += 1;
         }
      }
   }
   
   private function onC() : void
   {
      counter += 1;
      if(counter >= 2)
      {
         counter = 0;
      }
   }
   
   private function getBmdTxt(num:int) : BitmapData
   {
      return ComponentUtil.getBitmapData("Num" + num.toString(),Global.NianShou_Imgsdm);
   }
}
