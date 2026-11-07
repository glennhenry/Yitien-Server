package com.yiTian.view.modules.chunjiehuodong
{
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.net.message.cg.ChristmasWishCGMessage;
   import com.yiTian.net.message.cg.RetrieExpCGMessage;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.ChunJieQianDao.View_ChunJieQianDao_menu;
   import com.yiTian.view.modules.FangXinHuiJia.View_FangXinHuiJia_menu;
   import com.yiTian.view.modules.zhaocaimao.View_ZhaoCaiMao;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   
   public class View_YearACEntrance extends Panel123
   {
      
      private static var _instance:View_YearACEntrance;
      
      public static var tipStrarr:Array = ["活动时间：<font color=\'#00ff00\'>2014年1月25日-2014年2月8日</font>","活动时间：<font color=\'#00ff00\'>2014年1月25日-2014年2月8日</font>","活动时间：<font color=\'#00ff00\'>2014年1月25日-2014年2月8日</font>","活动时间：<font color=\'#00ff00\'>2014年1月25日-2014年2月8日</font>","活动时间：<font color=\'#00ff00\'>2014年1月25日-2014年2月8日</font>","活动时间：<font color=\'#00ff00\'>2014年1月25日-2014年2月8日</font><br/>活动期间内，可找回此前<font color=\'#00ff00\'>10天</font>未完成的日常任务经验。","活动时间：<font color=\'#00ff00\'>2014年1月30日-2014年2月8日</font>","活动时间：<font color=\'#00ff00\'>2014年1月30日-2014年2月8日</font>"];
      
      private var temp:Array = [["Icon_CJQD","Text_CJQD",{
         "x":233,
         "y":265
      }],["Icon_NSHS","Text_NSHS",{
         "x":306,
         "y":191
      }],["Icon_FXHJ","Text_FXHJ",{
         "x":393,
         "y":133
      }],["Icon_XQYW","Text_XQYW",{
         "x":491,
         "y":92
      }],["Icon_CJZB","Text_CJZB",{
         "x":596,
         "y":82
      }],["Icon_ZHJY","Text_ZHJY",{
         "x":696,
         "y":117
      }],["Icon_ZCLM","Text_ZCLM",{
         "x":755,
         "y":204
      }],["Icon_MNXY","Text_MNXY",{
         "x":758,
         "y":309
      }]];
      
      private var back:ScaleBitmap;
      
      private var canyuSpr:Sprite;
      
      private var tipTargetarr:Array = new Array();
      
      public function View_YearACEntrance()
      {
         super();
         regResource("lang/ch/HLMN.swf","HLMNdm");
      }
      
      public static function get instance() : View_YearACEntrance
      {
         if(!_instance)
         {
            _instance = new View_YearACEntrance();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var btn_1:Btn = null;
         ComponentUtil.getBitmap("Back_HLMN",this,{
            "x":0,
            "y":0
         },Global.HLMNdm);
         CloseButton = ComponentUtil.getButton("","Button_MNGB",this,{
            "x":848,
            "y":36,
            "textColor":16771436
         },Global.HLMNdm);
         ComponentUtil.getBitmap("Person_BNXM",this,{
            "x":19,
            "y":140
         },Global.HLMNdm);
         ComponentUtil.getBitmap("Text_HDSJ",this,{
            "x":328,
            "y":426
         },Global.HLMNdm);
         ComponentUtil.getBitmap("Text_YTCJ",this,{
            "x":293,
            "y":328
         },Global.HLMNdm);
         var i:int = 0;
         while(i < 8)
         {
            btn_1 = new Btn(this.temp[i][0],this.temp[i][1],i);
            ComponentUtil.setPropertie(btn_1,this.temp[i][2]);
            this.addChild(btn_1);
            this.tipTargetarr.push(btn_1);
            i++;
         }
         move = new Rectangle(0,33,800,35);
         CloseButton.callBack = this.close;
         this.addclick();
         this.eff();
      }
      
      private function eff() : void
      {
         var i:int = 0;
         while(i < 8)
         {
            ComponentUtil.setPropertie(this.tipTargetarr[i],{
               "x":100,
               "y":100
            });
            i++;
         }
         i = 0;
         while(i < 8)
         {
            setTimeout(function(i:int):void
            {
               Tween.to(tipTargetarr[i],150,{
                  "x":[tipTargetarr[i].x,temp[i][2].x],
                  "y":[tipTargetarr[i].y,temp[i][2].y]
               },null,null);
            },i * 140,i);
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
               Global.delegate.dosomething(View_ChunJieQianDao_menu.instance,View_ChunJieQianDao_menu.instance.onIconClick);
               break;
            case this.tipTargetarr[1]:
               Global.delegate.dosomething(View_BossTip.instance,function():void
               {
                  View_BossTip.instance.visible = true;
               });
               break;
            case this.tipTargetarr[2]:
               Global.delegate.dosomething(View_FangXinHuiJia_menu.instance,View_FangXinHuiJia_menu.instance.onIconClick);
               break;
            case this.tipTargetarr[3]:
               Global.delegate.dosomething(View_DYNG.instance,function():void
               {
                  View_DYNG.instance.visible = true;
               });
               break;
            case this.tipTargetarr[4]:
               Global.delegate.dosomething(View_ZiBiao.instance,function():void
               {
                  View_ZiBiao.instance.visible = true;
               });
               break;
            case this.tipTargetarr[5]:
               RetrieExpCGMessage.CG_RETRIEEXP_INFO();
               break;
            case this.tipTargetarr[6]:
               View_ZhaoCaiMao.instance.show();
               break;
            case this.tipTargetarr[7]:
               ChristmasWishCGMessage.CG_OPEN_WISH();
         }
      }
      
      private function close(e:MouseEvent) : void
      {
         this.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.eff();
         }
      }
   }
}

import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.manager.TipManager;
import com.yiTian.view.modules.chunjiehuodong.View_YearACEntrance;
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
      },Global.HLMNdm);
      ComponentUtil.getBitmap(url,this,{
         "x":6,
         "y":1
      },Global.HLMNdm);
      ComponentUtil.getButton("","Button_BTAN",this,{
         "x":5,
         "y":64,
         "textColor":16771436
      },Global.HLMNdm);
      ComponentUtil.getBitmap(url1,this,{
         "x":19,
         "y":68
      },Global.HLMNdm);
      this._index = i;
      this.addEventListener(MouseEvent.ROLL_OVER,this.onRoll);
      this.addEventListener(MouseEvent.ROLL_OUT,this.onUot);
      this.tipTarget = new Sprite();
      this.tipTarget.graphics.beginFill(16711680,0);
      this.tipTarget.graphics.drawRect(0,0,78,78);
      this.tipTarget.graphics.endFill();
      this.tipTarget.buttonMode = true;
      addChild(this.tipTarget);
      var str:String = View_YearACEntrance.tipStrarr[this._index];
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
