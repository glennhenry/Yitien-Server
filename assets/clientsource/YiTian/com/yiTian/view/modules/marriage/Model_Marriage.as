package com.yiTian.view.modules.marriage
{
   import com.utils.ColorConstant;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.gameUnit.role.Hero;
   import com.yiTian.gameUnit.role.HunLi;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.*;
   import com.yiTian.net.handler.MarriageHandler;
   import com.yiTian.net.message.cg.MarriageCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.TimeLineLL;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.guaji.BitmapBtn;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class Model_Marriage
   {
      
      public static var hlTipBtnInstance:BitmapBtn;
      
      public static var hlTipBtnEff:Effect;
      
      public static var firstBtn:BitmapBtn;
      
      public static var curMarriageInfo:Object;
      
      private static var _effType:int;
      
      private static var _id1:Number;
      
      private static var _id2:Number;
      
      public static var male:HunLi;
      
      public static var female:HunLi;
      
      public static const hlTipBMUrl:String = "resource/image/marriage/HLZF_Icon01.png";
      
      private static var tmpArr:Array = ["35096","35097","35094","35095"];
      
      private static var effectCreateTimer:Timer = new Timer(1);
      
      public function Model_Marriage()
      {
         super();
      }
      
      public static function updateViewer() : void
      {
         var id1:int = 0;
         var id2:int = 0;
         var myId:int = 0;
         var myPnl:View_CoupleSendFlower = null;
         var pnl:View_SendMarriageBless2 = null;
         if(Boolean(Model_Marriage.curMarriageInfo))
         {
            id1 = int(Model_Marriage.curMarriageInfo.maleID);
            id2 = int(Model_Marriage.curMarriageInfo.femaleID);
            myId = GameUnitManager.hero.id;
            if(id1 == myId || id2 == myId)
            {
               myPnl = Singleton.getInstance(View_CoupleSendFlower) as View_CoupleSendFlower;
               myPnl.update();
            }
            else
            {
               pnl = Singleton.getInstance(View_SendMarriageBless2) as View_SendMarriageBless2;
               pnl.update();
            }
         }
      }
      
      public static function GC_GETLITANGREWARD(result:int) : void
      {
         var vo:Vo_item = null;
         var eff:Effect = null;
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29292",2));
            vo = new Vo_item();
            vo.id = 46439;
            vo.Init_lib();
            ComboTweenStep.toBag(vo,Global.stage.stageWidth / 2,Global.stage.stageHeight / 2 - 50);
         }
         if(Boolean(firstBtn) && firstBtn.extraObject.state == 2)
         {
            eff = firstBtn.extraObject.eff;
            EffectManager.removeEffect(eff);
            UIManager.mainUiBtnContainer.removeBTN(firstBtn);
            firstBtn.buttonMode = false;
            firstBtn.dispose();
            firstBtn = null;
         }
      }
      
      public static function updateViewer2() : void
      {
         var dpnl:View_SendMarriageBless2 = null;
         var dpnl2:View_CoupleSendFlower = null;
         if(Singleton.hasInstance(View_SendMarriageBless2))
         {
            dpnl = Singleton.getInstance(View_SendMarriageBless2) as View_SendMarriageBless2;
            dpnl.visible = false;
         }
         if(Singleton.hasInstance(View_CoupleSendFlower))
         {
            dpnl2 = Singleton.getInstance(View_CoupleSendFlower) as View_CoupleSendFlower;
            dpnl2.visible = false;
         }
      }
      
      public static function showAlert(type:int, otherMessage:String = "") : void
      {
         var f:Function = null;
         var obj:Object = null;
         var message:String = "";
         switch(type)
         {
            case 2:
               message = LangConfig.getWord("1011",0);
               break;
            case 3:
               message = LangConfig.getWord("1012",0);
               break;
            case 4:
               message = LangConfig.getWord("1013",0);
               break;
            case 5:
               message = LangConfig.getWord("1014",0);
               break;
            case 6:
               message = LangConfig.getWord("1015",0);
               break;
            case 7:
               message = LangConfig.getWord("1016",0);
               break;
            case 8:
               message = LangConfig.getWord("1017",0);
               break;
            case 9:
               message = LangConfig.getWord("1018",0);
               break;
            case 10:
               message = LangConfig.getWord("1019",0);
               break;
            case 11:
               message = LangConfig.getWord("1020",0);
               break;
            case 12:
               message = LangConfig.getWord("1021",0);
               break;
            case 13:
               message = LangConfig.getWord("1022",0);
               break;
            case 14:
               message = LangConfig.getWord("1023",0);
               break;
            case 15:
               message = LangConfig.getWord("1024",0);
               break;
            case 16:
               message = LangConfig.getWord("1048",0);
               break;
            case 17:
               message = LangConfig.getWord("1049",0);
               break;
            case 18:
               message = LangConfig.getWord("1050",0);
               break;
            case 19:
               Model_Marriage.showEffects(1,0);
               break;
            case 20:
               Model_Marriage.showEffects(2,0);
               break;
            case 21:
               Model_Marriage.showEffects(3,0);
               break;
            case 22:
               curMarriageInfo = null;
               stopEffects();
               if(Boolean(hlTipBtnInstance))
               {
                  UIManager.mainUiBtnContainer.removeBTN(hlTipBtnInstance);
                  hlTipBtnInstance.buttonMode = false;
                  hlTipBtnInstance.dispose();
                  hlTipBtnInstance = null;
                  if(Boolean(hlTipBtnEff))
                  {
                     EffectManager.removeEffect(hlTipBtnEff);
                  }
               }
               Model_Marriage.curMarriageInfo = null;
               updateViewer2();
               break;
            case 25:
               showCharactor();
               (Singleton.getInstance(TimeLineLL) as TimeLineLL).clearInfo();
               break;
            case 26:
               message = LangConfig.getWord("1051",0);
               break;
            case 27:
               if(!UIManager.tipBtnContainer.hasItem(View_MarriageBlessTip.instance))
               {
                  UIManager.mainUiBtnContainer.addBTN(View_MarriageBlessTip.instance);
               }
               if(UIManager.getMarriageBlessPlane.visible)
               {
                  MarriageCGMessage.CG_MARRIAGE_BLESS_OPEN();
               }
               break;
            case 28:
               message = LangConfig.getWord("1052",0);
               break;
            case 29:
               message = LangConfig.getWord("1053",0);
               break;
            case 30:
               message = LangConfig.getWord("1054",0);
               break;
            case 31:
               message = LangConfig.getWord("1055",0);
               break;
            case 32:
               message = LangConfig.getWord("1056",0);
               break;
            case 33:
               message = LangConfig.getWord("1057",0);
               break;
            case 34:
               message = LangConfig.getWord("1078",0);
               if(UIManager.getMarriagePlane.visible)
               {
                  UIManager.getMarriagePlane.visible = false;
               }
               break;
            case 35:
               message = LangConfig.getWord("29284",2);
               break;
            case 36:
               if(!firstBtn)
               {
                  firstBtn = new BitmapBtn();
                  firstBtn.useHandCursor = true;
                  firstBtn.buttonMode = true;
                  firstBtn.init(4,4,46,46);
                  firstBtn.setBgDir("resource/image/marriage/yindao.png");
                  firstBtn.buttonMode = true;
                  obj = {};
                  obj.state = 1;
                  firstBtn.extraObject = obj;
                  firstBtn.clickCallBack = tipBtnClick;
                  UIManager.mainUiBtnContainer.addBTN(firstBtn);
               }
               f = function onAskNpc(npc:Npc):void
               {
                  if(npc.sysId == 51093)
                  {
                     firstBtn.extraObject.eff = EffectManager.addEffect("35343",firstBtn,1000,32,29,true);
                     firstBtn.extraObject.state = 2;
                     Global.control.removeCallBack(Enum_MsgType.NPC_INTERACTION,f);
                  }
               };
               Global.control.registerCallBack(Enum_MsgType.NPC_INTERACTION,f);
               break;
            case 37:
               message = LangConfig.getWord("29320",2);
               break;
            case 9999:
               Model_Marriage.showEffects(1,0);
               break;
            case 8888:
               Model_Marriage.showEffects(2,0);
               break;
            case 7777:
               Model_Marriage.showEffects(3,0);
               break;
            case 99:
               message = LangConfig.getWord("1025",0);
               break;
            case 101:
               message = LangConfig.getWord("1058",0);
               break;
            case 102:
               message = LangConfig.getWord("960",0);
               break;
            case 103:
               message = LangConfig.getWord("1059",0);
               break;
            case 104:
               message = LangConfig.getWord("1060",0);
               break;
            case 105:
               message = LangConfig.getWord("1061",0);
               break;
            case 106:
               message = LangConfig.getWord("29",0);
               break;
            case 99999:
               message = otherMessage;
         }
         if(message != "")
         {
            UIManager.centerBroadcast.addMsg(message);
         }
      }
      
      private static function tipBtnClick(e:MouseEvent) : void
      {
         if(firstBtn.extraObject.state == 1)
         {
            View_Alert.show(LangConfig.getWord("29289",2),View_Alert.OK_CANCAL,function():void
            {
               GameUnitManager.hero.autoMove(51093);
            },null,null,null,310,LangConfig.getWord("29291",2));
         }
         else if(firstBtn.extraObject.state == 2)
         {
            if(!firstBtn)
            {
               return;
            }
            View_Alert.show(LangConfig.getWord("29290",2),View_Alert.OK,function():void
            {
               MarriageCGMessage.CG_GETLITANGREWARD();
            },null,null,null,310,LangConfig.getWord("29073",2));
         }
      }
      
      public static function breakMarriage() : void
      {
         if(Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
         {
            UIManager.bagPwdPutIn.visible = true;
            return;
         }
         var message:String = LangConfig.getWord("1062",0,MarriageConfig.BREAK_COST);
         View_Alert.show(message,View_Alert.OK_CANCAL,onOK);
      }
      
      public static function onOK() : void
      {
         if(GameUnitManager.hero.silver < MarriageConfig.BREAK_COST)
         {
            showAlert(102);
         }
         else
         {
            MarriageHandler.CG_MARRIAGE_BREAK();
         }
      }
      
      public static function getMarriageInfo(ringID:int, id:Number, name:String) : void
      {
         var obj:Object = null;
         if(ringID == 0)
         {
            MarriageEffect.runEffect();
            if(GameUnitManager.hero.sex == 1)
            {
               showAlert(103);
            }
            else
            {
               showAlert(104);
            }
            return;
         }
         if(ringID > 0 && GameUnitManager.hero.sex == 1)
         {
            showAlert(99);
         }
         else if(ringID > 0 && GameUnitManager.hero.sex == 2)
         {
            obj = new Object();
            obj["ringID"] = ringID;
            obj["id"] = id;
            obj["name"] = name;
            UIManager.getMarriagePlane.data = obj;
            UIManager.getMarriagePlane.visible = true;
         }
         if(ringID < 0 && GameUnitManager.hero.sex == 1)
         {
            showAlert(14);
         }
      }
      
      public static function showEffects(type:int, countTime:int) : void
      {
         _effType = type;
         effectCreateTimer.delay = 1000;
         if(countTime > 0)
         {
            effectCreateTimer.repeatCount = countTime / effectCreateTimer.delay;
         }
         else
         {
            effectCreateTimer.repeatCount = 0;
         }
         effectCreateTimer.reset();
         effectCreateTimer.start();
         effectCreateTimer.addEventListener(TimerEvent.TIMER,effectTimerTickHd);
         effectCreateTimer.addEventListener(TimerEvent.TIMER_COMPLETE,effectTimerCompleteHd);
         Global.control.registerCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,leaveMarrigeScene);
      }
      
      private static function effectTimerCompleteHd(evt:TimerEvent) : void
      {
         effectCreateTimer.stop();
      }
      
      private static function effectTimerTickHd(evt:TimerEvent) : void
      {
         var e:Effect = null;
         var w:Number = Utils.rnd(Global.stage.stageWidth - 100,Global.stage.stageWidth + 60);
         var h:Number = Global.stage.stageHeight * 0.95;
         var sx:Number = Math.random() * w;
         var effId:String = tmpArr[Utils.rnd(0,_effType)];
         var time:int = Utils.rnd(h / 2,h) * 13;
         e = EffectManager.addEffect(effId,GameScene.upUILayer,2000,sx,0,true);
         Tween.to(e,time,{
            "px":[sx - 40,sx - 10],
            "py":[0,h]
         },function():void
         {
            GameScene.upUILayer.removeChild(e);
            EffectManager.removeEffect(e);
         });
      }
      
      public static function stopEffects() : void
      {
         effectCreateTimer.stop();
      }
      
      public static function beginCollect(npc:Npc) : void
      {
         if(CollectManager.isCollecting == false)
         {
            CollectManager.begin(npc);
            MarriageHandler.CG_MARRIAGE_COLLECT_BEGIN(1,npc.sysId);
         }
      }
      
      public static function endCollect(npc:Npc) : void
      {
         MarriageHandler.CG_MARRIAGE_COLLECT_BEGIN(2,npc.sysId);
      }
      
      public static function colseAllWin() : void
      {
         UIManager.marriagePlane.visible = false;
         UIManager.getMarriagePlane.visible = false;
         UIManager.getMarriageBlessPlane.visible = false;
         UIManager.hongbao.visible = false;
         Model_SendMarriageBless.disposeAll();
      }
      
      public static function getColorStrByVoColor(voColorType:int) : String
      {
         var color:String = null;
         switch(voColorType)
         {
            case 2:
               color = ColorConstant.getColorStr(ColorConstant.GREEN);
               break;
            case 3:
               color = ColorConstant.getColorStr(ColorConstant.BLUE);
               break;
            case 4:
               color = ColorConstant.getColorStr(ColorConstant.PURPLE);
         }
         return color;
      }
      
      public static function lockCamera() : void
      {
         if(Global.sceneID != 12304)
         {
            return;
         }
         GameUnitManager.hero.stopGo();
         UIManager.smallMap.clearPath();
         UIManager.mappanel.clearPath();
         GameUnitManager.hero.visible = false;
         if(Boolean(GameUnitManager.pet))
         {
            GameUnitManager.pet.visible = false;
         }
         Global.isPlayingMarriageEffect = true;
         if(GameUnitManager.hero.sex == 1)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,sceneOkHd);
         }
         else
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,sceneOkHd);
         }
      }
      
      private static function sceneOkHd() : void
      {
         showCharactor();
         unlockCamera();
         freeNpc();
         Global.control.removeCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,sceneOkHd);
      }
      
      public static function unlockCamera() : void
      {
         if(Global.sceneID != 12304)
         {
            return;
         }
         Global.isPlayingMarriageEffect = false;
         GameUnitManager.hero.visible = true;
         if(Boolean(GameUnitManager.pet))
         {
            GameUnitManager.pet.visible = true;
         }
         CameraManager.resize();
         CameraManager.wacth(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y);
      }
      
      public static function hideCharactor(id1:Number, id2:Number) : void
      {
         _id1 = id1;
         _id2 = id2;
         hideC();
         Global.control.registerCallBack(Enum_MsgType.MSG_ADD_PLAYER,hideC);
      }
      
      private static function hideC() : void
      {
         if(Boolean(GameUnitManager.findUnit(_id1,UnitType.PLAYER)))
         {
            GameUnitManager.findUnit(_id1,UnitType.PLAYER).visible = false;
         }
         if(Boolean(GameUnitManager.findUnit(_id2,UnitType.PLAYER)))
         {
            GameUnitManager.findUnit(_id2,UnitType.PLAYER).visible = false;
         }
      }
      
      public static function showCharactor() : void
      {
         if(Boolean(GameUnitManager.findUnit(_id1,UnitType.PLAYER)))
         {
            GameUnitManager.findUnit(_id1,UnitType.PLAYER).visible = true;
         }
         if(Boolean(GameUnitManager.findUnit(_id2,UnitType.PLAYER)))
         {
            GameUnitManager.findUnit(_id2,UnitType.PLAYER).visible = true;
         }
         Global.control.removeCallBack(Enum_MsgType.MSG_ADD_PLAYER,hideC);
         Global.isPlayingMarriageEffect = false;
      }
      
      public static function showNpc(marryType:int, id1:int, name1:String, id2:int, name2:String) : void
      {
         if(Global.sceneID != 12304)
         {
            return;
         }
         var hero:Hero = GameUnitManager.hero;
         if(!male)
         {
            male = HunLi.pool.length > 0 ? HunLi.pool.pop() : new HunLi();
         }
         male.init(-123041,51094,MarriageConfig.CAMERA_X_MALE,MarriageConfig.CAMERA_Y_MALE,3,0,new Array(),new Array());
         male.name = name1;
         male.roleId = id1;
         GameUnitManager.addUnit(male);
         if(!female)
         {
            female = HunLi.pool.length > 0 ? HunLi.pool.pop() : new HunLi();
         }
         female.init(-123042,51095,MarriageConfig.CAMERA_X_FEMALE,MarriageConfig.CAMERA_Y_FEMALE,3,0,new Array(),new Array());
         female.name = name2;
         female.roleId = id2;
         GameUnitManager.addUnit(female);
         Global.control.registerCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,leaveMarrigeScene);
      }
      
      private static function leaveMarrigeScene(sId:int) : void
      {
         if(sId == 12304)
         {
            return;
         }
         freeNpc();
         stopEffects();
         unlockCamera();
         Global.control.removeCallBack(Enum_MsgType.MSG_ADD_PLAYER,hideC);
         Global.control.removeCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,leaveMarrigeScene);
      }
      
      public static function freeNpc() : void
      {
         if(Boolean(male))
         {
            GameUnitManager.removeUnit(male);
            male = null;
         }
         if(Boolean(female))
         {
            GameUnitManager.removeUnit(female);
            female = null;
         }
      }
   }
}

