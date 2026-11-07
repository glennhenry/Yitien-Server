package com.yiTian.view.modules.FeiXingQi
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.command.IntervalTimer;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.DailyBtnManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FeiXingQiCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import com.yiTian.view.modules.loading.View_loading;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class View_FeiXingQiMainPanel extends Panel
   {
      
      private var bg:DisplayObject;
      
      private var titleBg:Bitmap;
      
      private var btn_roll:Button;
      
      public var tou:Child_touZiContainer;
      
      private var tf_touCDRemain:MyTextField;
      
      private var tf_roomIndex:MyTextField;
      
      private var tf_zbLabel:MyTextField;
      
      private var tf_accelerate:MyTextField;
      
      private var _numTou:int = -1;
      
      public var feiXingQi:Child_FeiXingQi;
      
      private var touTimer:IntervalTimer;
      
      private var touRemain:int;
      
      private var labelArr:Array = [];
      
      private var zbtfArr:Array = [];
      
      private var isInit:Boolean = false;
      
      public function View_FeiXingQiMainPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var bg2:ScaleBitmap = null;
         this.bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":841,
            "height":434
         },Global.Img_Cdm);
         bg2 = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":564,
            "height":384
         },Global.Img_Cdm);
         var bg3:ScaleBitmap = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":594,
            "y":40,
            "width":224,
            "height":384
         },Global.Img_Cdm);
         var bg4:ScaleBitmap = ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":599,
            "y":47,
            "width":214,
            "height":125
         },Global.Img_Cdm);
         var touziBack:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_TouZi",[13,13,2,2],this,{
            "x":602,
            "y":49,
            "width":210,
            "height":121
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.bg.width,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":807,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_roll = ComponentUtil.getButton(LangConfig.getWord("22327",2),"Button_Four",this,{
            "x":599,
            "y":178,
            "textColor":16184781
         },Global.Img_Cdm);
         this.tf_touCDRemain = ComponentUtil.getTextField(LangConfig.getWord("22328",2,"00:00"),this,{
            "x":678,
            "y":180,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.tf_accelerate = ComponentUtil.getTextField("",this,{
            "x":780,
            "y":180,
            "color":3798016,
            "size":12,
            "leading":0
         });
         this.tf_accelerate.mouseEnabled = true;
         this.tf_accelerate.htmlText = HtmlUtil.createLink("<font color=\'#00ff00\'>" + LangConfig.getWord("22331",2) + "</font>");
         var bg5:ScaleBitmap = ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":599,
            "y":208,
            "width":214,
            "height":103
         },Global.Img_Cdm);
         var bg6:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":600,
            "y":209,
            "width":212,
            "height":20
         },Global.Img_Cdm);
         this.tf_roomIndex = ComponentUtil.getTextField(LangConfig.getWord("22329",2) + "000",this,{
            "x":677,
            "y":209,
            "color":16764206,
            "size":12,
            "leading":0
         });
         var bg7:ScaleBitmap = ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":599,
            "y":317,
            "width":214,
            "height":100
         },Global.Img_Cdm);
         var titleBg2:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":600,
            "y":318,
            "width":212,
            "height":20
         },Global.Img_Cdm);
         this.tf_zbLabel = ComponentUtil.getTextField(LangConfig.getWord("22330",2),this,{
            "x":682,
            "y":317,
            "color":16764206,
            "size":12,
            "leading":0
         });
         var kuang1:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Translucent",[2,2,4,4],this,{
            "x":602,
            "y":235,
            "width":21,
            "height":21
         },Global.Img_Cdm);
         var kuang2:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Translucent",[2,2,4,4],this,{
            "x":710,
            "y":235,
            "width":21,
            "height":21
         },Global.Img_Cdm);
         var kuang3:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Translucent",[2,2,4,4],this,{
            "x":602,
            "y":270,
            "width":21,
            "height":21
         },Global.Img_Cdm);
         var kuang4:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Translucent",[2,2,4,4],this,{
            "x":710,
            "y":270,
            "width":21,
            "height":21
         },Global.Img_Cdm);
         this.initB();
      }
      
      override protected function initDynamicView() : void
      {
         this.btn_roll.callBack = this.rollClickHd;
         if(GameUnitManager.hero.level >= Enum_FeiXingQi.FXQOPENLVNEED)
         {
         }
         this.touTimer = new IntervalTimer();
         this.touTimer.interval = 990;
         this.touTimer.tickFun = this.touTick;
         this.tf_accelerate.addEventListener(TextEvent.LINK,this.accLinkHd);
         CloseButton.callBack = this.closeClickHd;
      }
      
      private function accLinkHd(evt:TextEvent) : void
      {
         FeiXingQiCGMessage.CG_FXQACCINFO(Model_FeiXingQi.version);
      }
      
      private function closeClickHd(evt:MouseEvent) : void
      {
         if(Model_FeiXingQi.isTween == true)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("22332",2));
            return;
         }
         this.visible = false;
      }
      
      public function initB() : void
      {
         this.feiXingQi = new Child_FeiXingQi();
         this.feiXingQi.x = 26;
         this.feiXingQi.y = 42;
         addChild(this.feiXingQi);
         this.tou = new Child_touZiContainer();
         this.tou.x = 634;
         this.tou.y = 80;
         addChildAt(this.tou,getChildIndex(this.btn_roll));
         this.tou.addEventListener(TouZiEvent.COMPLETE,this.touEndHd);
      }
      
      private function touEndHd(evt:TouZiEvent) : void
      {
         var result:int = evt.result;
         FeiXingQiCGMessage.CG_FXQROLLCOMPLETE(Model_FeiXingQi.version);
         this.rollBtnVisible(true);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.bg.width) / 2;
         y = (Global.stage.stageHeight - this.bg.height) / 2;
      }
      
      public function set touCDRemain(value:int) : void
      {
         var remainStr:String = null;
         this.touRemain = value;
         this.touTimer.updateRecordTime = getTimer();
         this.touTimer.start();
         if(value > 0)
         {
            remainStr = DateUtil.getMSBySecond3(this.touRemain);
            this.tf_touCDRemain.text = LangConfig.getWord("22328",2,remainStr);
            Model_FeiXingQi.setTipBtnRemainStr(remainStr);
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.ChuangGuan,-1,0]);
            Global.control.sendNotification(Enum_mainUIBtn_hide.ICON_EFFECT,[Enum_mainUIBtn_hide.ChuangGuan,0]);
         }
         else
         {
            this.tf_touCDRemain.text = LangConfig.getWord("22328",2,"00:00");
            Model_FeiXingQi.setTipBtnRemainStr("");
            if(DailyBtnManager.getCount(DailyBtnManager.CG) > 0)
            {
               Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.ChuangGuan,-1,1]);
               Global.control.sendNotification(Enum_mainUIBtn_hide.ICON_EFFECT,[Enum_mainUIBtn_hide.ChuangGuan,1]);
            }
         }
         this.tf_accelerate.visible = value <= 0;
      }
      
      public function get touCDRemain() : int
      {
         return this.touRemain;
      }
      
      private function touTick() : void
      {
         var remainStr:String = null;
         this.touRemain -= 1;
         remainStr = DateUtil.getMSBySecond3(this.touRemain);
         if(this.touRemain <= 0)
         {
            this.tf_accelerate.visible = false;
            this.touRemain = 0;
            this.touTimer.stop();
            Model_FeiXingQi.setTipBtnRemainStr("");
            if(DailyBtnManager.getCount(DailyBtnManager.CG) > 0)
            {
               Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.ChuangGuan,-1,1]);
               Global.control.sendNotification(Enum_mainUIBtn_hide.ICON_EFFECT,[Enum_mainUIBtn_hide.ChuangGuan,1]);
            }
         }
         else
         {
            this.tf_accelerate.visible = true;
            Model_FeiXingQi.setTipBtnRemainStr(remainStr);
            this.tf_touCDRemain.text = LangConfig.getWord("22328",2,remainStr);
         }
      }
      
      public function updatePlayerLabel() : void
      {
         var oY:Number = NaN;
         var i:int = 0;
         var pii:PlayerInfoItem = null;
         var u:Child_FeiXingQiUnit = null;
         var uArr:Array = Model_FeiXingQi.unitArr;
         var len:int = Math.max(uArr.length,this.labelArr.length);
         oY = 35;
         i = 0;
         while(i < len)
         {
            pii = this.labelArr[i];
            if(!pii)
            {
               pii = new PlayerInfoItem();
               pii.x = 605 + 108 * (i % 2);
               pii.y = 237 + oY * int(i / 2);
               addChild(pii);
               this.labelArr.push(pii);
            }
            u = uArr[i];
            pii.info = Boolean(u) ? {
               "id":u.id,
               "name":u.uName,
               "sex":u.sex,
               "job":u.job
            } : null;
            i += 1;
         }
      }
      
      public function addZB(arr:Array) : void
      {
         var tf:MyTextField = null;
         var str:String = null;
         var otherName:String = null;
         if(this.zbtfArr.length >= 2)
         {
            this.zbtfArr.push(this.zbtfArr.shift());
            this.zbtfArr[this.zbtfArr.length - 1].htmlText = "";
         }
         else
         {
            tf = ComponentUtil.getTextField("",this,{
               "x":608,
               "y":338 + 35 * this.zbtfArr.length,
               "realWidth":190,
               "color":14013809,
               "wordWrap":true
            });
            tf.autoSize = TextFieldAutoSize.CENTER;
            this.zbtfArr.push(tf);
            tf.mouseEnabled = true;
            tf.addEventListener(TextEvent.LINK,this.linkHd);
         }
         var result:int = int(arr[0]);
         var id1:Number = Number(arr[1]);
         var name1:String = arr[2];
         var id2:Number = Number(arr[3]);
         var name2:String = arr[4];
         if(id1 == GameUnitManager.hero.id)
         {
            otherName = HtmlUtil.createLink("<font color=\'#33ccff\'>" + name2 + "</font>",true,id2.toString());
            str = LangConfig.getWord("20251",2,otherName);
            if(result == 1)
            {
               str += LangConfig.getWord("20253",2);
            }
            else
            {
               str += LangConfig.getWord("20254",2);
            }
         }
         else if(id2 == GameUnitManager.hero.id)
         {
            otherName = HtmlUtil.createLink("<font color=\'#33ccff\'>" + name1 + "</font>",true,id1.toString());
            str = LangConfig.getWord("20252",2,otherName);
            if(result == 1)
            {
               str += LangConfig.getWord("20255",2);
            }
            else
            {
               str += LangConfig.getWord("20256",2);
            }
         }
         this.zbtfArr[this.zbtfArr.length - 1].htmlText = str;
         var i:int = 0;
         while(i < this.zbtfArr.length)
         {
            this.zbtfArr[i].y = 338 + i * 35;
            i += 1;
         }
      }
      
      public function clearZB() : void
      {
         var i:int = this.zbtfArr.length - 1;
         while(i >= 0)
         {
            (this.zbtfArr[i] as MyTextField).dispose();
            removeChild(this.zbtfArr[i]);
            i -= 1;
         }
         this.zbtfArr.splice(0);
      }
      
      private function linkHd(evt:TextEvent) : void
      {
         var id:Number = Number(evt.text);
         Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,id);
      }
      
      public function setRoomID(id:int) : void
      {
         this.tf_roomIndex.text = LangConfig.getWord("22329",2,Enum_BroadCastTool.instance.getBitStr(id,3));
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            if(!this.isInit)
            {
               this.feiXingQi.init();
               this.isInit = true;
               if(!Global.ChuangGuan_Imgsdm)
               {
                  this.load();
               }
               else
               {
                  this.initT();
                  this.visible = true;
               }
               return;
            }
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
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
      
      private function initT() : void
      {
         this.feiXingQi.loadBg();
         this.tou.init();
         ModalUIManager.fxqGuessingPanel.initB();
         var dic:Dictionary = Data_lib.fxqMap;
         var tArr:Array = Model_FeiXingQi.tileArr;
         var len:int = int(tArr.length);
         if(!this.titleBg)
         {
            this.titleBg = ComponentUtil.getBitmap("Title_ChuangGuan",this,{
               "x":340,
               "y":5
            },Global.ChuangGuan_Imgsdm);
         }
      }
      
      private function touLoadZiComplete(info:Object) : void
      {
         Global.ChuangGuan_Imgsdm = info.applicationDomain;
         this.initT();
         this.visible = true;
      }
      
      public function rollBtnVisible(value:Boolean) : void
      {
         this.btn_roll.enabled = value;
      }
      
      private function rollClickHd(evt:MouseEvent) : void
      {
         if(this.touRemain > 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("20327",2));
            return;
         }
         FeiXingQiCGMessage.CG_FXQROLL(Model_FeiXingQi.version,-1);
      }
      
      private function lvUpHd(lv:int) : void
      {
         if(lv >= 32)
         {
            Model_FeiXingQi.showTipBtn();
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,this.lvUpHd);
         }
      }
      
      private function onFrame(interval:int) : void
      {
         Global.control.sendNotification(Enum_MsgType.FXQ_FRAME,interval);
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.command.Enum_MsgType;
import com.yiTian.data.config.Enum_job;
import com.yiTian.utils.HtmlUtil;
import com.yiTian.utils.Utils;
import com.yiTian.view.modules.FeiXingQi.Enum_FeiXingQi;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;

class PlayerInfoItem extends Sprite
{
   
   private var bm_head:Bitmap;
   
   private var tf_name:MyTextField;
   
   private var _id:Number = 0;
   
   public function PlayerInfoItem()
   {
      super();
      this.bm_head = new Bitmap();
      addChild(this.bm_head);
      this.tf_name = ComponentUtil.getTextField("",this,{
         "x":25,
         "y":-2,
         "color":11904647
      });
      this.tf_name.mouseEnabled = true;
      addEventListener(MouseEvent.CLICK,this.onClick);
   }
   
   public function get id() : Number
   {
      return this._id;
   }
   
   private function onClick(evt:MouseEvent) : void
   {
      Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,this._id);
   }
   
   public function set info(obj:Object) : void
   {
      if(obj == null)
      {
         visible = false;
         return;
      }
      visible = true;
      var id:Number = Number(obj.id);
      var uName:String = obj.name;
      var job:int = int(obj.job);
      var sex:int = int(obj.sex);
      this._id = id;
      var dir:String = Enum_FeiXingQi.getHeadDir(job,sex);
      Utils.getLoadBitmap(Enum_FeiXingQi.getHeadDir(job,sex),this.bm_head);
      uName = HtmlUtil.fontNoSize(uName,"#" + Enum_job.JOBCOLOR[job - 1]);
      this.tf_name.htmlText = HtmlUtil.createLink(uName);
   }
}
