package com.yiTian.view.modules.DAU
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.manager.TipManager;
   import com.yiTian.net.message.cg.DAUCGMessage;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_DAU_summyRewardPanel extends Panel123
   {
      
      private var _bg:DisplayObject;
      
      private var boxs:Array = [];
      
      private var dauItems:Array = [];
      
      private var filterss:Array = [new GlowFilter(16776960,0.6,15,15,8,1)];
      
      private var _toIdx:int;
      
      private var tipTxt1:String = "<font color=\'#ff5555\'>您的连续登陆天数未达此奖励的领取条件</font>";
      
      private var tipTxt2:String = "<font color=\'#ffff33\'>您的连续登陆天数已达条件，点击领取</font>";
      
      private var tipTxt3:String = "<font color=\'#aaaaaa\'>该奖励已经领取</font>";
      
      public function View_DAU_summyRewardPanel()
      {
         super();
         regResource("lang/ch/DAU_Imgs.swf","DAU_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         var item:DAUItem = null;
         var _sp:Sprite = null;
         this._bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":616,
            "height":490
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":568,
            "height":440
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Back_Img",this,{
            "x":34,
            "y":50
         },Global.DAU_Imgsdm);
         move = new Rectangle(0,0,this._bg.width,this._bg.height);
         item = new DAUItem();
         item.x = 122;
         item.y = 133;
         item.tf.htmlText = Model_DAU.getRewardTxt(0);
         addChild(item);
         this.dauItems.push(item);
         item = new DAUItem();
         item.x = 250;
         item.y = 133;
         addChild(item);
         this.dauItems.push(item);
         item.tf.htmlText = Model_DAU.getRewardTxt(1);
         item = new DAUItem();
         item.x = 378;
         item.y = 133;
         addChild(item);
         this.dauItems.push(item);
         item.tf.htmlText = Model_DAU.getRewardTxt(2);
         _sp = new Sprite();
         this.boxs.push(ComponentUtil.getBitmap("DAUBox_Close",_sp,null,Global.DAU_Imgsdm));
         _sp.x = 133;
         _sp.y = 267;
         addChild(_sp);
         _sp.addEventListener(MouseEvent.CLICK,this.btn1ClickHd);
         _sp = new Sprite();
         this.boxs.push(ComponentUtil.getBitmap("DAUBox_Close",_sp,null,Global.DAU_Imgsdm));
         _sp.x = 253;
         _sp.y = 267;
         addChild(_sp);
         _sp.addEventListener(MouseEvent.CLICK,this.btn2ClickHd);
         _sp = new Sprite();
         this.boxs.push(ComponentUtil.getBitmap("DAUBox_Close",_sp,null,Global.DAU_Imgsdm));
         _sp.x = 384;
         _sp.y = 267;
         addChild(_sp);
         _sp.addEventListener(MouseEvent.CLICK,this.btn3ClickHd);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":584,
            "y":6,
            "textColor":16184781,
            "callBack":this.hide
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_DAU",this,{
            "x":234,
            "y":5
         },Global.DAU_Imgsdm);
         var tf:MyTextField = ComponentUtil.getTextField("",this,{
            "x":117,
            "y":375,
            "color":15335368
         });
         tf.multiline = true;
         tf.htmlText = "活动时间：8月25日00:00-8月30日23:59\n活动内容：在活动期间内累计达到对应的天数均可领取登录礼包。";
         ComponentUtil.getButton("蓝钻更多惊喜好礼","Button_HJYX",this,{
            "x":106,
            "y":436,
            "textColor":13230847,
            "callBack":this.hjxyClickHd
         },Global.DAU_Imgsdm);
         this.update();
         Global.control.registerCallBack(Model_DAU.SUMMY_REWARD_INFO_UPDATE,this.update);
      }
      
      private function btn1ClickHd(e:MouseEvent) : void
      {
         DAUCGMessage.CG_DAU_GET_REWARD(1);
      }
      
      private function btn2ClickHd(e:MouseEvent) : void
      {
         DAUCGMessage.CG_DAU_GET_REWARD(2);
      }
      
      private function btn3ClickHd(e:MouseEvent) : void
      {
         DAUCGMessage.CG_DAU_GET_REWARD(3);
      }
      
      private function hjxyClickHd(e:MouseEvent) : void
      {
         if(this._toIdx == 0)
         {
            navigateToURL(new URLRequest("http://yi.qq.com/webplat/info/news_version3/4814/5561/5562/m4016/201308/220664.shtml"));
            this._toIdx = setTimeout(function():void
            {
               clearTimeout(_toIdx);
               _toIdx = 0;
            },2000);
         }
      }
      
      public function show(prm:* = null) : void
      {
         this.visible = true;
         pop();
      }
      
      public function hide(prm:* = null) : void
      {
         this.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
      }
      
      override public function get width() : Number
      {
         return this._bg.width;
      }
      
      override public function get height() : Number
      {
         return this._bg.height;
      }
      
      private function update(info:Array = null) : void
      {
         var state:int = 0;
         var box:Bitmap = null;
         info ||= Model_DAU.DAU_summy_reward_info as Array;
         if(!info)
         {
            return;
         }
         var i:int = 0;
         while(i < info.length)
         {
            state = int(info[i]);
            box = this.boxs[i];
            (box.parent as Sprite).addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
            (box.parent as Sprite).addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
            if(state == 0)
            {
               box.bitmapData = ComponentUtil.getBitmapData("DAUBox_Close",Global.DAU_Imgsdm);
               box.filters = null;
               (box.parent as Sprite).buttonMode = false;
               TipManager.bind(box.parent as Sprite,this.tipTxt1);
               (box.parent as Sprite).transform.colorTransform = Util.colorNomal;
            }
            else if(state == 1)
            {
               box.bitmapData = ComponentUtil.getBitmapData("DAUBox_Open",Global.DAU_Imgsdm);
               box.filters = this.filterss;
               (box.parent as Sprite).buttonMode = true;
               TipManager.bind(box.parent as Sprite,this.tipTxt2);
            }
            else if(state == 2)
            {
               box.bitmapData = ComponentUtil.getBitmapData("DAUBox_goted",Global.DAU_Imgsdm);
               box.filters = null;
               (box.parent as Sprite).buttonMode = false;
               (box.parent as Sprite).transform.colorTransform = Util.colorNomal;
               TipManager.bind(box.parent as Sprite,this.tipTxt3);
            }
            i += 1;
         }
      }
      
      protected function onRollOut(event:MouseEvent) : void
      {
         (event.target as Sprite).transform.colorTransform = Util.colorNomal;
      }
      
      protected function onRollOver(event:MouseEvent) : void
      {
         (event.target as Sprite).transform.colorTransform = Util.colorWhite2;
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import flash.display.Bitmap;
import flash.display.Sprite;

class DAUItem extends Sprite
{
   
   public var box:Bitmap;
   
   public var tf:MyTextField;
   
   public function DAUItem()
   {
      super();
      ComponentUtil.getBitmap("Back_List",this,{
         "x":0,
         "y":0
      },Global.DAU_Imgsdm);
      this.tf = ComponentUtil.getTextField("",this,{
         "x":20,
         "y":15,
         "color":16777011,
         "leading":6
      });
   }
}
