package com.yiTian.manager
{
   import com.utils.ComponentUtil;
   import com.utils.FontUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_Direct;
   import com.yiTian.data.config.Enum_battle_status;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_map_lib;
   import com.yiTian.data.config.Enum_pata_map;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.config.Enum_server_battleStep;
   import com.yiTian.data.config.Enum_server_battleunit;
   import com.yiTian.data.config.Enum_sever_battleTarget;
   import com.yiTian.data.config.Enum_skill_range;
   import com.yiTian.data.config.Enum_skill_tarType;
   import com.yiTian.data.config.guide.Enum_guide_tonggun;
   import com.yiTian.data.model.Model_Battle;
   import com.yiTian.data.vo.Vo_Buffer;
   import com.yiTian.data.vo.Vo_Skill;
   import com.yiTian.data.vo.Vo_Step;
   import com.yiTian.data.vo.Vo_battle_lib_data;
   import com.yiTian.gameUnit.IBattleUnit;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.config.State;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.magic.BattleMagic;
   import com.yiTian.gameUnit.role.BattleUnit;
   import com.yiTian.gameUnit.role.FlyWord;
   import com.yiTian.net.message.cg.BattleCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.guangMingDing.Enum_guangMingDing;
   import com.yiTian.view.modules.huaShanLunJian.util.HuaShanUtil;
   import com.yiTian.view.modules.loading.View_loading;
   import com.yiTian.view.modules.shenBing.Enum_ShenBing;
   import com.yiTian.view.modules.wanansi.WanAnSiVO;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class BattleManager
   {
      
      private static var battleId:int;
      
      private static var type:int;
      
      private static var isWin:int;
      
      private static var steps:Array;
      
      private static var isReplay:Boolean;
      
      private static var roundStartMap:Object;
      
      private static var petArr:Array;
      
      private static var hostBattleUnit:BattleUnit;
      
      private static var _dObj:Object;
      
      private static var baiFaBaiZhongObjArr:Array;
      
      private static var _beginTime:int;
      
      private static var _totalTime:int;
      
      private static var _curStyle:String;
      
      private static var _curStep:Vo_Step;
      
      private static var _curSkill:Array;
      
      private static var _delay:int;
      
      private static var lastTime:int;
      
      private static const FRAMETIME:int = 40;
      
      public static var isPlaying:Boolean = false;
      
      private static var timePool:Array = [];
      
      private static var isFirstLoad:Boolean = true;
      
      public static var _round:int = -1;
      
      private static var allUnits:Array = [];
      
      private static var nowTemBBUnit:Array = [];
      
      private static var babyUnitArr:Array = [];
      
      private static var bmArr:Array = [];
      
      private static const PU_GONG:String = "PU_GONG";
      
      private static const JING_CHENG:String = "JING_CHENG";
      
      private static const YUAN_CHENG:String = "YUAN_CHENG";
      
      private static const ROW_ATTACK:String = "ROW_ATTACK";
      
      private static const COL_ATTACK:String = "COL_ATTACK";
      
      private static const DOUBLE_ATTACK:String = "DOUBLE_ATTACK";
      
      private static const THREE_ATTACK:String = "THREE_ATTACK";
      
      private static const MULTI_ATTACK:String = "MULTI_ATTACK";
      
      private static const JIAN_YU:String = "JIAN_YU";
      
      private static const TWO_ACTION:String = "TWO_ACTION";
      
      private static const KUANG_DAO:String = "KUANG_DAO";
      
      private static const PO_FU:String = "PO_FU";
      
      private static const LUN_HUI:String = "LUN_HUI";
      
      private static const JIAN_SHAN:String = "JIAN_SHAN";
      
      private static const JING_CHAO:String = "JING_CHAO";
      
      private static const QIN_LONG:String = "QIN_LONG";
      
      private static const PET_DOUBLE_ATTACK:String = "PET_DOUBLE_ATTACK";
      
      private static const JING_MO:String = "JING_MO";
      
      private static const NU_YI:String = "NU_YI";
      
      private static const PO_TIAN:String = "PO_TIAN";
      
      private static const SHIMEN_CIKE:String = "SHIMEN_CIKE";
      
      private static const SHIMEN_JIANKE_SG:String = "SHIMEN_JIANKE_SG";
      
      private static const SHIMEN_YIXIAN_SG:String = "SHIMEN_YIXIAN_SG";
      
      private static const SHIMEN_YIXIAN:String = "SHIMEN_YIXIAN";
      
      private static const SHIMEN_TIANDAO:String = "SHIMEN_TIANDAO";
      
      private static const SHIMEN_CK_SG:String = "SHIMEN_CK_SG";
      
      private static const SHIMEN_TD_SG:String = "SHIMEN_TD_SG";
      
      private static var playStyle:Dictionary = (function():Dictionary
      {
         var style:* = new Dictionary();
         style["PU_GONG"] = ["runTo","pugongAttack","attdelay","runBack","delay"];
         style["JING_CHENG"] = ["runTo",["playMusic","pattack","releaseSwfFly","yanSwfFly","skillNameFly","effSwfsFly"],"attdelay","runBack","delay"];
         style["SHIMEN_CK_SG"] = ["runTo",["playMusic","pattack_CKSG","releaseSwfFly","yanSwfFly","skillNameFly","effSwfsFly"],"attdelay","runBack","delay"];
         style["SHIMEN_TIANDAO"] = ["runTo",["playMusic","pattack_TD","yanSwfFly","skillNameFly"],"attdelay","runBack","delay"];
         style["YUAN_CHENG"] = [["playMusic","pattack","releaseSwfFly","yanSwfFly","skillNameFly","effSwfsFly"],["returnStand","delay"]];
         style["SHIMEN_TD_SG"] = [["playMusic","pattack_tdsg","releaseSwfFly","yanSwfFly","skillNameFly"],"returnStand","delay","runTo_sg","pugongAttack_tdsg","runBack","delay"];
         style["SHIMEN_YIXIAN"] = [["playMusic","pattack","releaseSwfFly_YX","yanSwfFly","skillNameFly"],["returnStand","delay"]];
         style["SHIMEN_CIKE"] = [["playMusic","shimen_ck_attact","yanSwfFly","skillNameFly"],["returnStand","delay"]];
         style["PO_TIAN"] = [["playMusic","pattack","releaseSwfFly","yanSwfFly","skillNameFly","effPotianSwfFly"],["returnStand","delay"]];
         style["ROW_ATTACK"] = ["runToRow",["playMusic","rowAttack","releaseSwfFly","yanSwfFly","skillNameFly","effRowSwfsFly"],"attdelay","runBack","delay"];
         style["COL_ATTACK"] = ["runToCol",["playMusic","colAttack","releaseSwfFly","yanSwfFly","skillNameFly","effColSwfsFly"],"attdelay","runBack","delay"];
         style["PET_DOUBLE_ATTACK"] = ["runTo",["playMusic","petDoubleAttack","releaseSwfFly","yanSwfFly","skillNameFly","effDoubleSwfsFly"],"runBack","delay"];
         style["DOUBLE_ATTACK"] = ["runTo",["playMusic","sameTargetsAttack","releaseSwfFly","yanSwfFly","skillNameFly","effDoubleSwfsFly"],"runBack","delay"];
         style["THREE_ATTACK"] = ["runTo",["playMusic","sameTargetsAttack","releaseSwfFly","yanSwfFly","skillNameFly","effDoubleSwfsFly"],"threeAttackBack","delay"];
         style["TWO_ACTION"] = [["playMusic","twoActionAttack","releaseSwfFly","yanSwfFly","skillNameFly","effDoubleSwfsFly"],["returnStand","delay"]];
         style["MULTI_ATTACK"] = [["playMusic","difTargetsAttack","releaseSwfFly","yanSwfFly","skillNameFly","effMultiSwfsFly"],["returnStand","delay"]];
         style["JIAN_YU"] = [["playMusic","difTargetsAttack","releaseSwfFly","yanSwfFly","skillNameFly","effMultiSwfsFly"],["roundEffFly","returnStand","delay"]];
         style["KUANG_DAO"] = [["playMusic","pattack","releaseSwfFly","yanSwfFly","skillNameFly","kuangdaoMove"],"attdelay","runBack","delay"];
         style["PO_FU"] = [["playMusic","pattack","releaseSwfFly","yanSwfFly","skillNameFly","effSwfsFly","pofuMove"],"attdelay","runBack","delay"];
         style["JIAN_SHAN"] = ["runTo",["playMusic","pattack","releaseSwfFly","yanSwfFly","skillNameFly","effSwfsFly","jianshanMove"],"attdelay","runBack","delay"];
         style["SHIMEN_JIANKE_SG"] = ["runTo",["playMusic","pattack","releaseSwfFly","yanSwfFly","skillNameFly","effSwfsFly_jksg","jianshanMove","jksg_effAdd"],"attdelay","runBack","delay"];
         style["SHIMEN_YIXIAN_SG"] = [["playMusic","releaseSwfFly","pattack_YXSG","skillNameFly"],["returnStand","delay"]];
         style["LUN_HUI"] = [["playMusic","lunhuiAttack","skillNameFly"],["lunhuiStand","delay"]];
         style["JING_MO"] = [["playMusic","jingmoAttack","skillNameFly"],["lunhuiStand","delay"]];
         style["JING_CHAO"] = [["playMusic","sameTargetsAttack","relJingchaoSwfFly","yanSwfFly","skillNameFly","effDoubleSwfsFly"],["lunhuiStand","delay"]];
         style["QIN_LONG"] = [["playMusic","pattack","releaseSwfFly","yanSwfFly","skillNameFly","effQinlongFly"],["returnStand","delay"]];
         return style;
      })();
      
      private static var _curFlag:Number = -1;
      
      public function BattleManager()
      {
         super();
      }
      
      public static function get bType() : int
      {
         return type;
      }
      
      public static function get battleID() : Number
      {
         return battleId;
      }
      
      public static function init(battleVo:Vo_battle_lib_data) : void
      {
         var arr:Array;
         battleVo.roundStartMap = battleVo.roundStartMap || {};
         isReplay = battleVo.isReplay;
         Model_Battle.last_battle_vo = battleVo.clone();
         Global.control.sendNotification(Enum_MsgType.BATTLE_PLAY_PRE_START,battleVo.battleId);
         if(Global.isInBattle)
         {
            end();
         }
         if(GuideManager.isPlaying)
         {
            GuideManager.jumpFlash();
         }
         Global.isInBattle = true;
         GameUnitManager.hero.stopGo();
         battleId = battleVo.battleId;
         arr = [];
         if(!Global.battleDm)
         {
            arr.push(["lang/ch/battle.swf",function(info:Object):void
            {
               if(!Global.battleDm)
               {
                  Global.battleDm = info.applicationDomain;
               }
            },LangConfig.getWord("10545",1),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         }
         if(isFirstLoad)
         {
            arr.push(["lang/" + Global.config.lang + "/Font.swf",function(info:Object):void
            {
               FontUtil.registerFont("hy",info.applicationDomain);
               isFirstLoad = false;
            },LangConfig.getWord("10546",1),Enum_resType.RES_URL]);
         }
         if(Boolean(arr.length))
         {
            View_loading.instance.load(arr,initComp,battleVo);
         }
         else
         {
            initComp(battleVo);
         }
         if(UIManager.smallMap.hasPath)
         {
            UIManager.smallMap.clearPath();
            UIManager.mappanel.clearPath();
         }
         CursorManager.hide();
      }
      
      private static function initComp(battleData:Vo_battle_lib_data) : void
      {
         if(battleId != battleData.battleId)
         {
            return;
         }
         if(View_loading.instance.visible)
         {
            View_loading.instance.visible = false;
         }
         MusicManager.getInstance().stopMusic();
         MusicManager.getInstance().playMusic("mapRes/mp3/battle.mp3");
         GameScene.battleLayer.init();
         GameScene.battleLayer.setJumpBattleBtn(battleData.type,battleData.isReplay);
         GameScene.battleLayer.initSkill();
         GameScene.downUILayer.visible = false;
         GameScene.uiLayer.visible = false;
         GameScene.popupLayer.visible = false;
         GameScene.modalLayer.visible = false;
         GameScene.mainLayer.visible = false;
         GameScene.battleLayer.visible = true;
         TipManager.hide();
         BattleManager.type = battleData.type;
         BattleManager.isWin = battleData.isWin;
         GameScene.battleLayer.setZF(battleData.selfZF,battleData.targetZF);
         initUnit(battleData.units);
         initSteps(battleData.steps);
         roundStartMap = battleData.roundStartMap;
         allUnits = battleData.units;
         babyUnitArr = [];
         handleOfBabySkill(battleData);
         begin();
      }
      
      private static function initUnit(units:Array) : void
      {
         var battleUnit:BattleUnit = null;
         var unitArr:Array = null;
         petArr = [];
         var len:int = int(units.length);
         var i:int = 0;
         while(i < len)
         {
            battleUnit = BattleUnitManager.getUnit();
            unitArr = units[i];
            battleUnit.init(unitArr[Enum_server_battleunit.ID],unitArr[Enum_server_battleunit.TYPE],unitArr[Enum_server_battleunit.SYSID],Status.NOMAL,unitArr[Enum_server_battleunit.DIRECTION],unitArr[Enum_server_battleunit.POSITION],unitArr[Enum_server_battleunit.NAME],unitArr[Enum_server_battleunit.HP],unitArr[Enum_server_battleunit.MAXHP],unitArr[Enum_server_battleunit.MP],unitArr[Enum_server_battleunit.MAXMP],GameScene.battleLayer.getBattleGrid(unitArr[Enum_server_battleunit.POSITION],unitArr[Enum_server_battleunit.DIRECTION]),unitArr[Enum_server_battleunit.BODY1],unitArr[Enum_server_battleunit.BODY2],unitArr[Enum_server_battleunit.WEAPON],null,unitArr[Enum_server_battleunit.SEX],Enum_job.getBaseJob(unitArr[Enum_server_battleunit.JOB]),unitArr[Enum_server_battleunit.ANGRY],unitArr[Enum_server_battleunit.LEVEL],unitArr[Enum_server_battleunit.HUIYUAN],unitArr[Enum_server_battleunit.PET_TYPE]);
            if(battleUnit.type == UnitType.PET)
            {
               petArr.push([battleUnit,battleUnit.parts]);
            }
            BattleUnitManager.addUnit(battleUnit);
            i++;
         }
      }
      
      private static function initSteps(steps:Array) : void
      {
         var step:Vo_Step = null;
         var stepData:Array = null;
         BattleManager.steps = [];
         var len:int = int(steps.length);
         var i:int = 0;
         while(i < len)
         {
            stepData = steps[i];
            step = new Vo_Step(stepData[Enum_server_battleStep.STEPID],stepData[Enum_server_battleStep.ROLEID],stepData[Enum_server_battleStep.HP],stepData[Enum_server_battleStep.MAXHP],stepData[Enum_server_battleStep.MP],stepData[Enum_server_battleStep.MAXMP],stepData[Enum_server_battleStep.SKILLID],stepData[Enum_server_battleStep.BUFFERIDS],stepData[Enum_server_battleStep.TARGETS],stepData[Enum_server_battleStep.ANGRY]);
            BattleManager.steps.push(step);
            i++;
         }
      }
      
      private static function begin() : void
      {
         timePool.push(setTimeout(beginPlay,1200));
         GameScene.battleLayer.playBeginEff();
      }
      
      private static function beginPlay() : void
      {
         Global.control.sendNotification(Enum_MsgType.BATTLE_PLAY_START,battleId);
         play();
      }
      
      public static function end() : void
      {
         var guiData:Array = null;
         var bId:int = battleId;
         HuaShanUtil.isReadBattleDataOfBabySkill = true;
         Global.control.sendNotification(Enum_MsgType.BATTLE_PLAY_PRE_END,bId);
         clearTimer();
         isPlaying = false;
         Global.isInBattle = false;
         MusicManager.getInstance().stopMusic();
         if(Global.isPata)
         {
            MusicManager.getInstance().playMusic("mapRes/mp3/" + Data_lib.sceneData[Global.sceneID][Enum_pata_map.MUSIC] + ".mp3");
         }
         else if(SceneConfig.getSceneType() == SceneConfig.GMD)
         {
            MusicManager.getInstance().playMusic("mapRes/mp3/" + Data_lib.ycgmd[Global.sceneID][Enum_guangMingDing.LIB_MAP_MUSIC] + ".mp3");
         }
         else
         {
            MusicManager.getInstance().playMusic("mapRes/mp3/" + Data_lib.map[Global.sceneMap][Enum_map_lib.MUSIC] + ".mp3");
         }
         TipManager.hide();
         GameScene.downUILayer.visible = true;
         GameScene.uiLayer.visible = true;
         GameScene.popupLayer.visible = true;
         GameScene.modalLayer.visible = true;
         GameScene.mainLayer.visible = true;
         GameScene.battleLayer.visible = false;
         GameScene.battleLayer.clear();
         BattleUnitManager.dispose();
         GameScene.isBattleEnd = true;
         GameScene.instance.resize();
         if(GameUnitManager.hero.status != Status.SIT)
         {
            CountStandTimeManager.reset();
         }
         if(!isReplay)
         {
            BattleCGMessage.CG_BATTLE_FINISH();
         }
         if(GameUnitManager.hero.status == Status.WU_LING)
         {
            UIManager.countDown_tip.visible = true;
         }
         BattleResultManager.dealResult(battleId,type,isWin);
         battleId = 0;
         _round = 0;
         if(MapManager.isFubenFinish)
         {
            if(GuideManager.checkTongGun(Global.sceneID))
            {
               guiData = Data_lib.guideTongGuan[Global.sceneID];
               GuideManager.showGuide(guiData[Enum_guide_tonggun.INFO],guiData[Enum_guide_tonggun.REWARD],guiData[Enum_guide_tonggun.BEIZHU]);
            }
         }
         if(WanAnSiVO.isPlay)
         {
            Global.control.registerCallBack(Enum_MsgType.MOVIE_END,wananMovieEnd);
            GuideManager.showGuide(Data_lib.guidewansansi[19074][0],"");
            WanAnSiVO.isPlay = false;
         }
         if(WanAnSiVO.isHellPlay)
         {
            GuideManager.showGuide(Data_lib.guidewansansi[10413][0],"");
            WanAnSiVO.isHellPlay = false;
         }
         Global.control.sendNotification(Enum_MsgType.BATTLE_PLAY_END,bId);
      }
      
      private static function wananMovieEnd() : void
      {
         Global.control.removeCallBack(Enum_MsgType.MOVIE_END,wananMovieEnd);
         NewPushManager.showNew(200);
      }
      
      private static function clearTimer() : void
      {
         var timer:uint = 0;
         var i:int = timePool.length - 1;
         while(i >= 0)
         {
            timer = uint(timePool[i]);
            clearTimeout(timer);
            timePool.splice(i,1);
            i--;
         }
      }
      
      public static function jumpBattle() : void
      {
         steps = [];
         _curStep = null;
         end();
      }
      
      private static function play() : void
      {
         if(steps.length > 0)
         {
            doStep(steps.shift());
         }
         else
         {
            trace("play End");
            end();
         }
      }
      
      private static function dealRoundStart(infos:Array) : Object
      {
         var info:Array = null;
         var type:int = 0;
         var roleId:Number = NaN;
         var sbId:int = 0;
         var curHp:int = 0;
         var maxHp:int = 0;
         var launcherId:Number = NaN;
         var unit:BattleUnit = null;
         var launcher:BattleUnit = null;
         var hpAdd:int = 0;
         var sbType:int = 0;
         var teamEff:int = 0;
         var personEffId:int = 0;
         var personEffId1:int = 0;
         trace("<font color=\'#ffff33\'>------------准备阶段-round=[ " + _curStep.stepId + " ]</font>");
         var _tempObj:Object = new Object();
         for each(info in infos)
         {
            type = int(info[0]);
            roleId = Number(info[1]);
            sbId = int(info[2]);
            curHp = int(info[3]);
            maxHp = int(info[4]);
            launcherId = Boolean(info[5]) ? Number(info[5]) : 0;
            unit = BattleUnitManager.findUnit(roleId);
            launcher = BattleUnitManager.findUnit(launcherId);
            _tempObj.type = type;
            _tempObj.curHp = curHp;
            _tempObj.launcher = launcher;
            if(launcherId != 0)
            {
               if(Boolean(unit))
               {
                  if(type == 1)
                  {
                     hpAdd = maxHp - unit.hpMax;
                     sbType = int(Data_lib.sbSkill[sbId][Enum_ShenBing.SKILL_SKILLTYPE]);
                     teamEff = int(Data_lib.sbSkill[sbId][Enum_ShenBing.SKILL_TEAM_EFF]);
                     personEffId = int(Data_lib.sbSkill[sbId][Enum_ShenBing.SKILL_PERSON_EFF]);
                     personEffId1 = int(Data_lib.sbSkill[sbId][Enum_ShenBing.SKILL_PERSON_EFF_1]);
                     trace(unit.name + " 添加神兵BUF(发动者=" + launcher.name + ")" + Data_lib.sbSkill[sbId][Enum_ShenBing.SKILL_NAME] + "lv:" + Data_lib.sbSkill[sbId][Enum_ShenBing.SKILL_QUALITY] + "  当前气血:" + unit.hp + "->" + curHp,"最大气血:" + unit.hpMax + "->" + maxHp);
                     if(sbType == 1)
                     {
                        unit.setInfo(curHp,maxHp,unit.mp,unit.mpMax,unit.angry,unit.angryMax);
                        if(hpAdd > 0)
                        {
                           getFlyWord(FlyWord.ADD_HP,uint(hpAdd).toString(),unit);
                        }
                     }
                     unit.addShenBing(sbId);
                     if(teamEff != 0)
                     {
                        GameScene.battleLayer.addTeamEff(unit.direction,teamEff);
                     }
                     if(personEffId != 0)
                     {
                        unit.addEffect(personEffId.toString(),true,0,0,1500,-1,null,0,unit.direction == Enum_Direct.SELF ? 1 : 0);
                     }
                     if(personEffId1 != 0)
                     {
                        unit.addEffect(personEffId1.toString(),false,0,0,1500);
                     }
                     if(launcherId % 1000000 == GameUnitManager.hero.id % 1000000)
                     {
                        GameScene.battleLayer.showShenBingIcon([sbId],1);
                     }
                  }
                  else if(type == 2)
                  {
                     unit.setInfo(curHp,maxHp,unit.mp,unit.mpMax,unit.angry,unit.angryMax);
                     trace(unit.name + " 修正属性:" + "当前气血:" + unit.hp + "->" + curHp,"最大气血:" + unit.hpMax + "->" + maxHp);
                  }
                  else if(type == 3)
                  {
                     trace(unit.name + "移除神兵BUF:" + Data_lib.sbSkill[sbId][Enum_ShenBing.SKILL_NAME] + "lv:" + Data_lib.sbSkill[sbId][Enum_ShenBing.SKILL_QUALITY]);
                     teamEff = int(Data_lib.sbSkill[sbId][Enum_ShenBing.SKILL_TEAM_EFF]);
                     personEffId = int(Data_lib.sbSkill[sbId][Enum_ShenBing.SKILL_PERSON_EFF]);
                     personEffId1 = int(Data_lib.sbSkill[sbId][Enum_ShenBing.SKILL_PERSON_EFF_1]);
                     unit.removeShenBing(sbId);
                     if(teamEff != 0)
                     {
                        GameScene.battleLayer.removeTeamEff(unit.direction,teamEff);
                     }
                     if(personEffId != 0)
                     {
                        unit.removeBuffByID(personEffId);
                     }
                     if(personEffId1 != 0)
                     {
                        unit.removeBuffByID(personEffId1);
                     }
                  }
               }
            }
         }
         return _tempObj;
      }
      
      private static function doStep(stepVO:Vo_Step) : void
      {
         var hhUnit:BattleUnit = null;
         var skillRange:int = 0;
         _curFlag = -1;
         _curStep = stepVO;
         GameScene.battleLayer.setRound(_curStep.stepId);
         var time:int = 0;
         if(_round != _curStep.stepId && Boolean(_curStep.stepId))
         {
            baiFaBaiZhongObjArr = [];
            BabySkillAdd.end();
            if(Boolean(bmArr.length))
            {
               for each(hhUnit in bmArr)
               {
                  hhUnit.turn_to_normal();
               }
               bmArr.splice(0);
            }
            if(_curStep.stepId != 0 && _curStep.stepId % 3 == 0)
            {
               time = dealWidthBabySkill();
            }
            _dObj = new Object();
            if(Boolean(roundStartMap[_curStep.stepId]))
            {
               _dObj = dealRoundStart(roundStartMap[_curStep.stepId]);
            }
         }
         _round = _curStep.stepId;
         if(_round > 5 && bType == 14)
         {
            GameScene.battleLayer.setJumpBattleBtn(bType,false);
         }
         hostBattleUnit = BattleUnitManager.findUnit(stepVO.roleId) as BattleUnit;
         if(!hostBattleUnit)
         {
            play();
            return;
         }
         _curSkill = Data_lib.skill[stepVO.skillId];
         if(stepVO.skillId == 0)
         {
            _curStyle = PU_GONG;
            _delay = 200;
         }
         else
         {
            skillRange = int(_curSkill[Vo_Skill.RANGE]);
            switch(skillRange)
            {
               case Enum_skill_range.PU_GONG:
                  _curStyle = PU_GONG;
                  _delay = 200;
                  break;
               case Enum_skill_range.JING_CHENG:
               case Enum_skill_range.DUAN_JING:
                  _curStyle = JING_CHENG;
                  _delay = 200;
                  break;
               case Enum_skill_range.YUAN_CHENG:
                  _curStyle = YUAN_CHENG;
                  _delay = 250;
                  if(_curSkill[Vo_Skill.SKILL_TYPE] == 3)
                  {
                     _delay = 400;
                  }
                  break;
               case Enum_skill_range.ROW:
                  _curStyle = ROW_ATTACK;
                  _delay = 200;
                  break;
               case Enum_skill_range.COL:
                  _curStyle = COL_ATTACK;
                  _delay = 200;
                  break;
               case Enum_skill_range.DOUBLE_ATTACK:
                  _curStyle = DOUBLE_ATTACK;
                  _delay = 200;
                  break;
               case Enum_skill_range.THREE_ATTACK:
                  _curStyle = THREE_ATTACK;
                  dealHurtValue([0.15,0.15,0.15,0.15,0.4]);
                  _delay = 300;
                  break;
               case Enum_skill_range.MULTI_ATTACK:
                  _curStyle = MULTI_ATTACK;
                  break;
               case Enum_skill_range.JIAN_YU:
                  _curStyle = JIAN_YU;
                  break;
               case Enum_skill_range.TWO_ACTION:
                  _curStyle = TWO_ACTION;
                  _delay = 250;
                  break;
               case Enum_skill_range.KUANG_DAO:
                  _curStyle = KUANG_DAO;
                  _delay = 200;
                  break;
               case Enum_skill_range.PO_FU:
                  _curStyle = PO_FU;
                  _delay = 200;
                  break;
               case Enum_skill_range.LUN_HUI:
               case Enum_skill_range.JING_MO:
                  _curStyle = LUN_HUI;
                  break;
               case Enum_skill_range.JIAN_SHAN:
                  _curStyle = JIAN_SHAN;
                  _delay = 200;
                  break;
               case Enum_skill_range.QIN_LONG:
                  _curStyle = QIN_LONG;
                  _delay = 1400;
                  break;
               case Enum_skill_range.JING_CHAO:
                  _curStyle = JING_CHAO;
                  dealHurtValue([0.2,0.2,0.2,0.4]);
                  _delay = 300;
                  break;
               case Enum_skill_range.PET_DOUBLE_ATTACK:
                  _curStyle = PET_DOUBLE_ATTACK;
                  _delay = 200;
                  break;
               case Enum_skill_range.NU_JI:
                  _curStyle = THREE_ATTACK;
                  dealHurtValue([0.2,0.3,0.5]);
                  _delay = 400;
                  break;
               case Enum_skill_range.PO_TIAN:
                  _curStyle = PO_TIAN;
                  _delay = 1500;
                  break;
               case Enum_skill_range.SHIMEN_CIKE:
                  _curStyle = SHIMEN_CIKE;
                  break;
               case Enum_skill_range.SHIMEN_JIANKE_SG:
                  _curStyle = SHIMEN_JIANKE_SG;
                  _delay = 500;
                  break;
               case Enum_skill_range.SHIMEN_YIXIAN_SG:
                  _curStyle = SHIMEN_YIXIAN_SG;
                  _delay = 1000;
                  break;
               case Enum_skill_range.SHIMEN_YIXIAN:
                  _curStyle = SHIMEN_YIXIAN;
                  _delay = 1000;
                  break;
               case Enum_skill_range.SHIMEN_TIANDAO:
                  _curStyle = SHIMEN_TIANDAO;
                  _delay = 700;
                  break;
               case Enum_skill_range.SHIMEN_CK_SG:
                  _curStyle = SHIMEN_CK_SG;
                  _delay = 700;
                  break;
               case Enum_skill_range.SHIMEN_TD_SG:
                  _curStyle = SHIMEN_TD_SG;
                  _delay = 700;
            }
         }
         setTime(time);
         isPlaying = true;
      }
      
      private static function dealWidthBabySkill() : int
      {
         var objBB:Object = null;
         var i:int = 0;
         var babyId:int = 0;
         var babySkillId:int = 0;
         var bUnit:BattleUnit = null;
         var bObj:Object = null;
         nowTemBBUnit = [];
         var time:int = 0;
         for each(objBB in babyUnitArr)
         {
            babyId = int(objBB.babyId);
            babySkillId = int(objBB.babySkillId);
            bUnit = BattleUnitManager.findUnit(babyId);
            if(!(babySkillId == 0 || !bUnit || bUnit.state == State.DEAD))
            {
               nowTemBBUnit.push({
                  "hUnit":bUnit,
                  "bId":babySkillId
               });
               if(babySkillId == 36023 || babySkillId == 36024)
               {
                  time = 700;
               }
            }
         }
         i = 0;
         while(i < nowTemBBUnit.length)
         {
            bObj = nowTemBBUnit[i];
            if(bObj.bId == 36023 || bObj.bId == 36024 && bObj.hUnit.state != State.DEAD)
            {
               babySkillAtt_PT(bObj.hUnit,bObj.bId);
            }
            if(bObj.bId == 36022 && bObj.hUnit.state != State.DEAD)
            {
               baiFaBaiZhongObjArr.push(bObj);
            }
            i++;
         }
         return time;
      }
      
      private static function handleOfBabySkill(battleVo:Vo_battle_lib_data) : void
      {
         var bs:String = null;
         var _aa:Array = null;
         var bbStr:String = battleVo.babySkill;
         if(bbStr == null)
         {
            return;
         }
         var arr:Array = bbStr.split(",");
         if(!arr)
         {
            return;
         }
         var i:int = 0;
         while(i < arr.length)
         {
            bs = arr[i];
            _aa = bs.split("_");
            if(_aa[0] != "0")
            {
               babyUnitArr.push({
                  "babyId":int(_aa[0]),
                  "babySkillId":int(_aa[1])
               });
            }
            i++;
         }
      }
      
      private static function doStyle() : void
      {
         var actions:Array = null;
         var len:int = 0;
         var i:int = 0;
         var style:Object = playStyle[_curStyle][_curFlag];
         if(style is String)
         {
            BattleManager[style]();
         }
         else
         {
            actions = style as Array;
            len = int(actions.length);
            i = 0;
            while(i < len)
            {
               BattleManager[actions[i]]();
               i++;
            }
         }
      }
      
      private static function babySkillAtt_PT(bUnit:BattleUnit, bbId:int) : void
      {
         BabySkillAdd.skillNameFly(bbId,bUnit);
         BabySkillAdd.patchAtt(bUnit,bbId);
         BabySkillAdd.releaseSwfFly(Data_lib.skill[bbId],bUnit);
      }
      
      private static function babySkillAtt_JC() : void
      {
         BabySkillAdd.skillNameFly(36022,hostBattleUnit);
         bmArr.push(hostBattleUnit);
         hostBattleUnit.addEffBFBZ(function():void
         {
            trace("....");
         });
      }
      
      private static function dealHurtValue(rate:Array) : void
      {
         var tempArr:Array = null;
         var targets:Array = _curStep.targets;
         var _target:BattleUnit = BattleUnitManager.findUnit(targets[0][Enum_sever_battleTarget.ROLEID]) as BattleUnit;
         if(!_target)
         {
            return;
         }
         var i:int = 0;
         var valueSteps:Array = targets[0][Enum_sever_battleTarget.HP];
         var _hurtValue:Number = _target.hp - valueSteps[i][Enum_sever_battleTarget.INHP];
         var minusArr:Array = [];
         var len:int = rate.length - 1;
         i = 0;
         while(i < len)
         {
            minusArr.push(int(_hurtValue * rate[i]));
            i++;
         }
         var tarArr:Array = [];
         var nowHp:Number = _target.hp;
         i = 0;
         while(i < minusArr.length)
         {
            tempArr = cloneArr(targets[0] as Array);
            tempArr[Enum_sever_battleTarget.HP].length = 1;
            tempArr[Enum_sever_battleTarget.HP][0][0] = nowHp - minusArr[i];
            tempArr[Enum_sever_battleTarget.STATUS] &= 6;
            tarArr.push(tempArr);
            nowHp = Number(tempArr[Enum_sever_battleTarget.HP][0][0]);
            i++;
         }
         tempArr = cloneArr(targets[0] as Array);
         tarArr.push(tempArr);
         _curStep.targets = tarArr;
      }
      
      private static function cloneArr(a:Array) : Array
      {
         var t:* = undefined;
         var rest:Array = [];
         for each(t in a)
         {
            if(t is Array)
            {
               rest.push(cloneArr(t as Array));
            }
            else
            {
               rest.push(t);
            }
         }
         return rest;
      }
      
      private static function playMusic() : void
      {
         var musicType:int = int(_curSkill[Vo_Skill.MUSIC]);
         if(Boolean(musicType))
         {
            MusicManager.getInstance().playSound(musicType.toString());
         }
      }
      
      private static function runTo() : void
      {
         var dir:Number = NaN;
         var disX:int = 0;
         var toX:int = 0;
         var toY:int = 0;
         setTime(350);
         var _target:BattleUnit = BattleUnitManager.findUnit(_curStep.targets[0][Enum_sever_battleTarget.ROLEID]) as BattleUnit;
         if(Boolean(_target))
         {
            dir = _target.direction == 1 ? -1 : 1;
            if(Boolean(_curStep.skillId))
            {
               disX = int(Data_lib.skill[_curStep.skillId][Vo_Skill.DISTANCE]);
            }
            else
            {
               disX = 70;
            }
            toX = _target.init_x + disX * dir;
            toY = _target.init_y + disX * 0.375 * dir;
            hostBattleUnit.runTo(toX,toY,moveEndCallBack);
         }
      }
      
      private static function moveEndCallBack() : void
      {
         var hObj:Object = null;
         for each(hObj in baiFaBaiZhongObjArr)
         {
            if(hObj.hUnit == hostBattleUnit)
            {
               setTime(500);
               babySkillAtt_JC();
               return;
            }
         }
      }
      
      private static function runToRow() : void
      {
         var position:String = null;
         var row:String = null;
         var posArr:Array = null;
         var dir:Number = NaN;
         var toX:int = 0;
         var toY:int = 0;
         setTime(300);
         var _target:BattleUnit = BattleUnitManager.findUnit(_curStep.targets[0][Enum_sever_battleTarget.ROLEID]) as BattleUnit;
         if(Boolean(_target))
         {
            position = _target.position;
            row = position.charAt(0);
            posArr = GameScene.battleLayer.getBattleGrid(int(row + "2"),_target.direction);
            dir = _target.direction == 1 ? -1 : 1;
            toX = posArr[0] + 70 * dir;
            toY = posArr[1] + 70 * 0.375 * dir;
            hostBattleUnit.runTo(toX,toY);
         }
      }
      
      private static function runToCol() : void
      {
         var position:String = null;
         var col:String = null;
         var posArr:Array = null;
         var dir:Number = NaN;
         var toX:int = 0;
         var toY:int = 0;
         setTime(300);
         var _target:BattleUnit = BattleUnitManager.findUnit(_curStep.targets[0][Enum_sever_battleTarget.ROLEID]) as BattleUnit;
         if(Boolean(_target))
         {
            position = _target.position;
            col = position.charAt(1);
            posArr = GameScene.battleLayer.getBattleGrid(int("1" + col),_target.direction);
            dir = _target.direction == 1 ? -1 : 1;
            toX = posArr[0] + 80 * dir;
            toY = posArr[1] + 80 * 0.375 * dir;
            hostBattleUnit.runTo(toX,toY);
         }
      }
      
      private static function runBack() : void
      {
         setTime(300);
         hostBattleUnit.runBack();
      }
      
      private static function threeAttackBack() : void
      {
         runBack();
         hostBattleUnit.weaponVisible = true;
      }
      
      private static function pattack_TD() : void
      {
         var actionUrl:int;
         setTime(700);
         actionUrl = int(_curSkill[Vo_Skill.ACTION]);
         hostBattleUnit.attack(actionUrl,700);
         timePool.push(setTimeout(function():void
         {
            effSwfsFly();
            dealResult();
         },380));
      }
      
      private static function pugongAttack() : void
      {
         setTime(700);
         hostBattleUnit.attack(0,700);
         timePool.push(setTimeout(dealResult,300));
      }
      
      private static function pattack_YXSG() : void
      {
         var actionUrl:int;
         var petTarget:Array;
         var dir:Number;
         var disX:int;
         var target:Array = null;
         var _target:BattleUnit = null;
         var _petTarget:BattleUnit = null;
         var _bbUnit:BattleUnit = null;
         var sTime:int = 0;
         var toX:int = 0;
         var toY:int = 0;
         var nn:int = 0;
         var endCall:Function = null;
         endCall = function():void
         {
            var mm:int = 0;
            _bbUnit.attack(0,800);
            mm = int(setTimeout(function():void
            {
               clearTimeout(mm);
               BattleUnitManager.removeUnit(_bbUnit);
            },800));
            timePool.push(setTimeout(function():void
            {
               dealSelf();
               dealTarget(_target,target);
               _target.addEffect("35336",false,0,0,800,-1,null,1);
            },_curSkill[Vo_Skill.HIT_DELAY] * FRAMETIME));
         };
         var attackTime:int = _curSkill[Vo_Skill.ACTION_TIME] * FRAMETIME;
         var releaseTime:int = _curSkill[Vo_Skill.RELEASE_TIME] * FRAMETIME;
         setTime(attackTime < releaseTime ? releaseTime : attackTime);
         actionUrl = int(_curSkill[Vo_Skill.ACTION]);
         hostBattleUnit.attack(actionUrl,attackTime);
         target = _curStep.targets[1];
         _target = BattleUnitManager.findUnit(target[Enum_sever_battleTarget.ROLEID]) as BattleUnit;
         petTarget = _curStep.targets[0];
         _petTarget = BattleUnitManager.findUnit(petTarget[Enum_sever_battleTarget.ROLEID]) as BattleUnit;
         timePool.push(setTimeout(function():void
         {
            _petTarget.addEffect("35335",false,0,0,_curSkill[Vo_Skill.EFFECT_TIME] * FRAMETIME,-1,null,0);
         },200));
         _bbUnit = BattleUnitManager.getUnit();
         _bbUnit.setBody(_petTarget.getBody());
         _bbUnit.way = _petTarget.way;
         _bbUnit.direction = _petTarget.direction;
         _bbUnit.nameBar.visible = false;
         _bbUnit.hpBack.visible = false;
         _bbUnit.hpBar.visible = false;
         sTime = int(setTimeout(function():void
         {
            clearTimeout(sTime);
            BattleUnitManager.addUnit(_bbUnit);
            ComponentUtil.setPropertie(_bbUnit,{
               "x":_petTarget.x,
               "y":_petTarget.y
            });
         },300));
         dir = _target.direction == 1 ? -1 : 1;
         disX = 70;
         toX = _target.init_x + disX * dir;
         toY = _target.init_y + disX * 0.375 * dir;
         nn = int(setTimeout(function():void
         {
            clearTimeout(nn);
            _bbUnit.runTo(toX,toY,endCall);
         },500));
      }
      
      private static function pattack_tdsg() : void
      {
         var actionUrl:int;
         var attackTime:int = _curSkill[Vo_Skill.ACTION_TIME] * FRAMETIME;
         var releaseTime:int = _curSkill[Vo_Skill.RELEASE_TIME] * FRAMETIME;
         setTime(attackTime < releaseTime ? releaseTime : attackTime);
         actionUrl = int(_curSkill[Vo_Skill.ACTION]);
         hostBattleUnit.attack(actionUrl,attackTime);
         timePool.push(setTimeout(function():void
         {
            dealSelf();
            var targets:* = _curStep.targets;
            var len:* = targets.length;
            var _target:* = BattleUnitManager.findUnit(targets[0][Enum_sever_battleTarget.ROLEID]) as BattleUnit;
            if(Boolean(_target))
            {
               dealTarget(_target,targets[0]);
            }
         },_curSkill[Vo_Skill.HIT_DELAY] * FRAMETIME));
      }
      
      private static function pugongAttack_tdsg() : void
      {
         var actionUrl:int;
         var __curSkill:Array = Data_lib.skill[1];
         var attackTime:int = __curSkill[Vo_Skill.ACTION_TIME] * FRAMETIME;
         var releaseTime:int = __curSkill[Vo_Skill.RELEASE_TIME] * FRAMETIME;
         setTime(attackTime < releaseTime ? releaseTime : attackTime);
         actionUrl = int(__curSkill[Vo_Skill.ACTION]);
         hostBattleUnit.attack(actionUrl,attackTime);
         timePool.push(setTimeout(function():void
         {
            dealSelf();
            var targets:* = _curStep.targets;
            var len:* = targets.length;
            var _target:* = BattleUnitManager.findUnit(targets[1][Enum_sever_battleTarget.ROLEID]) as BattleUnit;
            if(Boolean(_target))
            {
               dealTarget(_target,targets[1]);
            }
         },__curSkill[Vo_Skill.HIT_DELAY] * FRAMETIME));
      }
      
      private static function runTo_sg() : void
      {
         var dir:Number = NaN;
         var disX:int = 0;
         var toX:int = 0;
         var toY:int = 0;
         setTime(350);
         var _target:BattleUnit = BattleUnitManager.findUnit(_curStep.targets[1][Enum_sever_battleTarget.ROLEID]) as BattleUnit;
         if(Boolean(_target))
         {
            dir = _target.direction == 1 ? -1 : 1;
            disX = 70;
            toX = _target.init_x + disX * dir;
            toY = _target.init_y + disX * 0.375 * dir;
            hostBattleUnit.runTo(toX,toY);
         }
      }
      
      private static function pattack() : void
      {
         var attackTime:int = _curSkill[Vo_Skill.ACTION_TIME] * FRAMETIME;
         var releaseTime:int = _curSkill[Vo_Skill.RELEASE_TIME] * FRAMETIME;
         setTime(attackTime < releaseTime ? releaseTime : attackTime);
         var actionUrl:int = int(_curSkill[Vo_Skill.ACTION]);
         hostBattleUnit.attack(actionUrl,attackTime);
         timePool.push(setTimeout(dealResult,_curSkill[Vo_Skill.HIT_DELAY] * FRAMETIME));
      }
      
      private static function pattack_CKSG() : void
      {
         var attackTime:int = _curSkill[Vo_Skill.ACTION_TIME] * FRAMETIME;
         var releaseTime:int = _curSkill[Vo_Skill.EFFECT_TIME] * FRAMETIME;
         setTime(attackTime < releaseTime ? releaseTime : attackTime);
         var actionUrl:int = int(_curSkill[Vo_Skill.ACTION]);
         hostBattleUnit.ck_special_sign = true;
         hostBattleUnit.attack(actionUrl,attackTime);
         timePool.push(setTimeout(dealResult,_curSkill[Vo_Skill.HIT_DELAY] * FRAMETIME));
      }
      
      private static function shimen_ck_attact() : void
      {
         setTime(3000);
         var attackTime:int = _curSkill[Vo_Skill.ACTION_TIME] * FRAMETIME;
         var releaseTime:int = _curSkill[Vo_Skill.RELEASE_TIME] * FRAMETIME;
         var actionUrl:int = int(_curSkill[Vo_Skill.ACTION]);
         hostBattleUnit.attack(actionUrl,attackTime);
         hostBattleUnit.weaponVisible = false;
         dealSelf();
         feiLun();
      }
      
      private static function feiLun() : void
      {
         var angle:Number;
         var target:Array = null;
         var _target:BattleUnit = null;
         var magic:BattleMagic = null;
         var time:int = 0;
         var nn:int = 0;
         var releaseSwf:int = int(_curSkill[Vo_Skill.RELEASE_SWF_EFFECT]);
         target = _curStep.targets.shift();
         _target = BattleUnitManager.findUnit(target[Enum_sever_battleTarget.ROLEID]) as BattleUnit;
         var dir:Number = hostBattleUnit.direction == 1 ? -1 : 1;
         var disX:int = 40;
         var stX:int = hostBattleUnit.init_x + disX * dir;
         var stY:int = hostBattleUnit.init_y + disX * 0.375 * dir;
         magic = BattleUnitManager.getMagic();
         magic.init(1,stX,stY - 40,true,"modelRes/magic/35319.swf",400);
         BattleUnitManager.addUnit(magic);
         angle = Math.atan2(hostBattleUnit.y - _target.y,hostBattleUnit.x - _target.x) * 180 / Math.PI - 30;
         magic.rotation = angle;
         time = getFLTime(magic,_target);
         nn = int(setTimeout(function():void
         {
            clearTimeout(nn);
            Tween.to(magic,time,{
               "x":[magic.x,_target.x],
               "y":[magic.y,_target.y - 30]
            },function():void
            {
               dealTarget(_target,target);
               effswf(_target);
               BattleUnitManager.removeUnit(magic);
               setTime(800);
            });
         },100));
      }
      
      private static function getFLTime(startUnit:IBattleUnit, endUnit:BattleUnit) : int
      {
         var nowSpeed:int = 0;
         var a:Number = NaN;
         var b:Number = NaN;
         var c:Number = NaN;
         var variable:Number = NaN;
         var len:int = Math.ceil(Math.sqrt(Util.dist(startUnit.x,startUnit.y,endUnit.x,endUnit.y)));
         if(endUnit.x == startUnit.x)
         {
            nowSpeed = 250;
         }
         else
         {
            a = 1.8;
            b = 1;
            c = (endUnit.y - startUnit.y) / (endUnit.x - startUnit.x) * (endUnit.y - startUnit.y) / (endUnit.x - startUnit.x);
            variable = Math.sqrt((1 + c) / (1 / (a * a) + c / (b * b)));
            nowSpeed = 250 * variable;
         }
         return len / nowSpeed * 500;
      }
      
      private static function rowAttack() : void
      {
         var attackTime:int = _curSkill[Vo_Skill.ACTION_TIME] * FRAMETIME;
         var releaseTime:int = _curSkill[Vo_Skill.RELEASE_TIME] * FRAMETIME;
         setTime(attackTime < releaseTime ? releaseTime : attackTime);
         var actionUrl:int = int(_curSkill[Vo_Skill.ACTION]);
         hostBattleUnit.attack(actionUrl,attackTime);
         timePool.push(setTimeout(dealRowResult,_curSkill[Vo_Skill.HIT_DELAY] * FRAMETIME));
      }
      
      private static function colAttack() : void
      {
         var attackTime:int = _curSkill[Vo_Skill.ACTION_TIME] * FRAMETIME;
         var releaseTime:int = _curSkill[Vo_Skill.RELEASE_TIME] * FRAMETIME;
         setTime(attackTime < releaseTime ? releaseTime : attackTime);
         var actionUrl:int = int(_curSkill[Vo_Skill.ACTION]);
         hostBattleUnit.attack(actionUrl,attackTime);
         timePool.push(setTimeout(dealColResult,_curSkill[Vo_Skill.HIT_DELAY] * FRAMETIME));
      }
      
      private static function petDoubleAttack() : void
      {
         var attackTimeStr:String = _curSkill[Vo_Skill.ACTION_TIME];
         var attackTimeArr:Array = attackTimeStr.split("_");
         var attackTime:int = (int(attackTimeArr[0]) + int(attackTimeArr[1])) * FRAMETIME;
         var releaseTime:int = _curSkill[Vo_Skill.RELEASE_TIME] * FRAMETIME;
         setTime(attackTime < releaseTime ? releaseTime : attackTime);
         var actionUrlStr:String = _curSkill[Vo_Skill.ACTION];
         var actions:Array = actionUrlStr.split("_");
         hostBattleUnit.attack(actions[0],int(attackTimeArr[0]) * FRAMETIME);
         timePool.push(setTimeout(secondAction,(int(attackTimeArr[0]) - 1) * FRAMETIME,hostBattleUnit,actions[1],int(attackTimeArr[1]) * FRAMETIME));
         timePool.push(setTimeout(dealMultiAResult,int(_curSkill[Vo_Skill.HIT_DELAY].split("_")[0]) * FRAMETIME));
      }
      
      private static function secondAction(host:BattleUnit, action:int, time:int) : void
      {
         host.attack(action,time);
      }
      
      private static function twoActionAttack() : void
      {
         var attackTimeStr:String = _curSkill[Vo_Skill.ACTION_TIME];
         var attackTimeArr:Array = attackTimeStr.split("_");
         var attackTime:int = (int(attackTimeArr[0]) + int(attackTimeArr[1])) * FRAMETIME;
         var releaseTime:int = _curSkill[Vo_Skill.RELEASE_TIME] * FRAMETIME;
         setTime(attackTime < releaseTime ? releaseTime : attackTime);
         var actionUrlStr:String = _curSkill[Vo_Skill.ACTION];
         var actions:Array = actionUrlStr.split("_");
         hostBattleUnit.attack(actions[0],int(attackTimeArr[0]) * FRAMETIME);
         timePool.push(setTimeout(secondAction,(int(attackTimeArr[0]) - 1) * FRAMETIME,hostBattleUnit,actions[1],int(attackTimeArr[1]) * FRAMETIME));
         timePool.push(setTimeout(dealResult,_curSkill[Vo_Skill.HIT_DELAY] * FRAMETIME));
      }
      
      private static function sameTargetsAttack() : void
      {
         var attackTime:int = _curSkill[Vo_Skill.ACTION_TIME] * FRAMETIME;
         var releaseTime:int = _curSkill[Vo_Skill.RELEASE_TIME] * FRAMETIME;
         setTime(attackTime < releaseTime ? releaseTime : attackTime);
         var actionUrl:int = int(_curSkill[Vo_Skill.ACTION]);
         hostBattleUnit.attack(actionUrl,attackTime);
         if(_curSkill[Vo_Skill.RANGE] == Enum_skill_range.THREE_ATTACK)
         {
            hostBattleUnit.weaponVisible = false;
         }
         timePool.push(setTimeout(dealSameTargetsResult,int(_curSkill[Vo_Skill.HIT_DELAY].split("_")[0]) * FRAMETIME));
      }
      
      private static function difTargetsAttack() : void
      {
         var attackTime:int = _curSkill[Vo_Skill.ACTION_TIME] * FRAMETIME;
         var releaseTime:int = _curSkill[Vo_Skill.RELEASE_TIME] * FRAMETIME;
         setTime(attackTime < releaseTime ? releaseTime : attackTime);
         var actionUrl:int = int(_curSkill[Vo_Skill.ACTION]);
         hostBattleUnit.attack(actionUrl,attackTime);
         timePool.push(setTimeout(dealMultiAResult,int(_curSkill[Vo_Skill.HIT_DELAY].split("_")[0]) * FRAMETIME));
      }
      
      private static function lunhuiAttack() : void
      {
         var attackTime:int = _curSkill[Vo_Skill.ACTION_TIME] * FRAMETIME;
         var actionUrl:int = int(_curSkill[Vo_Skill.ACTION]);
         hostBattleUnit.attack(actionUrl,attackTime);
         hostBattleUnit.weaponVisible = false;
         setTime(5000);
         var magic:BattleMagic = BattleUnitManager.getMagic();
         magic.init(1,hostBattleUnit.x,hostBattleUnit.y,true,"modelRes/role/weapon" + hostBattleUnit.sex + "/attack/" + hostBattleUnit.getWeapon() + "_" + _curSkill[Vo_Skill.ACTION] + ".swf",400);
         BattleUnitManager.addUnit(magic);
         doLunhuiTarget(magic);
         dealSelf();
      }
      
      private static function doLunhuiTarget(magic:BattleMagic) : void
      {
         var target:Array = null;
         var _target:BattleUnit = null;
         var needTime:int = 0;
         if(!_curStep || !magic)
         {
            return;
         }
         if(Boolean(_curStep.targets.length))
         {
            target = _curStep.targets.shift();
            _target = BattleUnitManager.findUnit(target[Enum_sever_battleTarget.ROLEID]) as BattleUnit;
            if(!_target)
            {
               return;
            }
            needTime = getLunTime(magic,_target);
            Tween.to(magic,needTime,{
               "x":[magic.x,_target.x],
               "y":[magic.y,_target.y]
            },function():void
            {
               var effSwf:int = 0;
               dealTarget(_target,target);
               if(_curSkill[Vo_Skill.RANGE] == Enum_skill_range.JING_MO)
               {
                  if(!isPlaying)
                  {
                     return;
                  }
                  effSwf = int(_curSkill[Vo_Skill.EFFECT_SWF_NUMBER]);
                  if(Boolean(effSwf))
                  {
                     _target.addEffect(effSwf.toString(),false,0,0,_curSkill[Vo_Skill.EFFECT_TIME] * FRAMETIME,-1,null,1,1);
                  }
               }
               else
               {
                  effswf(_target);
               }
               doLunhuiTarget(magic);
            });
         }
         else
         {
            if(!hostBattleUnit)
            {
               return;
            }
            needTime = getLunTime(magic,hostBattleUnit);
            Tween.to(magic,needTime,{
               "x":[magic.x,hostBattleUnit.x],
               "y":[magic.y,hostBattleUnit.y]
            },function():void
            {
               BattleUnitManager.removeUnit(magic);
               setTime(1);
            });
         }
      }
      
      private static function getLunTime(startUnit:IBattleUnit, endUnit:IBattleUnit) : int
      {
         var nowSpeed:int = 0;
         var a:Number = NaN;
         var b:Number = NaN;
         var c:Number = NaN;
         var variable:Number = NaN;
         var len:int = Math.ceil(Math.sqrt(Util.dist(startUnit.x,startUnit.y,endUnit.x,endUnit.y)));
         if(endUnit.x == startUnit.x)
         {
            nowSpeed = 350;
         }
         else
         {
            a = 1.8;
            b = 1;
            c = (endUnit.y - startUnit.y) / (endUnit.x - startUnit.x) * (endUnit.y - startUnit.y) / (endUnit.x - startUnit.x);
            variable = Math.sqrt((1 + c) / (1 / (a * a) + c / (b * b)));
            nowSpeed = 350 * variable;
         }
         return len / nowSpeed * 1000;
      }
      
      private static function kuangdaoMove() : void
      {
         timePool.push(setTimeout(kdMove,5 * FRAMETIME));
      }
      
      private static function kdMove() : void
      {
         var dir:Number = NaN;
         var disX:int = 0;
         var toX:int = 0;
         var toY:int = 0;
         if(!_curStep)
         {
            return;
         }
         var _target:BattleUnit = BattleUnitManager.findUnit(_curStep.targets[0][Enum_sever_battleTarget.ROLEID]) as BattleUnit;
         if(Boolean(_target) && Boolean(hostBattleUnit))
         {
            dir = _target.direction == 1 ? -1 : 1;
            disX = 140;
            toX = _target.init_x + disX * dir;
            toY = _target.init_y + disX * 0.375 * dir;
            Tween.to(hostBattleUnit,7 * FRAMETIME,{
               "x":[hostBattleUnit.x,toX],
               "y":[hostBattleUnit.y,toY]
            });
         }
      }
      
      private static function pofuMove() : void
      {
         timePool.push(setTimeout(pfMove,4 * FRAMETIME));
      }
      
      private static function pfMove() : void
      {
         var dir:Number = NaN;
         var disX:int = 0;
         var toX:int = 0;
         var toY:int = 0;
         var _target:BattleUnit = BattleUnitManager.findUnit(_curStep.targets[0][Enum_sever_battleTarget.ROLEID]) as BattleUnit;
         if(Boolean(_target) && Boolean(hostBattleUnit))
         {
            dir = _target.direction == 1 ? -1 : 1;
            disX = 70;
            toX = _target.init_x + disX * dir;
            toY = _target.init_y + disX * 0.375 * dir;
            Tween.to(hostBattleUnit,5 * FRAMETIME,{
               "x":[hostBattleUnit.x,toX],
               "y":[hostBattleUnit.y,toY]
            });
         }
      }
      
      private static function jianshanMove() : void
      {
         timePool.push(setTimeout(jsMove,9 * FRAMETIME));
      }
      
      private static function jsMove() : void
      {
         var dir:Number = NaN;
         var disX:int = 0;
         var toX:int = 0;
         var toY:int = 0;
         var _target:BattleUnit = BattleUnitManager.findUnit(_curStep.targets[0][Enum_sever_battleTarget.ROLEID]) as BattleUnit;
         if(Boolean(_target) && Boolean(hostBattleUnit))
         {
            dir = _target.direction == 1 ? -1 : 1;
            disX = -70;
            toX = _target.init_x + disX * dir;
            toY = _target.init_y + disX * 0.375 * dir;
            Tween.to(hostBattleUnit,2 * FRAMETIME,{
               "x":[hostBattleUnit.x,toX],
               "y":[hostBattleUnit.y,toY]
            });
         }
      }
      
      private static function releaseSwfFly() : void
      {
         var releaseSwf:int = int(_curSkill[Vo_Skill.RELEASE_SWF_EFFECT]);
         if(Boolean(releaseSwf))
         {
            hostBattleUnit.addEffect(releaseSwf.toString(),false,0,0,_curSkill[Vo_Skill.RELEASE_TIME] * FRAMETIME);
         }
      }
      
      private static function releaseSwfFly_YX() : void
      {
         var target:Array = null;
         var _target:BattleUnit = null;
         var magic:BattleMagic = null;
         var time:int = 0;
         var n:int = 0;
         target = _curStep.targets.shift();
         _target = BattleUnitManager.findUnit(target[Enum_sever_battleTarget.ROLEID]) as BattleUnit;
         magic = BattleUnitManager.getMagic();
         var dir:Number = hostBattleUnit.direction == 1 ? -1 : 1;
         var disX:int = 30;
         var stX:int = hostBattleUnit.init_x + disX * dir;
         var stY:int = hostBattleUnit.init_y + disX * 0.375 * dir - 30;
         magic.init(1,stX,stY,true,"modelRes/magic/35333.swf",400);
         BattleUnitManager.addUnit(magic);
         time = getFLTime(magic,_target);
         n = int(setTimeout(function():void
         {
            clearTimeout(n);
            Tween.to(magic,time,{
               "x":[magic.x,_target.x],
               "y":[magic.y,_target.y - 10]
            },function():void
            {
               dealTarget(_target,target);
               effswf(_target);
               BattleUnitManager.removeUnit(magic);
               setTime(800);
            });
         },200));
      }
      
      private static function roundEffFly() : void
      {
         hostBattleUnit.addJianyu();
         timePool.push(setTimeout(removeJianyu,_delay - FRAMETIME * 15));
      }
      
      private static function removeJianyu() : void
      {
         hostBattleUnit.removeJianyu();
      }
      
      private static function relJingchaoSwfFly() : void
      {
         var _target:BattleUnit = null;
         var left_x:int = 0;
         var left_y:int = 0;
         var right_x:int = 0;
         var right_y:int = 0;
         hostBattleUnit.weaponVisible = false;
         _target = BattleUnitManager.findUnit(_curStep.targets[0][Enum_sever_battleTarget.ROLEID]) as BattleUnit;
         biaoFly(4,6,_target);
         biaoFly(9,6,_target);
         biaoFly(15,6,_target);
         left_x = hostBattleUnit.init_x - 70;
         left_y = hostBattleUnit.init_y + 35;
         right_x = hostBattleUnit.init_x + 70;
         right_y = hostBattleUnit.init_y - 35;
         timePool.push(setTimeout(function():void
         {
            lunFly(_target,left_x,left_y);
            lunFly(_target,right_x,right_y);
         },33 * FRAMETIME));
      }
      
      private static function biaoFly(delay:int, flyTime:int, _target:BattleUnit) : void
      {
         timePool.push(setTimeout(function():void
         {
            var magic:* = undefined;
            magic = BattleUnitManager.getMagic();
            magic.init(1,hostBattleUnit.x,hostBattleUnit.y,true,"modelRes/magic/34706.swf",40);
            magic.rotation = -Math.atan2(_target.init_x - magic.x,_target.init_y - magic.y) * 180 / Math.PI + 90;
            BattleUnitManager.addUnit(magic);
            Tween.to(magic,flyTime * FRAMETIME,{
               "x":[magic.x,_target.init_x],
               "y":[magic.y,_target.init_y]
            },function():void
            {
               BattleUnitManager.removeUnit(magic);
            });
         },delay * FRAMETIME));
      }
      
      private static function lunFly(_target:BattleUnit, magic_x:int, magic_y:int) : void
      {
         var magic:BattleMagic = null;
         magic = BattleUnitManager.getMagic();
         magic.init(1,magic_x,magic_y,true,"modelRes/magic/34703.swf",400);
         BattleUnitManager.addUnit(magic);
         timePool.push(setTimeout(function():void
         {
            Tween.to(magic,3 * FRAMETIME,{
               "x":[magic.x,_target.init_x],
               "y":[magic.y,_target.init_y]
            },function():void
            {
               BattleUnitManager.removeUnit(magic);
            });
         },6 * FRAMETIME));
      }
      
      private static function yanSwfFly() : void
      {
         var yanSwf:int = int(_curSkill[Vo_Skill.YAN_SWF]);
         if(Boolean(yanSwf))
         {
            hostBattleUnit.addEffect(yanSwf.toString(),false,0,0,_curSkill[Vo_Skill.YAN_TIME] * FRAMETIME);
         }
      }
      
      private static function shakeMap() : void
      {
         Tween.to(GameScene.mapLayer,60,{"y":[GameScene.mapLayer.y,GameScene.mapLayer.y - 30]},shakeBack);
         Tween.to(GameScene.battleLayer.gridLayer,60,{"y":[GameScene.battleLayer.gridLayer.y,GameScene.battleLayer.gridLayer.y - 30]});
      }
      
      private static function shakeBack() : void
      {
         Tween.to(GameScene.mapLayer,60,{"y":[GameScene.mapLayer.y,GameScene.mapLayer.y + 30]});
         Tween.to(GameScene.battleLayer.gridLayer,60,{"y":[GameScene.battleLayer.gridLayer.y,GameScene.battleLayer.gridLayer.y + 30]});
         if(!isPlaying)
         {
            CameraManager.wacth(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y);
         }
      }
      
      private static function skillNameFly() : void
      {
         if(_curStep.skillId <= 4)
         {
            return;
         }
         if(_curStep.skillId >= 36001 && _curStep.skillId <= 36319)
         {
            getFlyWord(FlyWord.SKILL,String(_curStep.skillId),hostBattleUnit);
         }
         else
         {
            GameScene.battleLayer.useSkill(_curSkill[Vo_Skill.NAME]);
         }
      }
      
      private static function effSwfsFly() : void
      {
         var _target:BattleUnit = null;
         var i:int = 0;
         if(!isPlaying)
         {
            return;
         }
         var targets:Array = _curStep.targets;
         var len:int = int(targets.length);
         if(Boolean(_curStep.skillId))
         {
            i = 0;
            while(i < len)
            {
               _target = BattleUnitManager.findUnit(targets[i][Enum_sever_battleTarget.ROLEID]) as BattleUnit;
               effswf(_target);
               i++;
            }
         }
      }
      
      private static function effSwfsFly_jksg() : void
      {
         var n:int = 0;
         n = int(setTimeout(function():void
         {
            clearTimeout(n);
            effSwfsFly();
         },400));
      }
      
      private static function jksg_effAdd() : void
      {
         var n:int = 0;
         n = int(setTimeout(function():void
         {
            clearTimeout(n);
            hostBattleUnit.addEffect("35326",false,0,0,400);
         },300));
      }
      
      private static function effPotianSwfFly() : void
      {
         var _target:BattleUnit = null;
         var effSwfStr:String = null;
         var effSwfs:Array = null;
         var effTimeStr:String = null;
         var effTimes:Array = null;
         var len:int = 0;
         var i:int = 0;
         if(!isPlaying)
         {
            return;
         }
         var targets:Array = _curStep.targets;
         if(Boolean(_curStep.skillId))
         {
            _target = BattleUnitManager.findUnit(targets[0][Enum_sever_battleTarget.ROLEID]) as BattleUnit;
            effSwfStr = _curSkill[Vo_Skill.EFFECT_SWF_NUMBER];
            effSwfs = effSwfStr.split("_");
            effTimeStr = _curSkill[Vo_Skill.EFFECT_TIME];
            effTimes = effTimeStr.split("_");
            len = int(effSwfs.length);
            i = 0;
            while(i < len)
            {
               if(Boolean(effSwfs[i]))
               {
                  _target.addEffect(effSwfs[i].toString(),false,0,0,effTimes[i] * FRAMETIME,-1,null,1);
               }
               i++;
            }
         }
      }
      
      private static function effRowSwfsFly() : void
      {
         var _target:BattleUnit = null;
         var i:int = 0;
         var col:int = 0;
         if(!isPlaying)
         {
            return;
         }
         var targets:Array = _curStep.targets;
         var len:int = int(targets.length);
         if(Boolean(_curStep.skillId))
         {
            i = 0;
            while(i < len)
            {
               _target = BattleUnitManager.findUnit(targets[i][Enum_sever_battleTarget.ROLEID]) as BattleUnit;
               if(_target)
               {
                  col = 3 - int(_target.position.charAt(1));
                  if(Boolean(col))
                  {
                     timePool.push(setTimeout(effswf,FRAMETIME * col * 2,_target));
                     trace("effRowSwfsFly",col,_target.name,_target.id);
                  }
                  else
                  {
                     effswf(_target);
                     trace("effRowSwfsFly",col,_target.name,_target.id);
                  }
               }
               i++;
            }
         }
      }
      
      private static function effColSwfsFly() : void
      {
         var _target:BattleUnit = null;
         var i:int = 0;
         var row:int = 0;
         if(!isPlaying)
         {
            return;
         }
         var targets:Array = _curStep.targets;
         var len:int = int(targets.length);
         if(Boolean(_curStep.skillId))
         {
            i = 0;
            while(i < len)
            {
               _target = BattleUnitManager.findUnit(targets[i][Enum_sever_battleTarget.ROLEID]) as BattleUnit;
               if(!(!_target || !_target.position))
               {
                  row = int(_target.position.charAt(0)) - 1;
                  if(Boolean(row))
                  {
                     timePool.push(setTimeout(effswf,FRAMETIME * row * 2,_target));
                     trace("effColSwfsFly",row,_target.name);
                  }
                  else
                  {
                     effswf(_target);
                     trace("effColSwfsFly",row,_target.name);
                  }
               }
               i++;
            }
         }
      }
      
      private static function effDoubleSwfsFly() : void
      {
         var _target:BattleUnit = null;
         if(!isPlaying)
         {
            return;
         }
         var targets:Array = _curStep.targets;
         var len:int = int(targets.length);
         if(Boolean(_curStep.skillId))
         {
            _target = BattleUnitManager.findUnit(targets[0][Enum_sever_battleTarget.ROLEID]) as BattleUnit;
            effswf(_target);
         }
      }
      
      private static function effMultiSwfsFly() : void
      {
         var _target:BattleUnit = null;
         var i:int = 0;
         if(!isPlaying)
         {
            return;
         }
         var hitTimeArr:Array = _curSkill[Vo_Skill.HIT_DELAY].split("_");
         var targets:Array = _curStep.targets;
         var len:int = int(targets.length);
         if(Boolean(_curStep.skillId))
         {
            i = 0;
            while(i < len)
            {
               _target = BattleUnitManager.findUnit(targets[i][Enum_sever_battleTarget.ROLEID]) as BattleUnit;
               if(_target)
               {
                  if(Boolean(i))
                  {
                     timePool.push(setTimeout(effswf,FRAMETIME * int(hitTimeArr[i]),_target));
                  }
                  else
                  {
                     effswf(_target);
                  }
               }
               i++;
            }
         }
         _delay = ((len > 1 ? int(hitTimeArr[len - 1]) : 0) + int(_curSkill[Vo_Skill.EFFECT_TIME])) * FRAMETIME;
      }
      
      private static function effQinlongFly() : void
      {
         if(!isPlaying)
         {
            return;
         }
         var _target:BattleUnit = BattleUnitManager.findUnit(_curStep.targets[0][Enum_sever_battleTarget.ROLEID]) as BattleUnit;
         var posArr:Array = GameScene.battleLayer.getBattleGrid(22,_target.direction);
         var effSwf:int = int(_curSkill[Vo_Skill.EFFECT_SWF_NUMBER]);
         var magic:BattleMagic = BattleUnitManager.getMagic();
         magic.init(1,posArr[0],posArr[1],false,"modelRes/magic/" + effSwf + ".swf",_curSkill[Vo_Skill.EFFECT_TIME] * FRAMETIME);
         BattleUnitManager.addUnit(magic);
      }
      
      private static function effswf(_target:BattleUnit) : void
      {
         var swfarr:Array = null;
         var effSwf:int = 0;
         if(!isPlaying)
         {
            return;
         }
         if(!_target)
         {
            return;
         }
         var swfStr:String = _curSkill[Vo_Skill.EFFECT_SWF_NUMBER];
         if(Boolean(swfStr))
         {
            swfarr = swfStr.split(";");
         }
         if(Boolean(swfarr))
         {
            if(swfarr.length > 1)
            {
               effSwf = int(swfarr[int(Util.rnd(0,swfarr.length - 1))]);
            }
            else
            {
               effSwf = int(swfarr[0]);
            }
         }
         if(Boolean(effSwf))
         {
            _target.addEffect(effSwf.toString(),false,0,0,_curSkill[Vo_Skill.EFFECT_TIME] * FRAMETIME,-1,null,1);
         }
      }
      
      private static function delay() : void
      {
         if(!isPlaying)
         {
            return;
         }
         if(_curStep.skillId > 4)
         {
            GameScene.battleLayer.removeSkill();
         }
         setTime(_delay);
      }
      
      private static function attdelay() : void
      {
         if(!isPlaying)
         {
            return;
         }
         setTime(120);
      }
      
      private static function returnStand() : void
      {
         hostBattleUnit.action = Action.STAND;
      }
      
      private static function lunhuiStand() : void
      {
         hostBattleUnit.action = Action.STAND;
         hostBattleUnit.weaponVisible = true;
      }
      
      private static function doKickBack() : void
      {
         var _target:BattleUnit = null;
         if(!isPlaying)
         {
            return;
         }
         var targets:Array = _curStep.targets;
         if(Boolean(targets[0]) && targets[0][Enum_sever_battleTarget.HP] == 0)
         {
            _target = BattleUnitManager.findUnit(targets[0][Enum_sever_battleTarget.ROLEID]) as BattleUnit;
            _target.playKickBack();
         }
      }
      
      private static function dealResult() : void
      {
         var _target:BattleUnit = null;
         if(!isPlaying)
         {
            return;
         }
         dealSelf();
         var targets:Array = _curStep.targets;
         var len:int = int(targets.length);
         var i:int = 0;
         while(i < len)
         {
            _target = BattleUnitManager.findUnit(targets[i][Enum_sever_battleTarget.ROLEID]) as BattleUnit;
            if(_target)
            {
               dealTarget(_target,targets[i]);
            }
            i++;
         }
      }
      
      private static function dealRowResult() : void
      {
         var _target:BattleUnit = null;
         var col:int = 0;
         if(!isPlaying)
         {
            return;
         }
         dealSelf();
         var targets:Array = _curStep.targets;
         var len:int = int(targets.length);
         var i:int = 0;
         while(i < len)
         {
            _target = BattleUnitManager.findUnit(targets[i][Enum_sever_battleTarget.ROLEID]) as BattleUnit;
            if(_target)
            {
               col = 3 - int(_target.position.charAt(1));
               if(Boolean(col))
               {
                  timePool.push(setTimeout(dealTarget,FRAMETIME * col * 2,_target,targets[i]));
               }
               else
               {
                  dealTarget(_target,targets[i]);
               }
            }
            i++;
         }
      }
      
      private static function dealColResult() : void
      {
         var _target:BattleUnit = null;
         var row:int = 0;
         if(!isPlaying)
         {
            return;
         }
         dealSelf();
         var targets:Array = _curStep.targets;
         var len:int = int(targets.length);
         var i:int = 0;
         while(i < len)
         {
            _target = BattleUnitManager.findUnit(targets[i][Enum_sever_battleTarget.ROLEID]) as BattleUnit;
            if(_target)
            {
               row = int(_target.position.charAt(0)) - 1;
               if(Boolean(row))
               {
                  timePool.push(setTimeout(dealTarget,FRAMETIME * row * 2,_target,targets[i]));
               }
               else
               {
                  dealTarget(_target,targets[i]);
               }
            }
            i++;
         }
      }
      
      private static function dealSameTargetsResult() : void
      {
         var _target:BattleUnit = null;
         if(!isPlaying)
         {
            return;
         }
         dealSelf();
         var hitTimeArr:Array = _curSkill[Vo_Skill.HIT_DELAY].split("_");
         var targets:Array = _curStep.targets;
         var len:int = int(targets.length);
         var i:int = 0;
         while(i < len)
         {
            _target = BattleUnitManager.findUnit(targets[i][Enum_sever_battleTarget.ROLEID]) as BattleUnit;
            if(_target)
            {
               if(Boolean(i))
               {
                  timePool.push(setTimeout(dealTarget,FRAMETIME * int(hitTimeArr[i]),_target,targets[i],i == len - 1 ? true : false));
               }
               else
               {
                  dealTarget(_target,targets[i],false);
               }
            }
            i++;
         }
      }
      
      private static function dealMultiAResult() : void
      {
         var _target:BattleUnit = null;
         if(!isPlaying)
         {
            return;
         }
         dealSelf();
         var hitTimeArr:Array = _curSkill[Vo_Skill.HIT_DELAY].split("_");
         var targets:Array = _curStep.targets;
         var len:int = int(targets.length);
         var i:int = 0;
         while(i < len)
         {
            _target = BattleUnitManager.findUnit(targets[i][Enum_sever_battleTarget.ROLEID]) as BattleUnit;
            if(_target)
            {
               if(Boolean(i))
               {
                  timePool.push(setTimeout(dealTarget,FRAMETIME * int(hitTimeArr[i]),_target,targets[i]));
               }
               else
               {
                  dealTarget(_target,targets[i]);
               }
            }
            i++;
         }
      }
      
      private static function dealSelf() : void
      {
         var bufData:Array = null;
         var addValue:int = 0;
         var _tempArr:Array = null;
         var _temName:String = null;
         if(!isPlaying)
         {
            return;
         }
         var _name:String = "";
         if(Boolean(_curSkill))
         {
            _name = _curSkill[Vo_Skill.NAME];
         }
         if(_dObj.type == 4 && _dObj.launcher == hostBattleUnit && _dObj.curHp < 0 && _name.indexOf("吸星刀") == -1)
         {
            trace("不显示飞血");
         }
         else
         {
            addValue = _curStep.hp - hostBattleUnit.hp;
            _tempArr = Data_lib.skill[_curStep.skillId];
            if(Boolean(_tempArr))
            {
               _temName = Data_lib.skill[_curStep.skillId][1];
            }
            if(Boolean(_temName) && Boolean(_temName.indexOf("吸星刀") != -1) && addValue < 0)
            {
               addValue = 0;
            }
            if(addValue != 0 && _curStyle != SHIMEN_TD_SG)
            {
               getFlyWord(addValue >= 0 ? FlyWord.ADD_HP : FlyWord.HURT,uint(addValue).toString(),hostBattleUnit);
            }
         }
         var sb:Array = [];
         var buf:Array = [];
         var bufPosition:Array = [];
         var j:int = 0;
         while(j < _curStep.bufferids.length)
         {
            if(Boolean(Data_lib.sbSkill[_curStep.bufferids[j][0]]))
            {
               sb.push(_curStep.bufferids[j]);
            }
            else
            {
               bufData = Data_lib.buffer[_curStep.bufferids[j][0]];
               buf.push(bufData[Vo_Buffer.SWF_URL]);
               bufPosition.push(bufData[Vo_Buffer.BUF_LAYER]);
            }
            j++;
         }
         hostBattleUnit.miJiComp.setBuffers(_curStep.bufferids);
         trace("\n ------------------  ",_curStep.stepId,_curStep.skillId,Boolean(_curStep.skillId) ? Data_lib.skill[_curStep.skillId][Vo_Skill.NAME] : "普攻");
         trace("攻击方：",hostBattleUnit.name,"  气血：",hostBattleUnit.hp,"->",_curStep.hp,"  最大气血：",hostBattleUnit.hpMax,"->",_curStep.maxHp,"  伤害值：",addValue,"   怒气：",_curStep.angry,"  BUF:",_curStep.bufferids);
         if(_curStyle != SHIMEN_TD_SG)
         {
            hostBattleUnit.setInfo(_curStep.hp,_curStep.maxHp,_curStep.mp,_curStep.maxMp,_curStep.angry,100);
         }
         else
         {
            hostBattleUnit.setInfo(hostBattleUnit.hp,_curStep.maxHp,_curStep.mp,_curStep.maxMp,_curStep.angry,100);
         }
         hostBattleUnit.setShenBing(sb);
         if(_curStyle != SHIMEN_TD_SG)
         {
            hostBattleUnit.addEffs(buf,bufPosition);
         }
      }
      
      private static function ckSGSpecialDeal(status:int, hurtValue:int, _target:BattleUnit, initY:Number = -175) : void
      {
         var _ssArr:Array = null;
         var _total:int = 0;
         var hurtValueFunc:Function = function(_index:int):void
         {
            var _per:Number;
            var _hurtValue:int;
            var nn:int;
            if(_index >= _ssArr.length)
            {
               return;
            }
            _per = _ssArr[_index] / _total > 1 ? 1 : _ssArr[_index] / _total;
            _hurtValue = int(hurtValue * _per);
            if(_hurtValue != 0 && !(status & 1 << Enum_battle_status.BAO_JI))
            {
               getFlyWord(_hurtValue > 0 ? FlyWord.ADD_HP : FlyWord.HURT,uint(_hurtValue).toString(),_target,initY);
            }
            if(Boolean(status & 1 << Enum_battle_status.BAO_JI))
            {
               getFlyWord(FlyWord.BAOJI,_hurtValue.toString(),_target);
               shakeMap();
            }
            if(Boolean(status & 1 << Enum_battle_status.DODGE))
            {
               getFlyWord(FlyWord.DODGE,uint(_hurtValue).toString(),_target);
               _target.dodge();
            }
            if(Boolean(status & 1 << Enum_battle_status.GE_DANG))
            {
               getFlyWord(FlyWord.GE_DANG,uint(_hurtValue).toString(),_target);
               _target.addEffect("35030",false,0,0,550,-1,null,1);
            }
            nn = int(setTimeout(function():void
            {
               hurtValueFunc(++_index);
            },440));
         };
         _ssArr = Data_lib.shiMenCikeSG[_curStep.skillId];
         _total = _ssArr[0] + _ssArr[1] + _ssArr[2];
         hurtValueFunc(0);
      }
      
      private static function dealAtb(_target:BattleUnit, targetData:Array, isLast:Boolean = true) : void
      {
      }
      
      private static function dealTarget(_target:BattleUnit, targetData:Array, isLast:Boolean = true) : void
      {
         var status:int;
         var hurtInfo:*;
         var newHp:int;
         var newHpMax:int;
         var newMp:int;
         var newMpMax:int;
         var hurtValue:int;
         var recHp:int;
         var sb:Array;
         var buf:Array;
         var bufPosition:Array;
         var j:int;
         var hurtSteps:Array = null;
         var i:int = 0;
         var bufData:Array = null;
         var _name:String = null;
         var tHp:int = 0;
         var tHpMax:int = 0;
         var tMp:int = 0;
         var tMpMax:int = 0;
         var thValue:int = 0;
         var time:int = 0;
         var off:Number = NaN;
         var t:int = 0;
         var skillArr:Array = null;
         var targetType:int = 0;
         var id:int = 0;
         var tarSkill:Array = null;
         var petSkillId:int = 0;
         var releaseSwf:int = 0;
         var autoTargets:Array = null;
         var autoTarLen:int = 0;
         var ii:int = 0;
         var _autotarget:BattleUnit = null;
         var effSwf:int = 0;
         var _autotargetStatus:int = 0;
         var _autohurtValue:int = 0;
         var autobuf:Array = null;
         var autobufPosition:Array = null;
         var autobufData:Array = null;
         var jj:int = 0;
         if(!_target)
         {
            return;
         }
         if(!isPlaying)
         {
            return;
         }
         status = int(targetData[Enum_sever_battleTarget.STATUS]);
         hurtInfo = targetData[Enum_sever_battleTarget.HP];
         i = 0;
         if(hurtInfo is Array)
         {
            hurtSteps = hurtInfo;
         }
         else
         {
            hurtSteps = [[hurtInfo]];
         }
         newHp = int(hurtSteps[i][Enum_sever_battleTarget.INHP]);
         newHpMax = int(hurtSteps[i][Enum_sever_battleTarget.INMAXHP]);
         newMp = int(hurtSteps[i][Enum_sever_battleTarget.INMP]);
         newMpMax = int(hurtSteps[i][Enum_sever_battleTarget.INMAXMP]);
         hurtValue = newHp - _target.hp;
         trace("受击者：",_target.name,"  气血：",_target.hp,"->",newHp,"  最大气血：",_target.hpMax,"->",int(targetData[Enum_sever_battleTarget.MAXHP]),"  伤害值：",hurtValue,"   状态：",status,"   怒气：",targetData[Enum_sever_battleTarget.ANGRY],"  BUF:",targetData[Enum_sever_battleTarget.BUFFERIDS]);
         if(_curStyle == SHIMEN_CK_SG)
         {
            ckSGSpecialDeal(status,hurtValue,_target);
         }
         else
         {
            _name = "";
            if(Boolean(_curSkill))
            {
               _name = _curSkill[Vo_Skill.NAME];
            }
            if(_name.indexOf("回春术") != -1 && _name.indexOf("白虎神光") != -1 && hostBattleUnit != _target)
            {
               trace("不飞血");
            }
            else
            {
               showStatus(status,hurtValue,_target);
            }
         }
         _target.setInfo(newHp,newHpMax,newMp,newMpMax,targetData[Enum_sever_battleTarget.ANGRY],100,isLast);
         recHp = _target.hp;
         if(hurtSteps.length > 1)
         {
            i = 1;
            while(i < hurtSteps.length)
            {
               tHp = int(hurtSteps[i][Enum_sever_battleTarget.INHP]);
               tHpMax = int(hurtSteps[i][Enum_sever_battleTarget.INMAXHP]);
               tMp = int(hurtSteps[i][Enum_sever_battleTarget.INMP]);
               tMpMax = int(hurtSteps[i][Enum_sever_battleTarget.INMAXMP]);
               thValue = tHp - recHp;
               time = i / (hurtSteps.length - 1) * 350;
               off = -175 - i * 25;
               t = int(setTimeout(function(prm:Array):void
               {
                  Utils.print(i.toString() + "次伤害受击者：",_target.name,"  气血：",_target.hp,"->",prm[1],"  最大气血：",_target.hpMax,"->",prm[2],"  伤害值：",prm[5]);
                  showStatus(0,prm[5],_target,prm[6]);
               },time,[i,tHp,tHpMax,tMp,tMpMax,thValue,off]));
               _target.setValue(tHp,tHpMax,tMp,tMpMax);
               recHp -= tHp;
               timePool.push(t);
               i++;
            }
         }
         if(!int(targetData[Enum_sever_battleTarget.SKILLID]))
         {
            if(!(status & 1 << Enum_battle_status.DODGE))
            {
               if(Boolean(_curStep.skillId))
               {
                  skillArr = Data_lib.skill[_curStep.skillId];
                  targetType = int(skillArr[Vo_Skill.TARGET]);
                  if(targetType == Enum_skill_tarType.ENEMY || _curStyle == SHIMEN_TD_SG && _target != hostBattleUnit)
                  {
                     _target.action = Action.HIT;
                     if(int(skillArr[Vo_Skill.HAS_HURT_EFF]) == 1)
                     {
                        _target.addEffect("hit",false,0,0,400);
                     }
                     if(newHp == 0 && isLast && _target.type == UnitType.NPC)
                     {
                        _target.playKickBack();
                     }
                  }
               }
               else
               {
                  _target.action = Action.HIT;
                  _target.addEffect("hit",false,0,0,400);
               }
            }
         }
         sb = [];
         buf = [];
         bufPosition = [];
         j = 0;
         while(j < targetData[Enum_sever_battleTarget.BUFFERIDS].length)
         {
            if(Boolean(Data_lib.sbSkill[targetData[Enum_sever_battleTarget.BUFFERIDS][j][0]]))
            {
               sb.push(targetData[Enum_sever_battleTarget.BUFFERIDS][j]);
            }
            else
            {
               id = int(targetData[Enum_sever_battleTarget.BUFFERIDS][j][0]);
               bufData = Data_lib.buffer[targetData[Enum_sever_battleTarget.BUFFERIDS][j][0]];
               buf.push(bufData[Vo_Buffer.SWF_URL]);
               bufPosition.push(bufData[Vo_Buffer.BUF_LAYER]);
            }
            j++;
         }
         _target.setShenBing(sb);
         _target.addEffs(buf,bufPosition);
         _target.miJiComp.setBuffers(targetData[Enum_sever_battleTarget.BUFFERIDS]);
         if(Boolean(targetData[Enum_sever_battleTarget.SKILLID]))
         {
            tarSkill = Data_lib.skill[targetData[Enum_sever_battleTarget.SKILLID]];
            petSkillId = int(targetData[Enum_sever_battleTarget.SKILLID]);
            if(petSkillId >= 36001 && petSkillId <= 36319)
            {
               getFlyWord(FlyWord.SKILL,petSkillId.toString(),_target);
            }
            releaseSwf = int(tarSkill[Vo_Skill.RELEASE_SWF_EFFECT]);
            if(Boolean(releaseSwf))
            {
               _target.addEffect(releaseSwf.toString(),false,0,0,tarSkill[Vo_Skill.RELEASE_TIME] * FRAMETIME);
            }
            autoTargets = targetData[Enum_sever_battleTarget.TARGETS];
            autoTarLen = int(autoTargets.length);
            ii = 0;
            while(ii < autoTarLen)
            {
               _autotarget = BattleUnitManager.findUnit(autoTargets[ii][Enum_sever_battleTarget.ROLEID]) as BattleUnit;
               if(_autotarget)
               {
                  effSwf = int(tarSkill[Vo_Skill.EFFECT_SWF_NUMBER]);
                  if(Boolean(effSwf))
                  {
                     _autotarget.addEffect(effSwf.toString(),false,0,0,tarSkill[Vo_Skill.EFFECT_TIME] * FRAMETIME,-1,null,1);
                  }
                  _autotargetStatus = int(autoTargets[ii][Enum_sever_battleTarget.STATUS]);
                  _autohurtValue = int(autoTargets[ii][Enum_sever_battleTarget.HP]) - _target.hp;
                  showStatus(_autotargetStatus,_autohurtValue,_autotarget);
                  if(_autotarget.x != _autotarget.init_x && int(autoTargets[ii][Enum_sever_battleTarget.HP]) == 0)
                  {
                     _autotarget.needGoBackDie = true;
                  }
                  _autotarget.setInfo(autoTargets[ii][Enum_sever_battleTarget.HP],autoTargets[ii][Enum_sever_battleTarget.MAXHP],autoTargets[ii][Enum_sever_battleTarget.MP],autoTargets[ii][Enum_sever_battleTarget.MAXMP],autoTargets[ii][Enum_sever_battleTarget.ANGRY],100);
                  autobuf = [];
                  autobufPosition = [];
                  jj = 0;
                  while(jj < autoTargets[ii][Enum_sever_battleTarget.BUFFERIDS].length)
                  {
                     autobufData = Data_lib.buffer[autoTargets[ii][Enum_sever_battleTarget.BUFFERIDS][jj][0]];
                     autobuf.push(autobufData[Vo_Buffer.SWF_URL]);
                     autobufPosition.push(autobufData[Vo_Buffer.BUF_LAYER]);
                     jj++;
                  }
                  _autotarget.addEffs(autobuf,autobufPosition);
               }
               ii++;
            }
         }
      }
      
      private static function showStatus(status:int, hurtValue:int, _target:BattleUnit, initY:Number = -175) : void
      {
         if(Boolean(status & 1 << Enum_battle_status.BAO_JI))
         {
            getFlyWord(FlyWord.BAOJI,hurtValue.toString(),_target);
            shakeMap();
         }
         if(Boolean(status & 1 << Enum_battle_status.DODGE))
         {
            getFlyWord(FlyWord.DODGE,uint(hurtValue).toString(),_target);
            _target.dodge();
         }
         if(Boolean(status & 1 << Enum_battle_status.GE_DANG))
         {
            getFlyWord(FlyWord.GE_DANG,uint(hurtValue).toString(),_target);
            _target.addEffect("35030",false,0,0,550,-1,null,1);
         }
         if(hurtValue != 0 && !(status & 1 << Enum_battle_status.BAO_JI))
         {
            getFlyWord(hurtValue > 0 ? FlyWord.ADD_HP : FlyWord.HURT,uint(hurtValue).toString(),_target,initY);
         }
      }
      
      public static function getFlyWord(type:String, value:String, target:BattleUnit, initY:Number = -175) : void
      {
         var flyword:FlyWord = FlyWord.getFlyWord();
         target.addChild(flyword);
         flyword.init(value,type,initY);
      }
      
      public static function setTime(totalTime:int) : void
      {
         _totalTime = totalTime;
         _beginTime = getTimer();
      }
      
      public static function run(now:int) : void
      {
         if(now - _beginTime >= _totalTime)
         {
            ++_curFlag;
            if(Boolean(_curStyle) && _curFlag > playStyle[_curStyle].length - 1)
            {
               play();
            }
            else
            {
               doStyle();
            }
         }
      }
   }
}

