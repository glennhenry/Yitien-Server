package com.yiTian.view.modules.tuanGou
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_TuanGou;
   import com.yiTian.data.vo.Vo_TuanGouItem;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import flash.display.Bitmap;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   
   public class ViewTuanGouPanel extends Panel
   {
      
      private var back:ScaleBitmap;
      
      private var buttonHelpParetn:Sprite;
      
      private var ButtonHelp:MyTextField;
      
      private var txt1:MyTextField;
      
      private var txt2:MyTextField;
      
      private var txt3:MyTextField;
      
      private var nameTxt1:MyTextField;
      
      private var nameTxt2:MyTextField;
      
      private var nameTxt3:MyTextField;
      
      private var shengYuTxt:MyTextField;
      
      private var vecTxt:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var wheel:TuanGouWheel;
      
      private var biLi:int = 23;
      
      private var expBg:Bitmap;
      
      private var expBar:Bitmap;
      
      private var expMask:Shape;
      
      private var jyTip:Sprite;
      
      private const WIDTH:int = 450;
      
      private const HEIGHT:int = 15;
      
      private var min:int = 115;
      
      private var max:int = 46000;
      
      private const itemNum:int = 4;
      
      private const lineNum:int = 2;
      
      private var itemArr:Array = [];
      
      private var isTrue:Boolean;
      
      private var eX:int = 55;
      
      private var cy:int = 365;
      
      private var vecJingYan:Vector.<int> = new <int>[0,2300,4600,8280,11960,15640,20240,24840,29440,34960,40480,46000];
      
      private var vecJingYan2:Vector.<int> = new <int>[0,500,1500,3000,5000,7000,12000,17000,22000,30000,38000,46000];
      
      private var rate:Vector.<Number> = new <Number>[0,0.05,0.1,0.18,0.26,0.34,0.44,0.54,0.64,0.76,0.88,1];
      
      private var bmTitle:Bitmap = new Bitmap();
      
      private var isFrist:Boolean = true;
      
      public function ViewTuanGouPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":910,
            "height":459
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":65,
            "width":860,
            "height":385
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":34,
            "y":348,
            "width":495,
            "height":91
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":34,
            "y":75,
            "width":495,
            "height":264
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":875,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.txt1 = ComponentUtil.getTextField("",this,{
            "x":42,
            "y":39,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.txt2 = ComponentUtil.getTextField("",this,{
            "x":205,
            "y":82,
            "color":16764206,
            "size":14,
            "leading":0
         });
         this.txt2.htmlText = LangConfig.getWord("50064",5,5);
         this.txt3 = ComponentUtil.getTextField("",this,{
            "x":590,
            "y":35,
            "color":16764206,
            "size":16,
            "leading":0
         });
         this.txt3.htmlText = LangConfig.getWord("50065",5);
         this.nameTxt1 = ComponentUtil.getTextField("",this,{
            "x":563,
            "y":426,
            "color":16184781,
            "size":12,
            "leading":0
         });
         this.nameTxt2 = ComponentUtil.getTextField("",this,{
            "x":563,
            "y":407,
            "color":16184781,
            "size":12,
            "leading":0
         });
         this.nameTxt3 = ComponentUtil.getTextField("",this,{
            "x":563,
            "y":388,
            "color":16184781,
            "size":12,
            "leading":0
         });
         this.vecTxt.push(this.nameTxt1,this.nameTxt2,this.nameTxt3);
         this.shengYuTxt = ComponentUtil.getTextField("",this,{
            "x":772,
            "y":366,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("50070",5),this,{
            "x":140,
            "y":390,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("50071",5),this,{
            "x":44,
            "y":412,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.buttonHelpParetn = new Sprite();
         this.buttonHelpParetn.x = 313;
         this.buttonHelpParetn.y = 412;
         this.addChild(this.buttonHelpParetn);
         this.buttonHelpParetn.buttonMode = true;
         this.buttonHelpParetn.addEventListener(MouseEvent.CLICK,this.showHelpPanel);
         this.ButtonHelp = ComponentUtil.getTextField(LangConfig.getWord("60336",6),this,{
            "x":0,
            "y":0,
            "color":48384,
            "size":12,
            "leading":0
         });
         this.buttonHelpParetn.addChild(this.ButtonHelp);
         move = new Rectangle(0,0,850,38);
         this.showItem();
         this.showHelpLine();
      }
      
      private function showHelpLine() : void
      {
         var shape:Shape = new Shape();
         shape.graphics.lineStyle(2,48384);
         shape.graphics.moveTo(316,430);
         shape.graphics.lineTo(362,430);
         shape.graphics.endFill();
         addChild(shape);
      }
      
      public function updateShengYuTxt() : void
      {
         this.shengYuTxt.htmlText = LangConfig.getWord("50067",5,Model_TuanGou.keepObj.surplus);
         this.setIconEff();
      }
      
      private function showItem() : void
      {
         var i:int = 0;
         var vo:Vo_TuanGouItem = null;
         var item:TuanGouItem = null;
         i = 0;
         while(i < this.itemNum)
         {
            vo = new Vo_TuanGouItem();
            item = new TuanGouItem(vo);
            item.x = 45 + (item.width + 2) * (i % this.lineNum);
            item.y = 110 + (item.height + 2) * Math.floor(i / this.lineNum);
            addChild(item);
            this.itemArr.push(item);
            i++;
         }
      }
      
      public function updateItem() : void
      {
         var vo:Vo_TuanGouItem = null;
         var k:int = 0;
         var i:int = 0;
         while(i < Model_TuanGou.vecItemVo.length)
         {
            vo = Model_TuanGou.vecItemVo[i];
            k = Model_TuanGou.vecItemVo[i].weiZhi;
            this.itemArr[k].update(vo);
            i++;
         }
      }
      
      private function showHelpPanel(e:MouseEvent) : void
      {
         helpPanel.instance.visible = !helpPanel.instance.visible;
      }
      
      public function updateTxt(obj:Object) : void
      {
         var num:int = 0;
         this.biLi = obj.biLi;
         this.txt1.htmlText = LangConfig.getWord("50063",5,obj.playerCount,this.biLi);
         if(10 - obj.weekCount >= 0)
         {
            num = 10 - obj.weekCount;
         }
         this.txt2.htmlText = LangConfig.getWord("50064",5,num);
         this.shengYuTxt.htmlText = LangConfig.getWord("50067",5,Model_TuanGou.keepObj.surplus);
         this.setIconEff();
      }
      
      private function setIconEff() : void
      {
         if(Model_TuanGou.keepObj.surplus > 0)
         {
            ViewTuanGouTip.instance.effectBegin();
            Global.control.sendNotification(Enum_mainUIBtn_hide.ICON_EFFECT,[Enum_mainUIBtn_hide.TuanGou,1]);
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.TuanGou,1,1]);
         }
         else
         {
            ViewTuanGouTip.instance.effectEnd();
            Global.control.sendNotification(Enum_mainUIBtn_hide.ICON_EFFECT,[Enum_mainUIBtn_hide.TuanGou,0]);
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.TuanGou,1,0]);
         }
      }
      
      public function wheelNum(num:int) : void
      {
         this.wheel.start(num);
         var ef:Effect = EffectManager.addEffect("35120",this,500,340,210);
         Tween.to(ef,499,{"x":[390,590]});
      }
      
      private function draw(shape:Shape, width:int) : void
      {
         shape.graphics.clear();
         shape.graphics.beginFill(255,1);
         shape.graphics.drawRect(0,0,this.WIDTH,this.HEIGHT);
         shape.graphics.endFill();
      }
      
      private function getSprite(w:Number, h:Number) : Sprite
      {
         var temp:Sprite = new Sprite();
         var g:Graphics = temp.graphics;
         g.beginFill(16777215,0);
         g.drawRect(0,0,w,h);
         g.endFill();
         return temp;
      }
      
      public function updateName() : void
      {
         var i:int = 0;
         while(i < Model_TuanGou.vecPlayAwards.length)
         {
            this.isTrue = true;
            this.vecTxt[i].htmlText = LangConfig.getWord("50066",5,Model_TuanGou.vecPlayAwards[i].name,Model_TuanGou.vecPlayAwards[i].goodName,Model_TuanGou.vecPlayAwards[i].goodCount);
            i++;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
      }
      
      public function update() : void
      {
         this.updateExpBar();
         if(Boolean(this.wheel))
         {
            this.wheel.update();
         }
         this.updateShengYuTxt();
      }
      
      private function updateExpBar() : void
      {
         var val:int = 0;
         var index:int = 0;
         var nowRate:Number = NaN;
         var nextRate:Number = NaN;
         if(!this.expBar)
         {
            return;
         }
         if(!this.expMask)
         {
            this.expMask = new Shape();
            this.draw(this.expMask,this.WIDTH);
            this.addChild(this.expMask);
            this.expMask.x = this.eX;
            this.expMask.y = 355;
            this.expBar.mask = this.expMask;
         }
         if(Model_TuanGou.keepObj.suffer >= 46000)
         {
            this.min = this.WIDTH;
         }
         else
         {
            val = int(Model_TuanGou.keepObj.suffer);
            index = this.getIndex(val);
            nowRate = this.rate[index];
            nextRate = this.rate[index + 1];
            this.min = this.WIDTH * nowRate + (Model_TuanGou.keepObj.suffer - this.vecJingYan2[index]) / (this.vecJingYan2[index + 1] - this.vecJingYan2[index]) * (this.WIDTH * (nextRate - nowRate));
         }
         var len:Number = this.min;
         this.expMask.width = len;
         this.jyTip = this.getSprite(this.WIDTH,this.HEIGHT);
         this.jyTip.x = this.expBar.x;
         this.jyTip.y = this.expBar.y;
         addChild(this.jyTip);
         this.jyTip.addEventListener(MouseEvent.MOUSE_OVER,this.onOver);
         this.drawLine();
         this.showTxt();
      }
      
      private function getIndex(_min:int) : int
      {
         var len:int = int(this.vecJingYan2.length);
         var i:int = 0;
         while(i < len - 1)
         {
            if(this.vecJingYan2[i] <= _min && this.vecJingYan2[i + 1] > _min)
            {
               return i;
            }
            i++;
         }
         return len - 1;
      }
      
      private function showTxt() : void
      {
         var i:int = 0;
         var txt:MyTextField = null;
         i = 0;
         while(i < this.vecJingYan.length)
         {
            txt = ComponentUtil.getTextField("",this,{
               "size":10,
               "realWidth":150,
               "width":150
            });
            txt.autoSize = TextFieldAutoSize.CENTER;
            txt.x = 54 + this.vecJingYan[i] / this.max * this.WIDTH;
            txt.y = 375;
            txt.text = this.vecJingYan2[i].toString();
            addChild(txt);
            i++;
         }
      }
      
      private function showLine() : void
      {
         var shape:Shape = null;
         var i:int = 0;
         while(i < this.vecJingYan.length)
         {
            shape = new Shape();
            shape.graphics.clear();
            shape.graphics.lineStyle(2,16711680);
            shape.graphics.moveTo(0,0);
            shape.graphics.lineTo(0,this.HEIGHT);
            shape.graphics.endFill();
            shape.x = 54 + this.vecJingYan[i] / this.max * this.WIDTH;
            shape.y = 3;
            addChild(shape);
            i++;
         }
      }
      
      private function drawLine() : void
      {
         var shape:Bitmap = null;
         var i:int = 1;
         while(i < this.vecJingYan.length - 1)
         {
            shape = new Bitmap();
            Utils.loadTitle("lang/ch/TuanGou_Imgs.swf","TuanGou_ProgressCut",shape,null,this);
            shape.x = 54 + this.rate[i] * this.WIDTH;
            shape.y = 362;
            addChild(shape);
            i++;
         }
      }
      
      private function onOver(e:MouseEvent) : void
      {
         TipManager.bind(this.jyTip,LangConfig.getWord("50072",5) + Model_TuanGou.keepObj.suffer.toString() + "/" + this.max.toString());
      }
      
      public function remveBtn() : void
      {
         if(UIManager.mainUiBtnContainer.hasBTN(ViewTuanGouTip.instance))
         {
            UIManager.mainUiBtnContainer.removeBTN(ViewTuanGouTip.instance);
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.isFrist)
            {
               this.isFrist = false;
               if(!this.expBg)
               {
                  this.expBg = new Bitmap();
                  Utils.loadTitle("lang/ch/TuanGou_Imgs.swf","TuanGou_ProgressBack",this.expBg,{
                     "x":44,
                     "y":355
                  },this);
               }
               if(!this.expBar)
               {
                  this.expBar = new Bitmap();
                  Utils.loadTitle("lang/ch/TuanGou_Imgs.swf","TuanGou_Progress",this.expBar,{
                     "x":this.eX,
                     "y":365
                  },this,this.onLoadExpBar);
               }
               Utils.loadTitle("lang/ch/TuanGou_Imgs.swf","Title_TuanGou",new Bitmap(),{
                  "x":362,
                  "y":5
               },this,this.onLoadExpBar);
               if(!this.wheel)
               {
                  this.wheel = new TuanGouWheel();
               }
               this.wheel.y = -50;
               this.wheel.x = 10;
               addChild(this.wheel);
            }
            ViewTuanGouTip.isCLick = false;
            if(!this.isFrist)
            {
               this.update();
            }
         }
         else
         {
            ViewTuanGouTip.isCLick = true;
         }
      }
      
      private function onLoadExpBar() : void
      {
         this.updateExpBar();
      }
   }
}

import com.ui.controls.MyTextField;
import com.ui.controls.ScaleBitmap;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.manager.LangConfig;
import com.yiTian.utils.Utils;
import com.yiTian.view.Panel;
import flash.display.Bitmap;
import flash.geom.Rectangle;

class helpPanel extends Panel
{
   
   private static var _instance:helpPanel;
   
   private var back:ScaleBitmap;
   
   private var bmd:Bitmap;
   
   private var bmTitle:Bitmap;
   
   public function helpPanel()
   {
      super();
      init();
   }
   
   public static function get instance() : helpPanel
   {
      if(!_instance)
      {
         _instance = new helpPanel();
      }
      return _instance;
   }
   
   override protected function initStaticView() : void
   {
      ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
         "x":0,
         "y":0,
         "width":428,
         "height":340 - 40
      },Global.Img_Cdm);
      ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
         "x":24,
         "y":40,
         "width":380,
         "height":290 - 40
      },Global.Img_Cdm);
      var t:MyTextField = ComponentUtil.getTextField("",this,{
         "x":44,
         "y":50,
         "color":11904647,
         "size":12,
         "leading":3
      });
      t.multiline = true;
      t.htmlText = LangConfig.getWord("50073",5);
      var t2:MyTextField = ComponentUtil.getTextField("",this,{
         "x":59,
         "y":275 - 35,
         "color":16764206,
         "size":16,
         "leading":0
      });
      t2.multiline = true;
      t2.htmlText = LangConfig.getWord("50074",5);
      move = new Rectangle(0,0,428,38);
      CloseButton = ComponentUtil.getButton("","Button_Close",this,{
         "x":394,
         "y":6,
         "textColor":16184781
      },Global.Img_Cdm);
   }
   
   override public function resetPosition() : void
   {
      x = (Global.stage.stageWidth - width) / 2;
      y = (Global.stage.stageHeight - height) / 2;
   }
   
   override public function set visible(value:Boolean) : void
   {
      super.visible = value;
      if(value)
      {
         if(!this.bmTitle)
         {
            this.bmTitle = new Bitmap();
            Utils.loadTitle("lang/ch/TuanGou_Imgs.swf","Title_TGJieShao",this.bmTitle,{
               "x":134,
               "y":5
            },this);
         }
      }
   }
}
