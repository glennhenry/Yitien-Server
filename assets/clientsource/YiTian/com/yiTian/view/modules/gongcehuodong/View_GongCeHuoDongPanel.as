package com.yiTian.view.modules.gongcehuodong
{
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.net.message.cg.BabyGiftCGMessage;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.chunjiehuodong.View_BossTip;
   import com.yiTian.view.modules.chunjiehuodong.View_DYNG;
   import com.yiTian.view.modules.chunjiehuodong.View_ZiBiao;
   import com.yiTian.view.modules.duanwujie.View_BoatActivity;
   import com.yiTian.view.modules.zhaocaimao.View_ZhaoCaiMao;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   
   public class View_GongCeHuoDongPanel extends Panel123
   {
      
      private static var _instance:View_GongCeHuoDongPanel;
      
      public static var tipStrarr:Array = ["活动时间：<font color=\'#00ff00\'>2014年5月31日10:00-2014年6月2日23:59</font>"];
      
      private var temp:Array = [["Icon_GCZiBiao","Text_GCZiBiao",{
         "x":218,
         "y":285
      }],["Icon_XQYW","Text_GCDiaoYu",{
         "x":296,
         "y":200
      }],["Icon_ZCLM","Text_ZCLM",{
         "x":394,
         "y":144
      }],["Icon_GCJiShi","Text_GCJiShi",{
         "x":505,
         "y":107
      }],["Icon_CJQD","Text_GCQianDao",{
         "x":621,
         "y":104
      }],["Icon_NSHS","Text_GCXiShi",{
         "x":722,
         "y":157
      }],["Icon_GCHuiGui","Text_GCHuiGui",{
         "x":753,
         "y":263
      }]];
      
      private var back:ScaleBitmap;
      
      private var canyuSpr:Sprite;
      
      private var tipTargetarr:Array = new Array();
      
      private var _backPet:Bitmap;
      
      private var _isCom:Boolean = false;
      
      public function View_GongCeHuoDongPanel()
      {
         super();
         regResource("lang/ch/gongcehuodong.swf","GCHDdm");
      }
      
      public static function get instance() : View_GongCeHuoDongPanel
      {
         if(!_instance)
         {
            _instance = new View_GongCeHuoDongPanel();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var btn_1:Btn = null;
         ComponentUtil.getBitmap("Text_HDSJ",this,{
            "x":332,
            "y":447
         },Global.GCHDdm);
         ComponentUtil.getBitmap("Text_YTSD",this,{
            "x":326,
            "y":321
         },Global.GCHDdm);
         ComponentUtil.getBitmap("Back_GCSD",this,{
            "x":0,
            "y":0
         },Global.GCHDdm);
         ComponentUtil.getBitmap("Text_HDSJ",this,{
            "x":332,
            "y":447
         },Global.GCHDdm);
         ComponentUtil.getBitmap("Text_YTSD",this,{
            "x":326,
            "y":321
         },Global.GCHDdm);
         this._backPet = ComponentUtil.getBitmap("Back_PET",this,{
            "x":0,
            "y":120,
            "alpha":0
         },Global.GCHDdm);
         var i:int = 0;
         while(i < 7)
         {
            btn_1 = new Btn(this.temp[i][0],this.temp[i][1],i);
            ComponentUtil.setPropertie(btn_1,this.temp[i][2]);
            this.addChild(btn_1);
            this.tipTargetarr.push(btn_1);
            i++;
         }
         move = new Rectangle(0,33,910,40);
         CloseButton = ComponentUtil.getButton("","Button_MNGB",this,{
            "x":848,
            "y":36,
            "textColor":16771436
         },Global.GCHDdm);
         CloseButton.callBack = this.close;
         this.addclick();
         this.eff();
      }
      
      private function eff() : void
      {
         var i:int = 0;
         while(i < 7)
         {
            ComponentUtil.setPropertie(this.tipTargetarr[i],{
               "x":100,
               "y":100
            });
            i++;
         }
         i = 0;
         while(i < 7)
         {
            setTimeout(function(i:int):void
            {
               Tween.to(tipTargetarr[i],150,{
                  "x":[tipTargetarr[i].x,temp[i][2].x],
                  "y":[tipTargetarr[i].y,temp[i][2].y]
               },null,null);
            },i * (50 + i * 10),i);
            i++;
         }
      }
      
      private function addclick() : void
      {
         var i:int = 0;
         while(i < this.tipTargetarr.length)
         {
            (this.tipTargetarr[i] as Sprite).addEventListener(MouseEvent.CLICK,this.itemClick);
            i++;
         }
      }
      
      private function itemClick(e:MouseEvent) : void
      {
         var bt:Btn;
         if(!(e.currentTarget is Btn))
         {
            return;
         }
         bt = e.currentTarget as Btn;
         switch(bt)
         {
            case this.tipTargetarr[0]:
               Global.delegate.dosomething(View_ZiBiao.instance,function():void
               {
                  View_ZiBiao.instance.visible = true;
               });
               break;
            case this.tipTargetarr[1]:
               Global.delegate.dosomething(View_DYNG.instance,function():void
               {
                  View_DYNG.instance.visible = true;
               });
               break;
            case this.tipTargetarr[2]:
               View_ZhaoCaiMao.instance.show();
               break;
            case this.tipTargetarr[3]:
               Global.delegate.dosomething(View_GongCejishi.instance,function():void
               {
                  View_GongCejishi.instance.visible = true;
               });
               break;
            case this.tipTargetarr[4]:
               Global.delegate.dosomething(View_BoatActivity.instance,function():void
               {
                  View_BoatActivity.instance.visible = true;
               });
               break;
            case this.tipTargetarr[5]:
               Global.delegate.dosomething(View_BossTip.instance,function():void
               {
                  View_BossTip.instance.visible = true;
               });
               break;
            case this.tipTargetarr[6]:
               BabyGiftCGMessage.CG_ETLB_OPEN();
         }
      }
      
      private function close(e:MouseEvent) : void
      {
         this.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            super.visible = value;
            this.alpha = 1;
            this._isCom = false;
            this.eff();
            if(Boolean(this._backPet))
            {
               Tween.to(this._backPet,700,{
                  "x":[-150,0],
                  "alpha":[0.5,1]
               },null);
            }
         }
         else if(Boolean(this._backPet))
         {
            Tween.to(this._backPet,700,{
               "x":[0,-150],
               "alpha":[1,0.5]
            },null);
            Tween.to(this,700,{"alpha":[1,0.5]},this.hide);
         }
      }
      
      private function hide() : void
      {
         super.visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 930) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.manager.TipManager;
import com.yiTian.view.modules.gongcehuodong.View_GongCeHuoDongPanel;
import flash.display.Sprite;
import flash.events.MouseEvent;

class Btn extends Sprite
{
   
   private var tipTarget:Sprite;
   
   private var _index:int;
   
   public function Btn(url:String, url1:String, i:int)
   {
      super();
      ComponentUtil.getBitmap("Back_HuoDongD",this,{
         "x":0,
         "y":0
      },Global.GCHDdm);
      ComponentUtil.getBitmap(url,this,{
         "x":6,
         "y":1
      },Global.GCHDdm);
      ComponentUtil.getButton("","Button_BTAN",this,{
         "x":5,
         "y":64,
         "textColor":16771436
      },Global.GCHDdm);
      ComponentUtil.getBitmap(url1,this,{
         "x":19,
         "y":68
      },Global.GCHDdm);
      this._index = i;
      this.addEventListener(MouseEvent.ROLL_OVER,this.onRoll);
      this.addEventListener(MouseEvent.ROLL_OUT,this.onUot);
      this.tipTarget = new Sprite();
      this.tipTarget.graphics.beginFill(16711680,0);
      this.tipTarget.graphics.drawRect(0,0,78,78);
      this.tipTarget.graphics.endFill();
      this.tipTarget.buttonMode = true;
      addChild(this.tipTarget);
      var str:String = View_GongCeHuoDongPanel.tipStrarr[0];
      TipManager.bind(this,str);
   }
   
   private function onRoll(e:MouseEvent) : void
   {
      var _temp_1:* = this;
      this.scaleY = 1.1;
      _temp_1.scaleX = 1.1;
   }
   
   private function onUot(e:MouseEvent) : void
   {
      var _temp_1:* = this;
      this.scaleY = 1;
      _temp_1.scaleX = 1;
   }
   
   public function get index() : int
   {
      return this._index;
   }
}
