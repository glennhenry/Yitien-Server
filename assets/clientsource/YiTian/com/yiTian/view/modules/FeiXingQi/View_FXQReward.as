package com.yiTian.view.modules.FeiXingQi
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.net.message.cg.FeiXingQiCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   
   public class View_FXQReward extends Panel123
   {
      
      private var bg:DisplayObjectContainer;
      
      private var titleBg:Bitmap;
      
      private var vecGed2:Vector.<fxqCJItem11>;
      
      private var vec:Vector.<fxqCJItemH>;
      
      private var tf_title:MyTextField;
      
      private var btn_roll:Button;
      
      public function View_FXQReward()
      {
         super();
         regResource(Enum_FeiXingQi.TOUZIDIR,"ChuangGuan_Imgsdm");
      }
      
      override protected function initStaticView() : void
      {
         this.bg = new Sprite();
         this.bg.mouseEnabled = false;
         addChild(this.bg);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.bg,{
            "x":0,
            "y":0,
            "width":456,
            "height":181
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":422,
            "y":6,
            "textColor":16184781,
            "callBack":this.hide
         },Global.Img_Cdm);
      }
      
      override protected function initDynamicView() : void
      {
         bindParent = GameScene.modalLayer;
      }
      
      override public function get width() : Number
      {
         return this.bg.width;
      }
      
      override public function get height() : Number
      {
         return this.bg.height;
      }
      
      public function show() : void
      {
         ModalUIManager.POPUP(this);
         pop();
      }
      
      public function hide(e:MouseEvent = null) : void
      {
         ModalUIManager.UNPOP();
      }
      
      override protected function initUI2() : void
      {
         var x1:Number;
         var ox:Number;
         var y1:Number = NaN;
         var i:int = 0;
         var itt:fxqCJItem11 = null;
         var it:fxqCJItemH = null;
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.bg,{
            "x":24,
            "y":40,
            "width":408,
            "height":131
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this.bg,{
            "x":127,
            "y":45,
            "width":221,
            "height":119
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this.bg,{
            "x":33,
            "y":45,
            "width":91,
            "height":119
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Back_TongGuan",this.bg,{
            "x":140,
            "y":74
         },Global.ChuangGuan_Imgsdm);
         this.initB();
         this.btn_roll = ComponentUtil.getButton("","Button_YaoJiang",this,{
            "x":292,
            "y":82
         },Global.ChuangGuan_Imgsdm);
         x1 = 177;
         ox = 55;
         y1 = 90;
         this.vecGed2 = new Vector.<fxqCJItem11>();
         i = 0;
         while(i < 1)
         {
            itt = new fxqCJItem11();
            itt.init();
            itt.x = 59;
            itt.y = 94;
            addChild(itt);
            this.vecGed2.push(itt);
            i += 1;
         }
         this.vec = new Vector.<fxqCJItemH>();
         i = 0;
         while(i < 2)
         {
            it = new fxqCJItemH();
            it.init();
            it.x = x1 + i * ox;
            it.y = y1;
            addChild(it);
            this.vec.push(it);
            i += 1;
         }
         this.btn_roll.callBack = function(evt:MouseEvent):void
         {
            FeiXingQiCGMessage.CG_ROLLREWARD(Model_FeiXingQi.version);
         };
         this.titleBg = ComponentUtil.getBitmap("Title_PassAward",this,{
            "x":148,
            "y":5
         },Global.ChuangGuan_Imgsdm);
      }
      
      public function roll11(id:int) : void
      {
         var i:int = 0;
         while(i < this.vecGed2.length)
         {
            this.vecGed2[i].start(id);
            i += 1;
         }
         fxqCJItem11.tt1 = 0;
      }
      
      public function roll(arr:Array) : void
      {
         var i:int = 0;
         while(i < this.vec.length)
         {
            this.vec[i].start(arr[i]);
            i += 1;
         }
         fxqCJItemH.tt1 = 0;
      }
      
      public function initB() : void
      {
         var tf:MyTextField = null;
         tf = ComponentUtil.getTextField("",this,{
            "x":72,
            "y":52,
            "color":16759552,
            "size":12,
            "leading":0
         });
         tf.autoSize = TextFieldAutoSize.CENTER;
         tf.text = LangConfig.getWord("29137",2);
         tf = ComponentUtil.getTextField("",this,{
            "x":205,
            "y":52,
            "color":16759552,
            "size":12,
            "leading":0
         });
         tf.autoSize = TextFieldAutoSize.CENTER;
         tf.text = LangConfig.getWord("29138",2);
         this.tf_title = ComponentUtil.getTextField("",this,{
            "x":351,
            "y":62,
            "realWidth":85,
            "color":14013809
         });
         this.tf_title.wordWrap = true;
         this.tf_title.autoSize = TextFieldAutoSize.CENTER;
         this.tf_title.htmlText = LangConfig.getWord("20328",2);
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ColorConstant;
import com.utils.ComponentUtil;
import com.yiTian.data.Enum_type_grid;
import com.yiTian.data.vo.Vo_item;
import com.yiTian.net.handler.FeiXingQiHandle;
import com.yiTian.utils.HtmlUtil;
import com.yiTian.utils.Tween;
import com.yiTian.view.comp.View_Grid;
import flash.display.Shape;
import flash.display.Sprite;

class fxqCJItem11 extends Sprite
{
   
   private static var counter:int;
   
   private static const OFFSET:Number = -50;
   
   private static const ITEMNUM:int = 2;
   
   public static var tt1:int = 0;
   
   private var vec:Vector.<View_Grid>;
   
   private var container:Sprite;
   
   private var _mask:Shape;
   
   private var rnd:int;
   
   private var d:uint;
   
   private var index:int;
   
   private var total:Number;
   
   private var startNum:Number;
   
   private var temp:Number;
   
   public function fxqCJItem11()
   {
      super();
   }
   
   public function init() : void
   {
      var i:int = 0;
      var grid:View_Grid = null;
      this.container = new Sprite();
      addChild(this.container);
      this._mask = ComponentUtil.getShape(50,50,65280,0.3);
      addChild(this._mask);
      this._mask.y = -8;
      this._mask.x = -6;
      mask = this._mask;
      this.vec = new Vector.<View_Grid>();
      i = 0;
      while(i < ITEMNUM)
      {
         grid = new View_Grid();
         grid.type = Enum_type_grid.NO_DRAG;
         grid.set_bmp_over(true,null);
         grid.set_bmp_bg();
         grid.set_bmp_select();
         grid.vo = this.getVo(this.getRnd());
         grid.y = i * OFFSET;
         this.container.addChild(grid);
         this.vec.push(grid);
         i += 1;
      }
   }
   
   private function onStep() : void
   {
      this.total = this.startNum - this.container.y;
      while(this.index <= this.total / OFFSET)
      {
         this.index += 1;
         this.vec[0].y = this.vec[this.vec.length - 1].y + OFFSET;
         this.vec.push(this.vec.shift());
         if(this.index == this.rnd)
         {
            this.vec[1].vo = this.getVo(this.d);
         }
         else
         {
            this.vec[1].vo = this.getVo(this.getRnd());
         }
      }
   }
   
   public function start(dis:uint) : void
   {
      counter = 0;
      this.rnd = 22 + tt1;
      tt1 += 2;
      this.d = dis;
      var offset:Number = this.rnd * OFFSET;
      this.index = 1;
      this.total = 0;
      this.temp = this.startNum = this.container.y;
      var timeCost:int = this.rnd * 200;
      Tween.to(this.container,timeCost,{"y":[this.container.y,this.container.y - offset]},this.onC,this.onStep,Tween.EASYINOUT);
   }
   
   private function onC() : void
   {
      counter += 1;
      if(counter >= 1)
      {
         counter = 0;
         FeiXingQiHandle.SHOWAWARD();
      }
   }
   
   private function getRnd() : int
   {
      return 46151 + Math.random() * 6;
   }
   
   private function getVo(id:int) : Vo_item
   {
      var vo:Vo_item = new Vo_item();
      vo.id = id;
      vo.Init_lib();
      return vo;
   }
}

class fxqCJItemH extends Sprite
{
   
   private static var counter:int;
   
   private static const OFFSET:Number = -50;
   
   private static const ITEMNUM:int = 2;
   
   public static var tt1:int = 0;
   
   private var vec:Vector.<MyTextField>;
   
   private var container:Sprite;
   
   private var _mask:Shape;
   
   private var rnd:int;
   
   private var d:uint;
   
   private var index:int;
   
   private var total:Number;
   
   private var startNum:Number;
   
   private var temp:Number;
   
   public function fxqCJItemH()
   {
      super();
   }
   
   public function init() : void
   {
      var tf:MyTextField = null;
      this.container = new Sprite();
      addChild(this.container);
      this._mask = ComponentUtil.getShape(40,40,65280,0.3);
      this._mask.y = 5;
      addChild(this._mask);
      mask = this._mask;
      this.vec = new Vector.<MyTextField>();
      var i:int = 0;
      while(i < ITEMNUM)
      {
         tf = ComponentUtil.getTextField("",this.container,{
            "x":3,
            "y":OFFSET * i + 3
         });
         tf.htmlText = this.getTxt(Math.random() * 6 + 1);
         this.vec.push(tf);
         i += 1;
      }
   }
   
   public function start(dis:uint) : void
   {
      counter = 0;
      this.rnd = 18 + tt1;
      tt1 += 2;
      this.d = dis;
      var offset:Number = this.rnd * OFFSET;
      this.index = 1;
      this.total = 0;
      this.temp = this.startNum = this.container.y;
      var timeCost:int = this.rnd * 200;
      Tween.to(this.container,timeCost,{"y":[this.container.y,this.container.y - offset]},this.onC,this.onStep,Tween.EASYINOUT);
   }
   
   private function onStep() : void
   {
      this.total = this.startNum - this.container.y;
      while(this.index <= this.total / OFFSET)
      {
         this.index += 1;
         this.vec[0].y = this.vec[this.vec.length - 1].y + OFFSET;
         this.vec.push(this.vec.shift());
         if(this.index == this.rnd)
         {
            this.vec[1].htmlText = this.getTxt(this.d);
         }
         else
         {
            this.vec[1].htmlText = this.getTxt(1 + Math.random() * 9);
         }
      }
   }
   
   private function onC() : void
   {
      counter += 1;
      if(counter >= 2)
      {
         counter = 0;
      }
   }
   
   private function getTxt(num:int) : String
   {
      return HtmlUtil.font(num.toString(),ColorConstant.getColorStr(ColorConstant.YELLOW_SAND),30);
   }
}
