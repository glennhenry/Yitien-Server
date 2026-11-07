package com.yiTian.gameUnit.role
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_CursorType;
   import com.yiTian.data.config.Enum_KeJu;
   import com.yiTian.data.config.Enum_NPC_ID;
   import com.yiTian.data.config.Enum_npc_type;
   import com.yiTian.data.config.Enum_quest_step_type;
   import com.yiTian.data.config.Enum_quest_type;
   import com.yiTian.data.model.Model_KeJu;
   import com.yiTian.data.model.Model_QiJu;
   import com.yiTian.data.model.Model_npc;
   import com.yiTian.data.model.Model_quest;
   import com.yiTian.data.vo.quest.Vo_quest;
   import com.yiTian.data.vo.quest.Vo_questStep;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.config.State;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CameraManager;
   import com.yiTian.manager.CollectManager;
   import com.yiTian.manager.CursorManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.GuideManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.QuestGuiManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.QiJuHandler;
   import com.yiTian.net.message.cg.BangBattleCGMessage;
   import com.yiTian.net.message.cg.BangCGMessage;
   import com.yiTian.net.message.cg.BattleCGMessage;
   import com.yiTian.net.message.cg.CaiDengMiCGMessage;
   import com.yiTian.net.message.cg.ChristmasCGMessage;
   import com.yiTian.net.message.cg.CrossClanBattleCGMessage;
   import com.yiTian.net.message.cg.KejuCGMessage;
   import com.yiTian.net.message.cg.MarriageCGMessage;
   import com.yiTian.net.message.cg.QiJuCGMessage;
   import com.yiTian.net.message.cg.ShenshouCGMessage;
   import com.yiTian.net.message.cg.WorldBossCGMessage;
   import com.yiTian.net.message.cg.WulinPartyCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.NpcPanel;
   import com.yiTian.view.comp.SceneWords;
   import com.yiTian.view.modules.KFHomeland.HomeSpecialMall;
   import com.yiTian.view.modules.banhui.shenshou.ShenShouPaiHang;
   import com.yiTian.view.modules.collect.View_collect;
   import com.yiTian.view.modules.crossCampBattle.Model_CrossCampBattle;
   import com.yiTian.view.modules.crossCampBattle.View_CrossCampBattleInfoPanel;
   import com.yiTian.view.modules.crossClanBattle.Enum_CrossClanBattle;
   import com.yiTian.view.modules.crossClanBattle.Model_CrossClanBattle;
   import com.yiTian.view.modules.keJu.KejuHandler;
   import com.yiTian.view.modules.marriage.Model_Marriage;
   import com.yiTian.view.modules.newerGuide.Model_newer;
   import com.yiTian.view.modules.qiJu.QijuBoss_Blood;
   import com.yiTian.view.modules.qingMing.Model_QingMing;
   import com.yiTian.view.modules.worldBoss.WorldBossUtil;
   import com.yiTian.view.modules.wulinduobao.BaoXiang;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class Npc extends Role
   {
      
      private static var _curPoint:Point;
      
      private static var _collectView:View_collect;
      
      public static const NAME:int = 0;
      
      public static const NPC_TYPE:int = 1;
      
      public static const ATTACK_MODE:int = 2;
      
      public static const ABILITY:int = 3;
      
      public static const BODY:int = 4;
      
      public static const HEAD:int = 5;
      
      public static const DIALOG:int = 6;
      
      public static const EXP:int = 7;
      
      public static const DROP_MONEY:int = 8;
      
      public static const DROP_ITEM:int = 9;
      
      public static const SPEED:int = 10;
      
      public static const ZC_ROUND:int = 11;
      
      public static const JJ_ROUND:int = 12;
      
      public static const REFRESH_TIME:int = 13;
      
      public static const MONSTER_LIST:int = 14;
      
      public static const RANDOM_MONSTER_LIST:int = 15;
      
      public static const SAY_LIST:int = 16;
      
      public static const ZHENG_FA:int = 17;
      
      public static const YUE_LI:int = 18;
      
      public static const OFFICIAL:int = 19;
      
      public static const NAME_HEIGHT:int = 20;
      
      public static const STAND_TIME:int = 21;
      
      public static var list:Dictionary = new Dictionary();
      
      public static var pool:Array = [];
      
      private static var VEC_HP_XY:Vector.<Point> = new <Point>[new Point(-50,-200),new Point(-50,-200),new Point(-50,-200)];
      
      private static var VEC_BACK_WID:Vector.<int> = new <int>[200,281,316];
      
      private static var VEC_HP_WID:Vector.<int> = new <int>[168,241,276];
      
      private static var VEC_HP_HEI:Vector.<int> = new <int>[12,16,21];
      
      private static var VEC_HP_WID2:Vector.<int> = new <int>[17,20,23];
      
      private static var VEC_HP_HEI2:Vector.<int> = new <int>[3,4,5];
      
      private static var VEC_TXT_Y:Vector.<int> = new <int>[-3,0,5];
      
      private static var num:int = 5;
      
      public var sysId:int;
      
      public var npcType:int;
      
      public var ability:Array;
      
      public var jierenwu:Effect;
      
      public var jiaorenwu:Effect;
      
      private var qiJuBlood:QijuBoss_Blood;
      
      private var xinYueBmp:Bitmap;
      
      private var bmBack:Bitmap;
      
      private var mask1:Shape;
      
      private var bmHP1:Bitmap;
      
      private var bmHP2:Bitmap;
      
      private var txtHP:MyTextField;
      
      private var times:int;
      
      private var _mode:int;
      
      private var tfBitmap:Bitmap;
      
      private var tfSprite:Sprite;
      
      private var btnBit:Bitmap;
      
      private var btnSpr:Sprite;
      
      private var _lastShake:int;
      
      private var _waiteTime:int;
      
      public var countdownTime:int;
      
      public var resourceMineCollecting:Boolean;
      
      public var guardId:Number;
      
      public var resourceTowerStatus:int;
      
      public var whichOccupieyTower:int;
      
      private var guardBtn:Button;
      
      private var attackBtn:Button;
      
      private var txt:MyTextField;
      
      private var guangQuan:Bitmap;
      
      private var campCarEffect:Effect;
      
      public function Npc()
      {
         super();
      }
      
      public static function getNpcBySysid(sysid:int) : Npc
      {
         var npc:Npc = null;
         for each(npc in list)
         {
            if(Boolean(npc) && npc.sysId == sysid)
            {
               return npc;
            }
         }
         return null;
      }
      
      public static function getBangHuiNpc(sysid:int) : Npc
      {
         var npc:Npc = null;
         for each(npc in list)
         {
            if(Boolean(npc))
            {
               if(npc.sysId == sysid)
               {
                  if(npc.sysId != Enum_NPC_ID.BANGHUI_XIGUA)
                  {
                     return npc;
                  }
                  if(npc.mode == 1)
                  {
                     return npc;
                  }
               }
            }
         }
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("931",0));
         return null;
      }
      
      public static function playEff(type:int) : void
      {
      }
      
      public static function refreshQuestIcon() : void
      {
         var npc:Npc = null;
         for each(npc in list)
         {
            if(Boolean(npc))
            {
               npc.setQuestIcon();
            }
         }
      }
      
      public static function getNearestMonster() : void
      {
         var step:Vo_questStep = null;
         var tempNpc:Npc = null;
         var tempLen:int = 0;
         var npc:Npc = null;
         var len:int = 0;
         var a:Number = NaN;
         var rot:int = 0;
         if(!Model_quest.curMainQ)
         {
            return;
         }
         if(Model_quest.curMainQ.status == 0)
         {
            step = Model_quest.curMainQ.continueStep[Model_quest.curMainQ.step - 1];
            if(step.stepType == Enum_quest_step_type.TONG_GUAN && Global.sceneID == step.mapId && step.mapId != 13102)
            {
               tempLen = 0;
               for each(npc in list)
               {
                  if(Boolean(npc) && Enum_npc_type.canBattle(npc.npcType))
                  {
                     len = Util.dist(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y,npc.global_x,npc.global_y);
                     if(len < tempLen || tempLen == 0)
                     {
                        tempNpc = npc;
                        tempLen = len;
                     }
                  }
               }
               if(Boolean(tempNpc))
               {
                  QuestGuiManager.addKuang(null,-35,-120,70,150);
                  a = Math.atan2(npc.global_y - GameUnitManager.hero.global_y,npc.global_x - GameUnitManager.hero.global_x);
                  rot = a * 180 / Math.PI;
                  QuestGuiManager.addJian(tempNpc,0,-35,rot);
               }
            }
         }
      }
      
      public static function setCollectViewLabel(label:String) : void
      {
         if(!_collectView)
         {
            _collectView = new View_collect();
            _collectView.y = -180;
         }
         _collectView.label = label;
      }
      
      public function init(objId:Number, sysId:Number, GlobalX:int, GlobalY:int, Hp:int, Hp_max:int, Mp:int, Mp_max:int, Direction:int, route:Array, buffer:Array) : void
      {
         var dest:int = 0;
         id = objId;
         this.sysId = sysId;
         type = UnitType.NPC;
         var _npc:Array = Data_lib.npc[sysId];
         this.npcType = _npc[NPC_TYPE];
         name = _npc[NAME];
         head = _npc[HEAD];
         standTime = _npc[STAND_TIME];
         global_x = GlobalX;
         global_y = GlobalY;
         this.speed = 100;
         if(sysId == 52910)
         {
            if(!this.xinYueBmp)
            {
               this.xinYueBmp = Utils.getLoadBitmap("resource/image/vip/vip_F.png",new Bitmap(),{
                  "x":nameBar.x - 27,
                  "y":-184
               });
            }
            else
            {
               Utils.getLoadBitmap("resource/image/vip/vip_F.png",this.xinYueBmp,{
                  "x":nameBar.x - 27,
                  "y":-184
               });
            }
            addChild(this.xinYueBmp);
         }
         hp = Hp;
         hpMax = Hp_max;
         mp = Mp;
         mpMax = Mp_max;
         this.ability = Boolean(_npc[ABILITY]) ? String(_npc[ABILITY]).split(",") : [];
         official = _npc[OFFICIAL];
         nameBar.y = _npc[NAME_HEIGHT] * -1;
         if(this.npcType != Enum_npc_type.COLLECT_NPC)
         {
            setShadow(Status.NOMAL,11);
         }
         setBody(Status.NOMAL,_npc[BODY]);
         if(sysId >= 56981 && sysId <= 57061)
         {
            Direction = 6;
         }
         way = Direction;
         status = Status.NOMAL;
         action = Action.STAND;
         if(Hp > 0)
         {
            state = State.LIFE;
         }
         else
         {
            state = State.DEAD;
         }
         this.setQuestIcon();
         if(ShenShouPaiHang.isShenShouPNC(sysId))
         {
            this.setShenShouHP(true);
         }
         if(QiJuHandler.isQiju_Boss(this.npcType))
         {
            this.setQiJuHP(true);
         }
         if(SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE && Model_CrossCampBattle.isHuangqi(sysId) == true)
         {
            this.setCampCrystal(hp,hpMax);
         }
         this._lastShake = getTimer() - Util.rnd(0,1200);
         this._waiteTime = 1500;
         if(sysId == GameUnitManager.hero.autoMoveID && GameUnitManager.hero.autoMoveType == UnitType.NPC)
         {
            dest = Utils.dist(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y,global_x,global_y);
            if(dest <= Global.constlockLength + Global.constlockLengAdd)
            {
               this.interaction(2);
               return;
            }
            GameUnitManager.hero.lockLength = Global.constlockLength;
            GameUnitManager.hero.lockTarget = this;
         }
         if(Global.isInHome)
         {
            this.setBtn();
         }
      }
      
      private function setCampCrystal(hp:int, hpMax:int) : void
      {
         var npc:Npc = null;
         var timeOut:int = 0;
         npc = this;
         timeOut = int(setTimeout(function():void
         {
            npc.way = 4;
            if(Model_CrossCampBattle.isHuangqi(npc.sysId) == true)
            {
               npc.setQiJuHP(true);
               View_CrossCampBattleInfoPanel.instance.updateNpcHp(npc);
               npc.nameBar.x = -20;
            }
            clearTimeout(timeOut);
         },500));
      }
      
      public function setQiJuHP(value:Boolean) : void
      {
         if(value)
         {
            if(!this.qiJuBlood)
            {
               this.qiJuBlood = new QijuBoss_Blood();
               addChild(this.qiJuBlood);
            }
            if(this.sysId == Enum_CrossClanBattle.CRYSTAL_NPCID)
            {
               ComponentUtil.setPropertie(this.qiJuBlood,{
                  "x":-50 - 90,
                  "y":-270
               });
            }
            else if(Model_CrossCampBattle.isHuangqi(this.sysId) == true)
            {
               ComponentUtil.setPropertie(this.qiJuBlood,{
                  "x":-70 - 90,
                  "y":-480
               });
            }
            else
            {
               ComponentUtil.setPropertie(this.qiJuBlood,{
                  "x":-50 - 90,
                  "y":-200
               });
               Model_QiJu.qiJuBoss = this;
            }
         }
         else
         {
            Model_QiJu.qiJuBoss = null;
            if(Boolean(this.qiJuBlood) && Boolean(this.qiJuBlood.parent))
            {
               removeChild(this.qiJuBlood);
               this.qiJuBlood = null;
            }
         }
      }
      
      public function upDataQiJuHP(nowBlood:Number, countBlood:Number) : void
      {
         if(Boolean(this.qiJuBlood))
         {
            this.qiJuBlood.upData(nowBlood,countBlood);
         }
      }
      
      public function setShenShouHP(value:Boolean) : void
      {
         var ind:int = 0;
         if(value)
         {
            way = 4;
            ind = ShenShouPaiHang.vecShenShouName.indexOf(name);
            this.parts.scaleX = -ShenShouPaiHang.vecShenShouSize[ind];
            this.parts.scaleY = ShenShouPaiHang.vecShenShouSize[ind];
            if(!this.txtHP)
            {
               this.bmBack = new Bitmap();
               addChild(this.bmBack);
               this.bmBack.x = VEC_HP_XY[ind].x;
               this.bmBack.y = VEC_HP_XY[ind].y;
               Utils.getLoadBitmap("resource/image/bang/b_" + ind + ".png",this.bmBack);
               this.bmHP2 = new Bitmap();
               addChild(this.bmHP2);
               Utils.getLoadBitmap("resource/image/bang/p_" + ind + "_" + "3.png",this.bmHP2);
               this.bmHP2.x = VEC_HP_XY[ind].x + VEC_HP_WID2[ind];
               this.bmHP2.y = VEC_HP_XY[ind].y + VEC_HP_HEI2[ind];
               this.bmHP1 = new Bitmap();
               addChild(this.bmHP1);
               Utils.getLoadBitmap("resource/image/bang/p_" + ind + "_" + "4.png",this.bmHP1);
               this.bmHP1.x = VEC_HP_XY[ind].x + VEC_HP_WID2[ind];
               this.bmHP1.y = VEC_HP_XY[ind].y + VEC_HP_HEI2[ind];
               this.mask1 = ComponentUtil.getShape(VEC_HP_WID[ind],VEC_HP_HEI[ind],16777215,1);
               addChild(this.mask1);
               this.mask1.x = this.bmHP1.x;
               this.mask1.y = this.bmHP1.y;
               this.bmHP1.mask = this.mask1;
               this.txtHP = ComponentUtil.getTextField("10000000000/10000000000",this,{
                  "x":this.bmHP1.x,
                  "y":this.bmHP1.y + VEC_TXT_Y[ind],
                  "align":TextFormatAlign.CENTER,
                  "realWidth":VEC_HP_WID[ind]
               });
               this.times = 0;
            }
            ShenShouPaiHang.shenShouNpc = this;
         }
         else
         {
            ShenShouPaiHang.shenShouNpc = null;
            if(Boolean(this.bmBack) && contains(this.bmBack))
            {
               removeChild(this.bmBack);
               this.bmBack = null;
            }
            if(Boolean(this.bmHP1) && contains(this.bmHP1))
            {
               removeChild(this.bmHP1);
               this.bmHP1 = null;
            }
            if(Boolean(this.bmHP2) && contains(this.bmHP2))
            {
               removeChild(this.bmHP2);
               this.bmHP2 = null;
            }
            if(Boolean(this.mask1) && contains(this.mask1))
            {
               removeChild(this.mask1);
               this.mask1 = null;
            }
            if(Boolean(this.txtHP) && contains(this.txtHP))
            {
               removeChild(this.txtHP);
               this.txtHP = null;
            }
            var _temp_6:* = this.parts;
            this.parts.scaleY = 1;
            _temp_6.scaleX = 1;
            if(Boolean(CollectManager.npc) && CollectManager.npc.id == this.id)
            {
               CollectManager.end();
            }
         }
      }
      
      public function updateShenShouHP(curHPStr:String, maxHPStr:String) : void
      {
         var word:SceneWords = null;
         if(this.txtHP == null)
         {
            return;
         }
         var curHP:Number = Number(curHPStr);
         var maxHP:Number = Number(maxHPStr);
         var num1:Number = maxHP / num;
         var num2:int = curHP / num1;
         var num3:Number = curHP % num1 / num1;
         var ind:int = ShenShouPaiHang.vecShenShouName.indexOf(name);
         this.txtHP.text = curHP + "/" + maxHP;
         if(num2 >= num)
         {
            return;
         }
         if(Boolean(num2))
         {
            this.bmHP2.visible = true;
            Utils.getLoadBitmap("resource/image/bang/p_" + ind + "_" + num2 + ".png",this.bmHP1);
            Utils.getLoadBitmap("resource/image/bang/p_" + ind + "_" + (num2 - 1) + ".png",this.bmHP2);
         }
         else
         {
            this.bmHP2.visible = false;
            Utils.getLoadBitmap("resource/image/bang/p_" + ind + "_" + num2 + ".png",this.bmHP1);
         }
         if(this.mask1.width > VEC_HP_WID[ind] * num3)
         {
            Tween.to(this.mask1,500,{"width":[this.mask1.width,VEC_HP_WID[ind] * num3]});
         }
         else
         {
            Tween.to(this.mask1,500,{"width":[VEC_HP_WID[ind],VEC_HP_WID[ind] * num3]});
         }
         if(curHP <= maxHP * 0.2 && this.times == 0 || curHP <= maxHP * 0.1 && this.times == 1)
         {
            ++this.times;
            word = SceneWords.getWord();
            word.text = LangConfig.getWord("30066",3);
            word.show(new Point(-word.width / 2,ShenShouPaiHang.shenShouNpc.nameBar.y - word.height),ShenShouPaiHang.shenShouNpc);
         }
      }
      
      public function init_bang(objId:Number, mode:int) : void
      {
         id = objId;
         this.sysId = Enum_NPC_ID.BANGHUI_XIGUA;
         this.mode = mode;
         type = UnitType.NPC;
         global_x = Data_lib.Watermelon[objId][0];
         global_y = Data_lib.Watermelon[objId][1];
         var _npc:Array = Data_lib.Watermelon[objId];
         this.npcType = Enum_npc_type.BANGPLANT;
         status = Status.NOMAL;
         action = Action.STAND;
         state = State.FLOOR;
      }
      
      public function set mode(value:int) : void
      {
         this._mode = value;
         if(this._mode == 0)
         {
            visible = false;
            return;
         }
         nameBar.y = this._mode == 1 ? -50 : -25;
         visible = true;
         var avater:int = 51086 + this._mode;
         setBody(status,avater);
         this.setQuestIcon();
      }
      
      public function get mode() : int
      {
         return this._mode;
      }
      
      public function beginCollect(str:String, type:int) : void
      {
         CollectManager.begin(this,5000,function():void
         {
            if(type == 1)
            {
               BangCGMessage.CG_BANG_PLANT_CHUCHONG(2,id);
            }
            else
            {
               BangCGMessage.CG_BANG_PLANT_CAIJI(3,id);
            }
         },null,str);
      }
      
      public function beginCrossClanCollect(str:String, type:int) : void
      {
         CollectManager.begin(this,10000,function():void
         {
            CrossClanBattleCGMessage.CG_RESOURCE_TOWER(Enum_CrossClanBattle.COLLECT_FINISH,id);
         },null,str);
      }
      
      override public function interaction(mode:int = 0) : void
      {
         Global.control.sendNotification(Enum_MsgType.NPC_INTERACTION,this);
         if(Model_newer.isRunning)
         {
            Model_newer.step = 2;
            Model_newer.newerHandle();
            return;
         }
         var st:int = SceneConfig.getSceneType();
         if(st == SceneConfig.GMD)
         {
            return;
         }
         if(st == SceneConfig.WORLDBOSS)
         {
            if(this.npcType == Enum_npc_type.WORLDBOSS)
            {
               if(WorldBossUtil.checkStart())
               {
                  WorldBossCGMessage.CG_WB_CHALLENGE();
               }
               else
               {
                  UIManager.centerBroadcast.addMsg("现在还准备阶段，不能进行挑战，请稍等片刻");
               }
               return;
            }
            CollectManager.begin(this,10000);
            WorldBossCGMessage.CG_WB_COLLECT(id,1);
            return;
         }
         var status:int = GameUnitManager.hero.status;
         if(this.npcType == Enum_npc_type.GHOST)
         {
            Model_QingMing.catchGhost(this.id);
            return;
         }
         if(this.sysId >= 56953 && this.sysId <= 56956)
         {
            if(Model_Marriage.curMarriageInfo != null)
            {
               if(GameUnitManager.hero.id == Model_Marriage.curMarriageInfo.maleID || GameUnitManager.hero.id == Model_Marriage.curMarriageInfo.femaleID)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("29287",2));
               }
               else
               {
                  CollectManager.begin(this);
                  MarriageCGMessage.CG_MARRIAGE_COLLECT_BEGIN(1,id);
               }
               return;
            }
            Model_Marriage.showAlert(29);
            return;
         }
         if(QiJuHandler.isQiju_Npc(this.npcType))
         {
            QiJuCGMessage.CG_QIJU_FIGHT(id,this.sysId);
            return;
         }
         if(QiJuHandler.isQiju_Chest(this.npcType))
         {
            QiJuCGMessage.CG_GET_QIJU_CHEST(id,this.sysId);
            return;
         }
         if(this.npcType == Enum_npc_type.christmas_snowman)
         {
            ChristmasCGMessage.cg_christmas_request_collect(id,this.global_x,this.global_y);
            return;
         }
         if(this.sysId >= 56957 && this.sysId <= 56976)
         {
            if(KejuHandler.canColl)
            {
               if(Model_KeJu.poemsIndexArr.length >= 20)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("80033",8));
                  return;
               }
               KejuCGMessage.CG_CATCHICE(this.sysId);
               KejuHandler.changColl();
            }
            return;
         }
         if(this.npcType == Enum_npc_type.BANGPLANT)
         {
            Model_npc._npc = this;
            if(this._mode == 1)
            {
               BangCGMessage.CG_BANG_PLANT_CHUCHONG(1,id);
            }
            else
            {
               BangCGMessage.CG_BANG_PLANT_CAIJI(1,id);
            }
            return;
         }
         if(status == Status.SIT || status == Status.FISH)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10541",1));
            return;
         }
         if(GameUnitManager.hero.captainId != 0 && Boolean(GameUnitManager.hero.teamPosition))
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10541",1));
            return;
         }
         if(st == SceneConfig.BZ_BATTLE)
         {
            if(this.npcType == Enum_npc_type.BANGCOLLECT)
            {
               BangBattleCGMessage.CG_COLLECT_JK(id,this.sysId);
               return;
            }
            if(this.npcType == Enum_npc_type.BANG_DEFENDER)
            {
               UIManager.npcDialog.show(this);
               return;
            }
            BangBattleCGMessage.CG_QUEST_BANG_BATTLE(2,id,this.sysId);
            return;
         }
         if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE)
         {
            Model_CrossClanBattle.removeAttack(this);
            Model_CrossClanBattle.dealNpc(this.sysId,this);
            return;
         }
         if(SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            Model_CrossCampBattle.dealNpc(this.sysId,this);
            return;
         }
         if(this.sysId == ShenShouPaiHang.qiuYaoBaoXiang)
         {
            ShenshouCGMessage.CG_SSBX_BEGIN_COLLECT(id);
            return;
         }
         if(ShenShouPaiHang.isShenShouPNC(this.sysId))
         {
            ShenshouCGMessage.CG_GONG_JI_SHENSHOU(id);
            return;
         }
         if(ShenShouPaiHang.vecTianMing.indexOf(this.sysId) >= 0)
         {
            ShenshouCGMessage.CG_SSBX_BEGIN_COLLECT(id);
            return;
         }
         if(GameUnitManager.hero.lockTarget == this)
         {
            GameUnitManager.hero.lockTarget = null;
            GameUnitManager.hero.autoMoveID = -1;
            GameUnitManager.hero.autoMoveType = -1;
         }
         if(Enum_npc_type.canBattle(this.npcType))
         {
            BattleCGMessage.CG_BATTLE(id,UnitType.NPC,this.sysId);
         }
         else if(this.npcType == Enum_npc_type.COLLECT_NPC)
         {
            GameUnitManager.hero.go(this.global_x,this.global_y);
            CollectManager.begin(this);
         }
         else if(this.npcType == Enum_npc_type.WULIN_ITEM)
         {
            WulinPartyCGMessage.CG_WULINF_BUFF(id,UnitType.NPC,this.sysId);
            _curPoint = new Point(this.global_x - CameraManager.sightX - 34,this.global_y - CameraManager.sightY - 34);
         }
         else if(this.npcType == Enum_npc_type.BAO_XIANG)
         {
            BaoXiang.collectBX(this.sysId);
         }
         else if(this.npcType == Enum_npc_type.HuaDeng)
         {
            if(GameUnitManager.hero.level < 30)
            {
               UIManager.centerBroadcast.addMsg("等级达到30级才可以参与");
            }
            else
            {
               CaiDengMiCGMessage.CG_CaiDengMi_OPEN();
            }
         }
         else
         {
            UIManager.npcDialog.show(this);
         }
      }
      
      public function setTitle(bmd:BitmapData) : void
      {
         if(this.sysId >= 56957 && this.sysId <= 56976)
         {
            if(Boolean(this.tfBitmap))
            {
               return;
            }
            this.tfBitmap = new Bitmap(bmd);
            this.tfBitmap.transform.colorTransform = Enum_KeJu.COLOR;
            this.tfSprite = new Sprite();
            this.tfSprite.addChild(this.tfBitmap);
            addChild(this.tfSprite);
            this.tfSprite.x = -50;
            this.tfSprite.y = -100;
            this.tfSprite.filters = Util.glowBig000000;
         }
      }
      
      public function setBtn() : void
      {
         if(Global.isInHome && this.sysId == Enum_npc_type.HOMENPCSYSID && SceneConfig.getSceneType() == SceneConfig.HOME)
         {
            if(Boolean(this.btnBit))
            {
               return;
            }
            this.btnBit = new Bitmap();
            Utils.getLoadBitmap("resource/image/exBtn/HomeMall.png",this.btnBit,{
               "x":0,
               "y":0
            });
            this.btnSpr = new Sprite();
            addChild(this.btnSpr);
            this.btnSpr.addChild(this.btnBit);
            this.btnSpr.x = -22;
            this.btnSpr.y = -154;
            this.btnSpr.addEventListener(MouseEvent.CLICK,this.homeMallClkHandel);
         }
      }
      
      private function homeMallClkHandel(evt:MouseEvent = null) : void
      {
         HomeSpecialMall.instance.visible = !HomeSpecialMall.instance.visible;
      }
      
      private function setQuestIcon() : void
      {
         var quest:Vo_quest = null;
         if(Enum_npc_type.canBattle(this.npcType))
         {
            return;
         }
         if(Boolean(this.jierenwu) && contains(this.jierenwu))
         {
            removeEffect(this.jierenwu);
         }
         if(Boolean(this.jiaorenwu) && contains(this.jiaorenwu))
         {
            removeEffect(this.jiaorenwu);
         }
         for each(quest in Model_quest.accepted)
         {
            if(quest.type != Enum_quest_type.SPECIAL)
            {
               if(quest.status == 0 && (quest.continueStep[quest.step - 1] as Vo_questStep).npcId == this.sysId)
               {
                  if(this.sysId == Enum_NPC_ID.BANGHUI_XIGUA)
                  {
                     if(this._mode != 1)
                     {
                        return;
                     }
                  }
                  this.jiaorenwu = addEffect("35008",true,0,nameBar.y - 35,1200);
                  return;
               }
               if(Boolean(quest.status > 0) && Boolean(quest.finishStep) && quest.finishStep.npcId == this.sysId)
               {
                  this.jiaorenwu = addEffect("35008",true,0,nameBar.y - 35,1200);
                  return;
               }
            }
         }
         for each(quest in Model_quest.canAccept)
         {
            if(Boolean(quest && quest.acceptStep) && Boolean(quest.acceptStep.npcId == this.sysId) && quest.accept_level <= GameUnitManager.hero.level)
            {
               this.jierenwu = addEffect("35006",true,0,nameBar.y - 35,1200);
               return;
            }
         }
      }
      
      public function set isCollect(value:Boolean) : void
      {
         var _p:Point = null;
         if(value)
         {
            if(!_collectView)
            {
               _collectView = new View_collect();
            }
            GameScene.popupLayer.addChild(_collectView);
            _p = localToGlobal(new Point(0,-180));
            _collectView.y = _p.y;
            _collectView.x = _p.x;
            _collectView.reset();
         }
         else if(Boolean(_collectView))
         {
            GameScene.popupLayer.removeChild(_collectView);
         }
      }
      
      public function updateCollectPro(rate:Number) : void
      {
         _collectView.update(rate);
      }
      
      private function shake(now:int) : void
      {
         if(GuideManager.isPlaying)
         {
            return;
         }
         if(!Enum_npc_type.needShake(this.npcType))
         {
            return;
         }
         if(now - this._lastShake < this._waiteTime)
         {
            return;
         }
         this._lastShake = now;
         if(action == Action.STAND)
         {
            action = Action.SHAKE;
            this._waiteTime = 900;
         }
         else if(action == Action.SHAKE)
         {
            action = Action.STAND;
            this._waiteTime = 1500;
         }
      }
      
      override public function update(now:int) : void
      {
         super.update(now);
         this.shake(now);
      }
      
      override public function show() : void
      {
         super.show();
         list[id] = this;
         getNearestMonster();
         if(this.npcType == Enum_npc_type.BANGPLANT && this._mode == 0)
         {
            visible = false;
         }
      }
      
      override public function align() : void
      {
         super.align();
         if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE || SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            this.alpha = 1;
            this.state = State.FLOOR;
         }
      }
      
      override public function mouseOver() : void
      {
         super.mouseOver();
         if(SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            if(Model_CrossCampBattle.selfWarCarArr.indexOf(this.id) != -1)
            {
               return;
            }
         }
         if(Enum_npc_type.canBattle(this.npcType) || this.npcType == Enum_npc_type.SHEN_SHOU_NPC || this.npcType == Enum_npc_type.CROSS_MONSTER)
         {
            CursorManager.show(Enum_CursorType.MONSTER);
         }
         else if(Enum_npc_type.canDialog(this.npcType) || this.npcType == Enum_npc_type.HuaDeng)
         {
            CursorManager.show(Enum_CursorType.FUN_NPC);
         }
         else if(Enum_npc_type.canCaiji(this.npcType) || this.npcType == Enum_npc_type.SHEN_SHOU)
         {
            CursorManager.show(Enum_CursorType.CAIJI);
         }
         else if(this.npcType == Enum_npc_type.WULIN_ITEM)
         {
            CursorManager.show(Enum_CursorType.PICKUP);
         }
         else if(this.npcType == Enum_npc_type.BANGPLANT)
         {
            CursorManager.show(Enum_CursorType.PICKUP);
         }
         else if(this.npcType == Enum_npc_type.ELITE_MONSTER)
         {
            CursorManager.show(Enum_CursorType.FUN_NPC);
         }
         else if(this.npcType == Enum_npc_type.KEY || this.npcType == Enum_npc_type.QIJU_CHEST)
         {
            CursorManager.show(Enum_CursorType.KEY);
         }
      }
      
      override public function mouseOut() : void
      {
         super.mouseOut();
         CursorManager.hide();
      }
      
      public function showGuardOrAttack(type:int, value:Boolean, callBack:Function) : void
      {
         if(type == Enum_CrossClanBattle.BTN_GUARD)
         {
            this.guardBtn = this.dealBtn(value,this.guardBtn,"Button_Two","守护",callBack);
         }
         else
         {
            this.attackBtn = this.dealBtn(value,this.attackBtn,"Button_Two","攻击",callBack);
         }
      }
      
      private function dealBtn(value:Boolean, btn:Button, url:String, name:String, callBack:Function) : Button
      {
         if(value == true)
         {
            if(!btn)
            {
               btn = ComponentUtil.getButton(name,url,GameScene.downUILayer,{
                  "x":this.x - 8 - CameraManager.sightX,
                  "y":this.y - 75 - CameraManager.sightY,
                  "textColor":16771436
               },Global.Img_Cdm);
               btn.addEventListener(MouseEvent.MOUSE_DOWN,callBack);
            }
         }
         else if(Boolean(btn) && btn.parent.contains(btn))
         {
            btn.parent.removeChild(btn);
            btn.removeEventListener(MouseEvent.MOUSE_DOWN,callBack);
            btn = null;
         }
         return btn;
      }
      
      public function updateBtnXY() : void
      {
         if(Boolean(this.guardBtn))
         {
            this.guardBtn.x = this.x - 8 - CameraManager.sightX;
            this.guardBtn.y = this.y - 75 - CameraManager.sightY;
         }
         if(Boolean(this.attackBtn))
         {
            this.attackBtn.x = this.x - 8 - CameraManager.sightX;
            this.attackBtn.y = this.y - 75 - CameraManager.sightY;
         }
      }
      
      public function showCountCownText(time:int) : void
      {
         var lastTime:uint = 0;
         var frameStep:Function = null;
         frameStep = function():void
         {
            var now:uint = uint(getTimer());
            if(now - lastTime > 1000)
            {
               if(countdownTime <= 0)
               {
                  if(Boolean(txt) && Boolean(txt.parent))
                  {
                     txt.parent.removeChild(txt);
                     txt = null;
                  }
                  Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,frameStep);
               }
               --countdownTime;
               if(Boolean(txt))
               {
                  txt.htmlText = countdownTime <= 0 ? "" : countdownTime + "";
               }
               lastTime = now;
            }
         };
         this.countdownTime = time;
         lastTime = uint(getTimer());
         if(!this.txt)
         {
            this.txt = ComponentUtil.getTextField("帮会中文名称.S000",null,{
               "x":1,
               "y":10,
               "color":16043313,
               "size":24,
               "leading":0,
               "bold":true
            });
            nameBar.addChild(this.txt);
         }
         this.txt.htmlText = this.countdownTime + "";
         if(Global.control.hasCallBack(Enum_MsgType.MSG_ENTERFRAME,frameStep) == false)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,frameStep);
         }
      }
      
      public function showGuardRange(value:Boolean) : void
      {
         if(value == true)
         {
            if(!this.guangQuan)
            {
               this.guangQuan = Utils.getLoadBitmap("resource/image/kuafubangzhan/guard.png",this.guangQuan,{
                  "x":-210,
                  "y":-263
               });
               addChild(this.guangQuan);
            }
         }
         else if(Boolean(this.guangQuan) && Boolean(this.guangQuan.parent) && this.guangQuan.parent.contains(this.guangQuan))
         {
            this.guangQuan.parent.removeChild(this.guangQuan);
            this.guangQuan = null;
         }
      }
      
      public function addCampCarEff() : void
      {
         if(!this.campCarEffect)
         {
            this.campCarEffect = addEffect("35312",true,50,-105,600);
         }
      }
      
      public function removeCampCarEffect() : void
      {
         if(Boolean(this.campCarEffect))
         {
            removeEffect(this.campCarEffect);
            this.campCarEffect = null;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(Enum_npc_type.canBattle(this.npcType))
         {
            UIManager.smallMap.delPoint(id);
         }
         if(this.sysId >= 56957 && this.sysId <= 56976)
         {
            if(Boolean(this.tfSprite))
            {
               if(Boolean(this.tfSprite.parent))
               {
                  this.tfBitmap = null;
                  this.removeChild(this.tfSprite);
                  this.tfSprite = null;
               }
            }
         }
         if(ShenShouPaiHang.isShenShouPNC(this.sysId))
         {
            this.setShenShouHP(false);
         }
         if(QiJuHandler.isQiju_Boss(this.npcType))
         {
            this.setQiJuHP(false);
         }
         if(Boolean(CollectManager.npc) && Boolean(CollectManager.isCollecting) && CollectManager.npc == this)
         {
            CollectManager.end();
         }
         if(Boolean(this.jierenwu) && contains(this.jierenwu))
         {
            removeEffect(this.jierenwu);
         }
         if(Boolean(this.jiaorenwu) && contains(this.jiaorenwu))
         {
            removeEffect(this.jiaorenwu);
         }
         if(Boolean(this.xinYueBmp))
         {
            this.xinYueBmp.bitmapData = null;
            if(contains(this.xinYueBmp))
            {
               removeChild(this.xinYueBmp);
            }
         }
         NpcPanel.checkVisible(this);
         delete list[id];
         pool.push(this);
         BaoXiang.reqHideCB(false);
         getNearestMonster();
         if(Model_CrossClanBattle.isClanBattleNpc(this.sysId) == true)
         {
            Model_CrossClanBattle.removeGuard(this);
            Model_CrossClanBattle.removeAttack(this);
            this.showGuardRange(false);
            this.setQiJuHP(false);
            this.guardId = 0;
         }
         if(Model_CrossCampBattle.isHuangqi(this.sysId) == true)
         {
            this.setQiJuHP(false);
         }
         if(Boolean(this.btnBit))
         {
            if(Boolean(this.btnBit.parent) && this.btnBit.parent.contains(this.btnBit))
            {
               this.btnBit.parent.removeChild(this.btnBit);
            }
            this.btnBit.visible = false;
         }
         if(Boolean(this.btnSpr))
         {
            this.btnSpr.removeEventListener(MouseEvent.CLICK,this.homeMallClkHandel);
            if(this.contains(this.btnSpr))
            {
               this.removeChild(this.btnSpr);
            }
            this.btnSpr.visible = false;
         }
         this.btnBit = null;
         this.btnSpr = null;
         this.removeCampCarEffect();
      }
   }
}

