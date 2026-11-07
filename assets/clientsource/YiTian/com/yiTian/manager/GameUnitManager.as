package com.yiTian.manager
{
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.gameUnit.GameUnit;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.magic.Magic;
   import com.yiTian.gameUnit.magic.MoveTargetPoint;
   import com.yiTian.gameUnit.role.Door;
   import com.yiTian.gameUnit.role.Hero;
   import com.yiTian.gameUnit.role.HunLi;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.gameUnit.role.NpcBaby;
   import com.yiTian.gameUnit.role.Parts;
   import com.yiTian.gameUnit.role.Pet;
   import com.yiTian.gameUnit.role.Player;
   import com.yiTian.gameUnit.role.Role;
   import com.yiTian.gameUnit.role.ShenBingUnit;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.KFHomeland.CreatedBuildings;
   import com.yiTian.view.modules.crossCampBattle.Model_CrossCampBattle;
   import com.yiTian.view.modules.huangbang.LoopPoint;
   import com.yiTian.view.modules.pata.CityDiaoXiang;
   import com.yiTian.view.modules.pata.PaTaDiaoXiang;
   import com.yiTian.view.modules.wulinduobao.BaoXiang;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   
   public class GameUnitManager
   {
      
      public static var pet:Pet;
      
      public static var overObj:GameUnit;
      
      private static var len:int;
      
      private static var count:int;
      
      private static var lastUpdateTime:int;
      
      private static var lastTeamCheck:int;
      
      public static var hero:Hero = new Hero();
      
      public static var moveTargetPoint:MoveTargetPoint = new MoveTargetPoint();
      
      public static var list:Array = [];
      
      private static var sort:Array = ["state","reOrder","y"];
      
      private static var _allVisibel:Boolean = true;
      
      private static var _isShowPlayer:Boolean = true;
      
      public function GameUnitManager()
      {
         super();
      }
      
      public static function showHorseHead(action:int, horseId:int) : Boolean
      {
         var data:Array = Data_lib.horseHead[action];
         var index:int = data.indexOf(horseId);
         return index >= 0;
      }
      
      public static function init() : void
      {
         addUnit(hero);
         if(SceneConfig.getSceneType() != SceneConfig.AiDeBaoBao && SceneConfig.getSceneType() != SceneConfig.KuaFuPaiDui)
         {
            if(Boolean(pet))
            {
               addUnit(pet);
            }
            if(Boolean(hero.sb))
            {
               hero.sb.global_x = GameUnitManager.hero.global_x;
               hero.sb.global_y = GameUnitManager.hero.global_y;
               addUnit(hero.sb);
            }
         }
         addUnit(moveTargetPoint);
      }
      
      public static function run(now:int) : void
      {
         var tempUnit:GameUnit = null;
         var unit:GameUnit = null;
         setTeammemberAutoGo(now);
         len = list.length;
         count = len - 1;
         while(count >= 0)
         {
            if(list[count])
            {
               list[count].update(now);
            }
            --count;
         }
         if(now - lastUpdateTime > 180)
         {
            len = list.length;
            list.sortOn(sort,Array.NUMERIC);
            count = len - 1;
            while(count >= 0)
            {
               if(GameScene.mainLayer.getChildIndex(list[count]) != count)
               {
                  GameScene.mainLayer.setChildIndex(list[count],count);
               }
               --count;
            }
            lastUpdateTime = now;
         }
         Utils.point.x = Global.stage.mouseX;
         Utils.point.y = Global.stage.mouseY;
         var overArr:Array = GameScene.mainLayer.getObjectsUnderPoint(Utils.point);
         var i:int = overArr.length - 1;
         while(i >= 0)
         {
            if(Util.isOnUI)
            {
               break;
            }
            unit = testUnit(overArr[i]);
            if(Boolean(unit) && (unit is Npc && SceneConfig.getSceneType() != SceneConfig.KFBZ_BATTLE || unit is BaoXiang))
            {
               tempUnit = unit;
               break;
            }
            if(unit != hero)
            {
               if(!tempUnit && Boolean(unit))
               {
                  tempUnit = unit;
               }
            }
            i--;
         }
         if(tempUnit == overObj)
         {
            return;
         }
         if(Boolean(overObj))
         {
            overObj.mouseOut();
         }
         overObj = tempUnit;
         if(Boolean(overObj))
         {
            overObj.mouseOver();
         }
      }
      
      private static function setTeammemberAutoGo(now:int) : void
      {
         var players:Dictionary = null;
         var player:Player = null;
         var pets:Dictionary = null;
         var master:Player = null;
         var pet:Pet = null;
         var captain:Player = null;
         var round:Number = NaN;
         var radius:Number = NaN;
         var rot:Number = NaN;
         var minus:Number = NaN;
         var ro:Number = NaN;
         var cars:Array = null;
         var npc:Npc = null;
         var i:int = 0;
         if(now - lastTeamCheck > 100)
         {
            lastTeamCheck = now;
            players = Player.list;
            for each(player in players)
            {
               if(Boolean(player.captainId) && Boolean(player.teamPosition != 0) && Boolean(player.tempRoute))
               {
                  captain = findUnit(player.captainId,UnitType.PLAYER) as Player;
                  if(Boolean(captain))
                  {
                     if(Util.dist(captain.global_x,captain.global_y,player.global_x,player.global_y) >= 3600 * player.teamPosition * player.teamPosition)
                     {
                        round = Math.atan2(captain.global_y - player.global_y,captain.global_x - player.global_x);
                        radius = round * 180 / Math.PI;
                        rot = captain.way * 45 - 90;
                        minus = rot - radius;
                        ro = minus * Math.PI / 180;
                        if(Math.cos(ro) > 0)
                        {
                           pet = Pet.heroIdList[player.id];
                           if(Boolean(pet))
                           {
                              setTempRoute(pet,player,player.tempRoute,0);
                           }
                           player.route = player.tempRoute;
                           player.tempRoute = null;
                        }
                     }
                  }
               }
            }
            pets = Pet.list;
            for each(pet in pets)
            {
               if(pet.tempRoute)
               {
                  master = findUnit(pet.heroId,UnitType.PLAYER) as Player;
                  if(Boolean(master))
                  {
                     if(Util.dist(master.global_x,master.global_y,pet.global_x,pet.global_y) > 6400)
                     {
                        pet.route = pet.tempRoute;
                        pet.tempRoute = null;
                     }
                  }
               }
            }
            if(Model_CrossCampBattle.battleCarArr.length > 0 && SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
            {
               cars = Model_CrossCampBattle.battleCarArr;
               i = 0;
               while(i < cars.length)
               {
                  master = findUnit(Model_CrossCampBattle.battleCarPlayerArr[i],UnitType.PLAYER) as Player;
                  if(Boolean(master))
                  {
                     npc = GameUnitManager.findUnit(cars[i],UnitType.NPC) as Npc;
                     if(Boolean(npc) && Boolean(Util.dist(master.global_x,master.global_y,npc.global_x,npc.global_y) > 16400) && Boolean(npc.tempRoute))
                     {
                        npc.route = npc.tempRoute;
                        npc.tempRoute = null;
                     }
                  }
                  i++;
               }
            }
         }
      }
      
      public static function setTempRoute(follow:Role, host:Role, route:Array, isOld:int = 1) : void
      {
         var sx:int = 0;
         var sy:int = 0;
         var y1:Number = NaN;
         var x1:Number = NaN;
         if(Boolean(isOld) && follow is Pet)
         {
            return;
         }
         follow.tempRoute = route.concat();
         if(!route.length || follow is Pet || SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            follow.tempRoute.unshift([host.global_x,host.global_y]);
         }
         var ey:int = int(follow.tempRoute[follow.tempRoute.length - 1][1]);
         var ex:int = int(follow.tempRoute[follow.tempRoute.length - 1][0]);
         if(follow.tempRoute.length >= 2)
         {
            sx = int(follow.tempRoute[follow.tempRoute.length - 2][0]);
            sy = int(follow.tempRoute[follow.tempRoute.length - 2][1]);
         }
         else
         {
            sx = host.global_x;
            sy = host.global_y;
         }
         var round:Number = Math.atan2(ey - sy,ex - sx);
         if(follow is Player)
         {
            y1 = ey - 60 * (follow as Player).teamPosition * Math.sin(round);
            x1 = ex - 60 * (follow as Player).teamPosition * Math.cos(round);
         }
         else
         {
            y1 = ey - 50 * Math.sin(round);
            x1 = ex - 100 * Math.cos(round);
         }
         follow.tempRoute.pop();
         follow.tempRoute.push([x1,y1]);
      }
      
      private static function testUnit(obj:DisplayObject) : GameUnit
      {
         var tem:Bitmap = null;
         if(obj is GameUnit)
         {
            if(obj is Role)
            {
               tem = (obj as Role).parts.getPart(Parts.BODY);
               if(Boolean(tem) && Boolean(tem.bitmapData) && !Utils.checkAlpha(tem))
               {
                  return null;
               }
            }
            return obj as GameUnit;
         }
         if(Boolean(obj.parent))
         {
            return testUnit(obj.parent);
         }
         return null;
      }
      
      public static function addUnit(unit:GameUnit) : void
      {
         if(list.indexOf(unit) == -1)
         {
            list.push(unit);
            GameScene.mainLayer.addChild(unit);
            unit.visible = _allVisibel;
         }
         if(list.length > 200)
         {
            if(Global.stage.frameRate == 30)
            {
               Global.stage.frameRate = 24;
            }
         }
         unit.show();
      }
      
      public static function removeUnit(unit:GameUnit) : void
      {
         var index:int = list.indexOf(unit);
         if(index >= 0)
         {
            list.splice(index,1);
         }
         if(unit.parent != GameScene.mainLayer)
         {
            Utils.print("GameUnitManager::removeUnit 错误: x,y,type,object",unit.global_x,unit.global_y,unit.type,unit);
         }
         if(Boolean(unit.parent))
         {
            unit.parent.removeChild(unit);
         }
         if(list.length < 200)
         {
            if(GameScene.mainLayer.cacheAsBitmap)
            {
               GameScene.mainLayer.cacheAsBitmap = false;
            }
            if(Global.stage.frameRate == 24)
            {
               Global.stage.frameRate = 30;
            }
         }
         unit.dispose();
      }
      
      public static function findUnit(id:Number, type:int) : GameUnit
      {
         switch(type)
         {
            case UnitType.PLAYER:
               return Player.list[id];
            case UnitType.NPC:
               return Npc.list[id];
            case UnitType.BABY:
               return NpcBaby.list[id];
            case UnitType.MAGIC:
               return Magic.list[id];
            case UnitType.PET:
               return Pet.list[id];
            case UnitType.FUBEN_DIAOXIANG:
               return PaTaDiaoXiang.list[id];
            case UnitType.CITY_DIAOXIANG:
               return CityDiaoXiang.list[id];
            case UnitType.HUNLI:
               return HunLi.list[id];
            case UnitType.JUMP_POINT:
               return Door.list[id];
            case UnitType.SHEN_BING:
               return ShenBingUnit.list[id];
            case UnitType.HUANGBANG_POINT:
               return LoopPoint.list[id];
            case UnitType.HOMEBUILDS:
               return CreatedBuildings.list[id];
            default:
               return null;
         }
      }
      
      public static function getUnit(type:int) : GameUnit
      {
         switch(type)
         {
            case UnitType.PLAYER:
               return Boolean(Player.pool.length) ? Player.pool.pop() : new Player();
            case UnitType.NPC:
               return Boolean(Npc.pool.length) ? Npc.pool.pop() : new Npc();
            case UnitType.MAGIC:
               return Boolean(Magic.pool.length) ? Magic.pool.pop() : new Magic();
            case UnitType.PET:
               return Boolean(Pet.pool.length) ? Pet.pool.pop() : new Pet();
            case UnitType.FUBEN_DIAOXIANG:
               return Boolean(PaTaDiaoXiang.pool.length) ? PaTaDiaoXiang.pool.pop() : new PaTaDiaoXiang();
            case UnitType.CITY_DIAOXIANG:
               return Boolean(CityDiaoXiang.pool.length) ? CityDiaoXiang.pool.pop() : new CityDiaoXiang();
            case UnitType.BAOXIANG:
               return Boolean(BaoXiang.pool.length) ? BaoXiang.pool.pop() : new BaoXiang();
            case UnitType.JUMP_POINT:
               return Boolean(Door.pool.length) ? Door.pool.pop() : new Door();
            case UnitType.SHEN_BING:
               return ShenBingUnit.getShenBingUnit();
            case UnitType.HUANGBANG_POINT:
               return Boolean(LoopPoint.pool.length) ? LoopPoint.pool.pop() : new LoopPoint();
            case UnitType.HOMEBUILDS:
               return CreatedBuildings.pool.length > 0 ? CreatedBuildings.pool.pop() : new CreatedBuildings();
            case UnitType.BABY:
               return NpcBaby.pool.length > 0 ? NpcBaby.pool.pop() : new NpcBaby();
            default:
               return null;
         }
      }
      
      public static function align() : void
      {
         var i:int = list.length - 1;
         while(i >= 0)
         {
            list[i].align();
            i--;
         }
      }
      
      public static function setAllVisible(visible:Boolean) : void
      {
         var unit:GameUnit = null;
         _allVisibel = visible;
         var needHidePlayer:Boolean = visible && !_isShowPlayer;
         var i:int = list.length - 1;
         while(i >= 0)
         {
            unit = list[i];
            if(!(needHidePlayer && (unit is Player && unit.id != hero.id || unit is Pet)))
            {
               unit.visible = visible;
            }
            i--;
         }
      }
      
      public static function set isShowPlayer(value:Boolean) : void
      {
         var player:Player = null;
         var pet:Pet = null;
         var sb:ShenBingUnit = null;
         if(GuideManager.isPlaying)
         {
            return;
         }
         _isShowPlayer = value;
         if(_isShowPlayer)
         {
            UIManager.selfBroadcast.addMsg(LangConfig.getWord("10548",1));
         }
         else
         {
            UIManager.selfBroadcast.addMsg(LangConfig.getWord("10549",1));
         }
         if(SceneConfig.getSceneType() == SceneConfig.KUNLUN)
         {
            return;
         }
         for each(player in Player.list)
         {
            if(!(player is Hero))
            {
               setSinglePlayerVisible(player);
            }
         }
         for each(pet in Pet.list)
         {
            if(pet.heroId != hero.id)
            {
               setSinglePetVisible(pet);
            }
         }
         for each(sb in ShenBingUnit.list)
         {
            if(sb.shenBingOwner != hero)
            {
               setSingleShenBingVisible(sb);
            }
         }
      }
      
      public static function setSinglePlayerVisible(player:Player) : void
      {
         if(SceneConfig.getSceneType() == SceneConfig.KUNLUN)
         {
            if(!player.visible)
            {
               player.visible = true;
            }
            return;
         }
         if(player.status == Status.AiDeBaoBao_BeiBao)
         {
            player.visible = false;
            return;
         }
         player.visible = _allVisibel && _isShowPlayer;
      }
      
      public static function setSinglePetVisible(pet:Pet) : void
      {
         if(SceneConfig.getSceneType() == SceneConfig.KUNLUN)
         {
            if(!pet.visible)
            {
               pet.visible = true;
            }
            return;
         }
         pet.visible = _allVisibel && _isShowPlayer;
      }
      
      public static function setSingleShenBingVisible(sb:ShenBingUnit) : void
      {
         sb.visible = _allVisibel && _isShowPlayer;
      }
      
      public static function get isShowPlayer() : Boolean
      {
         return _isShowPlayer;
      }
      
      public static function dispose() : void
      {
         var i:int = list.length - 1;
         while(i >= 0)
         {
            removeUnit(list[i]);
            i--;
         }
         Magic.clear_url_init();
      }
   }
}

