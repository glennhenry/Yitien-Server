package com.yiTian.view.modules.FeiXingQi
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.FeiXingQiHandle;
   import com.yiTian.net.message.cg.FeiXingQiCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.UIBase;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class View_FXQGuessing extends UIBase
   {
      
      private var bg:ScaleBitmap;
      
      private var titleBg:Bitmap;
      
      private var bm_bg:Bitmap;
      
      private var sp_result:Sprite;
      
      private var bg_m:Bitmap;
      
      private var bm_head1:Bitmap;
      
      private var bm_head2:Bitmap;
      
      private var guessing1:GuessingBM;
      
      private var guessing2:GuessingBM;
      
      private var tf_talk1:MyTextField;
      
      private var tf_talk2:MyTextField;
      
      private var tf_info:MyTextField;
      
      private var tf_win:MyTextField;
      
      private var guessingArr:Array;
      
      private var guessY:Number = 160;
      
      private var goY:Number = -20;
      
      private var CloseButton:Button;
      
      private var flagTime:int;
      
      private var tmpArr:Array;
      
      private var isInitB:Boolean = false;
      
      private var isLock:Boolean = false;
      
      public function View_FXQGuessing()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var bm_result:Bitmap = null;
         this.bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":509,
            "height":390
         },Global.Img_Cdm);
         var bg2:ScaleBitmap = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":460,
            "height":340
         },Global.Img_Cdm);
         this.CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":475,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         var kuang1:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Translucent",[2,2,4,4],this,{
            "x":34,
            "y":50,
            "width":120,
            "height":180
         },Global.Img_Cdm);
         var kuang2:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Translucent",[2,2,4,4],this,{
            "x":354,
            "y":50,
            "width":120,
            "height":180
         },Global.Img_Cdm);
         var bg3:ScaleBitmap = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":34,
            "y":245,
            "width":440,
            "height":125
         },Global.Img_Cdm);
         var kuang3:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Translucent",[2,2,4,4],this,{
            "x":36,
            "y":247,
            "width":436,
            "height":30
         },Global.Img_Cdm);
         this.tf_info = ComponentUtil.getTextField("",this,{
            "y":252,
            "color":16764206,
            "size":12,
            "leading":0,
            "realWidth":this.bg.width
         });
         this.tf_info.align = "center";
         this.tf_info.text = "";
         this.tf_talk1 = ComponentUtil.getTextField("",this,{
            "x":44,
            "y":160,
            "color":16764206,
            "size":12,
            "realWidth":100,
            "wordWrap":true
         });
         this.tf_talk2 = ComponentUtil.getTextField("",this,{
            "x":364,
            "y":160,
            "color":16764206,
            "size":12,
            "realWidth":100,
            "wordWrap":true
         });
         this.sp_result = new Sprite();
         bm_result = new Bitmap();
         bm_result.x = -60;
         bm_result.y = -28.5;
         this.sp_result.x = 260;
         this.sp_result.y = 100;
         this.sp_result.addChild(bm_result);
         addChild(this.sp_result);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         bindParent = GameScene.modalLayer;
         this.CloseButton.callBack = this.closeClickHd;
      }
      
      private function closeClickHd(evt:MouseEvent) : void
      {
         ModalUIManager.UNPOP();
      }
      
      override public function set visible(value:Boolean) : void
      {
         var myDir:String = null;
         if(value)
         {
            this.setState(0);
            this.tf_win.text = "";
            var _temp_1:* = this.guessing1;
            this.guessing2.type = 0;
            _temp_1.type = 0;
            myDir = "resource/image/icon/" + (23090 + Enum_job.getBaseJob(GameUnitManager.hero.job) * 100 + GameUnitManager.hero.sex) + ".png";
            this.setHead(Enum_FeiXingQi.NPCHEADDIR,1);
            this.setHead(myDir,2);
            this.showResultEff(0);
            if(!Global.ChuangGuan_Imgsdm)
            {
               this.load();
            }
            else if(!this.bg_m)
            {
               this.touLoadZiComplete();
            }
         }
         super.visible = value;
      }
      
      private function load() : void
      {
         var arr:Array = [];
         arr.push([Enum_FeiXingQi.TOUZIDIR,this.touLoadZiComplete,LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr,function():void
         {
            View_loading.instance.visible = false;
         });
      }
      
      private function touLoadZiComplete(info:Object = null) : void
      {
         if(Boolean(info))
         {
            Global.ChuangGuan_Imgsdm = info.applicationDomain;
         }
         this.bg_m = ComponentUtil.getBitmap("CaiQuan_BG",this,{
            "x":26,
            "y":42
         },Global.ChuangGuan_Imgsdm);
         setChildIndex(this.bg_m,2);
         this.titleBg = ComponentUtil.getBitmap("Title_CaiQuan",this,{
            "x":174,
            "y":5
         },Global.ChuangGuan_Imgsdm);
      }
      
      public function setHead(dir:String, which:int) : void
      {
         var bm:Bitmap = this["bm_head" + which.toString()];
         Utils.getLoadBitmap(dir,bm);
      }
      
      public function setGuess(type:int, which:int) : void
      {
         (this["guessing" + which.toString()] as GuessingBM).type = type;
      }
      
      public function setResult(npcPoint:int, myPoint:int, isWin:int) : void
      {
         var ooY:Number;
         var step1:ComboTweenStep;
         var step2:ComboTweenStep;
         var step3:ComboTweenStep = null;
         var flag:int = 0;
         this.isLock = true;
         this.setGuess(3,1);
         this.setGuess(3,2);
         ooY = -60;
         this.tmpArr = [npcPoint,myPoint,isWin];
         this.guessing1.alpha = this.guessing2.alpha = 1;
         this.guessing1.type = this.guessing2.type = 3;
         step1 = new ComboTweenStep();
         step1.time = 2000;
         step1.property = {"y":[this.guessY,this.guessY + this.goY]};
         step1.tweenType = Tween.TURBOSIN;
         step2 = new ComboTweenStep();
         step2.time = 150;
         step2.property = {
            "y":[this.guessY,this.guessY + ooY],
            "alpha":[1,0]
         };
         step2.tweenType = Tween.BEE_LINE;
         step3 = new ComboTweenStep();
         step3.time = 220;
         step3.property = {
            "y":[this.guessY + ooY,this.guessY],
            "alpha":[0,1]
         };
         step3.tweenType = Tween.SIN;
         flag = 0;
         step3.endFun = function():void
         {
            var resultStep1:ComboTweenStep = null;
            flag += 1;
            if(flag >= 2)
            {
               if(myPoint == 4)
               {
                  setTalk(LangConfig.getWord("20313".toString(),2),1);
                  guessing2.type = Enum_FeiXingQi.getLostPoint(tmpArr[0]);
                  resultStep1 = new ComboTweenStep();
                  resultStep1.time = 900;
                  resultStep1.tweenType = Tween.BEE_LINE;
                  resultStep1.endFun = function():void
                  {
                     guessing2.type = Enum_FeiXingQi.getWinPoint(tmpArr[0]);
                     setState(4);
                     showResultEff(1);
                     FeiXingQiHandle.SHOWAWARD();
                     isLock = false;
                     flag = 0;
                  };
                  Tween.playComboStep(guessing2,resultStep1);
               }
               else
               {
                  resultStep1 = new ComboTweenStep();
                  resultStep1.time = 300;
                  resultStep1.tweenType = Tween.BEE_LINE;
                  guessing2.type = tmpArr[1];
                  resultStep1.endFun = function():void
                  {
                     setState(isWin);
                     showResultEff(isWin);
                     FeiXingQiHandle.SHOWAWARD();
                     isLock = false;
                  };
                  Tween.playComboStep(guessing2,resultStep1);
               }
               guessing1.type = tmpArr[0];
               flag = 0;
            }
         };
         step1.next = step2;
         step2.next = step3;
         Tween.playComboStep(this.guessing1,step1);
         Tween.playComboStep(this.guessing2,step1);
      }
      
      public function showResultEff(value:int) : void
      {
         if(value == 0)
         {
            this.sp_result.visible = false;
         }
         else
         {
            this.sp_result.visible = true;
            (this.sp_result.getChildAt(0) as Bitmap).bitmapData = Enum_FeiXingQi.getTouZiBmd("R" + value.toString());
            Tween.to(this.sp_result,600,{
               "scaleX":[0.5,1.3],
               "scaleY":[0.5,1.3]
            },null,null,Tween.SIN06);
         }
      }
      
      public function setState(value:int) : void
      {
         var str1:String = null;
         var str2:String = null;
         var info:String = null;
         var i1:int = 0;
         var i2:int = 0;
         var i3:int = 0;
         switch(value)
         {
            case 0:
               i1 = 20311;
               i2 = 20316;
               i3 = 20317;
               break;
            case 1:
               i1 = 20311;
               i2 = 20316;
               i3 = 20317;
               break;
            case 2:
               i1 = 20313;
               i2 = 20322;
               i3 = 20319;
               break;
            case 3:
               i1 = 20314;
               i2 = 20323;
               i3 = 20320;
               break;
            case 4:
               i1 = 20315;
               i2 = 20313;
               i3 = 20318;
         }
         str1 = LangConfig.getWord(i1.toString(),2);
         str2 = LangConfig.getWord(i2.toString(),2);
         info = LangConfig.getWord(i3.toString(),2);
         if(Boolean(str1))
         {
            this.setTalk(str1,1);
         }
         if(Boolean(str2))
         {
            this.setTalk(str2,2);
         }
         if(Boolean(info))
         {
            this.setInfo(info);
         }
         if(value == 1)
         {
            FeiXingQiHandle.SHOWAWARD();
         }
      }
      
      public function initB() : void
      {
         if(this.isInitB)
         {
            return;
         }
         this.tf_win = ComponentUtil.getTextField("",this,{
            "x":200,
            "y":150,
            "size":30,
            "bold":true
         });
         this.createGroup();
         this.initHead();
         this.initGuessing();
         this.isInitB = true;
      }
      
      private function initGuessing() : void
      {
         this.guessing1 = new GuessingBM();
         ComponentUtil.setPropertie(this.guessing1,{
            "x":219,
            "y":this.guessY,
            "scaleX":-1
         });
         this.guessing2 = new GuessingBM();
         ComponentUtil.setPropertie(this.guessing2,{
            "x":289,
            "y":this.guessY
         });
         addChild(this.guessing1);
         addChild(this.guessing2);
      }
      
      private function initHead() : void
      {
         this.bm_head1 = new Bitmap();
         ComponentUtil.setPropertie(this.bm_head1,{
            "x":35,
            "y":41
         });
         this.bm_head2 = new Bitmap();
         ComponentUtil.setPropertie(this.bm_head2,{
            "x":355,
            "y":41
         });
         addChild(this.bm_head1);
         addChild(this.bm_head2);
      }
      
      private function createGroup() : void
      {
         var i:int = 0;
         var sp:Sprite = null;
         var g:GuessingBM = null;
         i = 0;
         while(i < 4)
         {
            sp = new Sprite();
            g = new GuessingBM();
            g.type = i + 1;
            sp.x = 77 + 97 * i;
            sp.y = 290;
            sp.buttonMode = true;
            sp.addChild(g);
            sp.addEventListener(MouseEvent.CLICK,this.spClickHd);
            addChild(sp);
            i += 1;
         }
      }
      
      public function setTalk(str:String, which:int) : void
      {
         this["tf_talk" + which.toString()].htmlText = str;
      }
      
      public function setInfo(str:String) : void
      {
         this.tf_info.htmlText = str;
      }
      
      private function spClickHd(evt:MouseEvent) : void
      {
         var g:GuessingBM;
         var now:int;
         var type:int = 0;
         evt.stopPropagation();
         if(this.isLock)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("20324",2));
            return;
         }
         g = evt.target.getChildAt(0);
         type = g.type;
         now = getTimer();
         if(now - this.flagTime < 1000)
         {
            return;
         }
         this.flagTime = now;
         if(type == 4)
         {
            View_Alert.show(LangConfig.getWord("20325",2),View_Alert.OK_CANCAL,function(evt:MouseEvent):void
            {
               if(GameUnitManager.hero.money < 20)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("20326",2));
                  return;
               }
               FeiXingQiCGMessage.CG_GUESSING(Model_FeiXingQi.version,type);
            });
            return;
         }
         FeiXingQiCGMessage.CG_GUESSING(Model_FeiXingQi.version,type);
      }
   }
}

import com.yiTian.view.modules.FeiXingQi.Enum_FeiXingQi;
import flash.display.Bitmap;

class GuessingBM extends Bitmap
{
   
   private var _type:int = -1;
   
   public function GuessingBM()
   {
      super();
   }
   
   public function set type(value:int) : void
   {
      if(this._type == value)
      {
         return;
      }
      if(value == 0)
      {
         bitmapData = null;
      }
      else
      {
         bitmapData = Enum_FeiXingQi.getTouZiBmd("G" + value.toString());
      }
      this._type = value;
   }
   
   public function get type() : int
   {
      return this._type;
   }
}
