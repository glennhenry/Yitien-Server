package com.yiTian.scene
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.TabButton;
   import com.ui.controls.TextInput;
   import com.utils.ColorConstant;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_bar_swap;
   import com.yiTian.data.config.Enum_map_lib;
   import com.yiTian.data.config.Enum_scene_type;
   import com.yiTian.data.config.guide.Enum_guide_tonggun;
   import com.yiTian.data.model.Model_KuaFuPaiDui;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.data.model.Model_initStr;
   import com.yiTian.data.model.Model_tiliStore;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.config.State;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.role.Door;
   import com.yiTian.gameUnit.role.Hero;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.gameUnit.role.Player;
   import com.yiTian.gameUnit.role.Role;
   import com.yiTian.manager.BattleManager;
   import com.yiTian.manager.BattleUnitManager;
   import com.yiTian.manager.CameraManager;
   import com.yiTian.manager.CountStandTimeManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.GuideManager;
   import com.yiTian.manager.KeyboardManager;
   import com.yiTian.manager.LoadManager;
   import com.yiTian.manager.MapManager;
   import com.yiTian.manager.MusicManager;
   import com.yiTian.manager.QuestGuiManager;
   import com.yiTian.manager.ResourceManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BagCGMessage;
   import com.yiTian.net.message.cg.DepotCGMessage;
   import com.yiTian.net.message.cg.SceneCGMessage;
   import com.yiTian.net.message.cg.SkillCGMessage;
   import com.yiTian.utils.AStar;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.auto.HandupMgr;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.AiDeBaoBao.AiDeBaoBao_control;
   import com.yiTian.view.modules.AiDeBaoBao.View_AiDeBaoBao_findPartner;
   import com.yiTian.view.modules.battle.View_BattleLayer;
   import com.yiTian.view.modules.boatChall.BoatManager;
   import com.yiTian.view.modules.crossClanBattle.Model_CrossClanBattle;
   import com.yiTian.view.modules.enterScene.EnterSceneHd;
   import com.yiTian.view.modules.guide.View_guide;
   import com.yiTian.view.modules.guide.View_questGuiJian;
   import com.yiTian.view.modules.mainUIBtnContainer.View_mainUiBtn_container;
   import com.yiTian.view.modules.newerGuide.Model_newer;
   import com.yiTian.view.modules.panel.View_updata_panelTip;
   import com.yiTian.view.modules.ship.Ship;
   import com.yiTian.view.modules.skill.Model_skill;
   import com.yiTian.view.modules.tiliStore.View_tiliTip;
   import com.yiTian.view.modules.worldBoss.WorldBossUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.system.IME;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class GameScene extends IScene
   {
      
      public static var battleLayer:View_BattleLayer;
      
      public static var isEnterScene:Boolean;
      
      private static var _instance:GameScene;
      
      public static var homeScale:Number;
      
      private static var preSceneType:int;
      
      private static var goLayer:Sprite = new Sprite();
      
      public static var mapLayer:Sprite = new Sprite();
      
      public static var gridLayer:Sprite = new Sprite();
      
      public static var newGridLayer:Sprite = new Sprite();
      
      public static var mainLayer:Sprite = new Sprite();
      
      public static var downUILayer:Sprite = new Sprite();
      
      public static var downUIDisabledLayer:Sprite = new Sprite();
      
      public static var uiLayer:Sprite = new Sprite();
      
      public static var popupLayer:Sprite = new Sprite();
      
      public static var modalLayer:Sprite = new Sprite();
      
      public static var loadingLayer:Sprite = new Sprite();
      
      public static var sysLayer:Sprite = new Sprite();
      
      public static var upUILayer:Sprite = new Sprite();
      
      public static var scaleRate:Number = 1;
      
      public static var isFirstEnter:Boolean = true;
      
      public static var isBattleEnd:Boolean = false;
      
      private var oriWid:int;
      
      private var oriHei:int;
      
      private var sildScale:Number;
      
      private var sildBoo:Boolean = false;
      
      public var oriMaxSildX:Number;
      
      public var oriMaxSildY:Number;
      
      public var maxSildX:Number;
      
      public var maxSildY:Number;
      
      private var sildX:Number;
      
      private var sildY:Number;
      
      private var oriX:Number;
      
      private var oriY:Number;
      
      private var lastTime:int;
      
      public var preFrameTime:int;
      
      private var canGo:Boolean = true;
      
      private var inter:int;
      
      private var disCardType:int;
      
      public function GameScene()
      {
         super();
         addChild(goLayer);
         goLayer.addChild(mapLayer);
         goLayer.addChild(gridLayer);
         gridLayer.cacheAsBitmap = true;
         goLayer.addChild(newGridLayer);
         newGridLayer.cacheAsBitmap = true;
         mainLayer.mouseEnabled = false;
         mainLayer.mouseChildren = false;
         goLayer.addChild(mainLayer);
         addChild(downUILayer);
         addChild(downUIDisabledLayer);
         downUIDisabledLayer.mouseEnabled = false;
         downUIDisabledLayer.mouseChildren = false;
         addChild(uiLayer);
         addChild(popupLayer);
         addChild(modalLayer);
         battleLayer = new View_BattleLayer();
         addChild(battleLayer);
         addChild(loadingLayer);
         addChild(sysLayer);
         addChild(upUILayer);
         upUILayer.mouseEnabled = false;
         upUILayer.mouseChildren = false;
      }
      
      public static function get instance() : GameScene
      {
         if(!_instance)
         {
            _instance = new GameScene();
         }
         return _instance;
      }
      
      public static function get goLX() : Number
      {
         return goLayer.x;
      }
      
      public static function get goLY() : Number
      {
         return goLayer.y;
      }
      
      public function setGoLayerScale(boo:Boolean = true) : void
      {
         var w:Number = NaN;
         var h:Number = NaN;
         if(boo)
         {
            w = Global.stage.stageWidth;
            h = Global.stage.stageHeight;
            this.sildScale = int(Math.max(w / MapManager.mapInfo.width,h / MapManager.mapInfo.height) * 100) / 100;
            if(this.sildScale < 0.5)
            {
               this.sildScale = 0.5;
            }
            scaleRate = 1;
            homeScale = this.sildScale;
            this.sildBoo = false;
            Tween.to(goLayer,800,{
               "scaleX":[goLayer.scaleX,this.sildScale],
               "scaleY":[goLayer.scaleY,this.sildScale]
            },this.setScale,function():void
            {
               scaleRate = goLayer.scaleX;
               CameraManager.resetMapPosition(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y);
            });
            Tween.to(GameScene,800,{"scaleRate":[GameScene.scaleRate,this.sildScale]},function():void
            {
               CameraManager.resetMapPosition(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y);
               setScale();
            });
         }
         else
         {
            scaleRate = 1;
            Tween.to(goLayer,800,{
               "scaleX":[goLayer.scaleX,1],
               "scaleY":[goLayer.scaleY,1]
            },this.setScale,function():void
            {
               scaleRate = goLayer.scaleX;
               CameraManager.resetMapPosition(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y);
            });
            Tween.to(GameScene,800,{"scaleRate":[GameScene.scaleRate,1]},function():void
            {
               CameraManager.resetMapPosition(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y);
               setScale();
            });
         }
      }
      
      private function setScale() : void
      {
         if(!Global.isBuildHome)
         {
            goLayer.scaleX = 1;
            goLayer.scaleY = 1;
            goLayer.x = 0;
            goLayer.y = 0;
         }
         else
         {
            this.sildBoo = true;
            goLayer.scaleX = this.sildScale;
            goLayer.scaleY = this.sildScale;
         }
         Utils.print("sildScale    ",this.sildScale);
      }
      
      public function disSilding() : void
      {
         this.oriWid = MapManager.mapInfo.width;
         this.oriHei = MapManager.mapInfo.height;
         this.oriMaxSildX = this.oriWid * this.sildScale - Global.stage.stageWidth;
         this.oriMaxSildY = this.oriHei * this.sildScale - Global.stage.stageHeight;
      }
      
      public function onSilding(evt:MouseEvent) : void
      {
         this.maxSildX = this.oriMaxSildX - CameraManager.sightX;
         this.maxSildY = this.oriMaxSildY - CameraManager.sightY;
         if(this.maxSildX > 20 || this.maxSildX < 20)
         {
            if(evt.stageX < Global.stage.stageWidth / 6)
            {
               if(this.maxSildX > 0)
               {
                  if(goLayer.x + 60 >= 0)
                  {
                     this.sildX = 0;
                  }
                  else
                  {
                     this.sildX = goLayer.x + 60;
                  }
               }
               else if(goLayer.x - 60 <= -this.maxSildX)
               {
                  this.sildX = -this.maxSildX;
               }
               else
               {
                  this.sildX = goLayer.x - 60;
               }
            }
            if(evt.stageX > Global.stage.stageWidth * 5 / 6)
            {
               if(this.maxSildX > 0)
               {
                  if(goLayer.x - 60 <= -this.maxSildX)
                  {
                     this.sildX = -this.maxSildX;
                  }
                  else
                  {
                     this.sildX = goLayer.x - 60;
                  }
               }
               else if(goLayer.x + 60 >= 0)
               {
                  this.sildX = 0;
               }
               else
               {
                  this.sildX = goLayer.x + 60;
               }
            }
         }
         if(this.maxSildY > 20 || this.maxSildY < 20)
         {
            if(evt.stageY < Global.stage.stageHeight / 6)
            {
               if(this.maxSildY > 0)
               {
                  if(goLayer.y + 60 > 0)
                  {
                     this.sildY = 0;
                  }
                  else
                  {
                     this.sildY = goLayer.y + 60;
                  }
               }
               else if(goLayer.y - 60 < -this.maxSildY)
               {
                  this.sildY = -this.maxSildY;
               }
               else
               {
                  this.sildY = goLayer.y - 60;
               }
            }
            if(evt.stageY > Global.stage.stageHeight * 5 / 6)
            {
               if(this.maxSildY > 0)
               {
                  if(goLayer.y - 60 < -this.maxSildY)
                  {
                     this.sildY = -this.maxSildY;
                  }
                  else
                  {
                     this.sildY = goLayer.y - 60;
                  }
               }
               else if(goLayer.y + 60 > 0)
               {
                  this.sildY = 0;
               }
               else
               {
                  this.sildY = goLayer.y + 60;
               }
            }
         }
         this.oriX = goLayer.x;
         this.oriY = goLayer.y;
         Tween.to(goLayer,200,{
            "x":[this.oriX,this.sildX],
            "y":[this.oriY,this.sildY]
         });
      }
      
      public function endSilding() : void
      {
         if(goLayer.hasEventListener(MouseEvent.MOUSE_MOVE))
         {
            goLayer.removeEventListener(MouseEvent.MOUSE_MOVE,this.onSilding);
         }
      }
      
      override public function show() : void
      {
         var guideview:View_guide = null;
         var tiliTip:View_tiliTip = null;
         var discrpt:String = null;
         var guiData:Array = null;
         super.show();
         var st:int = SceneConfig.getSceneType();
         if(!(Global.focus is TextInput || Global.focus is MyTextField))
         {
            Global.focus = this;
            IME.enabled = false;
         }
         if(!Global.isInBattle)
         {
            MapManager.dispose();
            CameraManager.dispose();
         }
         if(Global.sceneType == Enum_scene_type.COMMON_SCENE)
         {
            UIManager.mainUiBtnContainer.hideLeaveBtn();
            if(UIManager.jjdProm.visible)
            {
               UIManager.jjdProm.hide();
            }
            preSceneType = Enum_scene_type.COMMON_SCENE;
            if(isFirstEnter)
            {
               if(Global.isFirstPlay)
               {
                  guideview = new View_guide();
                  guideview.init();
                  uiLayer.addChild(guideview);
                  Global.objPan = guideview;
                  QuestGuiManager.addKuang(guideview,463 - 20,227 + 5,84,32);
                  QuestGuiManager.addJian(guideview,505 - 20,265 + 5,270);
                  guideview.addQB888();
               }
               SceneCGMessage.CG_ENTER_SCENE_OK();
               LoadManager.loadResource();
               if(Model_tiliStore.isTiliFull)
               {
                  tiliTip = View_tiliTip.getInstance();
                  tiliTip.visible = true;
               }
               MapManager.init();
               KeyboardManager.init();
            }
            else
            {
               if(st == SceneConfig.WORLDBOSS)
               {
                  SceneCGMessage.CG_ENTER_FUBEN_OK(Global.sceneID);
               }
               else
               {
                  SceneCGMessage.CG_ASK_CHANGE_SCENE_OK();
               }
               SceneConfig.getInstance().sceneOkExtraProgress(Global.sceneMap);
               Global.control.sendNotification(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,Global.sceneMap);
            }
            if(SceneConfig.getSceneType() == SceneConfig.WULIN)
            {
               UIManager.mainUiBtnContainer.showLeaveBtn(View_mainUiBtn_container.COMMON);
            }
            if(isFirstEnter)
            {
               isFirstEnter = false;
            }
         }
         else
         {
            if(SceneConfig.getSceneType() == SceneConfig.WANANSI || SceneConfig.getSceneType() == SceneConfig.SIMPLEFUNBEN || SceneConfig.getSceneType() == SceneConfig.QIJU || SceneConfig.getSceneType() == SceneConfig.PATA || SceneConfig.getSceneType() == SceneConfig.PATA2)
            {
               if(preSceneType != 0 && preSceneType != SceneConfig.getSceneType())
               {
                  if(GameUnitManager.hero.level >= 30)
                  {
                     EnterSceneHd.isShowHd();
                  }
               }
            }
            if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE)
            {
               SceneCGMessage.CG_ENTER_SCENE_OK();
            }
            preSceneType = SceneConfig.getSceneType();
            SceneCGMessage.CG_ENTER_FUBEN_OK(Global.sceneID);
            SceneConfig.getInstance().sceneOkExtraProgress(Global.sceneID);
            Global.control.sendNotification(Enum_MsgType.MSG_ENTER_FUBEN_OK,null);
         }
         if(GameUnitManager.hero.action == Action.DEAD || GameUnitManager.hero.state == State.DEAD)
         {
            GameUnitManager.hero.state = State.LIFE;
            GameUnitManager.hero.action = Action.STAND;
         }
         Global.control.registerCallBack(Enum_MsgType.MUSIC_PLAY,this.playMusic);
         if(Global.sceneMap != 14401)
         {
            GameUnitManager.init();
         }
         if(SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            SceneCGMessage.CG_ENTER_SCENE_OK();
         }
         goLayer.addEventListener(MouseEvent.MOUSE_DOWN,this.downEvent);
         addEventListener(MouseEvent.MOUSE_UP,this.upEvent);
         var data:Date = new Date();
         isEnterScene = true;
         var mapdata:Array = Data_lib.map[Global.sceneMap];
         if(Boolean(mapdata))
         {
            discrpt = mapdata[Enum_map_lib.DISCRPIT];
            if(discrpt != null && discrpt != "0")
            {
               UIManager.sceneDisView.show(Global.sceneMap);
            }
         }
         if(GuideManager.checkEnterFuben(Global.sceneID))
         {
            guiData = Data_lib.guideEnterGuan[Global.sceneID];
            GuideManager.showDialog(guiData[Enum_guide_tonggun.INFO],guiData[Enum_guide_tonggun.REWARD],guiData[Enum_guide_tonggun.BEIZHU]);
         }
         if(Boolean(GameUnitManager.hero))
         {
            GameUnitManager.hero.invalidateChengHao();
         }
      }
      
      private function playMusic() : void
      {
         if(Global.isInBattle)
         {
            return;
         }
         Global.control.removeCallBack(Enum_MsgType.MUSIC_PLAY,this.playMusic);
         var mapdata:Array = Data_lib.map[Global.sceneMap];
         if(Boolean(mapdata))
         {
            MusicManager.getInstance().playMusic("mapRes/mp3/" + mapdata[Enum_map_lib.MUSIC] + ".mp3");
         }
      }
      
      private function goJumpPoint() : void
      {
         var temp_target:Door = null;
         var door:Door = null;
         var temp_instance:int = 0;
         var instance:int = 0;
         for each(door in Door.list)
         {
            temp_instance = Math.abs(GameUnitManager.hero.global_x - door.global_x) + Math.abs(GameUnitManager.hero.global_y - door.global_y);
            if(temp_instance > instance)
            {
               instance = temp_instance;
               temp_target = door;
            }
            GameUnitManager.hero.go(temp_target.global_x,temp_target.global_y);
         }
      }
      
      public function frameEvent(e:Event) : void
      {
         var now:int = getTimer();
         if(now - this.lastTime > 200 && now - this.lastTime < 1000)
         {
            Global.isSleepMode = true;
         }
         else
         {
            Global.isSleepMode = false;
         }
         this.lastTime = now;
         UIManager.checkDragPanel();
         if(Global.sceneMap != 14401)
         {
            GameUnitManager.run(now);
         }
         else
         {
            BoatManager.run(now);
         }
         EffectManager.run(now);
         Heartbeat.run(now);
         if(BattleManager.isPlaying)
         {
            BattleUnitManager.run(now);
            BattleManager.run(now);
         }
         CountStandTimeManager.run(now);
         var TimeInterval:int = now - this.preFrameTime;
         this.preFrameTime = now;
         Global.control.sendNotification(Enum_MsgType.MSG_ENTERFRAME,TimeInterval);
      }
      
      public function addFrameCallBack(callBack:Function) : void
      {
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,callBack);
      }
      
      public function removeFrameCallBack(callBack:Function) : void
      {
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,callBack);
      }
      
      public function hasFrameCallBack(callBack:Function) : Boolean
      {
         return Global.control.hasCallBack(Enum_MsgType.MSG_ENTERFRAME,callBack);
      }
      
      public function uiOnGo(e:MouseEvent) : void
      {
         if(e.target.constructor.toString().indexOf("ScrollBar_background") != -1)
         {
            return;
         }
         if(e.target is TextField && (e.target as TextField).type == TextFieldType.INPUT || e.target is Button || e.target is TabButton || e.target is MovieClip || !this.canGo)
         {
            return;
         }
         this.downEvent(null);
      }
      
      public function onTextEventLink() : void
      {
         this.canGo = false;
         this.inter = setTimeout(this.setGo,1);
      }
      
      private function setGo() : void
      {
         clearTimeout(this.inter);
         this.canGo = true;
      }
      
      public function downEvent(e:MouseEvent) : void
      {
         var w1:Boolean = false;
         var w2:Boolean = false;
         var goRet_1:Boolean = false;
         var goRet:Boolean = false;
         if(Global.isInBattle)
         {
            return;
         }
         if(Global.isFirstPlay)
         {
            return;
         }
         if(GuideManager.isPlaying)
         {
            return;
         }
         if(Global.sceneMap == 14401)
         {
            w1 = AStar.getWalkable(CameraManager.sightX + Global.stage.mouseX,CameraManager.sightY + Global.stage.mouseY);
            w2 = AStar.getWalkable(CameraManager.sightX + Global.stage.mouseX,CameraManager.sightY + Global.stage.mouseY,false);
            if(Boolean(BoatManager.overObj) && Boolean(BoatManager.overObj is Ship) && !(BoatManager.overObj is Button))
            {
               (BoatManager.overObj as Ship).interaction();
            }
            return;
         }
         if(Global.isPlayingMarriageEffect)
         {
            return;
         }
         if(Model_newer.isRunning)
         {
            if(Model_newer.step == 1)
            {
               UIManager.centerBroadcast.addMsg("熊猫正在奔跑中，暂时无法操作身体。");
            }
            return;
         }
         var st:int = SceneConfig.getSceneType();
         if(st == SceneConfig.WORLDBOSS)
         {
            if(!WorldBossUtil.worldBossScenePass())
            {
               return;
            }
         }
         Model_CrossClanBattle.mouseX = CameraManager.sightX + Global.stage.mouseX;
         Model_CrossClanBattle.mouseY = CameraManager.sightY + Global.stage.mouseY;
         if(!HandupMgr.askMovePass())
         {
            return;
         }
         var hero:Hero = GameUnitManager.hero;
         if(st == SceneConfig.KuaFuPaiDui)
         {
            if(Model_KuaFuPaiDui.inTeam)
            {
               UIManager.centerBroadcast.addMsg("情侣舞中不能移动");
            }
            else
            {
               GameUnitManager.moveTargetPoint.show();
               if(hero.go(CameraManager.sightX + Global.stage.mouseX,CameraManager.sightY + Global.stage.mouseY))
               {
                  hero.lockTarget = null;
                  hero.autoMoveID = -1;
                  hero.autoMoveType = -1;
                  hero.lastPath = [];
                  GameUnitManager.hero.isAutoMove = false;
               }
            }
            return;
         }
         if(GameUnitManager.overObj is Role)
         {
            if(GameUnitManager.hero.captainId != 0 && Boolean(GameUnitManager.hero.teamPosition))
            {
               UIManager.centerBroadcast.addMsg(Model_initStr.STATE_NOT_OPERATION);
               return;
            }
            if(hero.status == Status.AiDeBaoBao_BeiBao)
            {
               if(GameUnitManager.overObj is Player && (GameUnitManager.overObj as Role).id != View_AiDeBaoBao_findPartner.instance.partner)
               {
                  UIManager.targetHead.show(GameUnitManager.overObj as Role);
                  AiDeBaoBao_control.target = GameUnitManager.overObj as Player;
                  return;
               }
               return;
            }
            if(hero.status == Status.AiDeBaoBao_Bao)
            {
               if(GameUnitManager.overObj is Player)
               {
                  GameUnitManager.moveTargetPoint.show();
                  goRet_1 = hero.go(CameraManager.sightX + Global.stage.mouseX,CameraManager.sightY + Global.stage.mouseY);
                  if(goRet_1)
                  {
                     hero.lockTarget = null;
                     hero.autoMoveID = -1;
                     hero.autoMoveType = -1;
                     hero.lastPath = [];
                     GameUnitManager.hero.isAutoMove = false;
                  }
                  UIManager.targetHead.hide();
                  return;
               }
            }
            hero.target = GameUnitManager.overObj as Role;
         }
         else if(GameUnitManager.overObj is Door)
         {
            hero.lockTarget = null;
            GameUnitManager.moveTargetPoint.show();
            hero.autoMoveID = -1;
            hero.autoMoveType = -1;
            hero.go(CameraManager.sightX + Global.stage.mouseX,CameraManager.sightY + Global.stage.mouseY);
         }
         else
         {
            if(hero.status == Status.AiDeBaoBao_BeiBao)
            {
               AiDeBaoBao_control.target = null;
               UIManager.targetHead.hide();
               return;
            }
            if(hero.status == Status.AiDeBaoBao_Bao)
            {
               UIManager.targetHead.hide();
            }
            GameUnitManager.moveTargetPoint.show();
            goRet = hero.go(CameraManager.sightX + Global.stage.mouseX,CameraManager.sightY + Global.stage.mouseY);
            if(goRet)
            {
               hero.lockTarget = null;
               hero.autoMoveID = -1;
               hero.autoMoveType = -1;
               hero.lastPath = [];
               GameUnitManager.hero.isAutoMove = false;
            }
         }
      }
      
      private function ok_depot() : void
      {
         DepotCGMessage.CG_DEPOT_DISCARD(UIManager.dragObj.grid.vo.gridId);
      }
      
      private function ok_bag() : void
      {
         if(this.disCardType == 0)
         {
            return;
         }
         if(this.disCardType == Enum_type_grid.BAG)
         {
            BagCGMessage.CG_BAG_REDUCE(BagCGMessage.DISCARD,UIManager.dragObj.grid.vo.gridId,0);
         }
         else if(this.disCardType == Enum_type_grid.DEPOT)
         {
            DepotCGMessage.CG_DEPOT_DISCARD(UIManager.dragObj.grid.vo.gridId);
         }
      }
      
      public function upEvent(e:MouseEvent) : void
      {
         var grid:View_Grid = null;
         var vo:Vo_valuable = null;
         if(UIManager.isDrag)
         {
            if(Util.isOnUI == false)
            {
               grid = UIManager.dragObj.grid;
               vo = grid.vo as Vo_valuable;
               if(grid.type == Enum_type_grid.BAG || grid.type == Enum_type_grid.DEPOT)
               {
                  this.disCardType = grid.type;
                  if(grid.vo == null)
                  {
                     return;
                  }
                  if(vo.bDiscard)
                  {
                     if(vo is Vo_equip && Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
                     {
                        UIManager.bagPwdPutIn.visible = true;
                        UIManager.stopDrag();
                        return;
                     }
                     View_Alert.show(Model_initStr.SURE_DISCARD + HtmlUtil.font(vo.str_name,ColorConstant.getColorStr(ColorConstant.RED)) + Model_initStr.HOW,View_Alert.OK_CANCAL,this.ok_bag);
                  }
                  else
                  {
                     UIManager.centerBroadcast.addMsg(Model_initStr.CANNOT_DISCARD);
                  }
               }
               else if(grid.type == Enum_type_grid.BAR)
               {
                  SkillCGMessage.CG_SET_BAR(Enum_bar_swap.BAR_DEL,grid.index + 1,0);
               }
               else if(grid.type != Enum_type_grid.SHOP)
               {
                  if(grid.type == Enum_type_grid.JIAOYI)
                  {
                  }
               }
            }
         }
         UIManager.stopDrag();
         Model_skill.stopDraw();
      }
      
      override public function resize() : void
      {
         MapManager.init();
         CameraManager.resize();
         if(isBattleEnd)
         {
            isBattleEnd = false;
         }
         else
         {
            UIManager.resetPosition();
         }
         View_updata_panelTip.resetPosition();
         battleLayer.resize();
      }
      
      override public function dispose() : void
      {
         if(View_questGuiJian.instance.bindSpr is Npc)
         {
            UIManager.questTraceView.showMainQGuide();
         }
         GameUnitManager.dispose();
         UIManager.sceneDisView.dispose();
         ResourceManager.dispose();
         MassLoader.dispose();
         removeEventListener(MouseEvent.MOUSE_DOWN,this.downEvent);
         removeEventListener(MouseEvent.MOUSE_UP,this.upEvent);
         Global.control.removeCallBack(Enum_MsgType.MUSIC_PLAY,this.playMusic);
         MusicManager.getInstance().stopMusic();
      }
   }
}

import com.yiTian.net.message.cg.SceneCGMessage;
import com.yiTian.utils.Utils;
import flash.events.Event;

class Heartbeat
{
   
   private static var last:int;
   
   private static var lastSendLogin:int;
   
   private static var rate:int = 10000;
   
   private static var loginRate:int = 600000;
   
   public function Heartbeat()
   {
      super();
   }
   
   public static function run(now:int) : void
   {
      if(now - last > rate)
      {
         SceneCGMessage.CG_HEARTBEAT();
         last = now;
      }
      if(now - lastSendLogin > loginRate)
      {
         sendIsLogin(now);
         lastSendLogin = now;
      }
   }
   
   private static function sendIsLogin(now:int) : void
   {
   }
   
   private static function loaded(e:Event) : void
   {
      Utils.print("IS LOGIN BACK",e.target.data);
   }
}
