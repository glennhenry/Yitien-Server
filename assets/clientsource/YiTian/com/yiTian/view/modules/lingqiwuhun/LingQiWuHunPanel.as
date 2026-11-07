package com.yiTian.view.modules.lingqiwuhun
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.DailyBtnManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.LingQiWuHunCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import com.yiTian.view.modules.mainUIBtnContainer.IMainUiBtn;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class LingQiWuHunPanel extends Panel
   {
      
      private static var pool:Array = [];
      
      private static var list:Array = [];
      
      private var txtTimes:MyTextField;
      
      private var btn:Button;
      
      private var back:DisplayObject;
      
      private var _lingBtn:MainUIBtn;
      
      private var _lingQiWuHunVO:LingQiWuHunVO;
      
      private var vecPosition:Vector.<Point>;
      
      private const XY:int = 4;
      
      private var vecSP:Vector.<Sprite>;
      
      private var vecTxt:Vector.<MyTextField>;
      
      private var vecStr:Vector.<String> = new <String>["LQ_HuiSe","LQ_BaiSe","LQ_LuSe","LQ_LanSe","LQ_ZiSe"];
      
      private const idArr:Array = [46252,46253,46254,46255];
      
      private var shMaskNumber:Shape;
      
      private var spNumber:Sprite;
      
      private var shMaskCircle:Shape;
      
      private var spEff:Sprite;
      
      private var shMaskRect:Shape;
      
      private const MASK_HEIGHT:int = 120;
      
      private const MASK_Y1:int = 155;
      
      private const MASK_Y2:int = 275;
      
      private var isRunning:Boolean;
      
      private var selectSP:Sprite;
      
      private var point:Point = new Point();
      
      private var runTimes:int;
      
      private var p1:Point;
      
      private var p2:Point;
      
      private var count:int;
      
      private const CUR_INTEGRAL:int = 500;
      
      private var effCircle:Effect;
      
      private var effStar:Effect;
      
      private var effWave:Effect;
      
      private var spEffWave:Sprite;
      
      private var vecEffStr:Vector.<String> = new <String>["35154","35155","35156","35157","35158"];
      
      private var vecNI:Vector.<NumberItem> = new Vector.<NumberItem>();
      
      private var lastTime:int;
      
      private const NUMBER_WID:int = 13;
      
      private const MAX:int = 7;
      
      private var counter:int;
      
      private var vecPai:Vector.<String> = new <String>[HtmlUtil.font("不使用英雄令",ColorConstant.getColorStr(ColorConstant.WHITE)),HtmlUtil.font("英雄令(白)",ColorConstant.getColorStr(ColorConstant.WHITE)),HtmlUtil.font("英雄令(绿)",ColorConstant.getColorStr(ColorConstant.GREEN)),HtmlUtil.font("英雄令(蓝)",ColorConstant.getColorStr(ColorConstant.BLUE)),HtmlUtil.font("英雄令(紫)",ColorConstant.getColorStr(ColorConstant.PURPLE))];
      
      private var firstTime:Boolean = true;
      
      public function LingQiWuHunPanel()
      {
         super();
      }
      
      private static function run() : void
      {
         var thread:Thread = null;
         var now:int = 0;
         var percent:Number = NaN;
         var j:int = 0;
         var value:Number = NaN;
         if(!list.length)
         {
            GameScene.instance.removeFrameCallBack(run);
         }
         var i:int = list.length - 1;
         while(i >= 0)
         {
            thread = list[i];
            now = getTimer();
            percent = (now - thread.beginTime) / (thread.totleTime / thread.times);
            j = 0;
            while(j < thread.propertie.length)
            {
               percent = percent > 1 ? 1 : percent;
               value = thread.propertie[j][1][0][0] + percent * (thread.propertie[j][1][0][1] - thread.propertie[j][1][0][0]);
               thread.target[thread.propertie[j][0]] = value;
               if(percent == 1 && thread.propertie[j][1].length > 1)
               {
                  thread.propertie[j][1].shift();
                  thread.beginTime = getTimer();
               }
               j++;
            }
            if(now - thread.beginTime > thread.totleTime)
            {
               list.splice(i,1);
               pool.push(thread);
               if(thread.complete != null)
               {
                  if(Boolean(thread.complete.length))
                  {
                     thread.complete(thread.target);
                  }
                  else
                  {
                     thread.complete();
                  }
               }
            }
            i--;
         }
      }
      
      override protected function initStaticView() : void
      {
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":733,
            "height":467
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":23,
            "y":40,
            "width":688,
            "height":419
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":699,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
      }
      
      public function showLingBtn() : IMainUiBtn
      {
         if(!this.lingBtn)
         {
            this._lingBtn = new MainUIBtn("resource/image/extralPng/lqjx.png",null,null,null,true);
            this.lingBtn.addEventListener(MouseEvent.CLICK,this.lingOnClick);
         }
         UIManager.mainUiBtnContainer.addBTN(this.lingBtn);
         Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.LingQi,1]);
         this.updateBtnCount(DailyBtnManager.getCount(DailyBtnManager.LIN_QI));
         return this.lingBtn;
      }
      
      public function updateBtnCount(count:int) : void
      {
         if(Boolean(this.lingBtn))
         {
            this.lingBtn.showTime(count);
            Global.control.sendNotification(Enum_mainUIBtn_hide.SET_COUNT,[Enum_mainUIBtn_hide.LingQi,count]);
            if(count == 0)
            {
               UIManager.mainUiBtnContainer.removeBTN(this.lingBtn);
               Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.LingQi,2]);
            }
            else
            {
               if(!UIManager.mainUiBtnContainer.hasBTN(this.lingBtn))
               {
                  UIManager.mainUiBtnContainer.addBTN(this.lingBtn);
               }
               Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.LingQi,1]);
            }
         }
      }
      
      public function hideLingBtn() : void
      {
         if(Boolean(this.lingBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(this.lingBtn);
         }
         Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.LingQi,2]);
      }
      
      protected function lingOnClick(event:MouseEvent) : void
      {
         UIManager.lingQiWuHunPanel.visible = !UIManager.lingQiWuHunPanel.visible;
         if(UIManager.lingQiWuHunPanel.visible)
         {
            LingQiWuHunCGMessage.CG_LINGQIWUHUN();
         }
      }
      
      public function get lingQiWuHunVO() : LingQiWuHunVO
      {
         return this._lingQiWuHunVO;
      }
      
      public function set lingQiWuHunVO(value:LingQiWuHunVO) : void
      {
         this._lingQiWuHunVO = value;
         this.update();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.back.width) / 2;
         y = (Global.stage.stageHeight - this.back.height) / 2;
      }
      
      private function Init() : void
      {
         var t:MyTextField = null;
         var b1:Bitmap = null;
         var b2:Bitmap = null;
         var sp:Sprite = null;
         var i:int = 0;
         var spTemp:Sprite = null;
         Utils.loadTitle("lang/ch/LingQiWH.swf","BG1",new Bitmap(),{
            "x":24,
            "y":41
         },this);
         Utils.loadTitle("lang/ch/LingQiWH.swf","BGTeXiao",new Bitmap(),{
            "x":234,
            "y":83
         },this);
         this.btn = ComponentUtil.getButton("","BT_JuanXian",this,{
            "x":317,
            "y":370,
            "textColor":16184781
         },Utils.swfPool["lang/ch/LingQiWH.swf"]);
         this.btn.addEventListener(MouseEvent.CLICK,this.btnOnClick);
         this.txtTimes = ComponentUtil.getTextField("",this,{
            "x":44,
            "y":55,
            "color":16763904,
            "size":14,
            "leading":0
         });
         this.txtTimes.bold = true;
         t = ComponentUtil.getTextField("",this,{
            "x":50,
            "y":428,
            "color":16763904,
            "size":12,
            "leading":0
         });
         t.htmlText = "每天的<font color=\'#33ff33\'>14点30分</font>根据灵气达到的数值召唤出不同品质的世界<font color=\'#ff3333\'>boss-武魂</font>，击败武魂可获得<font color=\'#33ff33\'>海量奖励</font>。";
         this.vecSP = new Vector.<Sprite>();
         this.vecPosition = new Vector.<Point>();
         this.vecTxt = new Vector.<MyTextField>();
         var vecPoint:Vector.<Point> = new <Point>[new Point(328,46),new Point(479,149),new Point(471,296),new Point(59,296),new Point(43,149)];
         i = 0;
         while(i < 5)
         {
            sp = new Sprite();
            if(i > 2)
            {
               b2 = ComponentUtil.getBitmap("LQ_Di",this,{
                  "x":vecPoint[i].x,
                  "y":vecPoint[i].y + 15
               },Utils.swfPool["lang/ch/LingQiWH.swf"]);
               b1 = ComponentUtil.getBitmap("LQ_lingqidi",this,{
                  "x":vecPoint[i].x + 130,
                  "y":vecPoint[i].y
               },Utils.swfPool["lang/ch/LingQiWH.swf"]);
               t = ComponentUtil.getTextField("",this,{
                  "x":b2.x + 12,
                  "y":b2.y + 8,
                  "color":16763904,
                  "multiline":true
               });
            }
            else
            {
               b2 = ComponentUtil.getBitmap("LQ_Di",this,{
                  "x":vecPoint[i].x + 35,
                  "y":vecPoint[i].y + 15
               },Utils.swfPool["lang/ch/LingQiWH.swf"]);
               b1 = ComponentUtil.getBitmap("LQ_lingqidi",this,{
                  "x":vecPoint[i].x,
                  "y":vecPoint[i].y
               },Utils.swfPool["lang/ch/LingQiWH.swf"]);
               t = ComponentUtil.getTextField("",this,{
                  "x":b2.x + 45,
                  "y":b2.y + 8,
                  "color":16763904,
                  "multiline":true
               });
            }
            sp.x = b1.x + this.XY;
            sp.y = b1.y + this.XY;
            sp.name = "circle_" + i;
            ComponentUtil.getBitmap(this.vecStr[i],sp,null,Utils.swfPool["lang/ch/LingQiWH.swf"]);
            this.vecSP.push(sp);
            this.vecPosition.push(new Point(sp.x,sp.y));
            sp.addEventListener(MouseEvent.CLICK,this.onClick);
            sp.buttonMode = true;
            this.vecTxt.push(t);
            i++;
         }
         this.spEff = new Sprite();
         addChild(this.spEff);
         this.shMaskCircle = new Shape();
         this.shMaskCircle.graphics.beginFill(0,0);
         this.shMaskCircle.graphics.drawCircle(0,0,70);
         this.shMaskCircle.graphics.endFill();
         addChild(this.shMaskCircle);
         this.shMaskCircle.x = 366;
         this.shMaskCircle.y = 215;
         this.spEff.mask = this.shMaskCircle;
         Utils.loadTitle("lang/ch/LingQiWH.swf","ShuiJinQiu",new Bitmap(),{
            "x":225,
            "y":72
         },this);
         i = 0;
         while(i < 5)
         {
            addChild(this.vecSP[i]);
            i++;
         }
         this.selectSP = this.vecSP[0];
         spTemp = new Sprite();
         spTemp.graphics.beginFill(0,0);
         spTemp.graphics.drawCircle(0,0,70);
         spTemp.graphics.endFill();
         addChild(spTemp);
         spTemp.x = 366;
         spTemp.y = 215;
         TipManager.bind(spTemp,"<font color=\'#bcb370\'>1.</font>每次捐灵可为全服增加<font color=\'#ffff33\'>1点</font>灵气<font color=\'#ff3333\'>（低于世界等级15级不增加灵气）</font>。<br><font color=\'#bcb370\'>2.</font>每天的<font color=\'#ffff33\'>14点30分</font>，根据灵气的多少召唤出不同等级的<font color=\'#33ff33\'>世界boss-武魂</font>。<br><font color=\'#bcb370\'>3.</font>0-150灵气，<font color=\'#7777ff\'>人级武魂</font><br>   151-600灵气，<font color=\'#7777ff\'>地级武魂</font><br>   601-1200灵气，<font color=\'#7777ff\'>天级武魂</font><br>   1201以上灵气，<font color=\'#7777ff\'>仙级武魂</font><br><font color=\'#bcb370\'>4.</font>当召唤出世界boss后，当前灵气清零。");
         this.shMaskRect = new Shape();
         this.shMaskRect.graphics.beginFill(0,0.5);
         this.shMaskRect.graphics.drawRect(0,0,155,135);
         this.shMaskRect.graphics.endFill();
         this.shMaskRect.x = 290;
         this.shMaskRect.y = this.MASK_Y1;
         this.spEff.addChild(this.shMaskRect);
         this.spEffWave = new Sprite();
         this.spEffWave.x = 290;
         this.spEff.addChild(this.spEffWave);
         this.shMaskNumber = new Shape();
         this.shMaskNumber.graphics.beginFill(16777215,0.5);
         this.shMaskNumber.graphics.drawRect(0,0,89,20);
         this.shMaskNumber.graphics.endFill();
         this.shMaskNumber.x = 324;
         this.shMaskNumber.y = 277;
         addChild(this.shMaskNumber);
         this.spNumber = new Sprite();
         this.spNumber.x = this.shMaskNumber.x;
         this.spNumber.y = this.shMaskNumber.y;
         addChild(this.spNumber);
         this.spNumber.mask = this.shMaskNumber;
         this.update();
         this.selectHight();
      }
      
      private function selectHight() : void
      {
         var vec:Vector.<Vo_valuable> = null;
         if(!this.txtTimes && !this._lingQiWuHunVO)
         {
            return;
         }
         var i:int = 3;
         while(i >= 0)
         {
            vec = CommandManager.get_bag_vec(Enum_filter.ID,null,[this.idArr[i]]);
            if(Boolean(vec.length))
            {
               if(this.vecSP.indexOf(this.selectSP) != i + 1)
               {
                  this.vecSP[i + 1].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               }
               return;
            }
            i--;
         }
         if(this.vecSP.indexOf(this.selectSP) != 4)
         {
            this.vecSP[4].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      protected function btnOnClick(e:MouseEvent) : void
      {
         var index:int;
         var vec:Vector.<Vo_valuable> = null;
         if(this.isRunning)
         {
            return;
         }
         index = this.vecSP.indexOf(this.selectSP);
         if(GameUnitManager.hero.level < 30)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10329",1) + "</font>");
            return;
         }
         if(index > 0)
         {
            vec = CommandManager.get_bag_vec(Enum_filter.ID,null,[this.idArr[index - 1]]);
            if(Boolean(vec.length))
            {
               LingQiWuHunCGMessage.CG_JUANXIAN_LINGQI(vec[0].id);
            }
            else
            {
               View_Alert.show("您的" + this.vecPai[index] + "不足，前往秘境可轻松获得，是否前往？",View_Alert.OK_CANCAL,function():void
               {
                  UIManager.sm_shop.visible = true;
               });
            }
         }
         else if(this.vecSP.indexOf(this.selectSP) == 0)
         {
            LingQiWuHunCGMessage.CG_JUANXIAN_LINGQI(0);
         }
      }
      
      private function checkPostion(p:Point) : int
      {
         var i:int = 0;
         while(i < this.vecPosition.length)
         {
            if(p.x == this.vecPosition[i].x && p.y == this.vecPosition[i].y)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      protected function onClick(e:MouseEvent) : void
      {
         this.point.x = e.target.x;
         this.point.y = e.target.y;
         this.runTimes = this.checkPostion(this.point);
         if(this.runTimes == -1 || this.runTimes == 0 || this.isRunning)
         {
            return;
         }
         this.selectSP = e.target as Sprite;
         this.isRunning = true;
         this.go();
      }
      
      private function getPoint(index:int) : Point
      {
         var i:int = index;
         if(index < 0)
         {
            i = 5 - Math.abs(index);
         }
         return this.vecPosition[i];
      }
      
      private function go() : void
      {
         var index:int = 0;
         var i:int = 0;
         var j:int = 0;
         var xa:Array = null;
         var ya:Array = null;
         i = 0;
         while(i < this.vecSP.length)
         {
            xa = [];
            ya = [];
            j = 0;
            while(j < this.runTimes)
            {
               this.point.x = this.vecSP[i].x;
               this.point.y = this.vecSP[i].y;
               index = this.checkPostion(this.point);
               this.p1 = this.getPoint(index - j);
               this.p2 = this.getPoint(index - j - 1);
               xa.push([this.p1.x,this.p2.x]);
               ya.push([this.p1.y,this.p2.y]);
               j++;
            }
            this.tweenToto(this.vecSP[i],500,{
               "x":xa,
               "y":ya
            },this.onComplete);
            this.vecTxt[i].alpha = 0;
            i++;
         }
         this.count = 0;
         this.removeEff();
      }
      
      private function onComplete() : void
      {
         var i:int = 0;
         ++this.count;
         if(this.count == 5)
         {
            this.isRunning = false;
            this.updateTxt();
            i = 0;
            while(i < 5)
            {
               this.vecTxt[i].alpha = 1;
               i++;
            }
            this.addEff();
         }
      }
      
      public function playEffect() : void
      {
         var spTemp:Sprite = null;
         var bmTemp:Bitmap = null;
         if(!this.selectSP || this.isRunning)
         {
            return;
         }
         spTemp = new Sprite();
         bmTemp = ComponentUtil.getBitmap(this.vecStr[this.vecSP.indexOf(this.selectSP)],spTemp,null,Utils.swfPool["lang/ch/LingQiWH.swf"]);
         bmTemp.x = -bmTemp.width / 2;
         bmTemp.y = -bmTemp.height / 2;
         spTemp.x = this.selectSP.x + bmTemp.width / 2;
         spTemp.y = this.selectSP.y + bmTemp.height / 2;
         addChild(spTemp);
         Tween.to(spTemp,500,{
            "x":[spTemp.x,370],
            "y":[spTemp.y,220],
            "alpha":[1,0.5]
         },function():void
         {
            Tween.to(spTemp,700,{
               "alpha":[0.5,0],
               "scaleX":[1,5],
               "scaleY":[1,5]
            },function(taget:DisplayObject):void
            {
               if(Boolean(taget.parent))
               {
                  removeChild(taget);
               }
            },null,Tween.SIN);
         },null);
      }
      
      private function addEff() : void
      {
         this.removeEff();
         if(!visible)
         {
            return;
         }
         var index:int = this.vecSP.indexOf(this.selectSP);
         if(index != -1)
         {
            this.effCircle = EffectManager.addEffect(this.vecEffStr[index],this.selectSP,1000,35,35,true);
         }
         if(!this.effStar)
         {
            this.effStar = EffectManager.addEffect("35152",this.spEff,2000,366,210,true);
            this.effWave = EffectManager.addEffect("35153",this.spEffWave,1000,75,67,true);
            this.effStar.mask = this.shMaskRect;
         }
         if(Boolean(this._lingQiWuHunVO))
         {
            this.spEffWave.y = this.shMaskRect.y = this.MASK_Y2 - this.MASK_HEIGHT * (this._lingQiWuHunVO.curIntegral % this.CUR_INTEGRAL / this.CUR_INTEGRAL);
         }
      }
      
      private function removeEff() : void
      {
         if(Boolean(this.effCircle))
         {
            EffectManager.removeEffect(this.effCircle);
            this.effCircle = null;
         }
         if(Boolean(this.effStar) && !visible)
         {
            EffectManager.removeEffect(this.effStar);
            this.effStar.mask = null;
            this.effStar = null;
         }
         if(Boolean(this.effWave) && !visible)
         {
            EffectManager.removeEffect(this.effWave);
            this.effWave = null;
         }
      }
      
      private function update() : void
      {
         if(Boolean(this.txtTimes) && Boolean(this._lingQiWuHunVO))
         {
            this.txtTimes.htmlText = "<font color=\'#FECB00\'>今日可捐献灵气</font><font color=\'#FA4C00\'>" + (3 - this._lingQiWuHunVO.juanXianTimes) + "次</font>";
            if(this._lingQiWuHunVO.juanXianTimes > 2)
            {
               this.btn.mouseEnabled = false;
               this.btn.filters = Util.disabled;
            }
            else
            {
               this.btn.mouseEnabled = true;
               this.btn.filters = [];
            }
            this.addEff();
            this.updateTxt();
            this.updateNumber();
         }
      }
      
      private function updateNumber() : void
      {
         var i:int = 0;
         var ni:NumberItem = null;
         var s:String = null;
         var k:int = 0;
         if(!this._lingQiWuHunVO || Boolean(this.vecNI.length) && Boolean(this.lastTime == this._lingQiWuHunVO.curIntegral))
         {
            return;
         }
         s = this._lingQiWuHunVO.curIntegral.toString();
         var l:int = String(this._lingQiWuHunVO.curIntegral).length;
         if(l < this.vecNI.length)
         {
            k = this.vecNI.length - l;
            i = 0;
            while(i < k)
            {
               ni = this.vecNI.pop();
               if(this.spNumber.contains(ni))
               {
                  this.spNumber.removeChild(ni);
               }
               i++;
            }
         }
         else if(l != this.vecNI.length)
         {
            if(l > this.vecNI.length)
            {
               k = l - this.vecNI.length;
               i = 0;
               while(i < k)
               {
                  ni = new NumberItem();
                  this.vecNI.unshift(ni);
                  this.spNumber.addChild(ni);
                  i++;
               }
            }
         }
         i = 0;
         while(i < this.vecNI.length)
         {
            this.vecNI[i].x = i * this.NUMBER_WID;
            this.vecNI[i].curNumber(int(s.charAt(i)),i);
            if(this._lingQiWuHunVO.curIntegral >= 0)
            {
               this.vecNI[i].go(int(s.charAt(i)));
            }
            i++;
         }
         this.spNumber.x = this.shMaskNumber.x + (this.shMaskNumber.width - this.spNumber.width) / 2;
         this.lastTime = this._lingQiWuHunVO.curIntegral;
         this.counter = 0;
      }
      
      public function play() : void
      {
         var s1:Sprite = null;
         var s2:Sprite = null;
         var b:Bitmap = null;
         var i:int = 0;
         ++this.counter;
         if(this.counter == String(this._lingQiWuHunVO.curIntegral).length)
         {
            s1 = new Sprite();
            s2 = new Sprite();
            s2.addChild(s1);
            addChild(s2);
            i = 0;
            while(i < this.vecNI.length)
            {
               b = ComponentUtil.getBitmap(String(this._lingQiWuHunVO.curIntegral).charAt(i),s1,null,Utils.swfPool["lang/ch/LingQiWH.swf"]);
               b.x = i * this.NUMBER_WID;
               i++;
            }
            s1.x = -s1.width / 2;
            s1.y = -s1.height / 2;
            s2.x = this.spNumber.x + s1.width / 2;
            s2.y = this.spNumber.y + s1.height / 2;
            Tween.to(s2,700,{
               "alpha":[1,0],
               "scaleX":[1,5],
               "scaleY":[1,5]
            },function(taget:DisplayObject):void
            {
               if(Boolean(taget.parent))
               {
                  removeChild(taget);
               }
            },null,Tween.SIN);
         }
      }
      
      public function test(value:int) : void
      {
         this._lingQiWuHunVO.curIntegral += value;
         this.updateNumber();
         this.addEff();
      }
      
      private function updateTxt() : void
      {
         var index:int = 0;
         var val:Number = NaN;
         var t:int = 0;
         var v:Number = NaN;
         if(this.isRunning || !this._lingQiWuHunVO)
         {
            return;
         }
         var i:int = 0;
         while(i < 5)
         {
            if(i == 0)
            {
               this.vecTxt[i].filters = [];
            }
            else
            {
               this.vecTxt[i].filters = Util.disabled;
            }
            this.point.x = this.vecSP[i].x;
            this.point.y = this.vecSP[i].y;
            index = this.checkPostion(this.point);
            val = 1 + i * 0.25;
            t = this._lingQiWuHunVO.juanXianTimes;
            if(t == 3)
            {
               t = 0;
            }
            v = Data_lib.jljy[GameUnitManager.hero.level][t] * val;
            this.vecTxt[index].htmlText = "<font color=\"#eff26d\">奖励：</font>经验" + v + "<br><font color=\"#eff26d\">消耗：</font>" + this.vecPai[i];
            i++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(this.firstTime)
         {
            this.firstTime = false;
            Utils.loadTitle("lang/ch/LingQiWH.swf","BiaoTi_txt",new Bitmap(),{
               "x":286,
               "y":5
            },this,this.Init);
         }
         if(value)
         {
            this.update();
            this.selectHight();
         }
         else
         {
            this.removeEff();
         }
      }
      
      private function tweenToto(target:Object, time:int, propertie:Object, complete:Function = null) : void
      {
         var thread:Thread = null;
         var key:String = null;
         thread = pool.length > 0 ? pool.pop() : new Thread();
         thread.target = target;
         list.push(thread);
         thread.beginTime = getTimer();
         thread.totleTime = time;
         thread.propertie = [];
         for(key in propertie)
         {
            thread.propertie.push([key,propertie[key]]);
         }
         thread.times = thread.propertie[0][1].length;
         thread.complete = complete;
         if(!GameScene.instance.hasFrameCallBack(run))
         {
            GameScene.instance.addFrameCallBack(run);
         }
         run();
      }
      
      public function get lingBtn() : MainUIBtn
      {
         return this._lingBtn;
      }
   }
}

import com.utils.ComponentUtil;
import com.yiTian.manager.UIManager;
import com.yiTian.utils.Tween;
import com.yiTian.utils.Utils;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

class Thread
{
   
   public var target:Object;
   
   public var beginTime:int;
   
   public var totleTime:int;
   
   public var propertie:Array;
   
   public var complete:Function;
   
   public var times:int;
   
   public function Thread()
   {
      super();
   }
}

class BitmapNumber extends Bitmap
{
   
   private static var pool:Vector.<Vector.<BitmapNumber>>;
   
   public var index:int;
   
   public function BitmapNumber(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false)
   {
      super(bitmapData,pixelSnapping,smoothing);
   }
   
   public static function getBitmap(value:int) : BitmapNumber
   {
      var bn:BitmapNumber = null;
      var i:int = 0;
      if(!pool)
      {
         pool = new Vector.<Vector.<BitmapNumber>>();
         i = 0;
         while(i < 10)
         {
            pool.push(new Vector.<BitmapNumber>());
            i++;
         }
      }
      if(Boolean(pool[value].length))
      {
         bn = pool[value].pop();
      }
      else
      {
         bn = new BitmapNumber();
      }
      return bn;
   }
   
   public function setNumber(value:int) : void
   {
      this.bitmapData = ComponentUtil.getBitmapData(String(value),Utils.swfPool["lang/ch/LingQiWH.swf"]);
      this.index = value;
   }
   
   public function dispose() : void
   {
      pool[this.index].push(this);
   }
}

class NumberItem extends Sprite
{
   
   private const NUMBER_HEI:int = 18;
   
   private var _num:int;
   
   private var container:Sprite;
   
   private var vecNB:Vector.<BitmapNumber> = new Vector.<BitmapNumber>();
   
   private var lastNumber:int;
   
   private var index:int;
   
   private var _pos:int;
   
   private var times:int;
   
   private const TIMES:int = 10;
   
   private const MILLISECOND:Number = 1000;
   
   public function NumberItem()
   {
      super();
      this.container = new Sprite();
      addChild(this.container);
   }
   
   public function curNumber(num:int, pos:int) : void
   {
      var bn:BitmapNumber = null;
      var i:int = 0;
      var temp:int = 0;
      this.container.y = 0;
      this._num = num;
      this._pos = pos;
      var l:int = int(this.vecNB.length);
      i = 0;
      while(i < l)
      {
         bn = this.vecNB.pop();
         if(this.container.contains(bn))
         {
            this.container.removeChild(bn);
         }
         bn.dispose();
         i++;
      }
      i = 0;
      while(i < 2)
      {
         temp = this.lastNumber + i;
         if(temp > 9)
         {
            temp = 0;
         }
         bn = BitmapNumber.getBitmap(temp);
         bn.setNumber(temp);
         this.vecNB.push(bn);
         bn.y = (this.vecNB.length - 1) * this.NUMBER_HEI;
         this.container.addChild(bn);
         i++;
      }
   }
   
   public function go(value:int) : void
   {
      var stopX:int;
      var t:int = String(UIManager.lingQiWuHunPanel.lingQiWuHunVO.curIntegral).length;
      this.times = value - this.lastNumber + this.TIMES;
      stopX = this.times * this.NUMBER_HEI;
      this.index = 1;
      Tween.to(this.container,this.MILLISECOND + 1000 * ((7 - this._pos) / 7),{"y":[this.container.y,this.container.y - stopX]},function():void
      {
         UIManager.lingQiWuHunPanel.play();
      },function():void
      {
         var temp:int = 0;
         if(index <= Math.abs(container.y / NUMBER_HEI))
         {
            ++index;
            vecNB[0].y = vecNB[vecNB.length - 1].y + NUMBER_HEI;
            vecNB.push(vecNB.shift());
            if(index == times)
            {
               vecNB[1].setNumber(lastNumber);
            }
            else
            {
               temp = vecNB[0].index + 1;
               if(temp > 9)
               {
                  temp = 0;
               }
               vecNB[1].setNumber(temp);
            }
         }
      },Tween.EASYINOUT);
      this.lastNumber = value;
   }
}
