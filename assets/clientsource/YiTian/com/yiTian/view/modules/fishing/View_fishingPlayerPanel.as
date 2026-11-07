package com.yiTian.view.modules.fishing
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.config.Enum_fishing;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FishingCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.Kunlun.View_RoomTipBtn;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getTimer;
   
   public class View_fishingPlayerPanel extends Panel
   {
      
      private static const DIAOYUTIME:int = 180000;
      
      private var bg:DisplayObject;
      
      private var tf_fishingRemainTime:MyTextField;
      
      private var btn_frontPage:Button;
      
      private var btn_nextPage:Button;
      
      private var btn_diaoyu:Button;
      
      private var btn_shouyu:Button;
      
      private var btn_myFishMark:Button;
      
      private var playerInfoVec:Vector.<Child_fishingPlayerItem>;
      
      private const numItem:int = 5;
      
      private var _state:int = 1;
      
      private var lastXiaGanTime:int;
      
      private var _last:int;
      
      private var isLoad:Boolean = false;
      
      private var extraStr:String;
      
      private var _currentPageIndex:int = 0;
      
      public var maxPageIndex:int = 3;
      
      public function View_fishingPlayerPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var posY:Number = NaN;
         var fpi:Child_fishingPlayerItem = null;
         bAutoRemove = false;
         this.tf_fishingRemainTime = ComponentUtil.getTextField("",this,{
            "y":17,
            "realWidth":510
         });
         this.tf_fishingRemainTime.autoSize = TextFieldAutoSize.CENTER;
         this.tf_fishingRemainTime.htmlText = "";
         this.playerInfoVec = new Vector.<Child_fishingPlayerItem>();
         posY = 55;
         var index:int = 0;
         while(index < this.numItem)
         {
            fpi = new Child_fishingPlayerItem();
            fpi.x = 18.5 + 90 * index;
            fpi.y = posY;
            addChild(fpi);
            this.playerInfoVec.push(fpi);
            index++;
         }
         if(!Global.Fishing_Imgsdm)
         {
            return;
         }
         this.sourceComplete();
      }
      
      public function set fishingStatus(type:int) : void
      {
         switch(type)
         {
            case 1:
               this.btn_diaoyu.visible = true;
               this.btn_shouyu.visible = false;
               break;
            case 2:
               this.btn_diaoyu.visible = false;
               this.btn_shouyu.visible = true;
         }
         this._state = type;
      }
      
      public function resetTimer() : void
      {
         this.lastXiaGanTime = getTimer();
      }
      
      public function counterStart() : void
      {
         GameScene.instance.addFrameCallBack(this.enterFrameHandle);
      }
      
      public function counterStop() : void
      {
         UIManager.fishingPlayerPanel.remainTime = " --:-- ";
         GameScene.instance.removeFrameCallBack(this.enterFrameHandle);
      }
      
      private function enterFrameHandle(interval:int) : void
      {
         var now:int = getTimer();
         if(now - this._last < 900)
         {
            return;
         }
         this._last = now;
         var remainTime:int = DIAOYUTIME - (getTimer() - this.lastXiaGanTime);
         if(remainTime <= 0)
         {
            this.counterStop();
            FishingCGMessage.CG_FISHINGONTIME(Model_fishing.getInstance().currentRiverId);
         }
         UIManager.fishingPlayerPanel.remainTime = this.formToTimeString(remainTime / 1000);
      }
      
      private function enterSceneHandle(obj:Object) : void
      {
         UIManager.fishingPlayerPanel.visible = false;
         UIManager.myFishMark.visible = false;
         UIManager.otherFishMark.visible = false;
         UIManager.riverChoose.visible = false;
         if(View_RoomTipBtn.isInstance())
         {
            UIManager.mainUiBtnContainer.removeBTN(View_RoomTipBtn.getInstance());
            View_RoomTipBtn.getInstance().dispose();
         }
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_SCENE,this.enterSceneHandle);
      }
      
      private function enterFuBenHandle(obj:Object) : void
      {
         if(obj == 12201 || obj == 12202)
         {
            UIManager.fishingPlayerPanel.visible = true;
            UIManager.mainUiBtnContainer.addBTN(View_RoomTipBtn.getInstance());
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_SCENE,this.enterSceneHandle);
         }
      }
      
      private function diaoyuClickHandle(evt:MouseEvent) : void
      {
         var st:int = SceneConfig.getSceneType();
         if(st != SceneConfig.FISH || st == SceneConfig.BEACH)
         {
            if(this._state == 1)
            {
               if(GameUnitManager.hero.action == Action.RUN)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("23326",2));
                  return;
               }
               FishingCGMessage.CG_XIAGAN(Model_fishing.getInstance().currentRiverId);
            }
            else
            {
               FishingCGMessage.CG_SHOUGAN(Model_fishing.getInstance().currentRiverId);
            }
         }
         if(this._state == 1)
         {
            if(GameUnitManager.hero.action == Action.RUN)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("23326",2));
               return;
            }
            FishingCGMessage.CG_XIAGAN(Model_fishing.getInstance().currentRiverId);
         }
         else
         {
            FishingCGMessage.CG_SHOUGAN(Model_fishing.getInstance().currentRiverId);
         }
      }
      
      public function leaveClickHandle(evt:MouseEvent = null) : void
      {
         var st:int = SceneConfig.getSceneType();
         if(st == SceneConfig.FISH || st == SceneConfig.BEACH)
         {
            if(GameUnitManager.hero.status == Status.FISH && Model_fishing.getInstance().isFishing == true)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("23327",2));
            }
            else
            {
               View_Alert.show(LangConfig.getWord("23328",2),View_Alert.OK_CANCAL,function(evt:MouseEvent):void
               {
                  FishingCGMessage.CG_LEAVE_FISHING(Model_fishing.getInstance().currentRiverId);
               });
            }
         }
      }
      
      private function myFishMarkClickHandle(evt:MouseEvent) : void
      {
         if(UIManager.myFishMark.visible == true)
         {
            UIManager.myFishMark.visible = false;
         }
         else
         {
            FishingCGMessage.CG_CHECK_FISH(Model_fishing.getInstance().currentRiverId,GameUnitManager.hero.id);
         }
      }
      
      private function riverClickHandle(evt:MouseEvent) : void
      {
         UIManager.riverChoose.visible = !UIManager.riverChoose.visible;
      }
      
      private function formToTimeString(__time:Number, __insertHout:String = ":", __insertMinute:String = ":") : String
      {
         if(__time < 0)
         {
            return "00:00";
         }
         var __minute:uint = __time / 60 % 60;
         var __second:uint = __time % 60;
         var __timeTxt:String = " ";
         __timeTxt += (__minute < 10 ? "0" + __minute.toString() : __minute.toString()) + __insertMinute;
         return __timeTxt + (__second < 10 ? "0" + __second.toString() : __second.toString());
      }
      
      override protected function initDynamicView() : void
      {
         Global.control.registerCallBack(Enum_MsgType.MSG_LEAVEFB_BTN,this.leaveClickHandle);
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN,this.enterFuBenHandle);
      }
      
      override public function set visible(value:Boolean) : void
      {
         var pf:String = null;
         var fpi:Child_fishingPlayerItem = null;
         super.visible = value;
         if(value)
         {
            pf = Global.pf;
            if(pf == Enum_SPStr.QZONE || pf == Enum_SPStr.PENGYOU || Enum_SPStr.isIwan(Global.pf))
            {
               this.extraStr = "<font color=\'#aaaa00\'>【<font color=\'#ffff00\'>黄钻</font>钓鱼经验加成10%】</font>";
            }
            else if(pf == Enum_SPStr.QQGAME)
            {
               if(Boolean(GameUnitManager.hero.ylDiaLvl) || Boolean(GameUnitManager.hero.superLan))
               {
                  this.extraStr = "<font color=\'#aaaa00\'>【<font color=\'#00ffff\'>蓝钻</font>钓鱼经验加成10%】</font>";
               }
               else
               {
                  this.extraStr = "<font color=\'#aaaa00\'>【<font color=\'#00ffff\'>大厅</font>钓鱼经验加成3%】</font>";
               }
            }
            else if(pf == Enum_SPStr.QQJIA || Global.pf == Enum_SPStr.GUANWANG)
            {
               this.extraStr = "<font color=\'#aaaa00\'>【<font color=\'#00ffff\'>会员</font>钓鱼经验加成10%】</font>";
            }
            else if(pf == Enum_SPStr.QQ3366)
            {
               if(Boolean(GameUnitManager.hero.ylDiaLvl) || Boolean(GameUnitManager.hero.superLan))
               {
                  this.extraStr = "<font color=\'#aaaa00\'>【<font color=\'#00ffff\'>蓝钻</font>钓鱼经验加成10%】</font>";
               }
               else
               {
                  this.extraStr = "<font color=\'#aaaa00\'>【<font color=\'#00ffff\'>3366</font>钓鱼经验加成3%】</font>";
               }
            }
            else if(pf == Enum_SPStr.CHITU)
            {
               this.extraStr = "<font color=\'#aaaa00\'>【<font color=\'#00ffff\'>盒子</font>钓鱼经验加成3%】</font>";
            }
            this.counterStop();
         }
         if(!Global.Fishing_Imgsdm)
         {
            this.load();
         }
         if(!this.isLoad)
         {
            for each(fpi in this.playerInfoVec)
            {
               fpi.load();
            }
            this.isLoad = true;
         }
      }
      
      private function load() : void
      {
         var arr:Array = [];
         arr.push([Enum_fishing.FISHINGSOURCE,this.sourceComplete,LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr,function():void
         {
            View_loading.instance.visible = false;
         });
      }
      
      private function sourceComplete(info:Object = null) : void
      {
         if(Boolean(this.bg))
         {
            return;
         }
         if(Boolean(info))
         {
            Global.Fishing_Imgsdm = info.applicationDomain;
         }
         this.bg = ComponentUtil.getBitmap("Back_YuLan",this,{
            "x":0,
            "y":7
         },Global.Fishing_Imgsdm);
         setChildIndex(this.bg,0);
         this.btn_diaoyu = ComponentUtil.getButton("","Button_Fish",this,{
            "x":20,
            "y":0,
            "textColor":16184781
         },Global.Fishing_Imgsdm);
         this.btn_shouyu = ComponentUtil.getButton("","Button_Shou",this,{
            "x":20,
            "y":0,
            "textColor":16184781
         },Global.Fishing_Imgsdm);
         this.btn_shouyu.visible = false;
         this.btn_myFishMark = ComponentUtil.getButton("","Button_MyYuLan",this,{
            "x":381,
            "y":0,
            "textColor":16184781
         },Global.Fishing_Imgsdm);
         this.btn_frontPage = ComponentUtil.getButton("","Button_FishPageUp",this,{
            "x":13,
            "y":52,
            "textColor":16184781
         },Global.Fishing_Imgsdm);
         this.btn_nextPage = ComponentUtil.getButton("","Button_FishPageDown",this,{
            "x":480,
            "y":52,
            "textColor":16184781
         },Global.Fishing_Imgsdm);
         this.btn_shouyu.callBack = this.diaoyuClickHandle;
         this.btn_diaoyu.callBack = this.diaoyuClickHandle;
         this.btn_myFishMark.callBack = this.myFishMarkClickHandle;
         this.btn_frontPage.callBack = this.frontPageClickHandle;
         this.btn_nextPage.callBack = this.nextPageClickHandle;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = Global.stage.stageHeight - height - 120;
      }
      
      private function frontPageClickHandle(evt:MouseEvent) : void
      {
         this.currentPageIndex = this._currentPageIndex - 1;
      }
      
      private function nextPageClickHandle(evt:MouseEvent) : void
      {
         this.currentPageIndex = this._currentPageIndex + 1;
      }
      
      public function set fishingPlayerInfo(value:Array) : void
      {
         Model_fishing.getInstance().fishPlayerArr = value;
         this.updateFishingPlayerInfoList();
      }
      
      public function updateFishingPlayerInfoList() : void
      {
         this.currentPageIndex = this._currentPageIndex;
      }
      
      public function set currentPageIndex(value:int) : void
      {
         var index:int = 0;
         if(value < 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29071",2));
         }
         else if(value > this.maxPageIndex)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29072",2));
         }
         else
         {
            this._currentPageIndex = value;
            index = 0;
            while(index < this.numItem)
            {
               this.playerInfoVec[index].vo = Model_fishing.getInstance().fishPlayerArr[this._currentPageIndex * 5 + index];
               index++;
            }
         }
      }
      
      public function set remainTime(value:String) : void
      {
         var str:String = LangConfig.getWord("29293",2) + "：<font color=\'#C48D3C\'>" + value + "</font>" + (this.extraStr != null ? "  " + this.extraStr : "");
         this.tf_fishingRemainTime.htmlText = str;
      }
   }
}

