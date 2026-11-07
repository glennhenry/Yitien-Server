package com.yiTian.view.modules.JinDan
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.JinDanCGMessage;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import flash.ui.Mouse;
   
   public class JinDanPanel extends Panel123
   {
      
      private static const C0:ColorTransform = new ColorTransform(0.65,0.65,0.65,1,0,0,0,0);
      
      private static const C1:ColorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
      
      private static const C2:ColorTransform = new ColorTransform(0.65,0.65,0.65,1,0,89,0,0);
      
      private static const C3:ColorTransform = new ColorTransform(0.65,0.65,0.65,1,0,53,89,0);
      
      private static const C4:ColorTransform = new ColorTransform(0.65,0.65,0.65,1,63,0,89,0);
      
      private var ChuiZi1:Bitmap;
      
      private var ChuiZi2:Bitmap;
      
      private var ChuiZi3:Bitmap;
      
      private var ChuiZi4:Bitmap;
      
      private var ChuiZi5:Bitmap;
      
      private var ChuiZi:Bitmap;
      
      private var expTxt1:MyTextField;
      
      private var expTxt2:MyTextField;
      
      private var expTxt3:MyTextField;
      
      private var expTxt4:MyTextField;
      
      private var expTxt5:MyTextField;
      
      private var spr1:Sprite;
      
      private var spr2:Sprite;
      
      private var spr3:Sprite;
      
      private var spr4:Sprite;
      
      private var spr5:Sprite;
      
      private var eggspr1:Sprite;
      
      private var eggspr2:Sprite;
      
      private var eggspr3:Sprite;
      
      private var ChuiZiArr:Array;
      
      private var eggArr:Array;
      
      private var numTF:MyTextField;
      
      private var egg1:Bitmap;
      
      private var egg2:Bitmap;
      
      private var egg3:Bitmap;
      
      private var ChuiZiIndex:int;
      
      private var back:DisplayObject;
      
      private var sp:Sprite = new Sprite();
      
      private var exptxt:MyTextField;
      
      private var jd:MovieClip;
      
      public function JinDanPanel()
      {
         super();
         regResource("lang/ch/Egg_Imgs.swf","Egg_Imgsdm");
      }
      
      override protected function initStaticView() : void
      {
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":524,
            "height":380
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":476,
            "height":330
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":34,
            "y":50,
            "width":456,
            "height":280
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":490,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHd);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
      }
      
      override protected function initUI2() : void
      {
         this.ChuiZiIndex = 0;
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":44,
            "y":230,
            "width":436,
            "height":90
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":140,
            "y":337,
            "width":50,
            "height":24
         },Global.Img_Cdm);
         var tt:MyTextField = ComponentUtil.getTextField("",this,{
            "x":155,
            "y":58,
            "color":16764206,
            "size":12,
            "leading":0
         });
         tt.htmlText = LangConfig.getWord("60451",6);
         this.exptxt = ComponentUtil.getTextField("",this,{
            "x":530,
            "y":208,
            "color":16764206,
            "size":16,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60452",6),this,{
            "x":65,
            "y":285,
            "color":13421772,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60453",6),this,{
            "x":135,
            "y":285,
            "color":16777215,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60454",6),this,{
            "x":223,
            "y":285,
            "color":327424,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60455",6),this,{
            "x":311,
            "y":285,
            "color":2662342,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60456",6),this,{
            "x":399,
            "y":285,
            "color":14566855,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60457",6),this,{
            "x":50,
            "y":340,
            "color":14662240,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60458",6),this,{
            "x":330,
            "y":340,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.expTxt1 = ComponentUtil.getTextField("",this,{
            "x":47,
            "y":300,
            "color":13421772,
            "size":12,
            "leading":0
         });
         this.expTxt2 = ComponentUtil.getTextField("",this,{
            "x":135,
            "y":300,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.expTxt3 = ComponentUtil.getTextField("",this,{
            "x":223,
            "y":300,
            "color":327424,
            "size":12,
            "leading":0
         });
         this.expTxt4 = ComponentUtil.getTextField("",this,{
            "x":311,
            "y":300,
            "color":2662342,
            "size":12,
            "leading":0
         });
         this.expTxt5 = ComponentUtil.getTextField("",this,{
            "x":399,
            "y":300,
            "color":14566855,
            "size":12,
            "leading":0
         });
         this.ChuiZi1 = ComponentUtil.getBitmap("ChuiZi",this,{
            "x":60,
            "y":240
         },Global.Egg_Imgsdm);
         this.ChuiZi2 = ComponentUtil.getBitmap("ChuiZi",this,{
            "x":148,
            "y":240
         },Global.Egg_Imgsdm);
         this.ChuiZi3 = ComponentUtil.getBitmap("ChuiZi",this,{
            "x":236,
            "y":240
         },Global.Egg_Imgsdm);
         this.ChuiZi4 = ComponentUtil.getBitmap("ChuiZi",this,{
            "x":324,
            "y":240
         },Global.Egg_Imgsdm);
         this.ChuiZi5 = ComponentUtil.getBitmap("ChuiZi",this,{
            "x":412,
            "y":240
         },Global.Egg_Imgsdm);
         this.ChuiZi = ComponentUtil.getBitmap("ChuiZi",this,{
            "x":412,
            "y":240
         },Global.Egg_Imgsdm);
         this.ChuiZi1.transform.colorTransform = C0;
         this.ChuiZi2.transform.colorTransform = C1;
         this.ChuiZi3.transform.colorTransform = C2;
         this.ChuiZi4.transform.colorTransform = C3;
         this.ChuiZi5.transform.colorTransform = C4;
         this.ChuiZi.transform.colorTransform = C4;
         this.numTF = ComponentUtil.getTextField("",this,{
            "x":153,
            "y":340,
            "color":16184781,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Title_Egg",this,{
            "x":182,
            "y":5
         },Global.Egg_Imgsdm);
         this.egg1 = ComponentUtil.getBitmap("Egg_1",this,{
            "x":45,
            "y":90
         },Global.Egg_Imgsdm);
         this.egg2 = ComponentUtil.getBitmap("Egg_1",this,{
            "x":198,
            "y":90
         },Global.Egg_Imgsdm);
         this.egg3 = ComponentUtil.getBitmap("Egg_1",this,{
            "x":351,
            "y":90
         },Global.Egg_Imgsdm);
         this.spr1 = new Sprite();
         this.spr2 = new Sprite();
         this.spr3 = new Sprite();
         this.spr4 = new Sprite();
         this.spr5 = new Sprite();
         this.ChuiZiArr = [this.spr1,this.spr2,this.spr3,this.spr4,this.spr5];
         var i:int = 0;
         while(i < 5)
         {
            this.ChuiZiArr[i].graphics.beginFill(0,0);
            this.ChuiZiArr[i].graphics.drawRect(60 + i * 88,240,50,50);
            this.ChuiZiArr[i];
            addChild(this.ChuiZiArr[i]);
            i++;
         }
         this.spr1.addEventListener(MouseEvent.CLICK,this.spr1Click);
         this.spr2.addEventListener(MouseEvent.CLICK,this.spr2Click);
         this.spr3.addEventListener(MouseEvent.CLICK,this.spr3Click);
         this.spr4.addEventListener(MouseEvent.CLICK,this.spr4Click);
         this.spr5.addEventListener(MouseEvent.CLICK,this.spr5Click);
         this.eggspr1 = new Sprite();
         this.eggspr2 = new Sprite();
         this.eggspr3 = new Sprite();
         this.eggArr = [this.eggspr1,this.eggspr2,this.eggspr3,this.egg1,this.egg2,this.egg3];
         var j:int = 0;
         while(j < 3)
         {
            setChildIndex(this.eggArr[j + 3],4);
            this.eggArr[j].graphics.beginFill(16711680,0);
            this.eggArr[j].graphics.drawRect(45 + j * 153,90,128,136);
            addChild(this.eggArr[j]);
            j++;
         }
         this.eggspr1.addEventListener(MouseEvent.CLICK,this.egg1Click);
         this.eggspr2.addEventListener(MouseEvent.CLICK,this.egg2Click);
         this.eggspr3.addEventListener(MouseEvent.CLICK,this.egg3Click);
         this.eggspr1.addEventListener(MouseEvent.ROLL_OVER,this.eggspr1Over);
         this.eggspr2.addEventListener(MouseEvent.ROLL_OVER,this.eggspr2Over);
         this.eggspr3.addEventListener(MouseEvent.ROLL_OVER,this.eggspr3Over);
         this.eggspr1.addEventListener(MouseEvent.ROLL_OUT,this.eggspr1Out);
         this.eggspr2.addEventListener(MouseEvent.ROLL_OUT,this.eggspr2Out);
         this.eggspr3.addEventListener(MouseEvent.ROLL_OUT,this.eggspr3Out);
         addEventListener(FocusEvent.FOCUS_OUT,this.onFocusOutHd);
      }
      
      private function onFocusOutHd(e:Event) : void
      {
         this.clearMouse();
      }
      
      private function onMouseOutHd(e:Event) : void
      {
         if(mouseX < this.back.x || mouseY < this.back.y || mouseX > this.back.x + this.back.width || mouseY > this.back.y + this.back.height)
         {
            this.clearMouse();
         }
      }
      
      private function setNormal(egg:DisplayObject) : void
      {
         egg.transform.colorTransform = Util.colorNomal;
      }
      
      private function setWhite2(egg:DisplayObject) : void
      {
         egg.transform.colorTransform = Util.colorWhite2;
      }
      
      private function clearMouse() : void
      {
         Mouse.show();
         removeEventListener(Event.ENTER_FRAME,this.chuiziMove);
         if(Boolean(this.ChuiZi))
         {
            this.ChuiZi.x = 412;
            this.ChuiZi.y = 240;
            this.ChuiZi.transform.colorTransform = C4;
         }
         this.ChuiZiIndex = 0;
      }
      
      public function getexp() : void
      {
         switch(JinDanVO.doubleexp)
         {
            case 1:
               this.exptxt.htmlText = "<font color = \'#00FF00\'>" + LangConfig.getWord("60459",6) + 1 + LangConfig.getWord("60460",6) + JinDanVO.exp + LangConfig.getWord("60461",6) + "</font>";
               break;
            case 2:
               this.exptxt.htmlText = "<font color = \'#00FF00\'>" + LangConfig.getWord("60459",6) + 1.5 + LangConfig.getWord("60460",6) + JinDanVO.exp + LangConfig.getWord("60461",6) + "</font>";
               break;
            case 3:
               this.exptxt.htmlText = "<font color = \'#00FF00\'>" + LangConfig.getWord("60459",6) + 2.5 + LangConfig.getWord("60460",6) + JinDanVO.exp + LangConfig.getWord("60461",6) + "</font>";
         }
         this.sp.addChild(this.exptxt);
         stage.addChild(this.sp);
         Tween.to(this.sp,2000,{},this.onSpTweenComplete);
      }
      
      private function onSpTweenComplete(sp:Sprite) : void
      {
         var child:DisplayObject = null;
         while(sp.numChildren > 0)
         {
            child = sp.getChildAt(0);
            sp.removeChild(child);
         }
         if(Boolean(sp.parent))
         {
            sp.parent.removeChild(sp);
         }
      }
      
      private function eggspr1Over(e:MouseEvent) : void
      {
         this.setWhite2(this.egg1);
      }
      
      private function eggspr2Over(e:MouseEvent) : void
      {
         this.setWhite2(this.egg2);
      }
      
      private function eggspr3Over(e:MouseEvent) : void
      {
         this.setWhite2(this.egg3);
      }
      
      private function eggspr1Out(e:MouseEvent) : void
      {
         this.setNormal(this.egg1);
      }
      
      private function eggspr2Out(e:MouseEvent) : void
      {
         this.setNormal(this.egg2);
      }
      
      private function eggspr3Out(e:MouseEvent) : void
      {
         this.setNormal(this.egg3);
      }
      
      private function spr1Click(e:MouseEvent) : void
      {
         var arr:Array = [this.ChuiZi,this.ChuiZi1,this.ChuiZi2,this.ChuiZi3,this.ChuiZi4,this.ChuiZi5];
         Mouse.hide();
         this.ChuiZiIndex = 1;
         this.getChuiZi();
      }
      
      private function spr2Click(e:MouseEvent) : void
      {
         if(CommandManager.get_bag_count(46252,2) > 0)
         {
            Mouse.hide();
            this.ChuiZiIndex = 2;
            this.getChuiZi();
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("60462",6));
         }
      }
      
      private function spr3Click(e:MouseEvent) : void
      {
         if(CommandManager.get_bag_count(46253,2) > 0)
         {
            Mouse.hide();
            this.ChuiZiIndex = 3;
            this.getChuiZi();
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("60462",6));
         }
      }
      
      private function spr4Click(e:MouseEvent) : void
      {
         if(CommandManager.get_bag_count(46254,2) > 0)
         {
            Mouse.hide();
            this.ChuiZiIndex = 4;
            this.getChuiZi();
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("60462",6));
         }
      }
      
      private function spr5Click(e:MouseEvent) : void
      {
         if(CommandManager.get_bag_count(46255,2) > 0)
         {
            Mouse.hide();
            this.ChuiZiIndex = 5;
            this.getChuiZi();
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("60462",6));
         }
      }
      
      private function s(e:Event) : void
      {
         if(this.jd.currentFrame == this.jd.totalFrames)
         {
            this.jd.stop();
            if(Boolean(this.jd.parent))
            {
               this.jd.parent.removeChild(this.jd);
            }
            if(JinDanVO.num == 0)
            {
               this.jd.removeEventListener(Event.EXIT_FRAME,this.s);
            }
         }
      }
      
      private function egg1Click(e:MouseEvent) : void
      {
         if(this.ChuiZiIndex != 0)
         {
            if(JinDanVO.num > 0)
            {
               this.jd.x = 45;
               this.jd.y = 90;
               this.jd.gotoAndPlay(1);
               addChild(this.jd);
               this.egg1.bitmapData = ComponentUtil.getBitmapData("Egg_6",Global.Egg_Imgsdm);
               this.hit();
            }
            else
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60463",6));
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("60464",6));
         }
      }
      
      private function egg2Click(e:MouseEvent) : void
      {
         if(this.ChuiZiIndex != 0)
         {
            if(JinDanVO.num > 0)
            {
               this.jd.x = 198;
               this.jd.y = 90;
               this.jd.gotoAndPlay(1);
               addChild(this.jd);
               this.egg2.bitmapData = ComponentUtil.getBitmapData("Egg_6",Global.Egg_Imgsdm);
               this.hit();
            }
            else
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60463",6));
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("60464",6));
         }
      }
      
      private function egg3Click(e:MouseEvent) : void
      {
         if(this.ChuiZiIndex != 0)
         {
            if(JinDanVO.num > 0)
            {
               this.jd.x = 351;
               this.jd.y = 90;
               this.jd.gotoAndPlay(1);
               addChild(this.jd);
               this.egg3.bitmapData = ComponentUtil.getBitmapData("Egg_6",Global.Egg_Imgsdm);
               this.hit();
            }
            else
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60463",6));
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("60464",6));
         }
      }
      
      private function getChuiZi() : void
      {
         var colorTransform:ColorTransform = new ColorTransform();
         addEventListener(Event.ENTER_FRAME,this.chuiziMove);
         switch(this.ChuiZiIndex)
         {
            case 1:
               this.ChuiZi.transform.colorTransform = C0;
               break;
            case 2:
               this.ChuiZi.transform.colorTransform = C1;
               break;
            case 3:
               this.ChuiZi.transform.colorTransform = C2;
               break;
            case 4:
               this.ChuiZi.transform.colorTransform = C3;
               break;
            case 5:
               this.ChuiZi.transform.colorTransform = C4;
         }
         this.eggsX();
      }
      
      private function chuiziMove(e:Event) : void
      {
         this.ChuiZi.x = mouseX;
         this.ChuiZi.y = mouseY - 15;
      }
      
      public function getnum() : void
      {
         this.expTxt1.htmlText = LangConfig.getWord("60466",6) + JinDanVO.jcexp;
         this.expTxt2.htmlText = LangConfig.getWord("60466",6) + JinDanVO.jcexp * 1.25;
         this.expTxt3.htmlText = LangConfig.getWord("60466",6) + JinDanVO.jcexp * 1.5;
         this.expTxt4.htmlText = LangConfig.getWord("60466",6) + JinDanVO.jcexp * 1.75;
         this.expTxt5.htmlText = LangConfig.getWord("60466",6) + JinDanVO.jcexp * 2;
         this.numTF.htmlText = JinDanVO.num + "/3";
         this.ChuiZiIndex = 0;
         removeEventListener(Event.ENTER_FRAME,this.chuiziMove);
         this.ChuiZi.x = 412;
         this.ChuiZi.y = 240;
      }
      
      public function eggsX() : void
      {
         this.egg1.bitmapData = ComponentUtil.getBitmapData("Egg_1",Global.Egg_Imgsdm);
         this.egg2.bitmapData = ComponentUtil.getBitmapData("Egg_1",Global.Egg_Imgsdm);
         this.egg3.bitmapData = ComponentUtil.getBitmapData("Egg_1",Global.Egg_Imgsdm);
      }
      
      private function hit() : void
      {
         Mouse.show();
         JinDanCGMessage.CG_HIT_EGG(this.ChuiZiIndex - 1);
      }
      
      override public function set visible(value:Boolean) : void
      {
         var t:Array = null;
         if(!this.jd && value)
         {
            t = [];
            t.push(["lang/ch/test.swf",function(info:Object):void
            {
               jd = info.content;
               jd.stop();
               jd.addEventListener(Event.EXIT_FRAME,s);
               visible = true;
            },LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
            View_loading.instance.load(t,function():void
            {
               View_loading.instance.visible = false;
            });
            View_loading.instance.visible = true;
            return;
         }
         if(!value)
         {
            this.clearMouse();
         }
         super.visible = value;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.back.width) / 2;
         y = (Global.stage.stageHeight - this.back.height) / 2;
      }
   }
}

