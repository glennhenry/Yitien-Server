package com.yiTian.view.modules.KFHomeland
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Bezier;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class IntroduceHome extends Panel123
   {
      
      private static const LEN:int = 4;
      
      public static var isFly:Boolean = false;
      
      private var back:ScaleBitmap = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
         "x":0,
         "y":0,
         "width":486,
         "height":329
      },Global.Img_Cdm);
      
      private var _nextBtn:Button;
      
      private var _preBtn:Button;
      
      private var _containVec:Vector.<Shape>;
      
      private var imgVecStr:Vector.<String> = new <String>["Iamge_WXTS1","Iamge_WXTS2","Iamge_WXTS3","Iamge_WXTS4","Iamge_WXTS5","Iamge_WXTS6"];
      
      private var titleStr:Vector.<String>;
      
      private var _tipsTxt:MyTextField;
      
      private var _introduceTxt:MyTextField;
      
      private var _curIndex:int = 0;
      
      private var imgBit1:Bitmap;
      
      private var imgBit2:Bitmap;
      
      private var jianTou:Bitmap;
      
      private var surtShutBtn:Button;
      
      private var lastTi:int;
      
      private var cont:int;
      
      private var isfirstEnter:Boolean = false;
      
      private var totalTime:int;
      
      public function IntroduceHome()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":438,
            "height":280
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":this.back.width - 37,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         if(!Global.KFJYdm)
         {
            SingleLoader.add("lang/ch/KFJY.swf",function(info:Object):void
            {
               Global.KFJYdm = info.applicationDomain;
               initIntroduce();
            });
         }
         else
         {
            this.initIntroduce();
         }
      }
      
      private function initIntroduce() : void
      {
         this.titleStr = new <String>[LangConfig.getWord("30228",3),LangConfig.getWord("30229",3),LangConfig.getWord("30230",3)];
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":43,
            "y":52,
            "width":400,
            "height":220
         },Global.KFJYdm);
         this._nextBtn = ComponentUtil.getButton("","Button_YouYi",this,{
            "x":442,
            "y":148,
            "textColor":16771436
         },Global.KFJYdm);
         this._preBtn = ComponentUtil.getButton("","Button_ZuoYi",this,{
            "x":31,
            "y":148,
            "textColor":16771436
         },Global.KFJYdm);
         ComponentUtil.getBitmap("Title_WXTS",this,{
            "x":163,
            "y":5
         },Global.KFJYdm);
         ComponentUtil.getBitmap("Light_WXTS",this,{
            "x":26,
            "y":271
         },Global.KFJYdm);
         this._tipsTxt = ComponentUtil.getTextField("",this,{
            "x":60,
            "y":278,
            "color":16383744,
            "size":12,
            "leading":0,
            "bold":true,
            "multiline":true,
            "wordWrap":true,
            "realWidth":380
         },"center");
         this._introduceTxt = ComponentUtil.getTextField("",this,{
            "x":60,
            "y":60,
            "color":16383744,
            "size":12,
            "leading":3,
            "multiline":true,
            "wordWrap":true,
            "realWidth":380
         },"center");
         this._introduceTxt.htmlText = LangConfig.getWord("30233",3);
         this.imgBit1 = ComponentUtil.getBitmap(this.imgVecStr[this._curIndex * 2],this,{
            "x":51,
            "y":59
         },Global.KFJYdm);
         this.imgBit2 = ComponentUtil.getBitmap(this.imgVecStr[this._curIndex * 2 + 1],this,{
            "x":269,
            "y":59
         },Global.KFJYdm);
         this._tipsTxt.htmlText = this.titleStr[this._curIndex];
         this.jianTou = ComponentUtil.getBitmap("Icon_JianTou",this,{
            "x":224,
            "y":148
         },Global.KFJYdm);
         this._nextBtn.callBack = this.nextHandle;
         this._preBtn.callBack = this.preHandle;
         this.surtShutBtn = ComponentUtil.getButton("确定关闭","Button_Four",this,{
            "x":210,
            "y":280,
            "textColor":16773818,
            "textOverColor":327424
         },Global.Img_Cdm);
         this.surtShutBtn.callBack = this.surtShutHandle;
         this.showIndex();
      }
      
      private function surtShutHandle(evt:MouseEvent) : void
      {
         this.visible = false;
      }
      
      private function nextHandle(evt:MouseEvent) : void
      {
         if(GameScene.instance.hasFrameCallBack(this.lightNextBtn))
         {
            GameScene.instance.removeFrameCallBack(this.lightNextBtn);
         }
         if(this._curIndex >= LEN)
         {
            return;
         }
         ++this._curIndex;
         this.showIndex();
      }
      
      private function preHandle(evt:MouseEvent) : void
      {
         if(this._curIndex < 0)
         {
            return;
         }
         --this._curIndex;
         this.showIndex();
      }
      
      private function showIndex() : void
      {
         if(!this.imgBit1)
         {
            return;
         }
         if(Boolean(this.imgBit1))
         {
            this.imgBit1.bitmapData = null;
            this.imgBit2.bitmapData = null;
         }
         if(this._curIndex == 0)
         {
            this._preBtn.mouseEnabled = false;
            this._preBtn.enabled = false;
         }
         else
         {
            this._preBtn.mouseEnabled = true;
            this._preBtn.enabled = true;
         }
         if(this._curIndex == LEN - 1)
         {
            this._nextBtn.mouseEnabled = false;
            this._nextBtn.enabled = false;
         }
         else
         {
            this._nextBtn.mouseEnabled = true;
            this._nextBtn.enabled = true;
         }
         if(this._curIndex == 3)
         {
            this.imgBit1.visible = false;
            this.imgBit2.visible = false;
            this.jianTou.visible = false;
            this._introduceTxt.visible = true;
            this._tipsTxt.visible = false;
            this.surtShutBtn.visible = true;
         }
         else
         {
            this.imgBit1.visible = true;
            this.imgBit2.visible = true;
            this.jianTou.visible = true;
            this._introduceTxt.visible = false;
            this._tipsTxt.visible = true;
            this.surtShutBtn.visible = false;
            this.imgBit1.bitmapData = ComponentUtil.getBitmapData(this.imgVecStr[this._curIndex * 2],Global.KFJYdm);
            this.imgBit2.bitmapData = ComponentUtil.getBitmapData(this.imgVecStr[this._curIndex * 2 + 1],Global.KFJYdm);
            this._tipsTxt.htmlText = this.titleStr[this._curIndex];
         }
      }
      
      private function lightNextBtn() : void
      {
         if(getTimer() - this.lastTi >= 500)
         {
            this.lastTi = getTimer();
            ++this.cont;
            if(this.cont % 2 == 0)
            {
               this._nextBtn.transform.colorTransform = Util.colorWhite2;
            }
            else
            {
               this._nextBtn.transform.colorTransform = Util.colorNomal;
            }
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!this.isfirstEnter)
            {
               super.init();
               this.isfirstEnter = true;
            }
            if(isFly)
            {
               GameScene.instance.addFrameCallBack(this.lightNextBtn);
            }
         }
         else if(isFly)
         {
            isFly = false;
            this.flyToIntrBtn();
         }
      }
      
      private function flyToIntrBtn() : void
      {
         var p:Point = null;
         var bm:Bitmap = null;
         p = new Point(this.x + this.back.width / 2,this.y);
         p = localToGlobal(p);
         bm = new Bitmap();
         bm.bitmapData = ComponentUtil.getBitmapData("Button_ShuoMing_up",Global.KFJYdm);
         bm.x = p.x;
         bm.y = p.y;
         var aimPoint:Point = EnterHomeControl.instance.getIntrBtnCoord();
         if(this.totalTime <= 0)
         {
            this.totalTime = Math.pow(Math.pow(aimPoint.y - p.y,2) + Math.pow(aimPoint.x - p.x,2),0.5) * 3.5;
         }
         var py:Number = p.y + Math.abs(p.y - aimPoint.y) / 5;
         var point1:Point = new Point(aimPoint.x,py);
         Bezier.getInstance().addTarget(bm,aimPoint,this.totalTime,GameScene.popupLayer,-1,[point1],Tween.CFUN);
         GameScene.instance.addFrameCallBack(this.afterFly);
      }
      
      private function afterFly() : void
      {
         if(getTimer() - this.totalTime >= 0)
         {
            GameScene.instance.removeFrameCallBack(this.afterFly);
            EnterHomeControl.instance.addIntrBtn(true);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.back.width) / 2;
         y = (Global.stage.stageHeight - this.back.height) / 2;
      }
   }
}

