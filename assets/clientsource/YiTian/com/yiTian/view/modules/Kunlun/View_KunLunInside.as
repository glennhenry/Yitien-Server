package com.yiTian.view.modules.Kunlun
{
   import com.ui.controls.Button;
   import com.ui.controls.MaskProgressBar;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.command.IBindViewer;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.model.Model_kunlun;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextFieldAutoSize;
   
   public class View_KunLunInside extends Panel implements IBindViewer
   {
      
      private var tf_title:MyTextField;
      
      private var btn_phb:Button;
      
      private var btn_answer:Button;
      
      private var tf_lixiandianDes:MyTextField;
      
      private var tf_lixiandianValue:MyTextField;
      
      private var tf_sb:MyTextField;
      
      private var tf_time:MyTextField;
      
      private var tf_refresh:MyTextField;
      
      private var pb_refresh:MaskProgressBar;
      
      private var tf_k1Title:MyTextField;
      
      private var tf_k2Title:MyTextField;
      
      private var tf_kill1:MyTextField;
      
      private var tf_kill2:MyTextField;
      
      private var inited:Boolean = false;
      
      private var back:DisplayObjectContainer;
      
      private var bm_pbBar:Bitmap;
      
      private var bm_pbBg:Bitmap;
      
      private var _actRemainTime:int;
      
      private var _freRemainTime:int;
      
      private var temp:int = 0;
      
      private var isUIComplete:Boolean = false;
      
      private var scVec:Vector.<smallRect>;
      
      public function View_KunLunInside()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var i:int = 0;
         var sr:smallRect = null;
         this.back = new Sprite();
         this.back.mouseEnabled = false;
         addChild(this.back);
         ComponentUtil.getScaleBitmap("Back_HuoDong",[60,36,3,5],this.back,{
            "x":0,
            "y":0,
            "width":290,
            "height":181
         },Global.Img_Cdm);
         this.tf_title = ComponentUtil.getTextField("",this,{
            "x":120,
            "y":4,
            "color":16184781,
            "size":14,
            "leading":0
         });
         this.tf_title.autoSize = TextFieldAutoSize.CENTER;
         this.tf_title.bold = true;
         this.tf_title.htmlText = LangConfig.getWord("23403",2);
         this.btn_phb = ComponentUtil.getButton("","Button_HDSeach",this,{
            "x":30,
            "y":2,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_answer = ComponentUtil.getButton("","Button_HDTips",this,{
            "x":236,
            "y":2,
            "textColor":16184781
         },Global.Img_Cdm);
         this.tf_lixiandianDes = ComponentUtil.getTextField("我的历险点：",this,{
            "x":40,
            "y":30
         });
         this.tf_lixiandianValue = ComponentUtil.getTextField("00",this,{
            "x":110,
            "y":30
         });
         this.tf_sb = ComponentUtil.getTextField(LangConfig.getWord("29207",2),this,{
            "x":40,
            "y":35 + 20
         });
         this.tf_sb.mouseEnabled = true;
         this.tf_refresh = ComponentUtil.getTextField(LangConfig.getWord("29208",2),this,{
            "x":40,
            "y":85 + 20
         });
         this.pb_refresh = new MaskProgressBar();
         this.bm_pbBar = new Bitmap();
         this.bm_pbBar.x = 1;
         this.bm_pbBar.y = 1;
         this.pb_refresh.bar = this.bm_pbBar;
         this.pb_refresh.y = 90 + 20;
         this.pb_refresh.x = 112;
         this.bm_pbBg = new Bitmap();
         this.pb_refresh.bg = this.bm_pbBg;
         this.pb_refresh.init();
         this.pb_refresh.realWidth = 122;
         addChild(this.pb_refresh);
         this.tf_time = ComponentUtil.getTextField(LangConfig.getWord("29058",2),this,{
            "x":40,
            "y":60 + 20
         });
         this.tf_k1Title = ComponentUtil.getTextField(LangConfig.getWord("29060",2),this,{
            "x":40,
            "y":110 + 20
         });
         this.tf_k2Title = ComponentUtil.getTextField(LangConfig.getWord("29061",2),this,{
            "x":40,
            "y":135 + 20
         });
         this.tf_kill1 = ComponentUtil.getTextField("",this,{
            "x":100,
            "y":110 + 20,
            "realWidth":40
         });
         this.tf_kill2 = ComponentUtil.getTextField("",this,{
            "x":100,
            "y":135 + 20,
            "realWidth":40
         });
         this.tf_kill2.autoSize = this.tf_kill1.autoSize = TextFieldAutoSize.CENTER;
         this.tf_title = ComponentUtil.getTextField("",this,{
            "size":16,
            "width":this.back.width
         });
         this.tf_title.autoSize = TextFieldAutoSize.CENTER;
         Model_kunlun.myKLInfo.setBindViewer(this);
         this.scVec = new Vector.<smallRect>();
         i = 0;
         while(i < 6)
         {
            sr = new smallRect();
            sr.x = 149 + i % 3 * 35;
            sr.y = 110 + 20 + int(i / 3) * 25;
            sr.init();
            sr.type = i + 1;
            addChild(sr);
            this.scVec.push(sr);
            i += 1;
         }
         bAutoRemove = false;
      }
      
      public function setMyLixiandian(lixiandian:int) : void
      {
         if(!this.tf_lixiandianValue)
         {
            return;
         }
         this.tf_lixiandianValue.htmlText = "<font color=\'#DDDD00\'>" + lixiandian + "</font>";
      }
      
      private function clickHd(e:MouseEvent) : void
      {
         GameScene.instance.uiOnGo(e);
      }
      
      public function enterKL() : void
      {
         this.visible = true;
         this.start();
      }
      
      public function leaveKL() : void
      {
         this.visible = false;
         this.stop();
      }
      
      public function updateTime(actRemainTime:int, freRemainTime:int) : void
      {
         if(actRemainTime >= 0)
         {
            this._actRemainTime = actRemainTime;
         }
         this._freRemainTime = freRemainTime;
      }
      
      public function start() : void
      {
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep);
      }
      
      public function stop() : void
      {
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep);
      }
      
      private function frameStep(interval:int) : void
      {
         this.temp += interval;
         if(this.temp >= 1000)
         {
            this.temp = 0;
            this._actRemainTime -= 1;
            this._freRemainTime -= 1;
            this.updateTimerTf(this._actRemainTime);
            this.updateRefreshTime(this._freRemainTime);
         }
      }
      
      public function update(obj:Object) : void
      {
         var sc:smallRect = null;
         var type:int = 0;
         var aim:int = 0;
         var curNum:int = 0;
         var sbName:String = obj.sbName;
         sbName = Model_heFu.repNameByHero(sbName);
         sbName = HtmlUtil.createLink(sbName);
         if(Boolean(sbName))
         {
            this.tf_sb.htmlText = LangConfig.getWord("22362",2) + "  <font color=\'#44DDFF\'>" + sbName + "</font>";
         }
         else
         {
            this.tf_sb.htmlText = LangConfig.getWord("22362",2) + LangConfig.getWord("22363",2);
         }
         this.tf_kill1.htmlText = "<font color=\'#FF0000\'>" + obj.kill1 + "</font>";
         this.tf_kill2.htmlText = "<font color=\'#FF0000\'>" + obj.kill2 + "</font>";
         var i:int = 0;
         while(i < 6)
         {
            sc = this.scVec[i];
            type = int(Enum_kunLun.killAim[i][0]);
            aim = int(Enum_kunLun.killAim[i][1]);
            curNum = type == 1 ? int(obj.kill1) : int(obj.kill2);
            if(curNum >= aim)
            {
               if(sc.filters != [])
               {
                  sc.filters = [];
               }
            }
            else if(sc.filters != Util.disabled)
            {
               sc.filters = Util.disabled;
            }
            i += 1;
         }
      }
      
      private function onLinkHd(evt:TextEvent) : void
      {
         evt.stopImmediatePropagation();
         var obj:Object = Model_kunlun.myKLInfo.getData();
         if(Boolean(obj) && Boolean(obj.sbId))
         {
            Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,obj.sbId);
         }
      }
      
      private function updateTimerTf(remainTime:int) : void
      {
         if(remainTime < 0)
         {
            remainTime = 0;
         }
         this.tf_time.htmlText = LangConfig.getWord("29058",2) + "  <font color=\'#DDDD00\'>" + DateUtil.getHMSBySecond2(remainTime,"::") + "</font>";
      }
      
      private function updateRefreshTime(remainTime:int) : void
      {
         if(remainTime < 0)
         {
            remainTime = 0;
         }
         if(this._actRemainTime < 300)
         {
            this.pb_refresh.persent = 1;
            return;
         }
         this.pb_refresh.persent = 1 - remainTime / 300;
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.btn_phb.callBack = this.phbClickHd;
         this.tf_sb.addEventListener(TextEvent.LINK,this.onLinkHd);
         Model_kunlun.myKLInfo.setBindViewer(UIManager.kunlun_inside);
         this.btn_answer.callBack = function(evt:MouseEvent):void
         {
            UIManager.kunlun_jieShao.visible = !UIManager.kunlun_jieShao.visible;
         };
      }
      
      public function initT() : void
      {
         var sr:smallRect = null;
         this.bm_pbBar.bitmapData = ComponentUtil.getBitmapData("Progress_KLTime",Global.KunLun_Imgsdm);
         this.bm_pbBg.bitmapData = ComponentUtil.getBitmapData("Progress_KTBack",Global.KunLun_Imgsdm);
         for each(sr in this.scVec)
         {
            sr.load();
         }
         this.isUIComplete = true;
      }
      
      override public function set visible(value:Boolean) : void
      {
         var arr:Array = null;
         if(value)
         {
            if(!this.isUIComplete)
            {
               if(!Global.KunLun_Imgsdm)
               {
                  arr = [];
                  arr.push(["lang/ch/KunLun_Imgs.swf",function(info:Object):void
                  {
                     Global.KunLun_Imgsdm = info.applicationDomain;
                  },LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
                  View_loading.instance.load(arr,function():void
                  {
                     initT();
                     visible = true;
                     View_loading.instance.visible = false;
                  });
                  return;
               }
               this.initT();
            }
         }
         super.visible = value;
      }
      
      private function phbClickHd(evt:MouseEvent) : void
      {
         UIManager.kunlun_substantive.visible = !UIManager.kunlun_substantive.visible;
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - this.back.width;
         y = UIManager.questTraceView.y;
      }
   }
}

import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.model.Model_kunlun;
import com.yiTian.manager.LangConfig;
import com.yiTian.manager.TipManager;
import com.yiTian.view.modules.Kunlun.Enum_kunLun;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;

class smallRect extends Sprite
{
   
   private var bm:Bitmap;
   
   private var _type:int;
   
   public function smallRect()
   {
      super();
   }
   
   public function set type(value:int) : void
   {
      this._type = value;
   }
   
   public function get type() : int
   {
      return this._type;
   }
   
   public function init() : void
   {
      this.bm = new Bitmap();
      addChild(this.bm);
      addEventListener(MouseEvent.ROLL_OVER,this.rollOverHd);
      addEventListener(MouseEvent.ROLL_OUT,this.rollOutHd);
   }
   
   public function load() : void
   {
      var dir:String = this.type.toString();
      this.bm.bitmapData = ComponentUtil.getBitmapData(dir,Global.KunLun_Imgsdm);
   }
   
   private function rollOverHd(evt:MouseEvent) : void
   {
      var descript:String = null;
      var finish:int = 0;
      var index:int = this.type - 1;
      var killType:int = int(Enum_kunLun.killAim[index][0]);
      var killAimCount:int = int(Enum_kunLun.killAim[index][1]);
      descript = killType == 1 ? LangConfig.getWord("22353",2) : LangConfig.getWord("22354",2);
      descript += (index % 3 + 1).toString();
      descript += LangConfig.getWord("22355",2,killAimCount.toString());
      descript += killType == 1 ? LangConfig.getWord("29101",2) : LangConfig.getWord("29102",2);
      descript += LangConfig.getWord("22356",2,Enum_kunLun.awardArr[killType - 1]);
      var obj:Object = Model_kunlun.myKLInfo.getData();
      if(Boolean(obj))
      {
         if(obj.kill1 != null)
         {
            finish = killType == 1 ? int(obj.kill1) : int(obj.kill2);
         }
      }
      descript += finish >= killAimCount ? "\n" + LangConfig.getWord("29103",2) : "\n" + LangConfig.getWord("29104",2);
      TipManager.update(descript);
   }
   
   private function rollOutHd(evt:MouseEvent) : void
   {
      TipManager.hide();
   }
}
