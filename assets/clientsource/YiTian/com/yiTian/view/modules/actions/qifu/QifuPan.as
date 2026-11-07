package com.yiTian.view.modules.actions.qifu
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.setTimeout;
   import flashx.textLayout.formats.TextAlign;
   
   public class QifuPan extends Panel123
   {
      
      public static var jifenTf:MyTextField;
      
      public static var jifenCount:int;
      
      private static const SHURU_YUANBAO:String = "输入元宝";
      
      private static const desCrip:String = "已经累计祈福了{0}次，\n每累计刷新200次可累积一颗祈福星";
      
      public static var isFirstOpen:Boolean = true;
      
      private static var _timeCount:int = 0;
      
      public static var isVis:Boolean = false;
      
      private var i:int;
      
      private var j:int;
      
      private var childStart:Child_start;
      
      private var childQifuStart:Child_qifuStart;
      
      private var childGrid:Child_grid;
      
      private var gridVec:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var tfInput:MyTextField;
      
      private var maskA:Sprite;
      
      private var maskB:Sprite;
      
      private var conA:Sprite;
      
      private var conB:Sprite;
      
      private var leftCon:Sprite;
      
      private var childJF:Child_jifenPan;
      
      private var myInfo:Array = [];
      
      private var worldInfo:Array = [];
      
      private var mytxtItem:Array = [];
      
      private var GltxtItem:Array = [];
      
      public function QifuPan()
      {
         super();
         regResource("lang/ch/QiFu.swf","QiFudm");
      }
      
      public static function shanEff() : void
      {
         var count:int;
         var color:String = null;
         if(_timeCount % 2 == 0)
         {
            color = "#fe0000";
         }
         else
         {
            color = "#f9ff00";
         }
         jifenTf.htmlText = HtmlUtil.font(jifenCount.toString(),color,14);
         if(_timeCount >= 3)
         {
            _timeCount = 0;
            return;
         }
         ++_timeCount;
         count = int(setTimeout(function():void
         {
            var t:* = setTimeout(function():void
            {
               shanEff();
            },37);
         },37));
      }
      
      override protected function initUI2() : void
      {
         var masLeftCon:Sprite;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":661,
            "height":480
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_QiFu",this,{
            "x":250,
            "y":5
         },Global.QiFudm);
         move = new Rectangle(0,0,658,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":624,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         initDynamicView();
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":612,
            "height":432
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":27,
            "y":43,
            "width":379,
            "height":426
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back4",[3,3,1,1],this,{
            "x":409,
            "y":43,
            "width":224,
            "height":426
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("BG_QF",this,{
            "x":30,
            "y":44 + 46
         },Global.QiFudm);
         ComponentUtil.getBitmap("BG_QF",this,{
            "x":30,
            "y":44
         },Global.QiFudm);
         ComponentUtil.getScaleBitmap("Back_ChuangWen",[11,11,1,1],this,{
            "x":411,
            "y":67,
            "width":220,
            "height":187
         },Global.QiFudm);
         ComponentUtil.getScaleBitmap("Back_ChuangWen",[11,11,1,1],this,{
            "x":410,
            "y":277,
            "width":222,
            "height":190
         },Global.QiFudm);
         ComponentUtil.getBitmap("BG_WDQiFu",this,{
            "x":411,
            "y":45
         },Global.QiFudm);
         ComponentUtil.getBitmap("BG_WDQiFu",this,{
            "x":411,
            "y":255
         },Global.QiFudm);
         ComponentUtil.getBitmap("Text_WDQiFu",this,{
            "x":486,
            "y":44
         },Global.QiFudm);
         ComponentUtil.getBitmap("Text_QFGongGao",this,{
            "x":486,
            "y":254
         },Global.QiFudm);
         this.leftCon = new Sprite();
         addChild(this.leftCon);
         ComponentUtil.setPropertie(this.leftCon,{"x":0});
         masLeftCon = new Sprite();
         masLeftCon.graphics.beginFill(0,1);
         masLeftCon.graphics.drawRect(0,0,300,480);
         masLeftCon.graphics.endFill();
         addChild(masLeftCon);
         ComponentUtil.setPropertie(masLeftCon,{"x":-295});
         this.leftCon.mask = masLeftCon;
         this.childJF = new Child_jifenPan();
         this.leftCon.addChild(this.childJF);
         this.maskA = new Sprite();
         this.maskA.graphics.beginFill(0,1);
         this.maskA.graphics.drawRect(0,0,221,185);
         this.maskA.graphics.endFill();
         addChild(this.maskA);
         ComponentUtil.setPropertie(this.maskA,{
            "x":411,
            "y":68
         });
         this.maskB = new Sprite();
         this.maskB.graphics.beginFill(0,1);
         this.maskB.graphics.drawRect(0,0,218,187);
         this.maskB.graphics.endFill();
         addChild(this.maskB);
         ComponentUtil.setPropertie(this.maskB,{
            "x":411,
            "y":278
         });
         this.conA = new Sprite();
         addChild(this.conA);
         this.conB = new Sprite();
         addChild(this.conB);
         this.conA.mask = this.maskA;
         this.conB.mask = this.maskB;
         ComponentUtil.setPropertie(this.conA,{
            "x":424,
            "y":71
         });
         ComponentUtil.setPropertie(this.conB,{
            "x":424,
            "y":283
         });
         this.childGrid = new Child_grid();
         addChild(this.childGrid);
         ComponentUtil.setPropertie(this.childGrid,{
            "x":60,
            "y":83
         });
         this.childQifuStart = new Child_qifuStart();
         addChild(this.childQifuStart);
         ComponentUtil.setPropertie(this.childQifuStart,{
            "x":60,
            "y":366 + 54
         });
         this.childStart = new Child_start();
         addChild(this.childStart);
         ComponentUtil.setPropertie(this.childStart,{
            "x":82,
            "y":420
         });
         this.childStart.visible = false;
         ComponentUtil.getTextField("元宝：",this,{
            "x":41,
            "y":54,
            "color":3461909,
            "size":12,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Back_JiangJinChi",[4,5,1,1],this,{
            "x":78,
            "y":54,
            "width":78,
            "height":20
         },Global.QiFudm);
         this.tfInput = ComponentUtil.getTextField(SHURU_YUANBAO,this,{
            "x":84,
            "y":55,
            "color":16776960,
            "size":12,
            "leading":0,
            "realWidth":66,
            "maxChars":7,
            "restrict":"0-9"
         });
         ComponentUtil.getButton("","Button_YBChongZhi",this,{
            "x":312,
            "y":49,
            "textColor":16771436,
            "callBack":function():void
            {
               UIManager.yuanBaoXiang.visible = !UIManager.yuanBaoXiang.visible;
            }
         },Global.QiFudm);
         ComponentUtil.getBitmap("Text_WDJF",this,{
            "x":126 - 26,
            "y":364 + 7
         },Global.QiFudm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":214 - 26,
            "y":364 + 7,
            "width":88,
            "height":22
         },Global.Img_Cdm);
         jifenTf = ComponentUtil.getTextField("2000000",this,{
            "x":228 - 36,
            "y":364 + 7,
            "color":16776960,
            "size":14,
            "leading":0,
            "realWidth":80,
            "align":TextAlign.CENTER
         });
         jifenTf.mouseEnabled = true;
         TipManager.bind(jifenTf,"祈福一次可获得10点积分");
         ComponentUtil.getButton("兑换","Button_Two",this,{
            "x":326 - 26,
            "y":363 + 7,
            "textColor":16771436,
            "callBack":function():void
            {
               Tween.to(leftCon,200,{"x":[0,-299]});
               childJF.toTop();
            }
         },Global.Img_Cdm);
      }
      
      public function update(_myInfo:Array, _worldInfo:Array, _curTimes:int = 0, startNum:int = 0) : void
      {
         var ss:String = null;
         var txtI:TxtGongGaoItem = null;
         var __ss:String = null;
         var _txtI:TxtGongGaoItem = null;
         this.reset();
         this.myInfo = _myInfo;
         this.worldInfo = _worldInfo;
         var lenM:int = int(_myInfo.length);
         var lenW:int = int(_worldInfo.length);
         this.i = 0;
         while(this.i < lenM)
         {
            ss = _myInfo[this.i];
            txtI = TxtGongGaoItem.instance;
            txtI.update(ss);
            this.mytxtItem.push(txtI);
            this.conA.addChild(txtI);
            ++this.i;
         }
         this.i = 0;
         while(this.i < lenW)
         {
            __ss = _worldInfo[this.i];
            _txtI = TxtGongGaoItem.instance;
            _txtI.update(__ss);
            this.GltxtItem.push(_txtI);
            this.conB.addChild(_txtI);
            ++this.i;
         }
         this.resize();
         jifenCount = startNum;
         jifenTf.htmlText = startNum.toString();
         var sstt:String = desCrip.replace("{0}",HtmlUtil.font(_curTimes.toString(),"#f9ff00"));
         TipManager.bind(this.childStart,sstt);
      }
      
      public function releaseJifen(__type:int) : void
      {
         var dic:Dictionary = Data_lib.qfduihuan;
         var costJifen:int = int(dic[__type][1]);
         jifenCount -= costJifen;
         jifenTf.htmlText = jifenCount.toString();
      }
      
      public function setTipsPos(disPlayObj:DisplayObject) : void
      {
         var p:Point = localToGlobal(new Point(this.leftCon.x,this.leftCon.y));
         disPlayObj.x = p.x + this.leftCon.width / 2;
      }
      
      private function reset() : void
      {
         var txtIF:TxtGongGaoItem = null;
         var _txtIF:TxtGongGaoItem = null;
         if(!this.mytxtItem || !this.GltxtItem)
         {
            return;
         }
         this.i = 0;
         while(this.i < this.mytxtItem.length)
         {
            txtIF = this.mytxtItem[this.i];
            txtIF.dispose();
            ++this.i;
         }
         this.i = 0;
         while(this.i < this.GltxtItem.length)
         {
            _txtIF = this.GltxtItem[this.i];
            _txtIF.dispose();
            ++this.i;
         }
         this.mytxtItem = [];
         this.GltxtItem = [];
      }
      
      public function setData(arrM:Array, arrG:Array, _curTimes:int = 0, startNum:int = 0) : void
      {
         this.myInfo = arrM;
         this.worldInfo = arrG;
         jifenCount = startNum;
         jifenTf.htmlText = startNum.toString();
         var ss:String = desCrip.replace("{0}",HtmlUtil.font(_curTimes.toString(),"#f9ff00"));
         TipManager.bind(this.childStart,ss);
      }
      
      private function movetoIndex(__index:int, __count:int, func:Function) : void
      {
         this.childGrid.beginMove(__index,__count,func);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         isVis = value;
         if(value)
         {
            this.childGrid.showVisEf();
            this.callB();
            GameScene.instance.addFrameCallBack(this.callB);
         }
         else
         {
            GameScene.instance.removeFrameCallBack(this.callB);
         }
      }
      
      private function callB() : void
      {
         this.tfInput.text = GameUnitManager.hero.money.toString();
      }
      
      public function run(arr:Array, func:Function) : void
      {
         var indexArr:Array = null;
         var _zIndex:int = 0;
         var _count:int = 0;
         if(!arr || !arr.length)
         {
            return;
         }
         var len:int = int(arr.length);
         if(len == 1)
         {
            indexArr = arr[0];
            _zIndex = int(indexArr[0]);
            _count = int(indexArr[0]);
            this.movetoIndex(_zIndex,_count,func);
         }
         else
         {
            this.childGrid.fastMove(arr,func);
         }
      }
      
      private function resize() : void
      {
         var txtIF:TxtGongGaoItem = null;
         var _txtIF:TxtGongGaoItem = null;
         var nowH1:int = 0;
         var nowH2:int = 0;
         this.i = 0;
         while(this.i < this.mytxtItem.length)
         {
            txtIF = this.mytxtItem[this.i];
            txtIF.y = nowH1;
            nowH1 += txtIF.height;
            ++this.i;
         }
         this.i = 0;
         while(this.i < this.GltxtItem.length)
         {
            _txtIF = this.GltxtItem[this.i];
            _txtIF.y = nowH2;
            nowH2 += _txtIF.height;
            ++this.i;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 660) / 2;
         y = (Global.stage.stageHeight - 480) / 2;
      }
   }
}

