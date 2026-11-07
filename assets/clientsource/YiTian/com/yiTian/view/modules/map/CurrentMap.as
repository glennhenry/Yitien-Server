package com.yiTian.view.modules.map
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_npc_type;
   import com.yiTian.data.config.Enum_pata_map;
   import com.yiTian.data.model.Model_kunlun;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.MapManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.WorldConfig;
   import com.yiTian.view.modules.crossClanBattle.Model_CrossClanBattle;
   import com.yiTian.view.modules.fishing.Model_fishing;
   import com.yiTian.view.modules.pata.PataVO;
   import com.yiTian.view.modules.ship.Ship;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFieldType;
   import flash.utils.Dictionary;
   
   public class CurrentMap extends Sprite
   {
      
      private var instance46:DisplayObject;
      
      private var instance48:DisplayObject;
      
      private var instance50:MyTextField;
      
      private var instance51:MyTextField;
      
      private var Button_Go:Button;
      
      private var Place_text:MyTextField;
      
      private var XAxis_text:MyTextField;
      
      private var YAxis_text:MyTextField;
      
      private var map:Map = new Map();
      
      private var heroPoint:MapPoint;
      
      private var mapItemList:Array = [];
      
      private var textItemList:Array = [];
      
      private var npcs:Array = [];
      
      private var monsters:Array = [];
      
      private var bxtArr:Array = [];
      
      private var bxpArr:Array = [];
      
      private var teamPoints:Array = [];
      
      public function CurrentMap()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":423.95,
            "y":45,
            "width":40,
            "height":21
         },Global.Img_Cdm);
         this.instance50 = ComponentUtil.getTextField("X",this,{
            "x":349.85,
            "y":46.6,
            "color":11527396
         });
         this.instance51 = ComponentUtil.getTextField("Y",this,{
            "x":410.85,
            "y":46.6,
            "color":11527396
         });
         this.Button_Go = ComponentUtil.getButton(LangConfig.getWord("10609",1),"Button_Four",this,{
            "x":478,
            "y":44,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Go.callBack = this.go;
         this.Place_text = ComponentUtil.getTextField(LangConfig.getWord("10610",1),this,{
            "x":220,
            "y":47.1,
            "color":16043313,
            "realWidth":100,
            "align":"right"
         });
         this.XAxis_text = ComponentUtil.getTextField("122",this,{
            "x":372.05,
            "y":47.1,
            "color":11527396,
            "type":TextFieldType.INPUT,
            "realWidth":35,
            "restrict":"0-9"
         });
         this.YAxis_text = ComponentUtil.getTextField("122",this,{
            "x":432.05,
            "y":47.1,
            "color":11527396,
            "type":TextFieldType.INPUT,
            "realWidth":35,
            "restrict":"0-9"
         });
         this.map.x = 20;
         this.map.y = 73;
         this.map.smoothing = true;
         addChild(this.map);
         this.heroPoint = MapPoint.getPoint();
         this.heroPoint.enabled = false;
         this.heroPoint.mouseEnabled = false;
         this.heroPoint.init({"type":MapPoint.SELF});
         this.map.addChild(this.heroPoint);
         this.setRotation(90 + GameUnitManager.hero.way * 45);
         visible = false;
      }
      
      private function go(e:MouseEvent) : void
      {
         Model_CrossClanBattle.mouseX = int(this.XAxis_text.text) * 20;
         Model_CrossClanBattle.mouseY = int(this.YAxis_text.text) * 20;
         if(Global.sceneMap == 14401)
         {
            return;
         }
         GameUnitManager.hero.go(int(this.XAxis_text.text) * 20,int(this.YAxis_text.text) * 20);
      }
      
      public function addShipPoint(ship:Ship) : void
      {
         this.map.addShip(ship,1);
      }
      
      public function refreshShip(ship:Ship) : void
      {
         this.map.refreshShip(ship,1);
      }
      
      public function removeShip(ship:Ship) : void
      {
         this.map.removeShip(ship,1);
      }
      
      public function refresh() : void
      {
         this.setTitle();
         this.updateMap();
         this.updateList();
      }
      
      public function setTitle() : void
      {
         var level:int = 0;
         if(SceneConfig.getSceneType() == SceneConfig.PATA)
         {
            this.Place_text.text = LangConfig.getWord("10520",1,PataVO.layers);
         }
         else if(Global.sceneID == 12201)
         {
            this.Place_text.text = LangConfig.getWord("10521",1) + Model_fishing.getInstance().currentRiverId.toString();
         }
         else if(Global.sceneID == 12001)
         {
            level = Boolean(Model_kunlun.myKLInfo.getData().myIndex) ? int(Model_kunlun.myKLInfo.getData().myIndex + 1) : 1;
            this.Place_text.text = LangConfig.getWord("10522",1,level);
         }
         else
         {
            this.Place_text.text = MapManager.mapInfo.name;
         }
         var str:String = this.Place_text.text;
         if(str.indexOf("光明顶") != -1)
         {
            this.Place_text.text = str.replace("明","眀");
         }
      }
      
      private function updateMap() : void
      {
         this.map.bitmapData = UIManager.smallMap.mapData;
         this.map.width = 520;
         this.map.height = 320;
         this.map.sx = MapManager.mapInfo.width / 520;
         this.map.sy = MapManager.mapInfo.height / 320;
         this.watch();
      }
      
      private function updateList() : void
      {
         var item:Object = null;
         var temp_text:Object = null;
         var npcType:int = 0;
         var temName:String = null;
         var mapItem:MapPoint = null;
         var npcTF:MyTextField = null;
         var maptype:int = 0;
         var type:int = 0;
         var pointX:int = 0;
         var pointY:int = 0;
         var doorPoint:MapPoint = null;
         var tempStr:String = null;
         var pointText:MyTextField = null;
         var pointName:String = null;
         var s:String = null;
         this.clear();
         var pointDic:Dictionary = new Dictionary();
         this.npcs = [];
         var arr:Array = MapManager.mapInfo.items;
         for each(item in MapManager.mapInfo.items)
         {
            if(item.type == MapPoint.FUN_NPC)
            {
               if(Data_lib.npc[item.id])
               {
                  npcType = int(Data_lib.npc[item.id][Npc.NPC_TYPE]);
                  if(SceneConfig.getSceneType() != SceneConfig.KFBZ_BATTLE)
                  {
                     if(!Enum_npc_type.canDialog(npcType) && npcType != Enum_npc_type.BAO_XIANG && item.id != 53536 && item.id != 53535)
                     {
                        continue;
                     }
                  }
                  item.name = Data_lib.npc[item.id][Npc.NAME];
                  if(item.name != "0")
                  {
                     item.official = Data_lib.npc[item.id][Npc.OFFICIAL];
                     temName = "";
                     if(item.official != null)
                     {
                        if(item.name != null)
                        {
                           temName = (item.official == "0" ? "" : item.official + "\n") + Data_lib.npc[item.id][Npc.NAME];
                        }
                        else
                        {
                           item.name = item.official;
                           temName = item.official;
                        }
                     }
                     else if(Boolean(item.name))
                     {
                        temName = item.name;
                     }
                     this.npcs.push(item);
                     mapItem = MapPoint.getPoint();
                     mapItem.x = item.lx = int(item.x / this.map.sx);
                     mapItem.y = item.ly = int(item.y / this.map.sy);
                     mapItem.init({
                        "type":MapPoint.FUN_NPC,
                        "name":temName,
                        "minimap_label":item.minimap_label
                     });
                     this.map.addChild(mapItem);
                     this.mapItemList.push(mapItem);
                     npcTF = ComponentUtil.getTextField(item.name,null,{"color":16776960});
                     npcTF.x = mapItem.x - npcTF.width / 2;
                     npcTF.y = mapItem.y - npcTF.height - 5;
                     if(npcTF.x + npcTF.width > this.map.width)
                     {
                        npcTF.x = this.map.width - npcTF.width - 5;
                     }
                     this.textItemList.push(npcTF);
                  }
               }
            }
            else if(item.type == MapPoint.JUMP_POINT)
            {
               maptype = SceneConfig.getSceneType();
               if(maptype == SceneConfig.KUNLUN)
               {
                  item.name = item.id == 1 ? LangConfig.getWord("10514",1) : LangConfig.getWord("10515",1);
               }
               else if(maptype == SceneConfig.PATA)
               {
                  type = int(Data_lib.sceneData[Global.sceneID][Enum_pata_map.JUMPPOINT_TYPE]);
                  item.name = type == UnitType.FUBENG_POINT ? LangConfig.getWord("10516",1) : LangConfig.getWord("10517",1);
               }
               else if(maptype == SceneConfig.GMD)
               {
                  item.name = "光眀顶";
               }
               else
               {
                  if(!WorldConfig.getMapConfig(item.tarMap))
                  {
                     continue;
                  }
                  item.name = WorldConfig.getMapConfig(item.tarMap).name;
               }
               if(!pointDic[item.name])
               {
                  pointDic[item.name] = item.name;
                  pointX = int(item.x / this.map.sx);
                  pointY = int(item.y / this.map.sy);
                  doorPoint = MapPoint.getPoint();
                  doorPoint.x = pointX;
                  doorPoint.y = pointY;
                  doorPoint.init({
                     "type":MapPoint.JUMP_POINT,
                     "name":LangConfig.getWord("10518",1) + item.name
                  });
                  this.map.addChild(doorPoint);
                  this.mapItemList.push(doorPoint);
                  tempStr = item.name;
                  if(tempStr.indexOf("光明顶") != -1)
                  {
                     item.name = tempStr.replace("明","眀");
                  }
                  pointText = ComponentUtil.getTextField(LangConfig.getWord("10518",1) + item.name,null,{"color":16776960});
                  pointText.x = doorPoint.x - pointText.width / 2;
                  pointText.y = doorPoint.y - pointText.height - 5;
                  if(pointText.x + pointText.width > this.map.width)
                  {
                     pointText.x = this.map.width - pointText.width - 5;
                  }
                  if(pointText.x < 0)
                  {
                     pointText.x = 0;
                  }
                  this.textItemList.push(pointText);
               }
            }
            else if(item.type == MapPoint.FUBENG_POINT)
            {
               if(Global.isPata)
               {
                  type = int(Data_lib.sceneData[Global.sceneID][Enum_pata_map.JUMPPOINT_TYPE]);
                  if(SceneConfig.getSceneType() == SceneConfig.PATA)
                  {
                     s = LangConfig.getWord("10517",1);
                  }
                  else
                  {
                     s = LangConfig.getWord("10634",1);
                  }
                  pointName = type == UnitType.FUBENG_POINT ? LangConfig.getWord("10516",1) : s;
               }
               else
               {
                  pointName = Data_lib.fubenPoint[item.id][1];
               }
               doorPoint = MapPoint.getPoint();
               doorPoint.x = int(item.x / this.map.sx);
               doorPoint.y = int(item.y / this.map.sy);
               doorPoint.init({
                  "type":MapPoint.FUBENG_POINT,
                  "name":LangConfig.getWord("10518",1) + pointName + LangConfig.getWord("10519",1)
               });
               this.map.addChild(doorPoint);
               this.mapItemList.push(doorPoint);
               pointText = ComponentUtil.getTextField("",null,{"color":9109248});
               pointText.htmlText = LangConfig.getWord("10518",1) + pointName + HtmlUtil.fontNoSize(LangConfig.getWord("10519",1),"#ffc533");
               pointText.x = doorPoint.x - pointText.width / 2;
               pointText.y = doorPoint.y - pointText.height - 8;
               if(pointText.x + pointText.width > this.map.width)
               {
                  pointText.x = this.map.width - pointText.width - 5;
               }
               if(pointText.x < 0)
               {
                  pointText.x = 0;
               }
               this.textItemList.push(pointText);
            }
         }
         for each(temp_text in this.textItemList)
         {
            if(temp_text is MyTextField)
            {
               this.map.addChild(temp_text as MyTextField);
            }
         }
      }
      
      public function addBX(name:String, x:int, y:int) : void
      {
         var mapItem:MapPoint = null;
         var bxTF:MyTextField = null;
         mapItem = MapPoint.getPoint();
         mapItem.x = int(x / this.map.sx);
         mapItem.y = int(y / this.map.sy);
         mapItem.init({
            "type":MapPoint.FUN_NPC,
            "name":name,
            "minimap_label":name
         });
         this.map.addChild(mapItem);
         this.mapItemList.push(mapItem);
         this.bxpArr.push(mapItem);
         bxTF = ComponentUtil.getTextField(name,null,{"color":16776960});
         bxTF.x = mapItem.x - bxTF.width / 2;
         bxTF.y = mapItem.y - bxTF.height - 5;
         if(bxTF.x + bxTF.width > this.map.width)
         {
            bxTF.x = this.map.width - bxTF.width - 5;
         }
         this.map.addChild(bxTF);
         this.textItemList.push(bxTF);
         this.bxtArr.push(bxTF);
      }
      
      public function removeBX() : void
      {
         var index:int = 0;
         var i:uint = 0;
         while(i < this.bxpArr.length)
         {
            if(this.map.contains(this.bxpArr[i]))
            {
               this.map.removeChild(this.bxpArr[i]);
            }
            index = this.mapItemList.indexOf(this.bxpArr[i]);
            if(index > -1)
            {
               this.mapItemList.splice(index,1);
            }
            i++;
         }
         i = 0;
         while(i < this.bxtArr.length)
         {
            if(this.map.contains(this.bxtArr[i]))
            {
               this.map.removeChild(this.bxtArr[i]);
            }
            index = this.textItemList.indexOf(this.bxtArr[i]);
            if(index > -1)
            {
               this.textItemList.splice(index,1);
            }
            i++;
         }
         this.bxtArr = [];
         this.bxpArr = [];
      }
      
      private function clear() : void
      {
         var text:MyTextField = null;
         while(Boolean(this.mapItemList.length))
         {
            this.mapItemList.pop().dispose();
         }
         for each(text in this.textItemList)
         {
            if(Boolean(text.parent))
            {
               text.parent.removeChild(text);
            }
            text.dispose();
         }
         this.mapItemList.length = 0;
         this.textItemList.length = 0;
      }
      
      public function watch() : void
      {
         if(Boolean(this.map.sx) && Boolean(this.map.sy))
         {
            if(Global.sceneMap == 14401)
            {
               if(Boolean(Ship.myShip))
               {
                  this.heroPoint.x = int(Ship.myShip.global_x / this.map.sx);
                  this.heroPoint.y = int(Ship.myShip.global_y / this.map.sy);
               }
               if(this.heroPoint.visible)
               {
                  this.heroPoint.visible = false;
               }
            }
            else
            {
               this.heroPoint.x = int(GameUnitManager.hero.global_x / this.map.sx);
               this.heroPoint.y = int(GameUnitManager.hero.global_y / this.map.sy);
               if(!this.heroPoint.visible)
               {
                  this.heroPoint.visible = true;
               }
            }
            if(!this.map.contains(this.heroPoint))
            {
               this.map.addChild(this.heroPoint);
            }
         }
      }
      
      public function setRotation(rotation:Number) : void
      {
         this.heroPoint.rotation = rotation;
      }
      
      public function drawPath(path:Array) : void
      {
         this.map.drawPath(path,this.map.sx,this.map.sy);
      }
      
      public function clearPath() : void
      {
         this.map.clearPath();
      }
      
      public function addTeamPoint(id:Number, $name:String, global_x:int, global_y:int) : void
      {
         var point:MapPoint = null;
         if(Boolean(this.teamPoints[id]))
         {
            this.delTeamPoint(id);
         }
         point = MapPoint.getPoint();
         point.init({
            "type":MapPoint.TEAM,
            "name":$name
         });
         point.x = int(global_x / this.map.sx);
         point.y = int(global_y / this.map.sy);
         this.map.addChild(point);
         this.teamPoints[id] = point;
      }
      
      public function refreshTeamPoint(id:Number, global_x:int, global_y:int) : void
      {
         if(Boolean(this.teamPoints[id]))
         {
            this.teamPoints[id].x = int(global_x / this.map.sx);
            this.teamPoints[id].y = int(global_y / this.map.sy);
         }
      }
      
      public function delTeamPoint(id:Number) : void
      {
         var point:MapPoint = null;
         if(this.teamPoints[id] != null)
         {
            point = this.teamPoints[id];
            delete this.teamPoints[id];
            if(Boolean(point))
            {
               point.dispose();
            }
         }
      }
      
      public function delTeamPoints() : void
      {
         var point:MapPoint = null;
         var i:int = int(this.teamPoints.length);
         while(i > 0)
         {
            point = this.teamPoints[i] as MapPoint;
            if(Boolean(point))
            {
               point.dispose();
            }
            i--;
         }
      }
   }
}

