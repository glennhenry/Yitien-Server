package com.yiTian.view.modules.pet
{
   import com.ui.controls.Button;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ResourceManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.PetCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class PetYellowDiamond extends Panel
   {
      
      private var bm:Bitmap;
      
      private var btnOpen:Button;
      
      private var _info:Object;
      
      private const STR1:String = "resource/image/pet/yellowDiamond.png";
      
      private const STR2:String = "resource/image/pet/linqujiangli.png";
      
      private var curStr:String;
      
      private var _PYDBtn:Sprite;
      
      private var PYDBM:Bitmap;
      
      private const petBGW:int = 156;
      
      private const petBGH:int = 71;
      
      private var petBGBM:Bitmap;
      
      private var spImg:Sprite;
      
      private var imgBM:Bitmap;
      
      private const INTERVALFRAM:int = 5;
      
      private var imgList:Vector.<BitmapData>;
      
      private var playIndex:int = 0;
      
      private var starX:int = 380;
      
      public var starY:int = 135;
      
      private var ccc:Sprite;
      
      private var lastTime:int;
      
      public function PetYellowDiamond()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
      }
      
      public function get PYDBtn() : Sprite
      {
         return this._PYDBtn;
      }
      
      public function showPYDBtn(type:int) : void
      {
         if(!this._PYDBtn)
         {
            this._PYDBtn = new Sprite();
            this._PYDBtn.graphics.beginFill(16777215,0);
            this._PYDBtn.graphics.drawRect(0,0,50,50);
            this._PYDBtn.graphics.endFill();
            this.PYDBM = new Bitmap();
            this._PYDBtn.addChild(this.PYDBM);
            this._PYDBtn.buttonMode = true;
            this._PYDBtn.addEventListener(MouseEvent.CLICK,this.PYDOnClick);
         }
         UIManager.mainUiBtnContainer.addBTN(this._PYDBtn);
         if(Boolean(type))
         {
            this.curStr = this.STR2;
            Utils.getLoadBitmap(this.STR2,this.PYDBM);
         }
         else
         {
            this.curStr = this.STR1;
            Utils.getLoadBitmap(this.STR1,this.PYDBM);
         }
      }
      
      protected function PYDOnClick(e:MouseEvent) : void
      {
         if(this.curStr == this.STR1)
         {
            UIManager.petYellowDiamond.visible = !UIManager.petYellowDiamond.visible;
         }
         else if(this.curStr == this.STR2)
         {
            if(GameUnitManager.hero.level > 14)
            {
               PetCGMessage.CG_PET_YELLOWDIAMOND_AWARD();
            }
            else
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10636",1));
            }
         }
      }
      
      private function removeShouChongBtn() : void
      {
         UIManager.mainUiBtnContainer.removeBTN(this._PYDBtn);
      }
      
      public function playEff() : void
      {
         var vo:Vo_item = null;
         var p:Point = UIManager.mainUiBtnContainer.localToGlobal(new Point(this._PYDBtn.x,this._PYDBtn.y));
         vo = new Vo_item();
         vo.id = 46415;
         vo.Init_lib();
         Tween.gridToBagBezierFuncDef(vo,-1,p.x,p.y);
         this.removeShouChongBtn();
         MassLoader.add("modelRes/magic/35087.swf",this.onComp,null,5,null,Enum_resType.MODEL_URL);
      }
      
      private function onComp(info:Object) : void
      {
         ResourceManager.setSource(info);
         EffectManager.addEffect("35087",GameScene.uiLayer,1000,(Global.stage.stageWidth - 20) / 2,Global.stage.stageHeight / 2 - 150);
      }
      
      private function onComplete(info:Object) : void
      {
         var c:Class = null;
         var d:BitmapData = null;
         this._info = info;
         this._info = info;
         this._info.content.init();
         this.imgList = new Vector.<BitmapData>(this.INTERVALFRAM * this._info.content.actionFrame,true);
         var i:int = 0;
         var j:int = 0;
         while(i < this.INTERVALFRAM * this._info.content.actionFrame)
         {
            if(i % this.INTERVALFRAM == 0)
            {
               c = info.applicationDomain.getDefinition("_" + (3 * this._info.content.actionFrame + j++)) as Class;
               d = new c();
               this.imgList[i] = d;
            }
            i++;
         }
         GameScene.instance.addFrameCallBack(this.play);
         this.lastTime = getTimer();
         this.playCCC();
      }
      
      private function playCCC() : void
      {
         var b:Bitmap = null;
         if(!this.ccc)
         {
            this.ccc = new Sprite();
            addChild(this.ccc);
            b = new Bitmap();
            this.ccc.addChild(b);
            this.ccc.alpha = 0;
            Utils.getLoadBitmap("resource/image/pet/7.3.png",b);
         }
         Tween.stop(this.ccc);
         Tween.to(this.ccc,1000,{
            "alpha":[0,1],
            "x":[this.starX,this.starX + 20],
            "scaleX":[0.1,1],
            "scaleY":[0.1,1],
            "y":[this.starY,this.starY - 40 / 2]
         });
      }
      
      private function play(interval:int) : void
      {
         if(!visible)
         {
            GameScene.instance.removeFrameCallBack(this.play);
         }
         if(getTimer() - this.lastTime > 2000)
         {
            this.lastTime = getTimer();
            this.playCCC();
         }
         if(this.playIndex < this.imgList.length)
         {
            if(this.imgList[this.playIndex] != null)
            {
               this.imgBM.x = this._info.content.rect[this._info.content.actionFrame * 3 + this.playIndex / this.INTERVALFRAM][0];
               this.imgBM.y = this._info.content.rect[this._info.content.actionFrame * 3 + this.playIndex / this.INTERVALFRAM][1];
               this.imgBM.bitmapData = this.imgList[this.playIndex];
            }
            ++this.playIndex;
         }
         else
         {
            this.playIndex = 0;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         var st:String = null;
         super.visible = value;
         if(value)
         {
            if(!this.bm.bitmapData)
            {
               Utils.getLoadBitmap("resource/image/pet/6_18.jpg",this.bm);
            }
            if(!this._info)
            {
               st = Global.pf == "qqgame" ? "20907" : "20906";
               MassLoader.add("modelRes/role/body/run/" + st + ".swf",this.onComplete,null,MassLoader.LEVEL2,null,Enum_resType.MODEL_URL);
            }
            else
            {
               GameScene.instance.addFrameCallBack(this.play);
               this.lastTime = getTimer();
               this.playCCC();
            }
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

