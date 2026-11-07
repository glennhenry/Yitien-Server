package com.yiTian.view.modules.sign
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.SignCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.specialBtnDill.Model_specialD;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getTimer;
   
   public class View_SignPanel extends Panel123
   {
      
      private var bg:DisplayObject;
      
      private var titleBg:DisplayObject;
      
      private var rewardItemVec:Vector.<Child_SignRewardItem> = new Vector.<Child_SignRewardItem>();
      
      public var holidayMenu:Child_HolidayMenu;
      
      private var datachoose:Child_DateChoose;
      
      private var txtCount:MyTextField;
      
      private var getRewardBtn:Button;
      
      private var txtLastPoint:MyTextField;
      
      private var txtNowPoint:MyTextField;
      
      private var txtTime:MyTextField;
      
      private var txtLiJuanPoint:MyTextField;
      
      private var kaifuDayMin:Bitmap;
      
      private var kaifuDayMax:Bitmap;
      
      private var isFirst:Boolean = true;
      
      private var _spBg:DisplayObjectContainer;
      
      private var _pigMc:MovieClip;
      
      private var _pigTf:MyTextField;
      
      private var _pigTxt:String = "累计签到两次可以获得飞天猪坐骑";
      
      public function View_SignPanel()
      {
         super();
         regResource("lang/ch/ZaiXian_Imgs.swf","ZaiXian_Imgsdm");
      }
      
      public static function get instance() : View_SignPanel
      {
         return Singleton.getInstance(View_SignPanel);
      }
      
      override protected function initUI2() : void
      {
         this.bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":670,
            "height":495
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":622,
            "height":445
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":34,
            "y":365,
            "width":342,
            "height":110
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":34,
            "y":50,
            "width":342,
            "height":310
         },Global.Img_Cdm);
         ComponentUtil.getTextField("累计签到次数：",this,{
            "x":261,
            "y":55,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Back_Green_List",[5,5,1,1],this,{
            "x":381,
            "y":50,
            "width":255,
            "height":425
         },Global.Img_Cdm);
         var txt:MyTextField = ComponentUtil.getTextField("",this,{
            "x":396,
            "y":90,
            "color":11523767,
            "size":12,
            "leading":0
         });
         var txt2:MyTextField = ComponentUtil.getTextField("",this,{
            "x":396,
            "y":117,
            "color":11523767,
            "size":12,
            "leading":0
         });
         var txt3:MyTextField = ComponentUtil.getTextField("",this,{
            "x":469,
            "y":90,
            "color":13424242,
            "size":12,
            "leading":0
         });
         var txt4:MyTextField = ComponentUtil.getTextField("",this,{
            "x":482,
            "y":117,
            "color":13424242,
            "size":12,
            "leading":0
         });
         var txt5:MyTextField = ComponentUtil.getTextField("",this,{
            "x":394,
            "y":245,
            "color":16764206,
            "size":12,
            "leading":0
         });
         txt.htmlText = "开服<font color=\'#04ff00\'>1-29</font>天：";
         txt2.htmlText = "开服大于<font color=\'#04ff00\'>29</font>天：";
         txt3.htmlText = "在线<font color=\'#04ff00\'>1</font>小时可获得<font color=\'#04ff00\'>10</font>点礼券";
         txt4.htmlText = "在线<font color=\'#04ff00\'>1</font>小时可获得<font color=\'#04ff00\'>12</font>点礼券";
         txt5.htmlText = "注：每天最大积累在线奖励时间：<font color=\'#04ff00\'>3.5</font>小时";
         ComponentUtil.getTextField("本周累计工资：",this,{
            "x":394,
            "y":300,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("上周结算工资：",this,{
            "x":394,
            "y":380,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":381,
            "y":155,
            "width":255,
            "height":2
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":381,
            "y":285,
            "width":255,
            "height":2
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":381,
            "y":365,
            "width":255,
            "height":2
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.bg.width,38);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":this.bg.width - 28,
            "y":6,
            "textColor":16184781,
            "callBack":this.hide
         },Global.Img_Cdm);
         this.initDynamicView();
         this.initT();
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.getRewardBtn = ComponentUtil.getButton("领取奖励","Button_TwoBule91",this,{
            "x":466,
            "y":440,
            "textColor":16184781
         },Global.Img_Cdm);
         this.txtCount = ComponentUtil.getTextField("00",this,{
            "x":345,
            "y":55,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.txtNowPoint = ComponentUtil.getTextField("礼券：0000点",this,{
            "x":474,
            "y":330,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.txtLastPoint = ComponentUtil.getTextField("礼券：0000点",this,{
            "x":474,
            "y":410,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.txtTime = ComponentUtil.getTextField("本周累计在线已达0000小时",this,{
            "x":431,
            "y":195,
            "color":11523767,
            "size":12,
            "leading":0
         });
         this.txtLiJuanPoint = ComponentUtil.getTextField("（当前每小时可获得0礼券）",this,{
            "x":429,
            "y":220,
            "color":11523767,
            "size":12,
            "leading":0
         });
         this.getRewardBtn.addEventListener(MouseEvent.CLICK,this.gain);
      }
      
      private function initT() : void
      {
         this.titleBg = ComponentUtil.getBitmap("Title_DLJiangLi",this,{
            "x":255,
            "y":5
         },Global.ZaiXian_Imgsdm);
         Model_Sign.setSignHolidayRewardData();
         Model_Sign.setSignRewardData();
         this.datachoose = new Child_DateChoose();
         this.datachoose.x = 44;
         this.datachoose.y = 76;
         addChild(this.datachoose);
         this.holidayMenu = Child_HolidayMenu.instance;
         addChild(this.holidayMenu);
         this.holidayMenu.x = 43;
         this.holidayMenu.y = 363;
         this.createRewardItem();
         this.holidayMenu.update("距离儿童节还有6天",6,Model_Sign.signHolidayRewardData);
         ComponentUtil.getBitmap("Text_Week",this,{
            "x":481,
            "y":168
         },Global.ZaiXian_Imgsdm);
         this.kaifuDayMax = ComponentUtil.getBitmap("Text_KaiFu",this,{
            "x":440,
            "y":65
         },Global.ZaiXian_Imgsdm);
         this.kaifuDayMin = ComponentUtil.getBitmap("Text_KaiFu2",this,{
            "x":440,
            "y":65
         },Global.ZaiXian_Imgsdm);
         ComponentUtil.getBitmap("Num_2",this,{
            "x":538,
            "y":68
         },Global.ZaiXian_Imgsdm);
         ComponentUtil.getBitmap("Num_9",this,{
            "x":553,
            "y":68
         },Global.ZaiXian_Imgsdm);
      }
      
      private function createRewardItem() : void
      {
         var item:Child_SignRewardItem = null;
         var i:int = 0;
         i = 0;
         while(i < Enum_Sign.HOLIDAY_REWARD_MAX_NUM)
         {
            item = new Child_SignRewardItem();
            item.x = 43 + 65 * i;
            item.y = 290;
            addChild(item);
            this.rewardItemVec.push(item);
            i++;
         }
      }
      
      private function updateRewardItem() : void
      {
         var i:int = 0;
         i = 0;
         while(i < Enum_Sign.HOLIDAY_REWARD_MAX_NUM)
         {
            if(Boolean(this.rewardItemVec[i]))
            {
               this.rewardItemVec[i].update(Model_Sign.signRewardStatusData[i],Model_Sign.signRewardData[i]);
            }
            i++;
         }
      }
      
      public function update(count:int, kaifuDay:int, nowPoint:int, lastPoint:int, time:String, wageStatus:int, date:Date) : void
      {
         this.txtCount.htmlText = "<font color=\'#04ff00\'>" + count + "</font>";
         this.txtNowPoint.htmlText = "礼券：<font color=\'#04ff00\'>" + nowPoint + "</font>点";
         this.txtLastPoint.htmlText = "礼券：<font color=\'#04ff00\'>" + lastPoint + "</font>点";
         this.txtTime.htmlText = "本周累计在线已达<font color=\'#04ff00\'>" + time + "</font>小时";
         if(kaifuDay >= Enum_Sign.KAIFU_DAY)
         {
            this.txtLiJuanPoint.htmlText = "（当前每小时可获得<font color=\'#04ff00\'>12</font>礼券）";
            this.kaifuDayMax.visible = true;
            this.kaifuDayMin.visible = false;
         }
         else
         {
            this.txtLiJuanPoint.htmlText = "（当前每小时可获得<font color=\'#04ff00\'>10</font>礼券）";
            this.kaifuDayMax.visible = false;
            this.kaifuDayMin.visible = true;
         }
         if(wageStatus == Enum_Sign.CAN_GET_WAGE)
         {
            this.getRewardBtn.label = "领取奖励";
            this.getRewardBtn.enabled = true;
         }
         else if(wageStatus == Enum_Sign.HAS_GET_WAGE)
         {
            this.getRewardBtn.label = "已领取";
            this.getRewardBtn.enabled = false;
         }
         else
         {
            this.getRewardBtn.label = "领取奖励";
            this.getRewardBtn.enabled = false;
         }
         if(this.isFirst == true && count < 2 && Model_Sign.rewardEffType == Enum_Sign.SHOW_EFF)
         {
            this.isFirst = false;
         }
         else if(count == 2 && Model_Sign.rewardEffType == Enum_Sign.SHOW_EFF)
         {
         }
         this.updateRewardItem();
         this.holidayStatusChange();
         this.datachoose.updateDate(date);
      }
      
      private function tweenPig() : void
      {
         this._pigMc = ComponentUtil.getDisplayObject("pigMc",this,{
            "x":400,
            "y":200,
            "scaleX":0.3,
            "scaleY":-0.3
         },Global.ZaiXian_Imgsdm) as MovieClip;
         Tween.to(this._pigMc,1000,{
            "x":[400,200],
            "scaleX":[-0.3,-0.7],
            "scaleY":[0.3,0.7]
         },function():void
         {
            _spBg = new Sprite();
            _spBg.x = _pigMc.x - 70;
            _spBg.y = 85;
            addChild(_spBg);
            ComponentUtil.getScaleBitmap("Back_Floating",[8,9,4,2],_spBg,{
               "x":-5,
               "y":-5,
               "width":220,
               "height":33
            },Global.Img_Cdm);
            _pigTf = ComponentUtil.getTextField("",_spBg,null);
            _pigTf.realWidth = 200;
            _pigTf.color = 16776960;
            _pigTf.wordWrap = true;
            _pigTf.autoSize = TextFieldAutoSize.CENTER;
            Tween.to(_pigTf,2000,{"alpha":[1,1]},null,tfPercentCallBack);
         });
      }
      
      private function onPigClick(e:MouseEvent) : void
      {
         this.removePig();
      }
      
      private function flyPig() : void
      {
         var disPoint:Point = null;
         var p:Point = null;
         if(!this._pigMc)
         {
            return;
         }
         disPoint = UIManager.mainMenu.getbagPoint();
         if(Boolean(this._pigMc.parent))
         {
            this._pigMc.parent.removeChild(this._pigMc);
         }
         if(!this._pigMc.parent)
         {
            GameScene.upUILayer.addChild(this._pigMc);
         }
         p = this.localToGlobal(new Point(this._pigMc.x,this._pigMc.y));
         this._pigMc.x = p.x;
         this._pigMc.y = p.y;
         Tween.to(this._pigMc,2500,{
            "x":[this._pigMc.x,disPoint.x],
            "y":[this._pigMc.y,disPoint.y + 60]
         },function():void
         {
            removePig();
            _pigMc = null;
         },null,Tween.BEE_LINE);
         if(Boolean(this._spBg) && Boolean(this._spBg.parent))
         {
            this._spBg.parent.removeChild(this._spBg);
         }
      }
      
      private function tfPercentCallBack(thread:Object) : void
      {
         var now:int = getTimer();
         var percent:Number = (now - thread.beginTime) / thread.totleTime;
         percent = Math.min(1,percent);
         this._pigTf.htmlText = this._pigTxt.substr(0,percent * this._pigTxt.length);
         this._pigMc.addEventListener(MouseEvent.CLICK,this.onPigClick);
      }
      
      private function removePig() : void
      {
         this._pigMc.stop();
         if(Boolean(this._pigMc.parent))
         {
            this._pigMc.parent.removeChild(this._pigMc);
         }
         if(Boolean(this._spBg.parent))
         {
            this._spBg.parent.removeChild(this._spBg);
         }
         this._pigMc.removeEventListener(MouseEvent.CLICK,this.onPigClick);
      }
      
      private function superHide() : void
      {
         super.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(!value)
         {
            Model_specialD.visFalseComp(this,UIManager.smallMap.Button_Fu,this.superHide,1);
         }
         else
         {
            super.visible = value;
         }
      }
      
      public function show(prm:* = null) : void
      {
         this.visible = true;
      }
      
      public function hide(prm:* = null) : void
      {
         this.visible = false;
      }
      
      public function flyRewardIcon(i:int) : void
      {
         if(Boolean(this.rewardItemVec[i]))
         {
            this.flyIcon(this.rewardItemVec[i].x,this.rewardItemVec[i].y);
         }
      }
      
      public function flyIcon(x:int, y:int) : void
      {
         var disPoint:Point = null;
         var bm:Bitmap2 = null;
         var dir:String = "resource/image/zaixian/ZaiXian_Imgs.png";
         disPoint = UIManager.mainMenu.getbagPoint();
         var p:Point = this.localToGlobal(new Point(x,y));
         bm = new Bitmap2();
         bm.load(dir);
         bm.x = p.x + 15;
         bm.y = p.y - 25;
         GameScene.upUILayer.addChild(bm);
         Tween.to(bm,2500,{
            "x":[bm.x,disPoint.x],
            "y":[bm.y,disPoint.y]
         },function(bm:Bitmap2):void
         {
            if(Boolean(bm.parent))
            {
               bm.parent.removeChild(bm);
            }
         },null,Tween.SIN);
      }
      
      public function flyHolidayIcon() : void
      {
         this.holidayMenu.flyIcon();
      }
      
      public function holidayStatusChange() : void
      {
         if(Boolean(this.holidayMenu))
         {
            if(Model_Sign.holidayStatus == 1)
            {
               this.holidayMenu.setBtnEnable(true);
               this.holidayMenu.setLabel(LangConfig.getWord("50015",5));
            }
            else if(Model_Sign.nextHolidayDay > 0)
            {
               this.holidayMenu.setBtnEnable(false);
               this.holidayMenu.setLabel("距离 <font color=\'#22DD22\'>" + Model_Sign.holidayName + "</font> 还有<font color=\'#22DD22\'>" + Model_Sign.nextHolidayDay + "</font>天");
            }
            else
            {
               this.holidayMenu.setBtnEnable(false);
               this.holidayMenu.setLabel("今日" + "<font color=\'#22DD22\'>(" + Model_Sign.holidayName + ")</font>" + "奖励已领取");
            }
         }
      }
      
      private function gain(e:MouseEvent) : void
      {
         SignCGMessage.CG_WEEK_WAGE(1);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
      }
      
      override public function get height() : Number
      {
         if(!this.bg)
         {
            return super.height;
         }
         return this.bg.height;
      }
      
      override public function get width() : Number
      {
         if(!this.bg)
         {
            return super.width;
         }
         return this.bg.width;
      }
   }
}

