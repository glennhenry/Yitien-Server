package com.yiTian.view.modules.KuaFuPaiDui
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_KuaFuPaiDui;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.gameUnit.role.Player;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.KuaFuPaiDuiCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.Kunlun.View_RoomTipBtn;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.ui.Keyboard;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class Control_KuaFuPaiDui
   {
      
      private static var _instance:Control_KuaFuPaiDui;
      
      private const prepareTime:int = 5000;
      
      private var prepareTimer:Timer;
      
      private const danceTime:int = 10000;
      
      private var spaceBarPos:Number;
      
      private var danceTimer:Timer;
      
      private var spaceBallBegin:int;
      
      private const wrongTime:int = 500;
      
      private var wrongTimer:Timer;
      
      private var stepsArray:Array;
      
      private var level:int;
      
      private var curStepId:int;
      
      private var specialKey:int;
      
      private var beginTime:int;
      
      private var leftTime:int;
      
      private var beginTime1:int;
      
      private var leftTime1:int;
      
      private var leaveBtn:MainUIBtn;
      
      private var firstEnter:Boolean = true;
      
      private var lightCircle:Effect;
      
      private var lightCircleSprite:Sprite;
      
      public function Control_KuaFuPaiDui(a:A)
      {
         super();
         if(a == null)
         {
            throw new Error("KuaFuPaiDui_control can not init");
         }
         this.Init();
      }
      
      public static function getInstance() : Control_KuaFuPaiDui
      {
         if(Boolean(_instance))
         {
            return _instance;
         }
         _instance = new Control_KuaFuPaiDui(new A());
         return _instance;
      }
      
      private function Init() : void
      {
         this.level = 1;
         this.stepsArray = [];
         this.prepareTimer = new Timer(1000);
         this.prepareTimer.addEventListener(TimerEvent.TIMER,this.onPrepareTimer);
         this.danceTimer = new Timer(50);
         this.danceTimer.addEventListener(TimerEvent.TIMER,this.ondanceTimer);
         this.wrongTimer = new Timer(this.wrongTime,1);
         this.wrongTimer.addEventListener(TimerEvent.TIMER,this.onwrongTimer);
         this.leaveBtn = new MainUIBtn("resource/image/pata/Exit_Icon.png");
         View_KuaFuPaiDui_explainIcon.instance.x = Global.stage.stageWidth - 235 - 75 * 3;
         View_RoomTipBtn.getInstance().x = Global.stage.stageWidth - 235 - 75 * 2;
         this.leaveBtn.x = Global.stage.stageWidth - 235 - 75;
         Global.control.registerCallBack(Enum_KuaFuPaiDui.ENTER,this.enter);
         Global.control.registerCallBack(Enum_KuaFuPaiDui.EXIT,this.exit);
         Global.control.registerCallBack(Enum_KuaFuPaiDui.COUNT_DOWN,this.updateCountDownTime);
         Global.control.registerCallBack(Enum_KuaFuPaiDui.ROUND_START,this.startPrepare);
         Global.control.registerCallBack(Enum_KuaFuPaiDui.REST,this.format);
         Global.control.registerCallBack(Enum_KuaFuPaiDui.SCORE_LIST,this.updateScoreList);
         Global.control.registerCallBack(Enum_KuaFuPaiDui.SCORE_ADD,this.addScore);
         Global.control.registerCallBack(Enum_KuaFuPaiDui.CHANGE_ROOM,this.changeRoom);
         Global.control.registerCallBack(Enum_KuaFuPaiDui.FRESH_ROOM,this.freshRoom);
         Global.control.registerCallBack(Enum_KuaFuPaiDui.FRESH_PARTNER,this.freshPartner);
         Global.control.registerCallBack(Enum_MsgType.MSG_ADD_PLAYER_2,this.onChangeShow);
         Global.control.registerCallBack(Enum_MsgType.UPDATE_AVATER_COMPLETE,this.onChangeShow);
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN_OK,this.showLeaveBtn);
         Global.control.registerCallBack(Enum_KuaFuPaiDui.INVITE_SUCCEED,this.goToThePlayer);
      }
      
      private function onChangeShow(player:Player) : void
      {
         if(player.status == Status.KuaFuPaiDui_HIDE)
         {
            player.visible = false;
         }
         else if(player.status > Status.KuaFuPaiDui_HIDE && player.status <= Status.KuaFuPaiDui_25)
         {
            player.visible = true;
         }
      }
      
      private function showLeaveBtn(e:*) : void
      {
         if(SceneConfig.getSceneType() != SceneConfig.KuaFuPaiDui)
         {
            return;
         }
         this.leaveBtn.addEventListener(MouseEvent.CLICK,this.clickBtnHandler);
         this.leaveBtn.addEventListener(MouseEvent.ROLL_OVER,this.overBtnHandler);
         this.leaveBtn.addEventListener(MouseEvent.ROLL_OUT,this.outBtnHandler);
         GameScene.uiLayer.addChild(this.leaveBtn);
      }
      
      private function enter(e:* = null) : void
      {
         UIManager.questTraceView.visible = false;
         UIManager.newMainBtnContainer.visible = false;
         UIManager.mainUiBtnContainer.visible = false;
         UIManager.special_btn.visible = false;
         UIManager.mainMenu.setBtnEnabled(false);
         UIManager.smallMap.setAllBtnEnabled(false);
         if(!GameUnitManager.isShowPlayer)
         {
            UIManager.smallMap.biClick(null);
         }
         View_KuaFuPaiDui_rank.instance.visible = true;
         View_KuaFuPaiDui_countDown.instance.visible = true;
         if(this.firstEnter)
         {
            this.firstEnter = false;
            View_KuaFuPaiDui_explainMenu.instance.visible = true;
         }
         View_KuaFuPaiDui_explainIcon.instance.addEventListener(MouseEvent.ROLL_OVER,this.overBtnHandler);
         View_KuaFuPaiDui_explainIcon.instance.addEventListener(MouseEvent.ROLL_OUT,this.outBtnHandler);
         View_RoomTipBtn.getInstance().addEventListener(MouseEvent.ROLL_OVER,this.overBtnHandler);
         View_RoomTipBtn.getInstance().addEventListener(MouseEvent.ROLL_OUT,this.outBtnHandler);
         GameScene.uiLayer.addChild(View_KuaFuPaiDui_explainIcon.instance);
         GameScene.uiLayer.addChild(View_RoomTipBtn.getInstance());
         if(Model_KuaFuPaiDui.effectArray.length == 0)
         {
            Model_KuaFuPaiDui.effectArray.push(ComponentUtil.getDisplayObject("Light",GameScene.gridLayer,{
               "x":1419,
               "y":994
            },Global.KFPDdm));
         }
         if(this.lightCircle == null)
         {
            this.lightCircleSprite = new Sprite();
            GameScene.gridLayer.addChild(this.lightCircleSprite);
            this.lightCircleSprite.x = GameUnitManager.hero.global_x;
            this.lightCircleSprite.y = GameUnitManager.hero.global_y;
            this.lightCircle = EffectManager.addEffect("35290",this.lightCircleSprite,2000,0,0,true);
         }
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onEnterFrame);
         Global.stage.addEventListener(Event.RESIZE,this.onResize);
      }
      
      private function exit(e:* = null) : void
      {
         var dis:DisplayObject = null;
         this.format();
         Model_KuaFuPaiDui.totalScore = 0;
         Model_KuaFuPaiDui.lastPartner = [];
         UIManager.questTraceView.visible = true;
         UIManager.newMainBtnContainer.visible = true;
         UIManager.mainUiBtnContainer.visible = true;
         UIManager.special_btn.visible = true;
         UIManager.mainMenu.setBtnEnabled(true);
         UIManager.smallMap.setAllBtnEnabled(true);
         View_KuaFuPaiDui_rank.instance.visible = false;
         View_KuaFuPaiDui_countDown.instance.visible = false;
         View_KuaFuPaiDui_danceStepsMenu.instance.visible = false;
         View_KuaFuPaiDui_explainMenu.instance.visible = false;
         View_KuaFuPaiDui_scoreEffect.instance.visible = false;
         this.leaveBtn.removeEventListener(MouseEvent.CLICK,this.clickBtnHandler);
         this.leaveBtn.removeEventListener(MouseEvent.ROLL_OVER,this.overBtnHandler);
         this.leaveBtn.removeEventListener(MouseEvent.ROLL_OUT,this.outBtnHandler);
         View_KuaFuPaiDui_explainIcon.instance.removeEventListener(MouseEvent.ROLL_OVER,this.overBtnHandler);
         View_KuaFuPaiDui_explainIcon.instance.removeEventListener(MouseEvent.ROLL_OUT,this.outBtnHandler);
         View_RoomTipBtn.getInstance().removeEventListener(MouseEvent.ROLL_OVER,this.overBtnHandler);
         View_RoomTipBtn.getInstance().removeEventListener(MouseEvent.ROLL_OUT,this.outBtnHandler);
         if(GameScene.uiLayer.contains(View_KuaFuPaiDui_explainIcon.instance))
         {
            GameScene.uiLayer.removeChild(View_KuaFuPaiDui_explainIcon.instance);
         }
         if(GameScene.uiLayer.contains(View_RoomTipBtn.getInstance()))
         {
            GameScene.uiLayer.removeChild(View_RoomTipBtn.getInstance());
         }
         if(GameScene.uiLayer.contains(this.leaveBtn))
         {
            GameScene.uiLayer.removeChild(this.leaveBtn);
         }
         while(Boolean(Model_KuaFuPaiDui.effectArray.length))
         {
            dis = Model_KuaFuPaiDui.effectArray.shift();
            if(Boolean(dis.stage))
            {
               GameScene.gridLayer.removeChild(dis);
            }
         }
         if(Boolean(this.lightCircle))
         {
            EffectManager.removeEffect(this.lightCircle);
            this.lightCircle = null;
            if(Boolean(this.lightCircleSprite.stage))
            {
               GameScene.gridLayer.removeChild(this.lightCircleSprite);
               this.lightCircleSprite = null;
            }
         }
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onEnterFrame);
         GameScene.instance.removeFrameCallBack(this.onCountDown);
         GameScene.instance.removeFrameCallBack(this.onDanceingTime);
         Global.stage.removeEventListener(Event.RESIZE,this.onResize);
      }
      
      private function clickBtnHandler(event:MouseEvent) : void
      {
         View_Alert.show("退出跨服派对房间后，会<font color=\'#ff0000\'>解除舞伴</font>关系，" + "默契度将会<font color=\'#ff0000\'>清零</font>，是否继续？",2,function():void
         {
            KuaFuPaiDuiCGMessage.CG_KuaFuPaiDui_EXIT();
         },null,null,null,310,null,null,"center",false,2);
      }
      
      private function overBtnHandler(e:MouseEvent) : void
      {
         e.currentTarget.transform.colorTransform = Util.colorWhite2;
      }
      
      private function outBtnHandler(e:MouseEvent) : void
      {
         e.currentTarget.transform.colorTransform = Util.colorNomal;
      }
      
      private function onResize(e:Event) : void
      {
         View_KuaFuPaiDui_explainIcon.instance.x = Global.stage.stageWidth - 235 - 75 * 3;
         View_RoomTipBtn.getInstance().x = Global.stage.stageWidth - 235 - 75 * 2;
         this.leaveBtn.x = Global.stage.stageWidth - 235 - 75;
      }
      
      private function startPrepare(e:* = null) : void
      {
         View_KuaFuPaiDui_danceStepsMenu.instance.setCountDown(5);
         this.wrongTimer.stop();
         this.prepareTimer.stop();
         this.danceTimer.stop();
         Global.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         this.stepsArray = this.creatArrow(Data_lib.danceSteps[this.level][0]);
         this.curStepId = 1;
         View_KuaFuPaiDui_danceStepsMenu.instance.creatArrow(this.stepsArray);
         View_KuaFuPaiDui_danceStepsMenu.instance.resetArrowRightWrong();
         this.prepareTimer.reset();
         this.prepareTimer.start();
      }
      
      private function freshRoom(e:* = null) : void
      {
         View_KuaFuPaiDui_roomMenu.instance.freshRoom();
      }
      
      private function changeRoom(e:* = null) : void
      {
         this.format();
         Model_KuaFuPaiDui.totalScore = 0;
         Model_KuaFuPaiDui.lastPartner = [];
      }
      
      private function format(e:* = null) : void
      {
         this.level = 1;
         this.wrongTimer.stop();
         this.prepareTimer.stop();
         this.danceTimer.stop();
         View_KuaFuPaiDui_danceStepsMenu.instance.checkSuccess();
         Global.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }
      
      private function onPrepareTimer(e:TimerEvent) : void
      {
         var leftTime:int = int(this.prepareTime / 1000) - this.prepareTimer.currentCount;
         View_KuaFuPaiDui_danceStepsMenu.instance.setCountDown(leftTime);
         this.spaceBarPos = 0;
         View_KuaFuPaiDui_danceStepsMenu.instance.setSpaceBar(this.spaceBarPos);
         View_KuaFuPaiDui_danceStepsMenu.instance.checkSuccess();
         if(leftTime == 0)
         {
            this.prepareTimer.stop();
            this.startDance();
         }
      }
      
      private function startDance() : void
      {
         this.danceTimer.reset();
         this.spaceBallBegin = getTimer();
         this.danceTimer.start();
         Global.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }
      
      private function ondanceTimer(e:TimerEvent) : void
      {
         var pastTime:int = getTimer() - this.spaceBallBegin;
         this.spaceBarPos = pastTime / this.danceTime;
         View_KuaFuPaiDui_danceStepsMenu.instance.setSpaceBar(this.spaceBarPos);
         View_KuaFuPaiDui_danceStepsMenu.instance.checkSuccess();
         if(this.spaceBarPos >= 1)
         {
            Global.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
            this.danceTimer.stop();
            this.timeOut();
         }
      }
      
      private function onwrongTimer(e:TimerEvent) : void
      {
         View_KuaFuPaiDui_danceStepsMenu.instance.setEnabled(this.curStepId,true);
         Global.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }
      
      private function timeOut() : void
      {
         if(this.level > 4)
         {
            this.level = 4;
         }
         KuaFuPaiDuiCGMessage.CG_KuaFuPaiDui_STEP(Model_KuaFuPaiDui.roundTime,0,0);
      }
      
      private function onKeyDown(e:KeyboardEvent) : void
      {
         if((e.keyCode < 37 || e.keyCode > 40) && e.keyCode != Keyboard.SPACE)
         {
            return;
         }
         if(e.keyCode == Keyboard.SPACE)
         {
            Global.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
            if(this.curStepId > this.stepsArray.length)
            {
               this.checkSuccess();
            }
            else
            {
               this.fail();
            }
         }
         else if(this.curStepId <= this.stepsArray.length)
         {
            if(this.stepsArray[this.curStepId - 1] == 4 && e.keyCode != Keyboard.SPACE)
            {
               this.specialKey = e.keyCode;
               View_KuaFuPaiDui_danceStepsMenu.instance.setArrowRightWrong(this.curStepId,1);
               View_KuaFuPaiDui_danceStepsMenu.instance.setRandomArrow(this.curStepId,this.specialKey - 37);
               ++this.curStepId;
            }
            else
            {
               if(e.keyCode - 37 != this.stepsArray[this.curStepId - 1])
               {
                  Global.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
                  this.wrongTimer.reset();
                  View_KuaFuPaiDui_danceStepsMenu.instance.setArrowRightWrong(this.curStepId,2);
                  this.wrongTimer.start();
                  return;
               }
               View_KuaFuPaiDui_danceStepsMenu.instance.setArrowRightWrong(this.curStepId,1);
               ++this.curStepId;
            }
         }
      }
      
      private function success() : void
      {
         View_KuaFuPaiDui_danceStepsMenu.instance.showPerfect();
         ++this.level;
         if(this.level > Data_lib.danceSteps.getLength())
         {
            this.level = 4;
         }
         KuaFuPaiDuiCGMessage.CG_KuaFuPaiDui_STEP(Model_KuaFuPaiDui.roundTime,1,this.specialKey);
      }
      
      private function fail() : void
      {
         this.danceTimer.stop();
         if(this.level > 4)
         {
            this.level = 4;
         }
         KuaFuPaiDuiCGMessage.CG_KuaFuPaiDui_STEP(Model_KuaFuPaiDui.roundTime,0,this.specialKey);
      }
      
      private function checkSuccess() : void
      {
         this.danceTimer.stop();
         if(View_KuaFuPaiDui_danceStepsMenu.instance.checkSuccess())
         {
            this.success();
         }
         else
         {
            this.fail();
         }
      }
      
      private function updateCountDownTime(arr:Array) : void
      {
         if(arr[0] == 1)
         {
            Model_KuaFuPaiDui.isDanceing = false;
            this.beginTime = getTimer();
            this.leftTime = arr[1];
            GameScene.instance.addFrameCallBack(this.onCountDown);
            View_KuaFuPaiDui_countDown.instance.visible = true;
            View_KuaFuPaiDui_danceStepsMenu.instance.visible = false;
         }
         else if(arr[0] == 2)
         {
            Model_KuaFuPaiDui.isDanceing = true;
            this.beginTime1 = getTimer();
            this.leftTime1 = arr[1];
            GameScene.instance.addFrameCallBack(this.onDanceingTime);
            if(Model_KuaFuPaiDui.inTeam)
            {
               View_KuaFuPaiDui_countDown.instance.visible = false;
               View_KuaFuPaiDui_danceStepsMenu.instance.visible = true;
            }
         }
      }
      
      private function onCountDown() : void
      {
         var now:int = getTimer();
         var useTime:int = now - this.beginTime;
         var curTime:int = this.leftTime - int(useTime / 1000);
         if(curTime <= 0)
         {
            curTime = 0;
            GameScene.instance.removeFrameCallBack(this.onCountDown);
         }
         View_KuaFuPaiDui_countDown.instance.setTime(curTime);
      }
      
      private function onDanceingTime() : void
      {
         var now:int = getTimer();
         var useTime:int = now - this.beginTime1;
         var curTime:int = this.leftTime1 - int(useTime / 1000);
         if(curTime <= 0)
         {
            curTime = 0;
            GameScene.instance.removeFrameCallBack(this.onDanceingTime);
         }
         View_KuaFuPaiDui_danceStepsMenu.instance.setLeftTime(curTime);
      }
      
      private function updateScoreList(arr:Array) : void
      {
         Model_KuaFuPaiDui.rankList = arr;
         View_KuaFuPaiDui_rank.instance.setRank();
      }
      
      private function freshPartner(e:* = null) : void
      {
         View_KuaFuPaiDui_partnerMenu.instance.freshRoom();
      }
      
      private function addScore(score:int) : void
      {
         View_KuaFuPaiDui_scoreEffect.instance.showScore(score);
      }
      
      private function creatArrow(num:uint) : Array
      {
         var i:uint = 0;
         var id:int = 0;
         var arr:Array = [];
         if(num > 1)
         {
            i = 0;
            while(i < num - 1)
            {
               arr.push(Math.floor(Math.random() * 4));
               i++;
            }
            id = Math.floor(Math.random() * (arr.length + 1));
            arr.splice(id,0,4);
         }
         else
         {
            arr.push(Math.floor(Math.random() * 4));
         }
         return arr;
      }
      
      private function goToThePlayer(flag:int) : void
      {
         var partner:Player = null;
         var goRet:Boolean = false;
         if(flag == 2)
         {
            partner = GameUnitManager.findUnit(Model_KuaFuPaiDui.lastPartner[0],UnitType.PLAYER) as Player;
            if(!partner)
            {
               return;
            }
            goRet = GameUnitManager.hero.go(partner.global_x,partner.global_y);
            if(goRet)
            {
               GameUnitManager.hero.lockTarget = null;
               GameUnitManager.hero.autoMoveID = -1;
               GameUnitManager.hero.autoMoveType = -1;
               GameUnitManager.hero.lastPath = [];
               GameUnitManager.hero.isAutoMove = false;
            }
         }
      }
      
      private function onEnterFrame() : void
      {
         if(GameUnitManager.hero.action == Action.RUN)
         {
            this.lightCircleSprite.x = GameUnitManager.hero.global_x;
            this.lightCircleSprite.y = GameUnitManager.hero.global_y;
         }
      }
   }
}

class A
{
   
   public function A()
   {
      super();
   }
}
