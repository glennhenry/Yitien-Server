package com.yiTian.net.handler
{
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_map_lib;
   import com.yiTian.data.config.Enum_npc_type;
   import com.yiTian.data.config.Enum_pata_map;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.config.Enum_scene_type;
   import com.yiTian.data.model.Model_quest;
   import com.yiTian.gameUnit.GameUnit;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.role.Hero;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.gameUnit.role.Pet;
   import com.yiTian.gameUnit.role.Player;
   import com.yiTian.gameUnit.role.Role;
   import com.yiTian.gameUnit.role.ShenBingUnit;
   import com.yiTian.manager.BattleStatusManager;
   import com.yiTian.manager.CameraManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.GuideManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.MapManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.SceneManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.SceneCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.scene.LoadingScene;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.AiDeBaoBao.View_AiDeBaoBao_findPartner;
   import com.yiTian.view.modules.KFHomeland.EnterHomeControl;
   import com.yiTian.view.modules.KFHomeland.Enum_SortBuildins;
   import com.yiTian.view.modules.KFHomeland.HomeLandBtn;
   import com.yiTian.view.modules.KFHomeland.VoHome;
   import com.yiTian.view.modules.activityGuide.View_ActivityGuidePanel;
   import com.yiTian.view.modules.baby.babyIcon.BabyIcon;
   import com.yiTian.view.modules.baby.babyPan.BabyChooseLY;
   import com.yiTian.view.modules.baby.babyPan.BabyInBattleRule;
   import com.yiTian.view.modules.baby.babyPan.BabyPanGuide;
   import com.yiTian.view.modules.banhui.shenshou.ShenShouPaiHang;
   import com.yiTian.view.modules.crossCampBattle.Model_CrossCampBattle;
   import com.yiTian.view.modules.fubenSel.newAdd.EnterSceneBtnManer;
   import com.yiTian.view.modules.guangMingDing.GuangMingDingConfig;
   import com.yiTian.view.modules.loading.View_loading;
   import com.yiTian.view.modules.mainUIBtnContainer.View_mainUiBtn_container;
   import com.yiTian.view.modules.treeDownCL.Model_treeCL;
   import com.yiTian.view.modules.treeDownCL.TreeOutsidePan;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class SceneHandler
   {
      
      public function SceneHandler()
      {
         super();
      }
      
      public static function GC_ENTER_SCENE(result:int, sceneId:int, targetX:int, targetY:int) : void
      {
         var arr:Array = null;
         var mapdata:Array = null;
         Utils.print("GC_ENTER_SCENE",sceneId,targetX,targetY);
         if(result == 1)
         {
            GameUnitManager.hero.isOnJumpPoint = false;
            if(UIManager.fubenSelPanel.visible)
            {
               UIManager.fubenSelPanel.visible = false;
            }
            GameUnitManager.hero.action = Action.STAND;
            GameUnitManager.hero.global_x = targetX;
            GameUnitManager.hero.global_y = targetY;
            Global.sceneID = sceneId;
            Global.sceneType = Enum_scene_type.COMMON_SCENE;
            if(Boolean(Data_lib.map[sceneId]) && Data_lib.map[sceneId][Enum_map_lib.TYPE] == 3)
            {
               if(!UIManager.mainUiBtnContainer.hasBTN(HomeLandBtn.instance.homeBtn) && VoHome.isActivity && GameUnitManager.hero.level >= 60)
               {
                  UIManager.mainUiBtnContainer.addBTN(HomeLandBtn.instance.homeBtn);
               }
            }
            else if(UIManager.mainUiBtnContainer.hasBTN(HomeLandBtn.instance.homeBtn))
            {
               UIManager.mainUiBtnContainer.removeBTN(HomeLandBtn.instance.homeBtn);
            }
            if(Boolean(Data_lib.sceneData[sceneId]))
            {
               mapdata = Data_lib.sceneData[sceneId];
               Global.sceneMap = mapdata[Enum_pata_map.MAPURL];
               Global.isPata = true;
            }
            else if(Boolean(Data_lib.ycgmd[sceneId]))
            {
               Global.sceneMap = Data_lib.ycgmd[sceneId][2];
               Global.isPata = false;
            }
            else
            {
               if(Global.sceneID >= 12301 && Global.sceneID <= 12303)
               {
                  Global.sceneMap = 12301;
               }
               else
               {
                  Global.sceneMap = Global.sceneID;
               }
               Global.isPata = false;
            }
            arr = [];
            if(!GameScene.isFirstEnter)
            {
               UIManager.smallMap.clearPath();
               UIManager.mappanel.clearPath();
               GameScene.instance.dispose();
               arr.push(["mapRes/map/" + Global.sceneMap + "/config.xml",function(info:Object):void
               {
                  MapManager.decodeConfig(info);
               },LangConfig.getWord("677",0),Enum_loaderType.SINGLE,Enum_resType.MAP_URL]);
               arr.push(["mapRes/map/" + Global.sceneMap + "/" + Global.sceneMap + ".swf",MapManager.decodeThumb,LangConfig.getWord("678",0),Enum_loaderType.SINGLE,Enum_resType.MAP_URL]);
               View_loading.instance.load(arr,GameScene.instance.show);
            }
            else
            {
               arr.push(["",UIManager.init,LangConfig.getWord("679",0)]);
               if(Global.isFirstPlay)
               {
                  arr.push(["lang/" + Global.config.lang + "/guide.swf",function(info:Object):void
                  {
                     Global.guideBtn = info.applicationDomain;
                  },LangConfig.getWord("680",0),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
               }
               arr.push(["mapRes/map/" + Global.sceneMap + "/config.xml",MapManager.decodeConfig,LangConfig.getWord("677",0),Enum_loaderType.SINGLE,Enum_resType.MAP_URL]);
               arr.push(["mapRes/map/" + Global.sceneMap + "/" + Global.sceneMap + ".swf",MapManager.decodeThumb,LangConfig.getWord("678",0),Enum_loaderType.SINGLE,Enum_resType.MAP_URL]);
               LoadingScene.load(arr,function():void
               {
                  LoadingScene.dispose();
                  var loadIns:Sprite = Global.loadScene["instance"];
                  loadIns.parent.removeChild(loadIns);
                  loadIns["dispose"]();
                  SceneManager.showScene(GameScene);
               });
            }
            Global.control.sendNotification(Enum_MsgType.MSG_ENTER_SCENE,sceneId);
            if(UIManager.shenShouPaiHang.visible)
            {
               UIManager.shenShouPaiHang.visible = false;
            }
            if(Model_treeCL.enterTreeSceneSign)
            {
               Model_treeCL.showAllExcShouChong();
               Model_treeCL.actionsEnd();
               Global.control.removeCallBack(Model_treeCL.ADD_EXPERIANCE,Model_treeCL.addExp);
            }
         }
         if(SceneConfig.getSceneType() == SceneConfig.WULIN || SceneConfig.getSceneType() == SceneConfig.HUNLI || SceneConfig.getSceneType() == SceneConfig.BZ_BATTLE)
         {
            EnterSceneBtnManer.addEnterFubenLis();
         }
         else
         {
            EnterSceneBtnManer.addEnterSceneLis();
         }
         if(BabyIcon.hasIcon)
         {
            BabyIcon.hide();
         }
         if(BabyPanGuide.instance.visible)
         {
            BabyPanGuide.instance.hide();
         }
         if(BabyChooseLY.instance.visible)
         {
            BabyChooseLY.instance.visible = false;
         }
         if(BabyInBattleRule.instance.visible)
         {
            BabyInBattleRule.instance.visible = false;
         }
      }
      
      public static function GC_ENTER_FUBEN(result:int, sceneId:int, targetX:int, targetY:int) : void
      {
         var st:int = 0;
         var arr:Array = null;
         var mapdata:Array = null;
         Utils.print("GC_ENTER_FUBEN",result,sceneId,targetX,targetY,GameUnitManager.hero.global_x,GameUnitManager.hero.global_y,GameUnitManager.hero.action);
         if(result == 1)
         {
            st = SceneConfig.getSceneType();
            GameUnitManager.hero.isOnJumpPoint = false;
            if(UIManager.fubenSelPanel.visible)
            {
               UIManager.fubenSelPanel.visible = false;
            }
            if(UIManager.bangPlant.visible)
            {
               UIManager.bangPlant.visible = false;
            }
            Model_quest.checkArrow(sceneId);
            GameUnitManager.hero.action = Action.STAND;
            GameUnitManager.hero.global_x = targetX;
            GameUnitManager.hero.global_y = targetY;
            Global.sceneID = sceneId;
            Global.sceneType = Enum_scene_type.FUBEN;
            if(UIManager.mainUiBtnContainer.hasBTN(HomeLandBtn.instance.homeBtn))
            {
               UIManager.mainUiBtnContainer.removeBTN(HomeLandBtn.instance.homeBtn);
            }
            if(Boolean(Data_lib.sceneData[sceneId]))
            {
               mapdata = Data_lib.sceneData[sceneId];
               Global.sceneMap = mapdata[Enum_pata_map.MAPURL];
               Global.isPata = true;
               if(SceneConfig.getSceneType() == SceneConfig.WANANSI)
               {
                  UIManager.mainUiBtnContainer.showLeaveBtn(View_mainUiBtn_container.WANANSI);
               }
            }
            else if(Boolean(Data_lib.ycgmd[sceneId]))
            {
               Global.sceneMap = Data_lib.ycgmd[sceneId][2];
               UIManager.mainUiBtnContainer.showLeaveBtn(0);
               Global.isPata = false;
            }
            else
            {
               Global.sceneMap = Global.sceneID;
               Global.isPata = false;
               if(st == SceneConfig.FISH)
               {
                  UIManager.mainUiBtnContainer.showLeaveBtn(View_mainUiBtn_container.FISHING);
               }
               else if(st == SceneConfig.WULIN)
               {
                  UIManager.mainUiBtnContainer.showLeaveBtn(View_mainUiBtn_container.WULINDAHUI);
               }
               else if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE)
               {
                  UIManager.mainUiBtnContainer.showLeaveBtn(View_mainUiBtn_container.KUAFU_BANGZHAN);
               }
               else if(st == SceneConfig.AiDeBaoBao)
               {
                  UIManager.mainUiBtnContainer.showLeaveBtn(0);
               }
               else if(st != SceneConfig.CROSS_CAMP_BATTLE)
               {
                  if(SceneConfig.getSceneType() == SceneConfig.DSCL)
                  {
                     UIManager.mainUiBtnContainer.showLeaveBtn(View_mainUiBtn_container.DSCL);
                     if(TreeOutsidePan.instance.visible)
                     {
                        TreeOutsidePan.instance.visible = false;
                     }
                     if(View_ActivityGuidePanel.instance.visible)
                     {
                        View_ActivityGuidePanel.instance.visible = false;
                     }
                     if(!Model_treeCL.enterTreeSceneSign)
                     {
                        Model_treeCL.hideAllExcShouChong();
                        Global.control.registerCallBack(Model_treeCL.ADD_EXPERIANCE,Model_treeCL.addExp);
                     }
                  }
                  else
                  {
                     UIManager.mainUiBtnContainer.showLeaveBtn(View_mainUiBtn_container.COMMON);
                  }
               }
            }
            arr = [];
            UIManager.smallMap.clearPath();
            UIManager.mappanel.clearPath();
            GameScene.instance.dispose();
            arr.push(["mapRes/map/" + Global.sceneMap + "/config.xml",function(info:Object):void
            {
               MapManager.decodeConfig(info);
            },LangConfig.getWord("677",0),Enum_loaderType.SINGLE,Enum_resType.MAP_URL]);
            arr.push(["mapRes/map/" + Global.sceneMap + "/" + Global.sceneMap + ".swf",MapManager.decodeThumb,LangConfig.getWord("678",0),Enum_loaderType.SINGLE,Enum_resType.MAP_URL]);
            View_loading.instance.load(arr,GameScene.instance.show);
            Utils.print("GC_ENTER_FUBEN_over",Global.sceneID,GameUnitManager.hero.global_x,GameUnitManager.hero.global_y,GameUnitManager.hero.action);
            Global.control.sendNotification(Enum_MsgType.MSG_ENTER_FUBEN,sceneId);
            if(sceneId == ShenShouPaiHang.shenShouMap)
            {
               UIManager.shenShouPaiHang.visible = true;
            }
            if(SceneConfig.getSceneType() == SceneConfig.HOME)
            {
               if(sceneId == 14132 || sceneId == 14131 || sceneId == 14137)
               {
                  VoHome.isOut == 1;
               }
               else if(sceneId == 14131 || sceneId == 14134 || sceneId == 14136)
               {
                  VoHome.isOut == 2;
               }
               VoHome.isOut = Data_lib.kfjyjzflb[sceneId][Enum_SortBuildins.OUT_INNER];
               EnterHomeControl.instance.enterHomeMap();
            }
         }
         EnterSceneBtnManer.addEnterFubenLis();
         if(BabyIcon.hasIcon)
         {
            BabyIcon.hide();
         }
         if(BabyPanGuide.instance.visible)
         {
            BabyPanGuide.instance.hide();
         }
         if(BabyChooseLY.instance.visible)
         {
            BabyChooseLY.instance.visible = false;
         }
         if(BabyInBattleRule.instance.visible)
         {
            BabyInBattleRule.instance.visible = false;
         }
      }
      
      public static function GC_ADD_PLAYER(result:int, status:int, id:Number, name:String, globalX:int, globalY:int, speed:int, hp:int, hpMax:int, mp:int, mpMax:int, level:int, body:int, hair:int, weapon:int, horse:int, sex:int, job:int, direction:int, targetPos:Array, captainId:Number, teamPosition:int, pets:Array, vip:int, partyId:Number, party:String, battleTime:int, paoBiao:int, chengHao:int, wulinChengHao:String, YLDiaLvl:int, isYearDia:int, huangZuanLvl:int, isHuangZuanYear:int, huiYuan:int, huiYuanYear:int, superLan:int, superLanYear:int, xinYueType:int, xinLvl:int, isShow:int, xunZhangLvl:int, isSuperHuang:int, partner:Number, skillStr:String, shenBing:int, zoneId:int, wingId:int) : void
      {
         var player:Player = null;
         var st:int = 0;
         var petData:Array = null;
         var pet:Pet = null;
         var captain:Player = null;
         var temRo:Array = null;
         var teamMembers:Dictionary = null;
         var teamMember:Player = null;
         trace("GC_ADD_PLAYER",id,name,globalX,globalY,"\tstatus:",status,"  captainId:",captainId,teamPosition,"  speed:",speed,body);
         if(Boolean(result))
         {
            player = GameUnitManager.findUnit(id,UnitType.PLAYER) as Player;
            if(!player)
            {
               player = GameUnitManager.getUnit(UnitType.PLAYER) as Player;
            }
            player.wulinChengHao = wulinChengHao;
            st = SceneConfig.getSceneType();
            if(st == SceneConfig.KUNLUN)
            {
               if(body != 55027)
               {
                  body = 55027;
               }
               horse = 0;
               weapon = 0;
               name = Data_lib.npc[55027][Npc.NAME];
               shenBing = 0;
            }
            else if(st == SceneConfig.AiDeBaoBao)
            {
               shenBing = 0;
            }
            player.init(id,status,name,globalX,globalY,speed,hp,hpMax,mp,mpMax,level,direction,sex,body,hair,weapon,horse,job,vip,partyId,party,YLDiaLvl,isYearDia,huangZuanLvl,isHuangZuanYear,huiYuan,huiYuanYear,superLan,superLanYear,xinYueType,xinLvl,isShow,isSuperHuang,wingId);
            player.xunZhangLv = xunZhangLvl;
            player.captainId = captainId;
            player.teamPosition = teamPosition;
            GameUnitManager.addUnit(player);
            GameUnitManager.setSinglePlayerVisible(player);
            UIManager.smallMap.addPoint(player);
            player.paoBiao = paoBiao;
            player.chengHao = chengHao;
            player.shenBingLv = shenBing;
            if(SceneConfig.getSceneType() != SceneConfig.KUNLUN && SceneConfig.getSceneType() != SceneConfig.KuaFuPaiDui)
            {
               if(Boolean(pets.length))
               {
                  petData = pets[0];
                  pet = GameUnitManager.findUnit(petData[0],UnitType.PET) as Pet;
                  if(!pet)
                  {
                     pet = GameUnitManager.getUnit(UnitType.PET) as Pet;
                  }
                  pet.init(id,petData[0],petData[1],petData[2],petData[3],petData[4],speed,petData[5],petData[6],petData[7],petData[8],petData[9],petData[10],petData[11],petData[12]);
                  pet.way = Util.rnd(0,7);
                  GameUnitManager.addUnit(pet);
                  GameUnitManager.setSinglePetVisible(pet);
               }
            }
            if(Boolean(battleTime) && status != Status.NOMAL)
            {
               BattleStatusManager.addUnit(id,UnitType.PLAYER,battleTime);
            }
            if(Boolean(player.captainId))
            {
               if(Boolean(player.teamPosition))
               {
                  captain = GameUnitManager.findUnit(player.captainId,UnitType.PLAYER) as Player;
                  if(Boolean(captain))
                  {
                     temRo = Boolean(captain.route) ? captain.route.concat() : [];
                     if(Boolean(captain.end_x) || Boolean(captain.end_y))
                     {
                        temRo.unshift([captain.end_x,captain.end_y]);
                     }
                     GameUnitManager.setTempRoute(player,captain,temRo);
                     Model_CrossCampBattle.setSingleCarRoute(player,player.tempRoute);
                     pet = Pet.heroIdList[player.id];
                     if(Boolean(pet))
                     {
                        GameUnitManager.setTempRoute(pet,player,player.tempRoute);
                     }
                  }
               }
               else if(targetPos.length != 0)
               {
                  teamMembers = Player.list;
                  for each(teamMember in teamMembers)
                  {
                     if(Boolean(teamMember.captainId) && Boolean(teamMember.captainId == player.id) && Boolean(teamMember.teamPosition))
                     {
                        GameUnitManager.setTempRoute(teamMember,player,targetPos);
                        Model_CrossCampBattle.setSingleCarRoute(teamMember,teamMember.tempRoute);
                        pet = Pet.heroIdList[teamMember.id];
                        if(Boolean(pet))
                        {
                           GameUnitManager.setTempRoute(pet,teamMember,teamMember.tempRoute);
                        }
                     }
                  }
               }
            }
            if(Boolean(player.captainId) && Boolean(!player.teamPosition) || !player.captainId)
            {
               if(targetPos.length != 0)
               {
                  Model_CrossCampBattle.setSingleCarRoute(player,targetPos);
                  pet = Pet.heroIdList[player.id];
                  if(Boolean(pet))
                  {
                     GameUnitManager.setTempRoute(pet,player,targetPos,0);
                  }
                  player.route = targetPos;
               }
            }
            player.AiDeBaoBao_partner = partner;
            player.AiDeBaoBao_buff = skillStr.split("_");
            player.zoneId = zoneId;
         }
         Global.control.sendNotification(Enum_MsgType.MSG_ADD_PLAYER,id);
         Global.control.sendNotification(Enum_MsgType.MSG_ADD_PLAYER_2,player);
      }
      
      public static function GC_UPDATE_PLAYER(id:Number, captainId:Number, teamPosition:int, speed:int) : void
      {
         var player:Player = null;
         if(GameUnitManager.hero.id == id)
         {
            player = GameUnitManager.hero;
            trace("GC_UPDATE_HERO",id,Boolean(player) ? player.name : "该玩家不存在","\tcaptainId:",captainId,teamPosition,"\t\tspeed:",speed);
         }
         else
         {
            player = GameUnitManager.findUnit(id,UnitType.PLAYER) as Player;
            trace("GC_UPDATE_PLAYER",id,Boolean(player) ? player.name : "该玩家不存在","\tcaptainId:",captainId,teamPosition,"\t\tspeed:",speed);
            if(!player)
            {
               return;
            }
         }
         player.captainId = captainId;
         player.teamPosition = teamPosition;
         player.speed = speed;
         var pet:Pet = Pet.heroIdList[player.id];
         if(Boolean(pet))
         {
            pet.speed = speed;
         }
      }
      
      public static function GC_DEL_ROLE(result:int, id:Number, type:int) : void
      {
         var pet:Pet = null;
         var sb:ShenBingUnit = null;
         var hero:Hero = GameUnitManager.hero;
         var unit:GameUnit = GameUnitManager.findUnit(id,type);
         if(!unit || unit.id == hero.id)
         {
            if(!unit)
            {
               trace("GC_UPDATE_HERO",id,"   该玩家不存在","\tcaptainId:","\t\tspeed:");
            }
            return;
         }
         if(unit == GameUnitManager.hero.target)
         {
            GameUnitManager.hero.target = null;
         }
         if(unit is Player)
         {
            pet = Pet.heroIdList[unit.id];
            if(Boolean(pet))
            {
               GameUnitManager.removeUnit(pet);
            }
            sb = (unit as Player).sb;
            if(Boolean(sb))
            {
               GameUnitManager.removeUnit(sb);
            }
         }
         trace("GC_DEL_ROLE",id,type,unit.name);
         GameUnitManager.removeUnit(unit);
      }
      
      public static function GC_MOVE(id:Number, type:int, route:Array) : void
      {
         var players:Dictionary = null;
         var player:Player = null;
         var pet:Pet = null;
         var role:Role = GameUnitManager.findUnit(id,type) as Role;
         if(!role)
         {
            return;
         }
         if(GameUnitManager.hero.status == Status.AiDeBaoBao_BeiBao && id == View_AiDeBaoBao_findPartner.instance.partner)
         {
            GameUnitManager.hero.route = route.concat();
         }
         if(role is Player)
         {
            if(Boolean((role as Player).captainId) && (role as Player).teamPosition == 0)
            {
               players = Player.list;
               for each(player in players)
               {
                  if(Boolean(player.captainId) && Boolean(player.captainId == role.id) && Boolean(player.teamPosition))
                  {
                     GameUnitManager.setTempRoute(player,role,route);
                     Model_CrossCampBattle.setSingleCarRoute(player,player.tempRoute);
                     pet = Pet.heroIdList[player.id];
                     if(Boolean(pet))
                     {
                        GameUnitManager.setTempRoute(pet,player,player.tempRoute);
                     }
                  }
               }
            }
            Model_CrossCampBattle.setSingleCarRoute(role,route);
            pet = Pet.heroIdList[role.id];
            if(Boolean(pet))
            {
               GameUnitManager.setTempRoute(pet,role,route,0);
            }
         }
         if(type == UnitType.NPC && GuideManager.isPlaying)
         {
            return;
         }
         role.route = route;
      }
      
      public static function GC_STOP_MOVE(id:Number, posX:int, posY:int) : void
      {
         var players:Dictionary = null;
         var player:Player = null;
         var pet:Pet = null;
         var role:Player = GameUnitManager.findUnit(id,UnitType.PLAYER) as Player;
         if(!role)
         {
            return;
         }
         var route:Array = [[posX,posY]];
         if(Boolean(role.captainId) && role.teamPosition == 0)
         {
            players = Player.list;
            for each(player in players)
            {
               if(Boolean(player.captainId) && Boolean(player.captainId == role.id) && Boolean(player.teamPosition))
               {
                  GameUnitManager.setTempRoute(player,role,route);
                  Model_CrossCampBattle.setSingleCarRoute(player,player.tempRoute);
                  pet = Pet.heroIdList[player.id];
                  if(Boolean(pet))
                  {
                     GameUnitManager.setTempRoute(pet,player,player.tempRoute);
                  }
               }
            }
         }
         Model_CrossCampBattle.setSingleCarRoute(role,route);
         pet = Pet.heroIdList[role.id];
         if(Boolean(pet))
         {
            GameUnitManager.setTempRoute(pet,role,route,0);
         }
         role.route = route;
      }
      
      public static function GC_ADD_NPC(objId:Number, sysId:int, globalX:int, globalY:int, hp:int, hpMax:int, mp:int, mpMax:int, direction:int, route:Array, buffer:Array) : void
      {
         Utils.print("GC_ADD_NPC",objId,sysId,globalX,globalY,Data_lib.npc[sysId][Npc.NAME]);
         var npc:Npc = GameUnitManager.findUnit(objId,UnitType.NPC) as Npc;
         if(!npc)
         {
            npc = GameUnitManager.getUnit(UnitType.NPC) as Npc;
         }
         npc.init(objId,sysId,globalX,globalY,hp,hpMax,mp,mpMax,direction,route,buffer);
         GameUnitManager.addUnit(npc);
         if(Enum_npc_type.canBattle(npc.npcType))
         {
            UIManager.smallMap.addPoint(npc);
         }
         if(route.length != 0)
         {
            npc.route = route;
         }
         Global.control.sendNotification(Enum_MsgType.ADD_NPC_SCENE,npc);
      }
      
      public static function GC_FUBEN_FINISH(result:int) : void
      {
         if(Boolean(result))
         {
            MapManager.setJumpItemVisible();
            if(SceneConfig.getSceneType() == SceneConfig.GMD)
            {
               GuangMingDingConfig.createJumpPoint();
            }
         }
         Global.control.sendNotification(Enum_MsgType.FUBEN_FINISH,result);
      }
      
      public static function GC_JUMP_POINT(roldId:Number, sceneId:int, sceneType:int, posX:int, posY:int, way:int) : void
      {
         var captain:Player = null;
         var temRo:Array = null;
         var player:Player = null;
         var pet:Pet = null;
         trace("GC_JUMP_POINT",roldId,sceneId,sceneType,posX,posY);
         var hero:Hero = GameUnitManager.hero;
         if(hero.id == roldId)
         {
            UIManager.smallMap.clearPath();
            UIManager.mappanel.clearPath();
            if(Global.sceneID == sceneId)
            {
               if(SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
               {
                  hero.stopGo();
               }
               hero.global_x = posX;
               hero.global_y = posY;
               hero.way = way;
               CameraManager.wacth(posX,posY);
               hero.align();
               if(Boolean(GameUnitManager.pet))
               {
                  GameUnitManager.pet.global_x = GameUnitManager.hero.global_x + 40;
                  GameUnitManager.pet.global_y = GameUnitManager.hero.global_y + 30;
                  GameUnitManager.pet.align();
               }
               if(Boolean(hero.captainId))
               {
                  if(Boolean(hero.teamPosition))
                  {
                     captain = GameUnitManager.findUnit(hero.captainId,UnitType.PLAYER) as Player;
                     if(Boolean(captain))
                     {
                        temRo = Boolean(captain.route) ? captain.route.concat() : [];
                        if(Boolean(captain.end_x) || Boolean(captain.end_y))
                        {
                           temRo.unshift([captain.end_x,captain.end_y]);
                        }
                        GameUnitManager.setTempRoute(hero,captain,temRo);
                        if(Boolean(GameUnitManager.pet))
                        {
                           GameUnitManager.setTempRoute(GameUnitManager.pet,hero,hero.tempRoute);
                        }
                     }
                  }
               }
            }
            else if(GameUnitManager.hero.captainId == 0 || GameUnitManager.hero.teamPosition == 0)
            {
               if(sceneType == Enum_scene_type.COMMON_SCENE)
               {
                  SceneCGMessage.CG_ASK_CHANGE_SCENE(sceneId,posX,posY);
               }
               else if(sceneType == Enum_scene_type.FUBEN)
               {
                  SceneCGMessage.CG_ENTER_FUBEN(sceneId);
               }
            }
         }
         else
         {
            player = GameUnitManager.findUnit(roldId,UnitType.PLAYER) as Player;
            if(!player)
            {
               return;
            }
            player.global_x = posX;
            player.global_y = posY;
            player.way = way;
            player.align();
            pet = Pet.heroIdList[player.id];
            if(Boolean(pet))
            {
               pet.global_x = player.global_x + 40;
               pet.global_y = player.global_y + 30;
               pet.align();
            }
            if(Boolean(player.captainId))
            {
               if(Boolean(player.teamPosition))
               {
                  captain = GameUnitManager.findUnit(player.captainId,UnitType.PLAYER) as Player;
                  if(Boolean(captain))
                  {
                     temRo = Boolean(captain.route) ? captain.route.concat() : [];
                     if(Boolean(captain.end_x) || Boolean(captain.end_y))
                     {
                        temRo.unshift([captain.end_x,captain.end_y]);
                     }
                     GameUnitManager.setTempRoute(player,captain,temRo);
                     if(Boolean(pet))
                     {
                        GameUnitManager.setTempRoute(pet,player,player.tempRoute);
                     }
                  }
               }
            }
         }
      }
      
      public static function GC_INBATTLE_STATUS(roleId:Number, type:int, leftTime:int) : void
      {
         BattleStatusManager.addUnit(roleId,type,leftTime * 1000);
      }
      
      public static function GC_ADD_PET(heroId:Number, petId:Number, name:String, body1:int, body2:int, body3:int, speed:int, hp:int, hpmax:int, level:int, zhizi:int, chengzhang:int, hxjx:int, petType:int, tupo:int) : void
      {
         var pet:Pet = null;
         var tempRoute:Array = null;
         if(heroId == GameUnitManager.hero.id)
         {
            if(!GameUnitManager.pet)
            {
               GameUnitManager.pet = new Pet();
            }
            pet = GameUnitManager.pet;
         }
         else
         {
            pet = GameUnitManager.findUnit(petId,UnitType.PET) as Pet;
            if(!pet)
            {
               pet = GameUnitManager.getUnit(UnitType.PET) as Pet;
            }
         }
         pet.init(heroId,petId,name,body1,body2,body3,speed,hp,hpmax,level,zhizi,chengzhang,hxjx,petType,tupo);
         GameUnitManager.addUnit(pet);
         var player:Player = GameUnitManager.findUnit(heroId,UnitType.PLAYER) as Player;
         if(Boolean(player))
         {
            if(Boolean(player.tempRoute))
            {
               tempRoute = player.tempRoute;
            }
            else if(Boolean(player.route))
            {
               tempRoute = player.route;
            }
            else
            {
               tempRoute = [];
            }
            GameUnitManager.setTempRoute(pet,player,tempRoute);
         }
      }
      
      public static function GC_COLLECT(result:int) : void
      {
         if(result == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("681",0));
         }
      }
      
      public static function GC_ENTER_FUBEN_FAULT(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("682",0));
         }
      }
      
      public static function GC_UPDATE_FUBENINFO(sceneId:int, fubenId:int) : void
      {
         MapManager.fubenInfo[sceneId] = fubenId;
      }
      
      public static function GC_USE_SXF(result:int) : void
      {
         switch(result)
         {
            case 1:
               UIManager.mappanel.visible = false;
               break;
            case 2:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("9",0));
               break;
            case 3:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("683",0));
               break;
            case 4:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("684",0));
               break;
            case 5:
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("685",0));
         }
      }
      
      public static function GC_SET_SEND_USE_YB() : void
      {
      }
      
      public static function GC_TEAM_WAIT(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("686",0));
         }
      }
   }
}

