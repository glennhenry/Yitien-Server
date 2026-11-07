package com.yiTian.view.modules.wuXing
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.WuxingCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.specialBtnDill.Model_specialD;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flashx.textLayout.formats.TextAlign;
   
   public class WuxingPan extends Panel123
   {
      
      public static var layers:int;
      
      private static var glowFFFF00:Array = [new GlowFilter(16776960,0.9,15,15,1,33)];
      
      public static var attrArr:Array = [];
      
      public static var isUseNew:Boolean = false;
      
      public static var isChooseBack:Boolean = false;
      
      private var tabtnVec:Vector.<TabButton> = new Vector.<TabButton>();
      
      private var bmVecF:Vector.<Bitmap> = new Vector.<Bitmap>();
      
      private var bmVecS:Vector.<Bitmap> = new Vector.<Bitmap>();
      
      private var bmVecT:Vector.<Bitmap> = new Vector.<Bitmap>();
      
      private var bmTYpe:Bitmap;
      
      private var i:int;
      
      private var maskTotal:Sprite;
      
      private var mskSingle:Sprite;
      
      private var chongR:Bitmap;
      
      private var chongT:Bitmap;
      
      private var chongRcontain:Sprite;
      
      private var chongTContainer:Sprite;
      
      private var chongTxt:Bitmap;
      
      private var danyaoitemVec:Vector.<DanYaoItem> = new Vector.<DanYaoItem>();
      
      private var containIconType:Sprite;
      
      private var _weiTiaoY:int = 50;
      
      private var spContainer:Sprite;
      
      private var now:TabButton;
      
      private var nowDyI:DanYaoItem;
      
      private var singleTf:MyTextField;
      
      private var totalTf:MyTextField;
      
      private var totalWorth_s:int;
      
      private var totalWorth_t:int;
      
      private var totalWorth_att:int;
      
      private var singleWorthArr:Array = [];
      
      public function WuxingPan()
      {
         super();
         regResource("lang/ch/WuXing_Imgs.swf","WuXing_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         var prog:Bitmap;
         var pro:Bitmap;
         var b:Button;
         var introtf:MyTextField;
         var stypeS:String = null;
         var p:Object = null;
         var tab:TabButton = null;
         var dyItem:DanYaoItem = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":688,
            "height":460 + this._weiTiaoY
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":640,
            "height":460
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":34,
            "y":80,
            "width":620,
            "height":410
         },Global.Img_Cdm);
         move = new Rectangle(0,0,667,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":654,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         initDynamicView();
         this.spContainer = new Sprite();
         this.spContainer = new Sprite();
         addChild(this.spContainer);
         ComponentUtil.setPropertie(this.spContainer,{
            "x":10,
            "y":this._weiTiaoY - 10
         });
         ComponentUtil.getBitmap("WuXingBack",this.spContainer,{
            "x":34,
            "y":50
         },Global.WuXing_Imgsdm);
         ComponentUtil.getBitmap("Text_ZhanLi",this.spContainer,{
            "x":42,
            "y":58
         },Global.WuXing_Imgsdm);
         this.i = 0;
         while(this.i < 10)
         {
            this.bmVecF.push(ComponentUtil.getBitmap("Num_9",this.spContainer,{
               "x":111 + this.i * 11,
               "y":58
            },Global.WuXing_Imgsdm));
            ++this.i;
         }
         this.i = 0;
         while(this.i < 6)
         {
            this.bmVecS.push(ComponentUtil.getBitmap("Num_9",this.spContainer,{
               "x":513 + this.i * 11,
               "y":82
            },Global.WuXing_Imgsdm));
            ++this.i;
         }
         this.i = 0;
         while(this.i < 6)
         {
            this.bmVecT.push(ComponentUtil.getBitmap("Num_9",this.spContainer,{
               "x":527 + this.i * 11,
               "y":106
            },Global.WuXing_Imgsdm));
            ++this.i;
         }
         this.i = 0;
         while(this.i < 5)
         {
            stypeS = WuXingMter.tabStyArr[this.i];
            p = WuXingMter.tabPropertyArr[this.i];
            tab = ComponentUtil.getTabButton("",stypeS,this.spContainer,{
               "x":p.x,
               "y":p.y,
               "tabIndex":this.i + 1,
               "textColor":16773818,
               "chooseColor":16773818
            },Global.WuXing_Imgsdm);
            this.tabtnVec[this.i] = tab;
            tab.addEventListener(MouseEvent.CLICK,this.tabChanged);
            tab.addEventListener(MouseEvent.MOUSE_OVER,this.overHd);
            tab.addEventListener(MouseEvent.MOUSE_OUT,this.outHd);
            ++this.i;
         }
         this.chongRcontain = new Sprite();
         this.spContainer.addChild(this.chongRcontain);
         EffectManager.addEffect("35181",this.chongRcontain,750,12,13,true);
         ComponentUtil.setPropertie(this.chongRcontain,{
            "x":198,
            "y":230
         });
         this.chongR = ComponentUtil.getBitmap("WXIcon_Lv1",this.chongRcontain,{
            "x":0,
            "y":0
         },Global.WuXing_Imgsdm);
         this.i = 0;
         while(this.i < 2)
         {
            dyItem = new DanYaoItem();
            ComponentUtil.setPropertie(dyItem,{
               "x":390,
               "y":169 + 65 * this.i
            });
            this.spContainer.addChild(dyItem);
            dyItem.init(this.i);
            this.danyaoitemVec.push(dyItem);
            dyItem.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
            {
               var dyI:DanYaoItem = null;
               if(!(e.target is DanYaoItem))
               {
                  dyI = e.target.parent;
               }
               else
               {
                  dyI = e.target as DanYaoItem;
               }
               if(Boolean(nowDyI))
               {
                  nowDyI.choose = false;
               }
               dyI.choose = true;
               nowDyI = dyI;
            });
            ++this.i;
         }
         ComponentUtil.getBitmap("Text_XiuLianZhi",this.spContainer,{
            "x":40,
            "y":416
         },Global.WuXing_Imgsdm);
         ComponentUtil.getBitmap("Text_XLZ",this.spContainer,{
            "x":473,
            "y":106
         },Global.WuXing_Imgsdm);
         ComponentUtil.getBitmap("Text_Level",this.spContainer,{
            "x":473,
            "y":82
         },Global.WuXing_Imgsdm);
         ComponentUtil.getButton("","Button_XiuLian",this.spContainer,{
            "x":445,
            "y":320,
            "textColor":16184781,
            "callBack":this.xiuLianHandler
         },Global.WuXing_Imgsdm);
         ComponentUtil.getBitmap("XLProgressBack",this.spContainer,{
            "x":463,
            "y":134
         },Global.WuXing_Imgsdm);
         prog = ComponentUtil.getBitmap("XLProgress",this.spContainer,{
            "x":465,
            "y":136
         },Global.WuXing_Imgsdm);
         this.mskSingle = new Sprite();
         this.mskSingle.graphics.beginFill(0,0);
         this.mskSingle.graphics.drawRect(0,0,148,10);
         this.mskSingle.graphics.endFill();
         ComponentUtil.setPropertie(this.mskSingle,{
            "x":465,
            "y":136
         });
         this.spContainer.addChild(this.mskSingle);
         prog.mask = this.mskSingle;
         this.chongTContainer = new Sprite();
         ComponentUtil.setPropertie(this.chongTContainer,{
            "x":558,
            "y":401
         });
         this.spContainer.addChild(this.chongTContainer);
         this.chongT = ComponentUtil.getBitmap("WXImg_Lv1",this.chongTContainer,{
            "x":0,
            "y":0
         },Global.WuXing_Imgsdm);
         this.chongTContainer.addEventListener(MouseEvent.MOUSE_OVER,function(e:MouseEvent):void
         {
            var pont:Point = null;
            var _voC:Vo_WuxingC = new Vo_WuxingC();
            _voC.initLib(layers);
            TipManager.update(_voC);
            pont = new Point(chongTContainer.x + chongTContainer.width - 5,chongTContainer.y + chongTContainer.height / 2);
            TipManager.view_tip.x = localToGlobal(pont).x;
            TipManager.view_tip.y = localToGlobal(pont).y + 35;
         });
         this.chongTContainer.addEventListener(MouseEvent.MOUSE_OUT,function(e:MouseEvent):void
         {
            TipManager.hide();
         });
         this.chongTxt = ComponentUtil.getBitmap("Text_Lv1",this.spContainer,{
            "x":570,
            "y":428
         },Global.WuXing_Imgsdm);
         this.containIconType = new Sprite();
         this.spContainer.addChild(this.containIconType);
         ComponentUtil.setPropertie(this.containIconType,{
            "x":392,
            "y":69
         });
         this.bmTYpe = ComponentUtil.getBitmap("Icon_Jin",this.containIconType,{
            "x":0,
            "y":0
         },Global.WuXing_Imgsdm);
         this.containIconType.addEventListener(MouseEvent.MOUSE_MOVE,function(e:MouseEvent):void
         {
            if(!now)
            {
               return;
            }
            e.target.tabIndex = now.tabIndex;
            overHd(e);
         });
         this.containIconType.addEventListener(MouseEvent.MOUSE_OUT,function(e:MouseEvent):void
         {
            outHd(e);
         });
         ComponentUtil.getBitmap("Back_Progress",this.spContainer,{
            "x":140,
            "y":416
         },Global.WuXing_Imgsdm);
         pro = ComponentUtil.getBitmap("Progress",this.spContainer,{
            "x":162,
            "y":422
         },Global.WuXing_Imgsdm);
         this.maskTotal = new Sprite();
         this.maskTotal.graphics.beginFill(0,0);
         this.maskTotal.graphics.drawRect(0,0,374,10);
         this.maskTotal.graphics.endFill();
         ComponentUtil.setPropertie(this.maskTotal,{
            "x":162,
            "y":422
         });
         this.spContainer.addChild(this.maskTotal);
         pro.mask = this.maskTotal;
         this.singleTf = ComponentUtil.getTextField("99/100",this.spContainer,{
            "x":465,
            "y":131,
            "color":16777215,
            "size":12,
            "leading":0,
            "realWidth":150,
            "align":TextAlign.CENTER
         });
         this.totalTf = ComponentUtil.getTextField("000000/000000",this.spContainer,{
            "x":303,
            "y":417,
            "color":16777215,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Title_WuXing",this,{
            "x":254,
            "y":5
         },Global.WuXing_Imgsdm);
         b = ComponentUtil.getButton("","Button_Quest",this.spContainer,{
            "x":610,
            "y":6,
            "textColor":16184781,
            "visible":false
         },Global.Img_Cdm);
         TipManager.bind(b,LangConfig.getWord("1172",0));
         ComponentUtil.getBitmap("Icons_Prompt",this,{
            "x":40,
            "y":49
         },Global.Img_Cdm);
         ComponentUtil.getTextField("五行属性越高，五行伤害也越高，抵挡对应五行伤害也越多（注：五行伤害可大幅度提高战斗伤害）",this,{
            "x":68,
            "y":54,
            "color":16383744,
            "size":12,
            "leading":0
         });
         introtf = ComponentUtil.getTextField("玩法介绍",this,{
            "x":600,
            "y":53,
            "color":16764206,
            "size":12,
            "leading":0,
            "underline":true
         });
         introtf.mouseEnabled = true;
         TipManager.bind(introtf,LangConfig.getWord("1172",0));
      }
      
      private function xiuLianHandler(e:MouseEvent) : void
      {
         var mon:Array = null;
         var _lvl:int = 0;
         var _arr:Array = [44587,44588];
         var _sst:Array = [HtmlUtil.font("凡品五行丹","#04ff00"),HtmlUtil.font("极品五行丹","#de45c7")];
         mon = [10,100];
         var ss:String = WuXingMter.non_descrip.replace("{0}",_sst[this.nowDyI.typeIndex]).replace("{1}",mon[this.nowDyI.typeIndex]);
         var _count:int = CommandManager.get_bag_count(_arr[this.nowDyI.typeIndex]);
         var __stle:int = WuXingMter.style;
         if(WuXingMter.style > 0)
         {
            _lvl = int(this.singleWorthArr[WuXingMter.style][2]);
         }
         if(_lvl == 100)
         {
            UIManager.centerBroadcast.addMsg("已满级");
            return;
         }
         if(!_count)
         {
            UIManager.wuXingProm.show(function():void
            {
               if(GameUnitManager.hero.money < mon[nowDyI.typeIndex])
               {
                  UIManager.centerBroadcast.addMsg("元宝不足");
                  return;
               }
               WuxingCGMessage.CG_XIUXING_WUXING(WuXingMter.style,1,nowDyI.typeIndex);
            },ss,this.nowDyI.typeIndex);
         }
         else
         {
            WuxingPan.isChooseBack = true;
            WuxingCGMessage.CG_XIUXING_WUXING(WuXingMter.style,0,this.nowDyI.typeIndex);
         }
      }
      
      private function tabChanged(e:MouseEvent) : void
      {
         var tab:TabButton = e.target as TabButton;
         if(Boolean(this.now))
         {
            this.now.choose = false;
            this.now.filters = [];
         }
         tab.choose = true;
         this.now = tab;
         this.now.filters = glowFFFF00;
         WuXingMter.style = tab.tabIndex - 1;
         this.changedBm(tab.tabIndex);
      }
      
      private function overHd(e:MouseEvent) : void
      {
         var pont:Point = null;
         var targetObj:Object = e.target as Object;
         if(!attrArr.length)
         {
            return;
         }
         var __vo:Vo_wuXing = attrArr[targetObj.tabIndex - 1];
         if(__vo == null)
         {
            return;
         }
         TipManager.update(__vo);
         pont = new Point(targetObj.x + targetObj.width - 5,targetObj.y + targetObj.height / 2);
         TipManager.view_tip.x = localToGlobal(pont).x;
         TipManager.view_tip.y = localToGlobal(pont).y + 35;
      }
      
      private function outHd(e:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      private function changedBm(__type:int) : void
      {
         var _worth:int = 0;
         var _totl:int = 0;
         var _lvl:int = 0;
         var _leijiWorth:int = 0;
         this.bmTYpe.bitmapData = ComponentUtil.getBitmapData(WuXingMter.bmStyArr[__type - 1],Global.WuXing_Imgsdm);
         if(Boolean(this.singleWorthArr.length))
         {
            if(__type <= this.singleWorthArr.length && __type >= 1)
            {
               _worth = int(this.singleWorthArr[__type - 1][0]);
               _totl = int(this.singleWorthArr[__type - 1][1]);
               _lvl = int(this.singleWorthArr[__type - 1][2]);
               _leijiWorth = int(this.singleWorthArr[__type - 1][3]);
               this.showLvl(_lvl);
               this.showWorth(_leijiWorth);
               if(_lvl == 100)
               {
                  this.singleTf.htmlText = HtmlUtil.font("满级","#fe0000");
                  this.mskSingle.width = 148 * 1;
               }
               else
               {
                  this.singleTf.text = _worth + "/" + _totl;
                  this.mskSingle.width = 148 * (_worth / _totl);
               }
            }
         }
      }
      
      private function showLvl(_Lv:int) : void
      {
         var bm2:Bitmap = null;
         var str:String = null;
         var s:String = null;
         var b:Bitmap = null;
         for each(bm2 in this.bmVecS)
         {
            bm2.visible = false;
         }
         str = _Lv.toString();
         this.i = 0;
         while(this.i < str.length)
         {
            s = str.charAt(this.i);
            b = this.bmVecS[this.i];
            b.visible = true;
            b.bitmapData = ComponentUtil.getBitmapData("Num_" + s,Global.WuXing_Imgsdm);
            ++this.i;
         }
      }
      
      private function showWorth(_value:int) : void
      {
         var bm3:Bitmap = null;
         var str:String = null;
         var s:String = null;
         var b:Bitmap = null;
         for each(bm3 in this.bmVecT)
         {
            bm3.visible = false;
         }
         str = _value.toString();
         this.i = 0;
         while(this.i < str.length)
         {
            s = str.charAt(this.i);
            b = this.bmVecT[this.i];
            b.visible = true;
            b.bitmapData = ComponentUtil.getBitmapData("Num_" + s,Global.WuXing_Imgsdm);
            ++this.i;
         }
      }
      
      public function showAttrb(value:int) : void
      {
         var s:String = null;
         var b:Bitmap = null;
         var str:String = value.toString();
         this.i = 0;
         while(this.i < str.length)
         {
            s = str.charAt(this.i);
            b = this.bmVecF[this.i];
            b.visible = true;
            b.bitmapData = ComponentUtil.getBitmapData("Num_" + s,Global.WuXing_Imgsdm);
            ++this.i;
         }
      }
      
      private function reset() : void
      {
         var bm1:Bitmap = null;
         var bm2:Bitmap = null;
         var bm3:Bitmap = null;
         this.totalWorth_s = 0;
         this.totalWorth_t = 0;
         this.totalWorth_att = 0;
         this.singleWorthArr = [];
         for each(bm1 in this.bmVecF)
         {
            bm1.visible = false;
         }
         for each(bm2 in this.bmVecS)
         {
            bm2.visible = false;
         }
         for each(bm3 in this.bmVecT)
         {
            bm3.visible = false;
         }
      }
      
      public function show() : void
      {
         this.visible = true;
      }
      
      public function update(dataArr:Array, totalZhanLi:int) : void
      {
         var _arr:Array = null;
         var _sid:int = 0;
         var _worth_s:int = 0;
         var _leiJiWorth_s:int = 0;
         var dic:Dictionary = null;
         var _vo:Vo_wuXing = null;
         var _worth_t:int = 0;
         var _attrbStr:String = null;
         var __a:Array = null;
         var lvl:int = 0;
         this.reset();
         this.i = 0;
         while(this.i < dataArr.length)
         {
            _arr = dataArr[this.i];
            _sid = int(_arr[0]);
            _worth_s = int(_arr[1]);
            _leiJiWorth_s = int(_arr[2]);
            dic = Data_lib.Wuxing_f;
            _vo = new Vo_wuXing();
            _vo.initLib(_sid);
            attrArr[_vo.typeIndex - 1] = _vo;
            _worth_t = int(Data_lib.Wuxing_f[_sid][3]);
            _attrbStr = Data_lib.Wuxing_f[_sid][4];
            __a = _attrbStr.split("_");
            this.totalWorth_s += _leiJiWorth_s;
            this.totalWorth_t += _worth_t;
            this.totalWorth_att += int(__a[1]);
            lvl = int(Data_lib.Wuxing_f[_sid][1]);
            this.singleWorthArr.push([_worth_s,_worth_t,lvl,_leiJiWorth_s]);
            ++this.i;
         }
         layers = WuXingMter.getChongShuWorth(this.totalWorth_s);
         this.showAttrb(totalZhanLi);
         if(layers == 1)
         {
            this.chongTxt.bitmapData = ComponentUtil.getBitmapData("Text_DaiJiHuo",Global.WuXing_Imgsdm);
            this.chongT.bitmapData = ComponentUtil.getBitmapData("WXImg_Lv1",Global.WuXing_Imgsdm);
            this.chongR.bitmapData = ComponentUtil.getBitmapData("WXIcon_Lv1",Global.WuXing_Imgsdm);
         }
         else
         {
            this.chongT.bitmapData = ComponentUtil.getBitmapData("WXImg_Lv" + (layers - 1),Global.WuXing_Imgsdm);
            this.chongTxt.bitmapData = ComponentUtil.getBitmapData("Text_Lv" + (layers - 1),Global.WuXing_Imgsdm);
            this.chongR.bitmapData = ComponentUtil.getBitmapData("WXIcon_Lv" + (layers - 1),Global.WuXing_Imgsdm);
         }
         var _numLayers:int = layers;
         if(_numLayers >= 11)
         {
            _numLayers = 10;
         }
         var t:int = int(Data_lib.Wuxing_s[_numLayers + 1][1]);
         var s:int = int(Data_lib.Wuxing_s[layers][2]);
         if(layers == 11)
         {
            this.totalTf.htmlText = HtmlUtil.font("已满级","#fe0000");
            this.maskTotal.width = 374 * 1;
         }
         else
         {
            this.totalTf.text = this.totalWorth_s + "/" + t;
            this.maskTotal.width = 374 * (this.totalWorth_s / t);
         }
         if(!this.now)
         {
            this.tabtnVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         else
         {
            this.tabtnVec[this.now.tabIndex - 1].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         TipManager.bind(this.chongRcontain,WuXingMter.tipsStr.replace("{0}",HtmlUtil.font((layers - 1).toString(),"#33CCFF")).replace("{1}",HtmlUtil.font("+" + s,"#33CCFF")).replace("{2}",HtmlUtil.font("+" + s,"#33CCFF")).replace("{3}",HtmlUtil.font("+" + s,"#33CCFF")).replace("{4}",HtmlUtil.font("+" + s,"#33CCFF")).replace("{5}",HtmlUtil.font("+" + s,"#33CCFF")));
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            super.visible = value;
            this.bagUpdate();
            Global.control.registerCallBack(Enum_MsgType.BAG_UPDATE,this.bagUpdate);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.BAG_UPDATE,this.bagUpdate);
            Model_specialD.visFalseComp(this,WuxingIconTip.tipBtn,this.superHide);
         }
      }
      
      private function superHide() : void
      {
         super.visible = false;
      }
      
      private function getToPoint(__indx:int) : Point
      {
         var tb:TabButton = this.tabtnVec[__indx];
         return new Point(tb.x,tb.y);
      }
      
      public function updateSucce() : void
      {
         var spri:Sprite = new Sprite();
         spri.graphics.beginFill(0,0.5);
         spri.graphics.drawCircle(0,0,39);
         spri.graphics.endFill();
         this.spContainer.addChild(spri);
         ComponentUtil.setPropertie(spri,{
            "x":this.now.x + 39,
            "y":this.now.y + 39
         });
         spri.filters = glowFFFF00;
         Tween.to(spri,500,{
            "x":[spri.x,this.chongRcontain.x + 13],
            "y":[spri.y,this.chongRcontain.y + 13]
         },function(sp:Sprite):void
         {
            var s_p:Sprite = null;
            var tb:TabButton = null;
            var toPoint:Point = null;
            if(isUseNew)
            {
               i = 0;
               while(i < 5)
               {
                  s_p = new Sprite();
                  s_p.graphics.beginFill(0,0.6);
                  s_p.graphics.drawCircle(0,0,13);
                  s_p.graphics.endFill();
                  spContainer.addChild(s_p);
                  tb = tabtnVec[i];
                  toPoint = getToPoint(i);
                  ComponentUtil.setPropertie(s_p,{
                     "x":sp.x,
                     "y":sp.y
                  });
                  Tween.to(s_p,100,{
                     "x":[s_p.x,toPoint.x],
                     "y":[s_p.y,toPoint.y]
                  });
                  ++i;
               }
               if(Boolean(sp) && spContainer.contains(sp))
               {
                  spContainer.removeChild(sp);
               }
               sp = null;
            }
            else
            {
               Tween.to(sp,600,{
                  "scaleX":[1,26 / 78],
                  "scaleY":[1,26 / 78]
               },function(sspp:Sprite):void
               {
                  var bm:Bitmap;
                  if(Boolean(sspp) && spContainer.contains(sspp))
                  {
                     spContainer.removeChild(sspp);
                  }
                  sspp = null;
                  bm = new Bitmap();
                  bm.bitmapData = chongR.bitmapData;
                  spContainer.addChild(bm);
                  ComponentUtil.setPropertie(bm,{
                     "x":chongRcontain.x,
                     "y":chongRcontain.y
                  });
                  Tween.to(bm,500,{
                     "scaleX":[1,2],
                     "scaleY":[1,2],
                     "x":[bm.x,bm.x - bm.width / 2],
                     "y":[bm.y,bm.y - bm.height / 2],
                     "alpha":[1,0.5]
                  },function(b:Bitmap):void
                  {
                     if(Boolean(b) && spContainer.contains(b))
                     {
                        spContainer.removeChild(b);
                     }
                     b = null;
                  });
               });
            }
         },null,Tween.EASYINOUT);
      }
      
      private function bagUpdate() : void
      {
         this.danyaoitemVec[0].update(CommandManager.get_bag_count(44587));
         this.danyaoitemVec[1].update(CommandManager.get_bag_count(44588));
         var cnt:int = WuXingMter.getCount();
         if(isChooseBack)
         {
            isChooseBack = false;
            return;
         }
         if(cnt == -1)
         {
            this.danyaoitemVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         else if(cnt == 2 || cnt == 3)
         {
            this.danyaoitemVec[1].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         else if(cnt == 1)
         {
            this.danyaoitemVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 670) / 2;
         y = (Global.stage.stageHeight - 460) / 2;
      }
   }
}

