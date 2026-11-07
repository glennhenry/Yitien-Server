package com.yiTian.view.modules.shengDanXuYuan
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_ChristmasWish;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ChristmasWishCGMessage;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class View_ChristmasWish extends Panel123
   {
      
      private static var _instance:View_ChristmasWish;
      
      private var type:int;
      
      private var moneyType:int;
      
      private var timeNum:uint;
      
      private const FILTER_ARRA:Array = [[new GlowFilter(16737792,1,10,10)],[new GlowFilter(16711782,1,10,10)],[new GlowFilter(39423,1,10,10)],[new GlowFilter(3407616,1,10,10)],[new GlowFilter(16777215,1,10,10)]];
      
      private const MOVE_RANG:int = 6;
      
      private var tip:Boolean = true;
      
      private var tipBox:WishTip;
      
      private var isPlay:Boolean;
      
      private var nowBtn:Button;
      
      private var nowBtnLabel:String;
      
      private var resetTime:Number;
      
      private var value:int;
      
      private var showTime:int;
      
      private const EFF_TIME:int = 1000;
      
      private var bottleEff:Effect;
      
      private var btnEff:Effect;
      
      private var back:Sprite;
      
      private var numItem:NumBerItem;
      
      private var bottleVec:Vector.<Sprite>;
      
      private var preBottle:Sprite;
      
      private var bottlePos:Array;
      
      private var className:Array = ["Icon_BSLB","Icon_LvSLB","Icon_LSLB","Icon_ZSLB","Icon_CSLB"];
      
      private var titleTF:MyTextField;
      
      private const STR_ARR:Array = [LangConfig.getWord("80186",8),LangConfig.getWord("80187",8),LangConfig.getWord("80188",8),LangConfig.getWord("80189",8),LangConfig.getWord("80190",8)];
      
      private var btnVec:Vector.<Button>;
      
      private var isFirst:Boolean = true;
      
      public function View_ChristmasWish()
      {
         super();
         regResource("lang/ch/MNXY.swf","MNXYdm");
      }
      
      public static function get instance() : View_ChristmasWish
      {
         if(!_instance)
         {
            _instance = new View_ChristmasWish();
         }
         return _instance;
      }
      
      public function upData(time:int, value:int, data:String) : void
      {
         var arr:Array = null;
         this.timeNum = time;
         this.titleTF.htmlText = LangConfig.reTxt(LangConfig.getWord("80183",8),this.timeNum);
         this.numItem.show(value);
         this.numItem.x = (this.back.width - this.numItem.width) / 2;
         var arrCount:Array = data.split("|");
         var len:int = int(arrCount.length);
         var dataArr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            arr = arrCount[i].toString().split("_");
            dataArr.push(arr[1],arr[2]);
            i++;
         }
         this.upTip(dataArr);
      }
      
      private function upTip(arr:Array) : void
      {
         var str:String = null;
         var bottle:Sprite = null;
         var len:int = int(arr.length);
         var i:int = 0;
         while(i < len)
         {
            str = LangConfig.getWord("80204",8,arr[i],arr[i + 1]);
            bottle = this.bottleVec[4 - i / 2];
            TipManager.bind(bottle,str);
            i += 2;
         }
      }
      
      private function selectBottleFun(event:MouseEvent) : void
      {
         var nowBottle:Sprite = null;
         nowBottle = event.currentTarget as Sprite;
         if(Boolean(this.preBottle))
         {
            if(this.preBottle == nowBottle)
            {
               return;
            }
            this.preBottle.filters = Util.disabled;
            this.resetBottle();
         }
         this.moneyType = int(nowBottle.name.split("_")[1]);
         nowBottle.filters = this.FILTER_ARRA[this.moneyType - 1];
         this.preBottle = nowBottle;
         this.bottleMove();
      }
      
      private function resetBottle() : void
      {
         Tween.stop(this.preBottle);
         ComponentUtil.setPropertie(this.preBottle,this.bottlePos[this.preBottle.name.split("_")[1] - 1]);
      }
      
      private function bottleMove() : void
      {
         if(!visible)
         {
            this.preBottle.filters = Util.disabled;
            this.preBottle = null;
            return;
         }
         Tween.to(this.preBottle,400,{"y":[this.preBottle.y,this.preBottle.y - this.MOVE_RANG]},this.moveFun);
      }
      
      private function moveFun() : void
      {
         var id:int = this.preBottle.name.split("_")[1] - 1;
         var pos:Object = this.bottlePos[id];
         if(this.preBottle.y <= pos.y - this.MOVE_RANG)
         {
            Tween.to(this.preBottle,800,{"y":[this.preBottle.y,pos.y + this.MOVE_RANG]},this.moveFun);
         }
         else
         {
            Tween.to(this.preBottle,800,{"y":[this.preBottle.y,pos.y - this.MOVE_RANG]},this.moveFun);
         }
      }
      
      private function btnFun(event:MouseEvent) : void
      {
         if(this.timeNum <= 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80185",8));
            return;
         }
         if(GameUnitManager.hero.money < Enum_ChristmasWish.moneyVec[this.moneyType - 1])
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80006",8));
            return;
         }
         this.nowBtn = event.currentTarget as Button;
         this.type = this.nowBtn.name.split("_")[1];
         if(this.tip && this.moneyType != 5)
         {
            if(!this.tipBox)
            {
               this.tipBox = new WishTip();
            }
            this.tipBox.show(LangConfig.getWord("80212",8,Enum_ChristmasWish.moneyVec[this.moneyType - 1]),function():void
            {
               ChristmasWishCGMessage.CG_GET_WISH(6 - moneyType,type);
            },function():void
            {
               tip = !tip;
            });
         }
         else
         {
            ChristmasWishCGMessage.CG_GET_WISH(6 - this.moneyType,this.type);
         }
      }
      
      public function upBtn(type:int, showType:int, value:int) : void
      {
         if(this.isPlay)
         {
            return;
         }
         if(Boolean(this.preBottle))
         {
            this.resetBottle();
         }
         this.isPlay = true;
         this.value = value;
         this.type = type;
         this.nowBtn = this.btnVec[type - 1];
         this.nowBtnLabel = this.nowBtn.label;
         this.nowBtn.labelSize = 18;
         this.nowBtn.textColor = 3394560;
         this.showTime = showType == 0 ? this.EFF_TIME : int(this.EFF_TIME * 3);
         if(showType == 0)
         {
            Button_Lable.play(this.nowBtn,value,this.playComp);
         }
         else
         {
            this.nowBtn.label = value + "";
            this.playComp();
         }
         this.startEff(showType);
         this.disBtn(false,this.nowBtn);
         this.disBottle(false);
      }
      
      private function playComp() : void
      {
         var str:String = LangConfig.reTxt(LangConfig.getWord("80191",8),this.STR_ARR[this.type - 1],this.value);
         UIManager.centerBroadcast.addMsg(str);
         this.resetTime = getTimer();
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.reset);
      }
      
      private function reset() : void
      {
         if(getTimer() - this.resetTime >= this.showTime)
         {
            this.isPlay = false;
            this.bottleMove();
            this.disBtn(true,this.nowBtn);
            this.nowBtn.labelSize = 12;
            this.nowBtn.textColor = 16184781;
            this.nowBtn.label = this.nowBtnLabel;
            this.nowBtn = null;
            this.disBottle(true);
            this.disEff();
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.reset);
         }
      }
      
      private function disBottle(lock:Boolean) : void
      {
         var bottle:Sprite = null;
         for each(bottle in this.bottleVec)
         {
            bottle.mouseEnabled = lock;
         }
      }
      
      private function disBtn(lock:Boolean, btn:Button) : void
      {
         var otherBtn:Button = null;
         for each(otherBtn in this.btnVec)
         {
            otherBtn.mouseEnabled = lock;
            if(otherBtn != btn)
            {
               if(lock)
               {
                  otherBtn.filters = [];
               }
               else
               {
                  otherBtn.filters = Util.disabled;
               }
            }
         }
      }
      
      private function startEff(showType:int) : void
      {
         this.disEff();
         var ids:Array = [35328,35331,35330,35332,35329];
         var id:int = int(ids[5 - this.moneyType]);
         this.bottleEff = EffectManager.addEffect(id + "",this,this.EFF_TIME * 0.8,this.preBottle.x + 17 + 17,this.preBottle.y + 17 + 22,true);
         this.bottleEff.filters = this.FILTER_ARRA[this.moneyType - 1];
         if(showType == 0)
         {
            EffectManager.addEffect("35166",this,this.EFF_TIME * 3,this.nowBtn.x + 59,this.nowBtn.y + 19,false);
         }
         else
         {
            EffectManager.addEffect("35167",this,this.EFF_TIME * 2,this.nowBtn.x + 59,this.nowBtn.y + 19,false);
         }
      }
      
      private function disEff() : void
      {
         if(Boolean(this.bottleEff))
         {
            EffectManager.removeEffect(this.bottleEff);
            this.bottleEff.filters = [];
         }
      }
      
      private function initBottle() : void
      {
         var bottleSp:Sprite = null;
         var bottleBitmap:Bitmap = null;
         this.bottleVec = new Vector.<Sprite>();
         this.bottlePos = [{
            "x":302 + 29,
            "y":83 + 45
         },{
            "x":335 + 29,
            "y":165 + 45
         },{
            "x":244 + 29,
            "y":168 + 45
         },{
            "x":370 + 29,
            "y":240 + 45
         },{
            "x":198 + 29,
            "y":248 + 45
         }];
         var i:int = 0;
         while(i < 5)
         {
            bottleSp = new Sprite();
            bottleSp.buttonMode = true;
            bottleBitmap = new Bitmap();
            bottleBitmap.bitmapData = ComponentUtil.getBitmapData(this.className[4 - i],Global.MNXYdm);
            addChild(bottleSp);
            bottleSp.addChild(bottleBitmap);
            ComponentUtil.setPropertie(bottleSp,this.bottlePos[i]);
            this.bottleVec.push(bottleSp);
            bottleSp.addEventListener(MouseEvent.CLICK,this.selectBottleFun);
            bottleSp.name = "bottle_" + (i + 1);
            bottleSp.filters = Util.disabled;
            i++;
         }
      }
      
      override protected function initUI2() : void
      {
         this.back = new Sprite();
         addChild(this.back);
         if(!Global.Img_Cdm)
         {
            return;
         }
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.back,{
            "x":0,
            "y":0,
            "width":708,
            "height":553
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.back,{
            "x":24,
            "y":40,
            "width":660,
            "height":410
         },Global.Img_Cdm);
         move = new Rectangle(0,0,708,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":674,
            "y":6,
            "textColor":16184781,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Back_MNXY",this.back,{
            "x":29,
            "y":45
         },Global.MNXYdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.back,{
            "x":24,
            "y":455,
            "width":660,
            "height":89
         },Global.Img_Cdm);
         this.initBtn();
         this.numItem = new NumBerItem();
         addChild(this.numItem);
         ComponentUtil.setPropertie(this.numItem,{
            "x":305,
            "y":405
         });
         ComponentUtil.getBitmap("Title_MNXY",this.back,{
            "x":274,
            "y":5
         },Global.MNXYdm);
         this.numItem.show(0);
         this.initBottle();
         this.titleTF = ComponentUtil.getTextField("",this,{
            "x":54,
            "y":65,
            "color":16777215,
            "size":14,
            "leading":0
         });
      }
      
      private function initBtn() : void
      {
         var btn:Button = null;
         this.btnVec = new Vector.<Button>();
         var pos:Array = [{
            "x":132,
            "y":465,
            "textColor":16184781
         },{
            "x":293,
            "y":465,
            "textColor":16184781
         },{
            "x":454,
            "y":465,
            "textColor":16184781
         },{
            "x":234,
            "y":504,
            "textColor":16184781
         },{
            "x":395,
            "y":504,
            "textColor":16184781
         }];
         var i:int = 0;
         while(i < 5)
         {
            btn = ComponentUtil.getButton(LangConfig.getWord("80184",8) + this.STR_ARR[i],"Button_WXY",this.back,pos[i],Global.MNXYdm);
            btn.callBack = this.btnFun;
            this.btnVec.push(btn);
            btn.name = "btn_" + (i + 1);
            i++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.isFirst)
            {
               if(!Global.MNXYdm)
               {
                  preFun();
               }
               else
               {
                  this.initUI2();
               }
               this.isFirst = false;
            }
            if(!this.isPlay)
            {
               this.bottleVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
         }
         else if(!this.isPlay)
         {
            this.resetBottle();
            this.preBottle.filters = Util.disabled;
            this.preBottle = null;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.CheckBox;
import com.ui.controls.MyTextField;
import com.utils.ColorConstant;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.manager.LangConfig;
import com.yiTian.view.Panel;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;

class NumBerItem extends Sprite
{
   
   private var numVec:Vector.<Bitmap>;
   
   public function NumBerItem()
   {
      super();
      this.numVec = new Vector.<Bitmap>();
   }
   
   public function show(value:int) : void
   {
      var posX:Number = NaN;
      var numStr:String = value + "";
      var len:int = numStr.length;
   }
   
   public function dispose() : void
   {
      var bitmap:Bitmap = null;
      var len:int = int(this.numVec.length);
      var i:int = 0;
      while(i < len)
      {
         bitmap = this.numVec[i];
         if(Boolean(bitmap) && Boolean(bitmap.parent))
         {
            this.removeChild(bitmap);
         }
         this.numVec[i] = null;
         i++;
      }
      this.numVec.length = 0;
   }
}

class WishTip extends Panel
{
   
   private var Button_No:Button;
   
   private var Button_Yes:Button;
   
   private var checkBox:CheckBox;
   
   private var contentTF:MyTextField;
   
   private var _okFun:Function;
   
   private var _checkFun:Function;
   
   public function WishTip()
   {
      super();
      init();
   }
   
   override protected function initStaticView() : void
   {
      ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
         "x":0,
         "y":0,
         "width":348,
         "height":179
      },Global.Img_Cdm);
      ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
         "x":29,
         "y":45,
         "width":290,
         "height":120
      },Global.Img_Cdm);
      ComponentUtil.getBitmap("Title_Prompt",this,{
         "x":94,
         "y":5
      },Global.Img_Cdm);
      this.Button_No = ComponentUtil.getButton(LangConfig.getWord("5",0),"Button_Four",this,{
         "x":210,
         "y":125,
         "textColor":16184781
      },Global.Img_Cdm);
      this.Button_Yes = ComponentUtil.getButton(LangConfig.getWord("6",0),"Button_Four",this,{
         "x":65,
         "y":125,
         "textColor":16184781
      },Global.Img_Cdm);
      this.contentTF = ComponentUtil.getTextField("",this,{
         "x":this.width / 2,
         "y":68,
         "color":ColorConstant.getColorInt(4)
      },"center");
      this.checkBox = ComponentUtil.getCheckBox(LangConfig.getWord("80213",8),"CheckBox01",this,null,Global.Img_Cdm);
      ComponentUtil.setPropertie(this.checkBox,{
         "x":(this.width - this.checkBox.width) / 2,
         "y":100
      });
      this.Button_No.callBack = function(event:MouseEvent):void
      {
         visible = false;
      };
      this.Button_Yes.callBack = this.okFun;
      this.checkBox.clickFun = this.checkFun;
   }
   
   public function show(content:String, okFun:Function, checkFun:Function) : void
   {
      this.contentTF.htmlText = content;
      this._okFun = okFun;
      this._checkFun = checkFun;
      visible = true;
   }
   
   private function okFun(event:MouseEvent) : void
   {
      if(this._okFun != null)
      {
         this._okFun();
      }
      visible = false;
   }
   
   private function checkFun(target:CheckBox) : void
   {
      if(this._checkFun != null)
      {
         this._checkFun();
      }
   }
   
   override public function resetPosition() : void
   {
      x = (Global.stage.stageWidth - width) / 2;
      y = (Global.stage.stageHeight - height) / 2;
   }
}
