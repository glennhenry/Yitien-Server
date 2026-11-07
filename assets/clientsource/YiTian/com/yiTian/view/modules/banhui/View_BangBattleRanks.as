package com.yiTian.view.modules.banhui
{
   import Layout.VGroup;
   import com.ui.controls.Button;
   import com.ui.controls.MaskProgressBar;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BangBattleCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.view.UIBase123;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.loading.View_loading;
   import com.yiTian.view.modules.mainUIBtnContainer.View_mainUiBtn_container;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getTimer;
   
   public class View_BangBattleRanks extends UIBase123
   {
      
      public static const bmDirs:Array = ["resource/image/bangZhan/1.png","resource/image/bangZhan/2.png","resource/image/bangZhan/3.png","resource/image/bangZhan/4.png"];
      
      private var _bg:DisplayObjectContainer;
      
      private var _tf_title:MyTextField;
      
      private var _tf_time:MyTextField;
      
      private var _tf_mySoccer:MyTextField;
      
      private var _tf_killM:MyTextField;
      
      private var _tf_killH:MyTextField;
      
      private var _tf_bangSoccer:MyTextField;
      
      private var _tf_kuangTime:MyTextField;
      
      private var _pb_kuangTime:MaskProgressBar;
      
      private var btn_phb:Button;
      
      private var btn_answer:Button;
      
      private var bm_pbBar:Bitmap;
      
      private var bm_pbBg:Bitmap;
      
      private var isOverPb:Boolean = false;
      
      private var _isInBB:Boolean;
      
      private var _updateTime1:int;
      
      private var _updateTime2:int;
      
      private var _lastTime1:int;
      
      private var _lastTime2:int;
      
      private var _pre1:int;
      
      private var _pre2:int;
      
      private var _isStart:int;
      
      private var bmArr:Array = [];
      
      private var bmVGroup:VGroup = new VGroup(145,113,0,0,0,22);
      
      private var isUIComplete:Boolean = false;
      
      public function View_BangBattleRanks()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this._bg = new Sprite();
         this._bg.mouseEnabled = false;
         addChild(this._bg);
         ComponentUtil.getScaleBitmap("Back_HuoDong",[60,36,3,5],this._bg,{
            "x":0,
            "y":0,
            "width":270,
            "height":166
         },Global.Img_Cdm);
         this.btn_phb = ComponentUtil.getButton("","Button_HDSeach",this,{
            "x":30,
            "y":2,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_answer = ComponentUtil.getButton("","Button_HDTips",this,{
            "x":216,
            "y":2,
            "textColor":16184781
         },Global.Img_Cdm);
         this._tf_title = ComponentUtil.getTextField("",this,{
            "x":130,
            "y":4,
            "color":16184781,
            "size":14
         });
         this._tf_title.autoSize = TextFieldAutoSize.CENTER;
         this._tf_title.bold = true;
         this._tf_title.htmlText = LangConfig.getWord("29057",2);
         this._tf_time = ComponentUtil.getTextField(LangConfig.getWord("29058",2),this,{
            "x":40,
            "y":34
         });
         this._tf_mySoccer = ComponentUtil.getTextField(LangConfig.getWord("29059",2),this,{
            "x":40,
            "y":54
         });
         this._tf_killH = ComponentUtil.getTextField(LangConfig.getWord("29060",2),this,{
            "x":40,
            "y":74
         });
         this._tf_killM = ComponentUtil.getTextField(LangConfig.getWord("29061",2),this,{
            "x":40,
            "y":94
         });
         this._tf_bangSoccer = ComponentUtil.getTextField(LangConfig.getWord("29062",2),this,{
            "x":40,
            "y":114
         });
         this._tf_kuangTime = ComponentUtil.getTextField(LangConfig.getWord("29063",2),this,{
            "x":40,
            "y":134
         });
         this._pb_kuangTime = new MaskProgressBar();
         this._pb_kuangTime.x = this._tf_kuangTime.width + this._tf_kuangTime.x;
         this._pb_kuangTime.y = 140;
         this._pb_kuangTime.realWidth = 125;
         this.bm_pbBar = new Bitmap();
         this.bm_pbBar.x = 1;
         this.bm_pbBar.y = 2;
         this.bm_pbBg = new Bitmap();
         this._pb_kuangTime.bg = this.bm_pbBg;
         this._pb_kuangTime.bar = this.bm_pbBar;
         this._pb_kuangTime.init();
         this._pb_kuangTime.persent = 1;
         this._pb_kuangTime.addEventListener(MouseEvent.MOUSE_MOVE,this.pbROverHd);
         this._pb_kuangTime.addEventListener(MouseEvent.ROLL_OUT,this.pbROutHd);
         addChild(this._pb_kuangTime);
         bindParent = GameScene.uiLayer;
      }
      
      private function tipUpdate() : void
      {
         TipManager.update(LangConfig.getWord("29064",2) + int(this._pb_kuangTime.persent * 180).toString() + "/180");
      }
      
      private function pbROverHd(evt:MouseEvent) : void
      {
         this.tipUpdate();
         this.isOverPb = true;
      }
      
      private function pbROutHd(evt:MouseEvent) : void
      {
         this.isOverPb = false;
         TipManager.hide();
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.visible = false;
         this.btn_phb.callBack = this.phbClickHd;
         this.btn_answer.callBack = function(evt:MouseEvent):void
         {
            UIManager.bbIntroduce.visible = !UIManager.bbIntroduce.visible;
         };
         Global.control.registerCallBack(Enum_MsgType.MSG_LEAVEFB_BTN,this.leaveCb);
         Global.control.registerCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,this.sceneOkCb);
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN_OK,this.sceneOkCb);
      }
      
      private function phbClickHd(evt:MouseEvent) : void
      {
         UIManager.bbRank.visible = !UIManager.bbRank.visible;
      }
      
      private function sceneOkCb(obj:Object = null) : void
      {
         var s:int = 0;
         var sType:int = SceneConfig.getSceneType();
         if(sType == SceneConfig.BZ_BATTLE || sType == SceneConfig.BZ_READY)
         {
            UIManager.questTraceView.visible = false;
            if(this._isInBB)
            {
               return;
            }
            this._isInBB = true;
            this.visible = true;
            UIManager.mainUiBtnContainer.showLeaveBtn(View_mainUiBtn_container.BANGZHAN);
            Global.control.registerCallBack(Enum_MsgType.MSG_LEAVEFB_BTN,this.leaveCb);
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep);
         }
         else
         {
            if(!this._isInBB)
            {
               return;
            }
            this._isInBB = false;
            UIManager.questTraceView.visible = true;
            this.visible = false;
            UIManager.mainUiBtnContainer.hideLeaveBtn();
            s = GameUnitManager.hero.status;
            if(s == Status.BANG_PAI || s == Status.BZ_COLLECT)
            {
               GameUnitManager.hero.status = Status.NOMAL;
            }
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.frameStep);
         }
      }
      
      private function leaveCb(o:Object = null) : void
      {
         var sId:int = Global.sceneID;
         if(sId == 12401 || sId >= 12403 && sId <= 12406)
         {
            View_Alert.show(LangConfig.getWord("29065",2),View_Alert.OK_CANCAL,function():void
            {
               BangBattleCGMessage.CG_FR_LEAVE_BATTLE();
            });
         }
         else if(sId == 12402)
         {
            View_Alert.show(LangConfig.getWord("29065",2),View_Alert.OK_CANCAL,function():void
            {
               BangBattleCGMessage.CG_MAIN_LEAVE_BATTLE();
            });
         }
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - this._bg.width;
         y = UIManager.questTraceView.y;
      }
      
      public function updateActTime(value:int) : void
      {
         if(value == -1)
         {
            return;
         }
         this._updateTime1 = getTimer();
         this._lastTime1 = value;
      }
      
      public function updateKuangTime(value:int) : void
      {
         if(value == -1)
         {
            return;
         }
         this._updateTime2 = getTimer();
         this._lastTime2 = value;
      }
      
      private function frameStep() : void
      {
         var remain1:int = 0;
         var remain2:int = 0;
         var now:int = getTimer();
         if(now - this._pre1 >= 1000)
         {
            this._pre1 = now;
            if(this._isStart == 1)
            {
               remain1 = this._lastTime1 - (now - this._updateTime1) / 1000;
               this.actTime = remain1;
            }
            else
            {
               this.actTime = 1800;
            }
         }
         if(now - this._pre2 >= 1000)
         {
            this._pre2 = now;
            if(this._isStart == 1)
            {
               remain2 = this._lastTime2 - (now - this._updateTime2) / 1000;
               if(remain2 < 0)
               {
                  this.updateKuangTime(180);
               }
               this.kuangTime = remain2;
            }
            else
            {
               this.kuangTime = 180;
            }
            if(this.isOverPb)
            {
               this.tipUpdate();
            }
         }
      }
      
      private function set actTime(value:int) : void
      {
         var str:String = value >= 0 ? DateUtil.getHMSBySecond2(value) : "00:00:00";
         this._tf_time.htmlText = LangConfig.getWord("29058",2) + "<font color=\'#DDDD00\'>" + str + "</font>";
      }
      
      private function set kuangTime(value:int) : void
      {
         this._pb_kuangTime.persent = value / 180;
      }
      
      public function set isStart(value:int) : void
      {
         this._isStart = value;
      }
      
      public function update(actTime:int, mySoccer:int, killH:int, killM:int, bangSoccer:int, kuangRemain:int, isStart:int) : void
      {
         this.updateActTime(actTime);
         if(kuangRemain >= 0)
         {
            this.updateKuangTime(kuangRemain);
         }
         if(actTime >= 0)
         {
            this._tf_time.htmlText = LangConfig.getWord("29058",2) + "<font color=\'#DDDD00\'>" + actTime.toString() + "</font>";
         }
         this._tf_mySoccer.htmlText = LangConfig.getWord("29059",2) + "<font color=\'#DDDD00\'>" + mySoccer.toString() + "</font>";
         this._tf_killH.htmlText = LangConfig.getWord("29060",2) + "<font color=\'#DDDD00\'>" + killH.toString() + "</font>";
         this._tf_killM.htmlText = LangConfig.getWord("29061",2) + "<font color=\'#DDDD00\'>" + killM.toString() + "</font>";
         this._tf_bangSoccer.htmlText = LangConfig.getWord("29062",2) + "<font color=\'#DDDD00\'>" + bangSoccer.toString() + "</font>";
         this._isStart = isStart;
      }
      
      public function updateBangLord(bArr:Array) : void
      {
         var bm:Bitmap2 = null;
         var j:int = 0;
         var zbID:Number = NaN;
         var bmm:Bitmap2 = null;
         for each(bm in this.bmArr)
         {
            removeChild(bm);
            bm.load(null);
         }
         this.bmArr.splice(0);
         this.bmVGroup.clearItem();
         j = 0;
         while(j < bArr.length)
         {
            zbID = Number(bArr[j]);
            if(zbID == GameUnitManager.hero.partyId)
            {
               bmm = new Bitmap2();
               bmm.load(bmDirs[j]);
               this.bmVGroup.appendItem(bmm);
               this.bmArr.push(bmm);
               addChild(bmm);
            }
            j += 1;
         }
         this.bmVGroup.align();
      }
      
      override public function set visible(value:Boolean) : void
      {
         var arr:Array = null;
         if(value)
         {
            if(!this.isUIComplete)
            {
               if(!Global.bangzhan_Imsdm)
               {
                  arr = [];
                  arr.push(["lang/ch/BangZhan_Imgs.swf",function(info:Object):void
                  {
                     Global.bangzhan_Imsdm = info.applicationDomain;
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
            this.resetPosition();
         }
         super.visible = value;
      }
      
      private function initT() : void
      {
         this.bm_pbBar.bitmapData = ComponentUtil.getBitmapData("Progress_TimeReflash",Global.bangzhan_Imsdm);
         this.bm_pbBg.bitmapData = ComponentUtil.getBitmapData("Back_TimeReflash",Global.bangzhan_Imsdm);
         this.isUIComplete = true;
      }
   }
}

