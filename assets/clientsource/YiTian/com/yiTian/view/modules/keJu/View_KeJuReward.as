package com.yiTian.view.modules.keJu
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_KeJu;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.model.Model_KeJu;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.KejuCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.UIBase;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_KeJuReward extends UIBase
   {
      
      private static var _instance:View_KeJuReward;
      
      private var btn_roll:Button;
      
      private var back:Sprite;
      
      private var closeButton:Button;
      
      private var content:MyTextField;
      
      private var vec:Vector.<fxqCJItemH>;
      
      public function View_KeJuReward()
      {
         super();
         init();
      }
      
      public static function get instance() : View_KeJuReward
      {
         if(!_instance)
         {
            _instance = new View_KeJuReward();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         this.back = new Sprite();
         addChild(this.back);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.back,{
            "x":0,
            "y":0,
            "width":408,
            "height":190
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.back,{
            "x":24,
            "y":40,
            "width":360,
            "height":140
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this.back,{
            "x":34 + 120,
            "y":50,
            "width":220,
            "height":120
         },Global.Img_Cdm);
         this.content = ComponentUtil.getTextField("",this,{
            "x":34,
            "y":60,
            "color":16777215,
            "size":12,
            "realWidth":115
         });
         this.content.wordWrap = true;
         ComponentUtil.getTextField(LangConfig.getWord("80053",8),this,{
            "x":34,
            "y":130
         });
         this.closeButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":374,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.closeButton.addEventListener(MouseEvent.CLICK,function():void
         {
            visible = false;
         });
      }
      
      override protected function initDynamicView() : void
      {
         bindParent = GameScene.modalLayer;
         this.createItem();
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
      
      private function createItem() : void
      {
         var y1:Number = NaN;
         var i:int = 0;
         var it:fxqCJItemH = null;
         var x1:Number = 80 + 120;
         y1 = 88;
         this.vec = new Vector.<fxqCJItemH>();
         i = 0;
         while(i < 2)
         {
            it = new fxqCJItemH();
            it.init();
            it.x = x1 + i * 55;
            it.y = y1;
            addChild(it);
            this.vec.push(it);
            i += 1;
         }
      }
      
      private function startRoll(event:MouseEvent) : void
      {
         if(Model_KeJu.version != 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80048",8));
            return;
         }
         KejuCGMessage.CG_KEJUROLL(Model_KeJu.version);
      }
      
      public function show(num:int, vo:MyInfoVO) : void
      {
         this.visible = true;
         this.content.htmlText = LangConfig.getWord("80049",8,num,vo.count,vo.num,DateUtil.getMSBySecond3(vo.time));
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!Global.KeJu_Imgsdm)
            {
               this.load();
            }
            else if(!this.btn_roll)
            {
               this.sourceComplete();
            }
         }
      }
      
      private function load() : void
      {
         var arr:Array = [];
         arr.push([Enum_KeJu.KEJUSOURCE,this.sourceComplete,LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr,function():void
         {
            View_loading.instance.visible = false;
         });
      }
      
      private function sourceComplete(info:Object = null) : void
      {
         if(Boolean(info))
         {
            Global.KeJu_Imgsdm = info.applicationDomain;
         }
         ComponentUtil.getBitmap("Back_TongGuan",this.back,{
            "x":50 + 120,
            "y":70
         },Global.KeJu_Imgsdm);
         this.btn_roll = ComponentUtil.getButton("","Button_YaoJiang",this,{
            "x":201 + 120,
            "y":83,
            "textColor":16184781
         },Global.KeJu_Imgsdm);
         this.btn_roll.callBack = this.startRoll;
         ComponentUtil.getBitmap("Title_ChouJiang",this,{
            "x":124,
            "y":5
         },Global.KeJu_Imgsdm);
         this.resetPosition();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ColorConstant;
import com.utils.ComponentUtil;
import com.yiTian.data.model.Model_KeJu;
import com.yiTian.manager.LangConfig;
import com.yiTian.manager.UIManager;
import com.yiTian.utils.HtmlUtil;
import com.yiTian.utils.Tween;
import flash.display.Shape;
import flash.display.Sprite;

class fxqCJItemH extends Sprite
{
   
   private static var counter:int;
   
   private static const OFFSET:Number = -41;
   
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
            "x":12,
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
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("80032",8,Model_KeJu.lqNum));
         Model_KeJu.lqNum = 0;
      }
   }
   
   private function getTxt(num:int) : String
   {
      return HtmlUtil.font(num.toString(),ColorConstant.getColorStr(ColorConstant.YELLOW_SAND),30);
   }
}
