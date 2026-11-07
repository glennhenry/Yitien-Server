package com.yiTian.view.modules.KFHomeland
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Bezier;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Alert;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextFormatAlign;
   import flash.utils.getTimer;
   
   public class HomeSpecialMall extends Panel123
   {
      
      public static var _curSucBoughtPicStr:String;
      
      public static var _curSucBoughtIndex:int;
      
      private static var _instance:HomeSpecialMall;
      
      private static const _len:int = 5;
      
      private static const mallBtnStr:String = "resource/image/exBtn/loveAct.png";
      
      private var back:ScaleBitmap;
      
      private var mallVec:Vector.<HomeMallItem>;
      
      private var _yunbao:int;
      
      private var _homeMoney:int;
      
      private var _silver:int;
      
      private var _bingSilver:int;
      
      private var _yunbaoText:MyTextField;
      
      private var _homeMoneyText:MyTextField;
      
      private var _silverText:MyTextField;
      
      private var _bingSilverText:MyTextField;
      
      private var _leftRefreshTime:int;
      
      private var _leftRefreshTimeTxt:MyTextField;
      
      private var _refreshbtn:Button;
      
      private var _boughtBitVec:Vector.<Bitmap>;
      
      private var isShowCheckBox:Boolean = false;
      
      private var recTime:String;
      
      private var lastTime:int;
      
      private var starTime:int;
      
      public function HomeSpecialMall()
      {
         super();
      }
      
      public static function get instance() : HomeSpecialMall
      {
         if(!_instance)
         {
            _instance = new HomeSpecialMall();
            _instance.init();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":652,
            "height":321
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":604,
            "height":271
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":this.back.width - 37,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         if(!Global.KFJYdm)
         {
            SingleLoader.add("lang/ch/KFJY.swf",function(info:Object):void
            {
               Global.KFJYdm = info.applicationDomain;
               initMall();
            });
         }
         else
         {
            this.initMall();
         }
      }
      
      private function refreshHandle(evt:MouseEvent) : void
      {
         if(!this.isShowCheckBox)
         {
            View_Alert.checkStatus(this.isShowCheckBox);
            View_Alert.show(LangConfig.getWord("30204",3),View_Alert.OK_CANCAL,function(vet:MouseEvent):void
            {
               HomeLandCGMessage.CG_REFRESH_MALL();
            },null,null,null,310,"","",TextFormatAlign.LEFT,true);
            View_Alert.instance.showCheckBox = this.operationCheckCall;
         }
         else
         {
            HomeLandCGMessage.CG_REFRESH_MALL();
         }
      }
      
      private function operationCheckCall(box:CheckBox) : void
      {
         this.isShowCheckBox = box.selected;
      }
      
      private function initMall() : void
      {
         var i:int = 0;
         var item:HomeMallItem = null;
         ComponentUtil.getBitmap("Back_ShangPu",this,{
            "x":36,
            "y":50
         },Global.KFJYdm);
         ComponentUtil.getBitmap("Title_ShangPu",this,{
            "x":246,
            "y":5
         },Global.KFJYdm);
         this.mallVec = new Vector.<HomeMallItem>();
         this._boughtBitVec = new Vector.<Bitmap>(_len,true);
         i = 0;
         while(i < _len)
         {
            item = new HomeMallItem(i);
            addChild(item);
            item.x = 52 + i * 109;
            item.y = 67;
            this.mallVec.push(item);
            this._boughtBitVec[i] = ComponentUtil.getBitmap("Back_YCS",this,{
               "x":item.x + 3,
               "y":item.y + 4
            },Global.KFJYdm);
            this._boughtBitVec[i].visible = false;
            i++;
         }
         ComponentUtil.getTextField(LangConfig.getWord("30205",3),this,{
            "x":213,
            "y":247,
            "color":11523767,
            "size":16,
            "leading":0
         });
         this._leftRefreshTimeTxt = ComponentUtil.getTextField("00:23:27",this,{
            "x":331,
            "y":247,
            "color":16646144,
            "size":16,
            "leading":0
         });
         this._refreshbtn = ComponentUtil.getButton("","Button_ShuaXin",this,{
            "x":405,
            "y":252,
            "textColor":16771436
         },Global.KFJYdm);
         ComponentUtil.getBitmap("Icon_JYB",this,{
            "x":200,
            "y":287
         },Global.KFJYdm);
         ComponentUtil.getTextField(LangConfig.getWord("30206",3),this,{
            "x":72,
            "y":284,
            "color":327424,
            "size":12,
            "leading":0
         });
         this._yunbaoText = ComponentUtil.getTextField("5500000",this,{
            "x":105,
            "y":285,
            "color":16383744,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Icon_YinZi",this,{
            "x":363,
            "y":287
         },Global.KFJYdm);
         ComponentUtil.getTextField(LangConfig.getWord("30207",3),this,{
            "x":217,
            "y":284,
            "color":327424,
            "size":12,
            "leading":0
         });
         this._homeMoneyText = ComponentUtil.getTextField("5500000",this,{
            "x":262,
            "y":285,
            "color":16383744,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Icon_YuanBao",this,{
            "x":54,
            "y":287
         },Global.KFJYdm);
         ComponentUtil.getTextField(LangConfig.getWord("30208",3),this,{
            "x":380,
            "y":284,
            "color":327424,
            "size":12,
            "leading":0
         });
         this._silverText = ComponentUtil.getTextField("5500000",this,{
            "x":413,
            "y":285,
            "color":16383744,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Icon_BangYin",this,{
            "x":505,
            "y":287
         },Global.KFJYdm);
         ComponentUtil.getTextField(LangConfig.getWord("30209",3),this,{
            "x":522,
            "y":284,
            "color":327424,
            "size":12,
            "leading":0
         });
         this._bingSilverText = ComponentUtil.getTextField("5500000",this,{
            "x":555,
            "y":285,
            "color":16383744,
            "size":12,
            "leading":0
         });
         this._refreshbtn.callBack = this.refreshHandle;
      }
      
      public function flyToSortBag() : void
      {
         var p:Point = null;
         var bm:Bitmap = null;
         var totalTime:int = 0;
         p = new Point(this.mallVec[_curSucBoughtIndex].x + 25,this.mallVec[_curSucBoughtIndex].y + 36);
         p = localToGlobal(p);
         bm = new Bitmap();
         var dir:String = _curSucBoughtPicStr;
         bm = Utils.getLoadBitmap(dir,bm);
         bm.x = p.x;
         bm.y = p.y;
         var aimPoint:Point = EnterHomeControl.instance.buildBtnCoord;
         if(totalTime <= 0)
         {
            totalTime = Math.pow(Math.pow(aimPoint.y - p.y,2) + Math.pow(aimPoint.x - p.x,2),0.5) * 3.5;
         }
         var py:Number = p.y + Math.abs(p.y - aimPoint.y) / 5;
         var point1:Point = new Point(aimPoint.x,py);
         Bezier.getInstance().addTarget(bm,aimPoint,totalTime,GameScene.popupLayer,-1,[point1],Tween.CFUN);
         this.mallVec[_curSucBoughtIndex].visible = false;
         this._boughtBitVec[_curSucBoughtIndex].visible = true;
      }
      
      public function refreshCurrery(type:int, ownum:Number) : void
      {
         switch(type)
         {
            case 1:
               this._yunbaoText.text = String(ownum);
               break;
            case 2:
               this._homeMoneyText.text = String(ownum);
               break;
            case 3:
               this._silverText.text = String(ownum);
               break;
            case 4:
               this._bingSilverText.text = String(ownum);
         }
      }
      
      public function update(obj:Object) : void
      {
         var i:int = 0;
         if(!obj)
         {
            return;
         }
         this._leftRefreshTime = obj.leftRefresh;
         this._leftRefreshTimeTxt.text = this.getMSbyS(obj.leftRefresh);
         this.starTime = getTimer();
         if(GameScene.instance.hasFrameCallBack(this.runTime))
         {
            GameScene.instance.removeFrameCallBack(this.runTime);
         }
         if(obj.leftRefresh > 0)
         {
            GameScene.instance.addFrameCallBack(this.runTime);
         }
         this._yunbaoText.text = String(obj.yunbao);
         this._homeMoneyText.text = String(obj.homeMoney);
         this._silverText.text = String(obj.silver);
         this._bingSilverText.text = String(obj.bindSilver);
         var goodsInfoArr:Array = obj.goodsInfoArr as Array;
         i = 0;
         while(i < goodsInfoArr.length)
         {
            this.mallVec[i].update(goodsInfoArr[i][0],goodsInfoArr[i][2]);
            if(int(goodsInfoArr[i][1]) == 1)
            {
               this.mallVec[i].visible = false;
               this._boughtBitVec[i].visible = true;
            }
            else
            {
               this.mallVec[i].visible = true;
               this._boughtBitVec[i].visible = false;
            }
            i++;
         }
      }
      
      private function runTime() : void
      {
         if(this._leftRefreshTime * 1000 - (getTimer() - this.starTime) <= 0)
         {
            GameScene.instance.removeFrameCallBack(this.runTime);
         }
         if(getTimer() - this.lastTime >= 1000)
         {
            this.lastTime = getTimer();
            this.recTime = this.getMSbyS((this._leftRefreshTime * 1000 - (getTimer() - this.starTime)) / 1000);
            this._leftRefreshTimeTxt.htmlText = "<font color=\'#fe0000\'>" + this.recTime + "</font>";
         }
      }
      
      private function getMSbyS(t:int) : String
      {
         var result:String = "";
         var m:String = uint(t / 60) + "";
         var s:String = uint(t % 60) + "";
         if(int(m) < 10)
         {
            m = "0" + m;
         }
         if(int(s) < 10)
         {
            s = "0" + s;
         }
         return m + ":" + s;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            HomeLandCGMessage.CG_ENTER_MALL();
         }
         else if(GameScene.instance.hasFrameCallBack(this.runTime))
         {
            GameScene.instance.removeFrameCallBack(this.runTime);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.back.width) / 2;
         y = (Global.stage.stageHeight - this.back.height) / 2;
      }
   }
}

