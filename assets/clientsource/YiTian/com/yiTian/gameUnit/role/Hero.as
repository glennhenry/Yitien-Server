package com.yiTian.gameUnit.role
{
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_pata_map;
   import com.yiTian.data.config.Enum_scene_type;
   import com.yiTian.data.model.Model_CrossDart;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.data.vo.Vo_mapTarItem;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.config.State;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.manager.CameraManager;
   import com.yiTian.manager.CollectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.GuideManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.MapManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.GuangMingDingCGMessage;
   import com.yiTian.net.message.cg.BangBattleCGMessage;
   import com.yiTian.net.message.cg.FishingCGMessage;
   import com.yiTian.net.message.cg.SceneCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.AStar;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.WorldConfig;
   import com.yiTian.view.NpcPanel;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.KFHomeland.HomeLandCGMessage;
   import com.yiTian.view.modules.KFHomeland.VoHome;
   import com.yiTian.view.modules.crossCampBattle.Model_CrossCampBattle;
   import com.yiTian.view.modules.crossClanBattle.Model_CrossClanBattle;
   import com.yiTian.view.modules.crossClanBattle.View_MsgPanel;
   import com.yiTian.view.modules.fishing.Model_fishing;
   import com.yiTian.view.modules.friends.View_FriendsPanel;
   import com.yiTian.view.modules.fubenSel.View_fuBenSaodanging;
   import com.yiTian.view.modules.huangbang.Model_Huangbang;
   import com.yiTian.view.modules.marriage.Model_Marriage;
   import com.yiTian.view.modules.newerGuide.Model_newer;
   import com.yiTian.view.modules.ship.Ship;
   import com.yiTian.view.modules.treeDownCL.Model_treeCL;
   import com.yiTian.view.modules.wulinduobao.BaoXiang;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class Hero extends Player
   {
      
      public static const ENUM_ADD_WING:String = "enum_add_wing";
      
      public var bingSilver:int;
      
      public var money:int;
      
      public var silver:int;
      
      public var liquan:int;
      
      public var vigor:int;
      
      public var maxvigor:int = 1500;
      
      public var exp:Number;
      
      public var nextexp:Number;
      
      public var prestige:int;
      
      public var title:Array;
      
      public var minAtt:int;
      
      public var def:int;
      
      public var attRate:int;
      
      public var dod:int;
      
      public var crit:int;
      
      public var critv:int;
      
      public var repelv:int;
      
      public var attSpeed:int;
      
      public var strength:int;
      
      public var damgr:int;
      
      public var signed:String;
      
      public var yeLi:int;
      
      public var christmasScore:int;
      
      public var pkMode:int;
      
      public var autoMoveID:int;
      
      public var autoMoveType:int;
      
      private var _target:Role;
      
      public var lockTarget:Role;
      
      public var lockLength:int;
      
      public var lastPath:Array = [];
      
      public var lastTar:Vo_mapTarItem;
      
      public var huangZuan:int;
      
      public var weapon:int;
      
      public var body:int;
      
      public var horse:int;
      
      public var _wing:int;
      
      public var bindShip:Ship;
      
      public var crossClanName:String;
      
      public var crossClanIdArr:Array = [];
      
      public var nickName:String;
      
      public var ResourceMineType:int;
      
      public var _status:int;
      
      private var _marriageID:Number = 0;
      
      public var marriageRing:int = 0;
      
      public var on_show_callback:Function;
      
      private var quest_auto_callback_sign:int;
      
      private var _checkTime:int;
      
      public var isOnJumpPoint:Boolean;
      
      private var lastGoTime:int;
      
      private var _autoGoBm:Bitmap;
      
      private var _isAutoMove:Boolean;
      
      private var _disk:Number;
      
      private var _disA:Number;
      
      private var _disB:Number;
      
      private var dest:int;
      
      private var _marriageName:String = "";
      
      public function Hero()
      {
         super();
      }
      
      public function set wing(value:int) : void
      {
         if(value == this._wing)
         {
            return;
         }
         this._wing = value;
         Global.control.sendNotification(ENUM_ADD_WING,value);
      }
      
      public function get wing() : int
      {
         return this._wing;
      }
      
      override public function set state(value:int) : void
      {
         if(state != value)
         {
            if(value == State.DEAD)
            {
            }
         }
         super.state = value;
      }
      
      override public function show() : void
      {
         super.show();
         if(!Global.isPlayingMarriageEffect)
         {
            if(Model_treeCL.watchX > 0 && Model_treeCL.watchY > 0)
            {
               CameraManager.wacth(Model_treeCL.watchX,Model_treeCL.watchY);
            }
            else
            {
               CameraManager.wacth(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y);
            }
         }
         else
         {
            Model_Marriage.lockCamera();
         }
         end_x = global_x;
         end_y = global_y;
         if(Boolean(this.lastPath) && Boolean(this.lastPath.length))
         {
            this.lastTar = this.lastPath.shift();
            if(this.lastPath.length == 0)
            {
               this.go(this.lastTar.x,this.lastTar.y,Boolean(this.autoMoveID) ? Global.constlockLength : 0);
            }
            else
            {
               this.go(this.lastTar.x,this.lastTar.y);
            }
         }
         if(this.on_show_callback != null)
         {
            this.on_show_callback();
            this.on_show_callback = null;
         }
      }
      
      private function showCurrentQuestArrow() : void
      {
         this.quest_auto_callback_sign = 0;
      }
      
      override public function update(now:int) : void
      {
         super.update(now);
         if(action == Action.RUN)
         {
            if(!Global.isPlayingMarriageEffect)
            {
               if(Model_treeCL.watchX > 0 && Model_treeCL.watchY > 0)
               {
                  CameraManager.wacth(Model_treeCL.watchX,Model_treeCL.watchY);
               }
               else
               {
                  CameraManager.wacth(global_x,global_y);
               }
            }
         }
         if(action == Action.STAND)
         {
            this.isAutoMove = false;
         }
         this.checkNpcPanel();
      }
      
      private function checkNpcPanel() : void
      {
         if(getTimer() - this._checkTime > 200)
         {
            NpcPanel.checkVisible(null,NpcPanel.TYPE_HERO_RUN);
            this._checkTime = getTimer();
         }
         if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE)
         {
            Model_CrossClanBattle.checkVisible();
         }
         if(SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            Model_CrossCampBattle.checkVisible();
         }
      }
      
      override public function align() : void
      {
         var obj_jump:Door = null;
         var pataData:Array = null;
         var tarmapId:int = 0;
         var beginX:int = 0;
         var beginY:int = 0;
         var curTime:int = 0;
         var arr:Array = null;
         super.align();
         obj_jump = AStar.checkJumpArea(global_x,global_y) as Door;
         if(obj_jump == null)
         {
            if(this.isOnJumpPoint)
            {
               this.isOnJumpPoint = false;
            }
            return;
         }
         if(obj_jump != null && GameScene.isEnterScene && obj_jump.visible)
         {
            if(this.isOnJumpPoint)
            {
               return;
            }
            this.isOnJumpPoint = true;
            if(Global.isPata)
            {
               if(captainId == 0 || teamPosition == 0)
               {
                  pataData = Data_lib.sceneData[Global.sceneID];
                  tarmapId = int(pataData[Enum_pata_map.TARMAP_ID]);
                  if(int(pataData[Enum_pata_map.JUMPPOINT_TYPE]) == UnitType.FUBENG_POINT)
                  {
                     SceneCGMessage.CG_ENTER_FUBEN(tarmapId);
                  }
                  else
                  {
                     beginX = int(pataData[Enum_pata_map.BEGIN_X]);
                     beginY = int(pataData[Enum_pata_map.BEGIN_Y]);
                     SceneCGMessage.CG_ASK_CHANGE_SCENE(tarmapId,beginX,beginY);
                  }
               }
               return;
            }
            if(Global.sceneID == 12401)
            {
               curTime = getTimer();
               if(curTime - Model_bang.lastMGQTime < 5000)
               {
                  return;
               }
               Model_bang.lastMGQTime = curTime;
               BangBattleCGMessage.CG_MAIN_GROUND();
               return;
            }
            if(Global.sceneID == 12402)
            {
               arr = new Array();
               arr[12403] = 1;
               arr[12404] = 2;
               arr[12405] = 3;
               arr[12406] = 4;
               BangBattleCGMessage.CG_FOUR_ROOM(arr[obj_jump.linkID]);
               return;
            }
            if(Global.sceneID >= 12403 && Global.sceneID <= 12406)
            {
               BangBattleCGMessage.CG_FR_RETURN_TO_MAIN();
               return;
            }
            if(SceneConfig.getSceneType() == SceneConfig.HOME)
            {
               HomeLandCGMessage.CG_ENTER_HOMELAND(GameUnitManager.hero.id,3,VoHome.heroS);
               return;
            }
            if(Global.sceneMap >= 12410 && Global.sceneMap <= 12509)
            {
               GuangMingDingCGMessage.CG_GMD_ENTER_MAP();
               return;
            }
            if(obj_jump.door_type == UnitType.JUMP_POINT)
            {
               Global.targetSceneId = obj_jump.linkID;
               Global.toX = obj_jump.toX;
               Global.toY = obj_jump.toY;
               action = Action.STAND;
               if(captainId == 0 || teamPosition == 0)
               {
                  SceneCGMessage.CG_ASK_CHANGE_SCENE(obj_jump.linkID,obj_jump.toX,obj_jump.toY);
               }
            }
            else
            {
               if(Model_CrossDart.inCrossScence)
               {
                  UIManager.centerBroadcast.addMsg("跨服运镖不能进入副本！");
                  return;
               }
               if(this.isAutoMove && this.autoMoveType != UnitType.FUBENG_POINT)
               {
                  if(Boolean(this.lastTar.tarMap) && String(obj_jump.id).substr(0,3) == String(this.lastTar.tarMap).substr(0,3))
                  {
                     SceneCGMessage.CG_ENTER_FUBEN(this.lastTar.tarMap);
                  }
                  return;
               }
               if(captainId == 0 || teamPosition == 0)
               {
                  if(!UIManager.fubenSelPanel.visible)
                  {
                     UIManager.fubenSelPanel.visible = true;
                     UIManager.fubenSelPanel.update(obj_jump.id);
                  }
               }
            }
         }
      }
      
      public function go(tx:int, ty:int, dis:int = 0) : Boolean
      {
         var path:Array = null;
         var pet:Pet = null;
         var last:Array = null;
         var lastSen:Array = null;
         var pathRound:Number = NaN;
         var disSqrt:Number = NaN;
         var players:Dictionary = null;
         var player:Player = null;
         if(tx == 0 && ty == 0)
         {
            try
            {
               throw new Error("go(0,0)");
            }
            catch(e:Error)
            {
               Utils.print("go(tx:int, ty:int)",e.getStackTrace(),e);
            }
         }
         if(SceneConfig.getSceneType() == SceneConfig.HUANGBANG && Model_Huangbang.Shaker == false)
         {
            return false;
         }
         if(status == Status.AiDeBaoBao_Bao && AStar.checkBlock(tx,ty))
         {
            return false;
         }
         if(Global.isBuildHome)
         {
            return false;
         }
         if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE)
         {
            if(Model_CrossClanBattle.checkEnemyRange() == true)
            {
               return false;
            }
            if(Model_CrossClanBattle.checkSelfRange() == true)
            {
               if(View_MsgPanel.instance.visible == true)
               {
                  Global.delegate.dosomething(View_MsgPanel.instance,View_MsgPanel.instance.showTipIcon);
               }
               return false;
            }
         }
         if(SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            if(Model_CrossCampBattle.checkRange(true) == true)
            {
               return false;
            }
         }
         if(View_fuBenSaodanging.isQingJiao)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10534",1));
            return false;
         }
         if(Model_newer.stop)
         {
            this.autoMoveID = 0;
            this.autoMoveType = -1;
            return false;
         }
         if(Global.isPlayingMarriageEffect)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("1036",0));
            return false;
         }
         if(!Model_team.isCanGo())
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10535",1));
            return false;
         }
         if(status == Status.FISH)
         {
            View_Alert.show(LangConfig.getWord("10536",1),View_Alert.OK_CANCAL,function(evt:MouseEvent = null):void
            {
               FishingCGMessage.CG_SHOUGAN(Model_fishing.getInstance().currentRiverId);
            },null,null,null,310,LangConfig.getWord("10537",1),LangConfig.getWord("10538",1));
            return false;
         }
         if(status == Status.SIT && level >= 30)
         {
            Global.control.sendNotification(Enum_MsgType.MSG_CANCELGJ,null);
            Utils.print("取消挂机");
            return false;
         }
         if(Global.isInBattle)
         {
            Utils.print("正在战斗中");
            return false;
         }
         if(GuideManager.isPlaying)
         {
            Utils.print("正在动画中");
            return false;
         }
         if(action != Action.STAND && action != Action.RUN && action != Action.SIT)
         {
            Utils.print("动作不对",action);
            return false;
         }
         if(getTimer() - this.lastGoTime < 200)
         {
            Utils.print("点得太快",getTimer(),this.lastGoTime);
            return false;
         }
         if(Boolean(AStar._grid))
         {
            Utils.print("global_x",global_x,"global_y",global_y);
            path = AStar.find(global_x,global_y,tx,ty);
            if(!path)
            {
               try
               {
                  throw new Error("go 找不到路径");
               }
               catch(e:Error)
               {
                  Utils.print("go 找不到路径",e.getStackTrace(),e,global_x,global_y,tx,ty);
               }
            }
            Utils.print("GO SPEED",speed);
            if(Boolean(path) && Boolean(speed))
            {
               if(Boolean(dis))
               {
                  if(path.length > 1)
                  {
                     last = path[path.length - 1];
                     lastSen = path[path.length - 2];
                     if(Util.dist(last[0],last[1],lastSen[0],lastSen[1]) > dis)
                     {
                        path.pop();
                        pathRound = Math.atan2(last[1] - lastSen[1],last[0] - lastSen[0]);
                        disSqrt = Math.sqrt(dis);
                        path.push([last[0] - disSqrt * Math.cos(pathRound),last[1] - disSqrt * Math.sin(pathRound)]);
                     }
                     else
                     {
                        path.pop();
                     }
                  }
                  else
                  {
                     last = path[path.length - 1];
                     if(Util.dist(last[0],last[1],global_x,global_y) < dis)
                     {
                        if(Boolean(this.lockTarget))
                        {
                           this.lockTarget.interaction();
                        }
                        return false;
                     }
                     path.pop();
                     pathRound = Math.atan2(last[1] - global_y,last[0] - global_x);
                     disSqrt = Math.sqrt(dis);
                     path.push([last[0] - disSqrt * Math.cos(pathRound),last[1] - disSqrt * Math.sin(pathRound)]);
                  }
               }
               UIManager.smallMap.drawPath(path.concat());
               UIManager.mappanel.drawPath(path.concat());
               if(path.length > 64)
               {
                  throw new Error("路径点个数为：" + path.length + "....");
               }
               if(Boolean(captainId) && teamPosition == 0)
               {
                  players = Player.list;
                  for each(player in players)
                  {
                     if(Boolean(player.captainId) && Boolean(player.captainId == id) && Boolean(player.teamPosition))
                     {
                        GameUnitManager.setTempRoute(player,this,path);
                        pet = Pet.heroIdList[player.id];
                        if(Boolean(pet))
                        {
                           GameUnitManager.setTempRoute(pet,player,player.tempRoute);
                        }
                     }
                  }
               }
               pet = GameUnitManager.pet;
               if(Boolean(pet))
               {
                  GameUnitManager.setTempRoute(pet,this,path,0);
               }
               Model_CrossCampBattle.setSingleCarRoute(this,path);
               SceneCGMessage.CG_MOVE(path);
               this.route = path;
               this.lastGoTime = getTimer();
               if(CollectManager.isCollecting)
               {
                  CollectManager.end();
               }
               BaoXiang.reqHideCB(false);
               return true;
            }
         }
         return false;
      }
      
      public function stopGo() : void
      {
         var route:Array = null;
         var players:Dictionary = null;
         var player:Player = null;
         var pet:Pet = null;
         if(action == Action.RUN)
         {
            action = Action.STAND;
            if(captainId == 0 || teamPosition == 0)
            {
               SceneCGMessage.CG_STOP_MOVE(global_x,global_y);
            }
            this.lastPath = null;
            route = [[global_x,global_y]];
            if(Boolean(captainId) && teamPosition == 0)
            {
               players = Player.list;
               for each(player in players)
               {
                  if(Boolean(player.captainId) && Boolean(player.captainId == this.id) && Boolean(player.teamPosition))
                  {
                     GameUnitManager.setTempRoute(player,this,route);
                     pet = Pet.heroIdList[player.id];
                     if(Boolean(pet))
                     {
                        GameUnitManager.setTempRoute(pet,player,player.tempRoute);
                     }
                  }
               }
            }
            pet = Pet.heroIdList[id];
            if(Boolean(pet))
            {
               GameUnitManager.setTempRoute(pet,this,route,0);
            }
         }
      }
      
      override public function set status(value:int) : void
      {
         if(status == Status.SIT && value != Status.SIT)
         {
            this.autoMoveID = 0;
         }
         super.status = value;
      }
      
      override protected function moveOver() : void
      {
         UIManager.smallMap.clearPath();
         UIManager.mappanel.clearPath();
      }
      
      public function set target(value:Role) : void
      {
         if(!value)
         {
            if(!(this.lockTarget && this.lockTarget is Npc))
            {
               this.lockTarget = null;
            }
            UIManager.targetHead.hide();
            return;
         }
         if(value != this)
         {
            if(value is Player && value.status != Status.KUN_LUN)
            {
               UIManager.targetHead.show(value);
            }
            if(value.state == State.LIFE || value.state == State.FLOOR)
            {
               if(Util.dist(global_x,global_y,value.global_x,value.global_y) <= Global.constlockLength + Global.constlockLengAdd)
               {
                  trace(this._target == CollectManager.npc);
                  if(Boolean(this._target) && Boolean(this._target == CollectManager.npc) && CollectManager.isCollecting)
                  {
                     CollectManager.end();
                  }
                  if(SceneConfig.getSceneType() == SceneConfig.HUANGBANG && Model_Huangbang.Shaker == false)
                  {
                     return;
                  }
                  value.interaction();
               }
               else
               {
                  this.lockTarget = value;
                  this.lockLength = Global.constlockLength;
                  this.go(value.global_x,value.global_y,Global.constlockLength);
               }
            }
            else
            {
               this.lockTarget = null;
            }
            this._target = value;
         }
      }
      
      public function get target() : Role
      {
         return this._target;
      }
      
      public function set isAutoMove(value:Boolean) : void
      {
         if(value == this._isAutoMove)
         {
            return;
         }
         this._isAutoMove = value;
         if(!this._autoGoBm)
         {
            this._autoGoBm = Utils.getLoadBitmap("resource/image/quest/xuLu.png");
            addChild(this._autoGoBm);
            this._autoGoBm.x = -85;
            this._autoGoBm.y = nameBar.y - 60;
         }
         this._autoGoBm.visible = value;
      }
      
      public function get isAutoMove() : Boolean
      {
         return this._isAutoMove;
      }
      
      public function autoMove(id:int, type:int = 2) : void
      {
         var npc:Npc = null;
         if(View_fuBenSaodanging.isQingJiao)
         {
            return;
         }
         if(Global.sceneType == Enum_scene_type.FUBEN && !MapManager.isFubenFinish)
         {
            return;
         }
         this.lastTar = null;
         if(this.autoMoveID == id && type == this.autoMoveType)
         {
            return;
         }
         this.lastPath = WorldConfig.getPath(id,type);
         if(!this.lastPath || !this.lastPath.length)
         {
            return;
         }
         this.isAutoMove = true;
         if(type == UnitType.NPC)
         {
            npc = Npc.getNpcBySysid(id);
            if(Boolean(npc))
            {
               this.dest = Utils.dist(global_x,global_y,npc.global_x,npc.global_y);
               if(this.dest <= Global.constlockLength + Global.constlockLengAdd)
               {
                  npc.interaction(2);
                  return;
               }
               this.lockLength = Global.constlockLength;
               this.lockTarget = npc;
            }
         }
         this.autoMoveID = id;
         this.autoMoveType = type;
         this.lastTar = this.lastPath.shift();
         if(this.autoMoveType == UnitType.NPC)
         {
            this.go(this.lastTar.x,this.lastTar.y,Boolean(this.lastPath.length) ? 0 : Global.constlockLength);
         }
         else
         {
            this.go(this.lastTar.x,this.lastTar.y,0);
         }
      }
      
      public function autoMoveLocation(mapId:int, targetXY:Vo_mapTarItem = null) : void
      {
         if(View_fuBenSaodanging.isQingJiao)
         {
            return;
         }
         if(Global.sceneType == Enum_scene_type.FUBEN && !MapManager.isFubenFinish)
         {
            return;
         }
         this.lastPath = WorldConfig.getDirectPath(mapId,targetXY);
         if(!this.lastPath)
         {
            return;
         }
         if(!this.lastPath.length)
         {
            return;
         }
         this.isAutoMove = true;
         this.autoMoveID = 0;
         this.autoMoveType = -1;
         this.lastTar = this.lastPath.shift();
         this.go(this.lastTar.x,this.lastTar.y);
      }
      
      override public function isHidePlayer() : Boolean
      {
         return false;
      }
      
      override public function set route(path:Array) : void
      {
         super.route = path;
         var rotation:Number = Math.atan2(end_y - start_y,end_x - start_x) * 180 / Math.PI + 180;
         UIManager.smallMap.setRotation(rotation);
         UIManager.mappanel.setRotation(rotation);
      }
      
      override protected function move(now:int) : void
      {
         var npc:Npc = null;
         super.move(now);
         if(action == Action.RUN)
         {
            UIManager.smallMap.setPosition();
            if(Boolean(!this.lockTarget) && Boolean(this.autoMoveID) && this.autoMoveType == UnitType.NPC)
            {
               npc = Npc.getNpcBySysid(this.autoMoveID);
               if(Boolean(npc))
               {
                  this.lockLength = Global.constlockLength;
                  this.lockTarget = npc;
               }
            }
         }
      }
      
      override public function dispose() : void
      {
         delete list[id];
         filters = [];
         action = Action.STAND;
         end_x = 0;
         end_y = 0;
         this.state = State.LIFE;
      }
      
      public function get marriageID() : Number
      {
         return this._marriageID;
      }
      
      public function set marriageID(value:Number) : void
      {
         var temp:int = 0;
         if(value == 0)
         {
            temp = this._marriageID;
            this._marriageID = 0;
            View_FriendsPanel.setMarriageById(temp);
         }
         else
         {
            this._marriageID = value;
            View_FriendsPanel.setMarriageById(value);
         }
      }
      
      public function set marriageName(value:String) : void
      {
         this._marriageName = value;
      }
      
      public function get marriageName() : String
      {
         return this._marriageName;
      }
   }
}

