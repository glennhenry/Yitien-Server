package com.yiTian.view.modules.zhuanZhi
{
   import Layout.HGroup;
   import Layout.ILayout;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.ZhuanZhiCGMessage;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.specialBtnDill.Model_specialD;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_zhuanZhiTask extends Panel123
   {
      
      private var list:Object;
      
      private var btn:Button;
      
      private var l:ILayout;
      
      private var _items:Array = [];
      
      private var _lastIndex:int = 0;
      
      private var _tfDescript:MyTextField;
      
      private var _tfReward:MyTextField;
      
      private var _tfTiaoJian:MyTextField;
      
      public function View_zhuanZhiTask()
      {
         super();
         regResource("lang/ch/ZhuanZhi_Imgs.swf","ZhuanZhi_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         var i:int = 0;
         var bm:Bitmap = null;
         var item:CHOOSEITEM = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":498,
            "height":330
         },Global.Img_Cdm);
         move = new Rectangle(0,0,width,38);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":450,
            "height":280
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":187,
            "y":50,
            "width":277,
            "height":260
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":188,
            "y":51,
            "width":275,
            "height":26
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":34,
            "y":50,
            "width":144,
            "height":260
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":188,
            "y":243,
            "width":275,
            "height":26
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":188,
            "y":157,
            "width":275,
            "height":26
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":35,
            "y":51,
            "width":142,
            "height":26
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("21205",2),this,{
            "x":300,
            "y":54,
            "color":16764206
         });
         ComponentUtil.getTextField(LangConfig.getWord("29421",2),this,{
            "x":74,
            "y":54,
            "color":167642060
         });
         ComponentUtil.getTextField(LangConfig.getWord("21207",2),this,{
            "x":300,
            "y":160,
            "color":16764206
         });
         ComponentUtil.getTextField(LangConfig.getWord("29422",2),this,{
            "x":300,
            "y":246,
            "color":16764206
         });
         this._tfDescript = ComponentUtil.getTextField("",this,{
            "x":192,
            "y":85,
            "color":11904647,
            "realWidth":260,
            "multiline":true,
            "wordWrap":true
         });
         this._tfReward = ComponentUtil.getTextField("",this,{
            "x":192,
            "y":191,
            "multiline":true,
            "color":16383744
         });
         this._tfTiaoJian = ComponentUtil.getTextField("",this,{
            "x":192,
            "y":277,
            "multiline":true,
            "color":16383744
         });
         this.btn = ComponentUtil.getButton("","Button_Orange",this,{
            "x":380,
            "y":277,
            "textColor":16184781,
            "callBack":this.btnClickHd
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":464,
            "y":6,
            "textColor":16184781,
            "callBack":this.btnCloseClickHd
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_JinJie",this,{
            "x":169,
            "y":5
         },Global.ZhuanZhi_Imgsdm);
         var bmUrlArr:Array = ["No_1","No_2","No_3"];
         var l:ILayout = new HGroup(36,78,0,0,0,52);
         i = 0;
         while(i < 3)
         {
            bm = ComponentUtil.getBitmap(bmUrlArr[i],null,null,Global.ZhuanZhi_Imgsdm);
            item = new CHOOSEITEM(bm);
            item.addEventListener(MouseEvent.CLICK,this.itemChoose);
            item.buttonMode = true;
            this._items.push(item);
            addChild(item);
            l.appendItem(item);
            i += 1;
         }
         l.align();
         l.dispose();
      }
      
      public function getChooseIndex() : int
      {
         return this._lastIndex;
      }
      
      public function setChooseIndex(v:int = -1) : void
      {
         if(this._lastIndex >= 0)
         {
            this._items[this._lastIndex].setSelected(false);
            this._items[this._lastIndex].updateFace();
         }
         if(v == -1)
         {
            v = this._lastIndex;
         }
         this._lastIndex = v;
         this._items[v].setSelected(true);
         this._items[v].updateFace();
         var state:int = int(Model_zhuanZhi.myTaskInfos[v][1]);
         this._tfDescript.htmlText = ZhuanZhiUtil.getDescript(v + 1);
         this._tfReward.htmlText = ZhuanZhiUtil.getRewardStr(v + 1);
         this._tfTiaoJian.htmlText = state <= 2 ? ZhuanZhiUtil.getCondDescript(v + 1) : LangConfig.getWord("10460",1);
         this.updateBtn(Model_zhuanZhi.myTaskInfos[v][1]);
      }
      
      private function itemChoose(e:MouseEvent) : void
      {
         var idx:int = this._items.indexOf(e.target);
         this.setChooseIndex(idx);
      }
      
      private function btnCloseClickHd(e:MouseEvent) : void
      {
         this.visible = false;
      }
      
      private function btnClickHd(e:MouseEvent) : void
      {
         ZhuanZhiCGMessage.CG_APPLY_TASK(this._lastIndex + 1);
      }
      
      public function updateBtn(v:int) : void
      {
         if(v == 0)
         {
            this.btn.label = LangConfig.getWord("29423",2);
         }
         else if(v == 1)
         {
            this.btn.label = LangConfig.getWord("29074",2);
         }
         else if(v == 2)
         {
            this.btn.label = LangConfig.getWord("29423",2);
         }
         else if(v == 3)
         {
            this.btn.label = LangConfig.getWord("29424",2);
         }
         this.btn.enabled = v == 2;
      }
      
      public function update() : void
      {
         var state:int = 0;
         var v:Array = Model_zhuanZhi.myTaskInfos;
         var i:int = 0;
         while(i < 3)
         {
            state = int(v[i][1]);
            this._items[i].setState(state);
            i += 1;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            this.update();
            Global.control.registerCallBack(Enum_MsgType.BAG_UPDATE,this.onBagChange);
            this.setChooseIndex(ZhuanZhiUtil.getCanSumitTaskIndex(Model_zhuanZhi.myTaskInfos));
            super.visible = value;
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.BAG_UPDATE,this.onBagChange);
            Model_specialD.visFalseComp(this,ZhuanZhiUtil.zhuanZhiTipBtn,this.superHide);
         }
      }
      
      private function superHide() : void
      {
         super.visible = false;
      }
      
      private function onBagChange() : void
      {
         ZhuanZhiCGMessage.CG_ZZ_ZHUANZHIINFO();
         this.setChooseIndex();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

import com.utils.ComponentUtil;
import com.utils.Util;
import com.yiTian.Global;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;

class CHOOSEITEM extends Sprite
{
   
   private static const DEFINENAMES:Array = ["Closed","Opened","Opened","Finished"];
   
   private var _selected:Boolean = false;
   
   private var _rollOver:Boolean = false;
   
   private var _info:Object;
   
   private var _bmState:Bitmap;
   
   public function CHOOSEITEM(bm:Bitmap)
   {
      super();
      addChild(bm);
      this.enabledEvents();
      mouseChildren = false;
      this._bmState = new Bitmap();
      this._bmState.x = 95;
      addChild(this._bmState);
   }
   
   public function enabledEvents() : void
   {
      addEventListener(MouseEvent.ROLL_OVER,this.rollOverHd);
      addEventListener(MouseEvent.ROLL_OUT,this.rollOutHd);
      addEventListener(MouseEvent.CLICK,this.clickHd);
   }
   
   private function rollOverHd(evt:MouseEvent) : void
   {
      this._rollOver = true;
      this.updateFace();
   }
   
   private function rollOutHd(evt:MouseEvent) : void
   {
      this._rollOver = false;
      this.updateFace();
   }
   
   private function clickHd(evt:MouseEvent) : void
   {
      this.setSelected(true);
   }
   
   public function setSelected(v:Boolean) : void
   {
      this._selected = v;
   }
   
   public function updateFace() : void
   {
      transform.colorTransform = Boolean(this._selected) || Boolean(this._rollOver) ? Util.colorWhite2 : Util.colorNomal;
   }
   
   public function setState(v:uint) : void
   {
      this._bmState.bitmapData = ComponentUtil.getBitmapData(DEFINENAMES[v],Global.ZhuanZhi_Imgsdm);
   }
}
