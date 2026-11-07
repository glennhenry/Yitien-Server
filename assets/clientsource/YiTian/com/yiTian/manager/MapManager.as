package com.yiTian.manager
{
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.config.Enum_scene_type;
   import com.yiTian.data.model.Model_CrossDart;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.magic.Magic;
   import com.yiTian.gameUnit.role.Door;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.AStar;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.geom.ColorTransform;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class MapManager
   {
      
      public static var RIGHT_BORDER:int;
      
      public static var BOTTOM_BORDER:int;
      
      public static var RIGHT_X:int;
      
      public static var RIGHT_Y:int;
      
      private static var block_row:int;
      
      private static var block_col:int;
      
      private static var length:int;
      
      private static var lastEnterMapId:int;
      
      private static var bNight:Boolean;
      
      private static var mask:Shape;
      
      public static var numLoadingItem:int;
      
      private static var a1:Number;
      
      private static var a2:Number;
      
      public static var BLOCK_WIDTH:int = 500;
      
      public static var BLOCK_HEIGHT:int = 300;
      
      public static var TILE_SIZE:int = 25;
      
      public static var mapInfo:Object = new Object();
      
      public static var fubenInfo:Dictionary = new Dictionary();
      
      private static var list:Vector.<Bitmap> = new Vector.<Bitmap>();
      
      private static var listPool:Vector.<Bitmap> = new Vector.<Bitmap>();
      
      private static var mapPool:Dictionary = new Dictionary();
      
      public static var HomeScale:Number = 1;
      
      public static var isLoadMap:Boolean = false;
      
      private static var isInitHome:Boolean = false;
      
      public static var map_data:ByteArray = new ByteArray();
      
      public static var isFubenFinish:Boolean = false;
      
      private static var isfirstEnterHome:Boolean = false;
      
      public static var loadQueue:Array = [];
      
      public static var MAX:int = 1;
      
      public function MapManager()
      {
         super();
      }
      
      public static function initFubenInfo(fubenStr:String) : void
      {
         var tempData:Array = null;
         var fubenData:Array = fubenStr.split("|");
         var i:int = 0;
         while(i < fubenData.length)
         {
            if(Boolean(fubenData[i]))
            {
               tempData = fubenData[i].split("_");
               fubenInfo[tempData[0]] = tempData[1];
            }
            i++;
         }
      }
      
      public static function init() : void
      {
         var block:Bitmap = null;
         var row:int = 0;
         var map:Bitmap = null;
         var col:int = 0;
         if(Global.isInBattle)
         {
            return;
         }
         var len:int = int(list.length);
         var i:int = len - 1;
         while(i >= 0)
         {
            map = list[i];
            GameScene.mapLayer.removeChild(map);
            listPool.push(map);
            list.splice(i,1);
            i--;
         }
         block_row = Math.ceil(Global.stage.stageHeight / BLOCK_HEIGHT) + 1;
         block_col = Math.ceil(Global.stage.stageWidth / BLOCK_WIDTH) + 1;
         row = 0;
         while(row < block_row)
         {
            col = 0;
            while(col < block_col)
            {
               block = Boolean(listPool.length) ? listPool.pop() : new Bitmap();
               block.x = col * BLOCK_WIDTH;
               block.y = row * BLOCK_HEIGHT;
               GameScene.mapLayer.addChild(block);
               list.push(block);
               col++;
            }
            row++;
         }
         RIGHT_BORDER = mapInfo.width - Global.stage.stageWidth;
         BOTTOM_BORDER = mapInfo.height - Global.stage.stageHeight;
      }
      
      public static function setNight(value:Boolean) : void
      {
         bNight = value;
         updateNight();
      }
      
      private static function updateNight() : void
      {
         var colorTransform:ColorTransform = new ColorTransform();
         if(bNight)
         {
            colorTransform.redOffset = -50;
            colorTransform.greenOffset = -40;
            colorTransform.blueOffset = -30;
            if(!mask)
            {
               mask = new Shape();
               mask.graphics.beginFill(0,0.4);
               mask.graphics.drawRect(0,0,3000,3000);
               mask.graphics.endFill();
            }
            GameScene.mapLayer.addChild(mask);
         }
         else
         {
            colorTransform.redOffset = 0;
            colorTransform.greenOffset = 0;
            colorTransform.blueOffset = 0;
            if(Boolean(mask) && GameScene.mapLayer.contains(mask))
            {
               GameScene.mapLayer.removeChild(mask);
            }
         }
         GameScene.mapLayer.transform.colorTransform = colorTransform;
      }
      
      public static function decodeConfig(info:Object) : void
      {
         var length:int = 0;
         var i:int = 0;
         var obj:Object = null;
         var door:Door = null;
         var need_add:Boolean = false;
         var arr:Object = null;
         var aa:Array = null;
         var indexX_door:int = 0;
         var indexY_door:int = 0;
         var k:int = 0;
         var j:int = 0;
         var temp1:int = 0;
         var temp2:int = 0;
         var magic:Magic = null;
         var magicData:Array = null;
         isLoadMap = true;
         info.data.uncompress();
         var mapId:int = int(info.data.readInt());
         if(mapId != Global.sceneMap)
         {
            return;
         }
         mapInfo.id = mapId;
         mapInfo.name = info.data.readUTF();
         mapInfo.width = info.data.readInt();
         mapInfo.height = info.data.readInt();
         map_data.length = 0;
         ByteArray(info.data).readBytes(map_data);
         AStar.jump_position = null;
         AStar.init(map_data);
         AStar.jump_position = [];
         mapInfo.items = [];
         mapInfo.jumpItems = [];
         var door_array:Dictionary = new Dictionary();
         var obj_array:Dictionary = new Dictionary();
         if(map_data.position < map_data.length)
         {
            length = map_data.readShort();
            i = 0;
            for(; i < length; i++)
            {
               obj = {};
               obj.id = map_data.readInt();
               obj.type = map_data.readShort();
               obj.x = map_data.readInt();
               obj.y = map_data.readInt();
               if(obj.type == UnitType.JUMP_POINT || obj.type == UnitType.FUBENG_POINT)
               {
                  need_add = true;
                  for(arr in door_array)
                  {
                     if(Math.abs(obj.x - arr[0]) < 300 && Math.abs(obj.y - arr[1]) < 300)
                     {
                        need_add = false;
                        door = door_array[arr];
                        arr[0] = (arr[0] * arr[2] + obj.x) / (arr[2] + 1);
                        arr[1] = (arr[1] * arr[2] + obj.y) / (arr[2] + 1);
                        arr[2] += 1;
                        door.global_x = arr[0];
                        door.global_y = arr[1];
                        if(Boolean(obj_array[arr]))
                        {
                           obj_array[arr].x = arr[0];
                           obj_array[arr].y = arr[1];
                        }
                        door.align();
                        break;
                     }
                  }
                  if(!need_add)
                  {
                     if(obj.type == UnitType.JUMP_POINT)
                     {
                        map_data.readInt();
                        map_data.readInt();
                        map_data.readInt();
                     }
                     indexX_door = obj.x / TILE_SIZE;
                     indexY_door = obj.y / TILE_SIZE;
                     k = -1;
                     while(k <= 1)
                     {
                        j = -1;
                        while(j <= 1)
                        {
                           temp1 = indexX_door + k;
                           temp2 = indexY_door + j;
                           if(temp2 >= 0 && temp1 >= 0 && temp2 < AStar._grid.numRows && temp1 < AStar._grid.numCols)
                           {
                              AStar._grid.getNode(temp1,temp2).jumpArea = true;
                              AStar._grid.getNode(temp1,temp2).jumpLink = door;
                              AStar.jump_position.push([temp1,temp2,door]);
                           }
                           j++;
                        }
                        k++;
                     }
                     continue;
                  }
                  door = new Door();
                  if(obj.type == UnitType.JUMP_POINT)
                  {
                     door.linkID = map_data.readInt();
                  }
                  door.type = UnitType.JUMP_POINT;
                  door.door_type = obj.type;
                  door.init(obj.id,obj.x,obj.y,0,true,35001,500);
                  if(obj.type == UnitType.JUMP_POINT)
                  {
                     door.toX = map_data.readInt();
                     door.toY = map_data.readInt();
                  }
                  GameUnitManager.addUnit(door);
                  door.visible = Global.sceneType != Enum_scene_type.FUBEN || Global.sceneID == 12001 || Global.sceneID >= 12401 && Global.sceneID <= 12406 || SceneConfig.getSceneType() == SceneConfig.HOME;
                  if(Model_CrossDart.inCrossScence && door.door_type == UnitType.FUBENG_POINT)
                  {
                     door.visible = false;
                  }
                  mapInfo.jumpItems.push(door);
                  if(obj.type == UnitType.JUMP_POINT)
                  {
                     obj.tarMap = door.linkID;
                     obj.toX = door.toX;
                     obj.toY = door.toY;
                  }
                  aa = [obj.x,obj.y,1];
                  door_array[aa] = door;
                  obj_array[aa] = obj;
                  indexX_door = obj.x / TILE_SIZE;
                  indexY_door = obj.y / TILE_SIZE;
                  k = -1;
                  while(k <= 1)
                  {
                     j = -1;
                     while(j <= 1)
                     {
                        temp1 = indexX_door + k;
                        temp2 = indexY_door + j;
                        if(temp2 >= 0 && temp1 >= 0 && temp2 < AStar._grid.numRows && temp1 < AStar._grid.numCols)
                        {
                           AStar._grid.getNode(temp1,temp2).jumpArea = true;
                           AStar._grid.getNode(temp1,temp2).jumpLink = door;
                           AStar.jump_position.push([temp1,temp2,door]);
                        }
                        j++;
                     }
                     k++;
                  }
               }
               else if(obj.type == UnitType.MINIMAP_POINT)
               {
                  obj.text = map_data.readUTF();
                  obj.color = map_data.readUTF();
                  obj.size = map_data.readUnsignedInt();
               }
               else if(obj.type == UnitType.EFFECT_POINT)
               {
                  obj.effectText = map_data.readUTF();
                  obj.x = map_data.readInt();
                  obj.y = map_data.readInt();
                  magic = GameUnitManager.getUnit(UnitType.MAGIC) as Magic;
                  magicData = Data_lib.magic[obj.effectText];
                  if(Boolean(magicData))
                  {
                     magic.url_init(obj.effectText,obj.x,obj.y,true,obj.id,magicData[Magic.PLAYTIME],true,magicData[Magic.PLAYWORD]);
                     if(Boolean(int(magic.rotation)))
                     {
                        magic.rotation = magicData[Magic.ROTATION];
                     }
                  }
                  else
                  {
                     magic.url_init(obj.id,obj.x,obj.y,true,obj.id,3000);
                  }
                  continue;
               }
               mapInfo.items.push(obj);
            }
         }
         if(Boolean(map_data.bytesAvailable))
         {
            trace(1);
         }
         Utils.print("decodeConfig",5);
         RIGHT_BORDER = mapInfo.width - Global.stage.stageWidth;
         BOTTOM_BORDER = mapInfo.height - Global.stage.stageHeight;
         RIGHT_X = Math.ceil((mapInfo.width - BLOCK_WIDTH * 2) / BLOCK_WIDTH);
         RIGHT_Y = Math.ceil((mapInfo.height - BLOCK_HEIGHT * 2) / BLOCK_HEIGHT);
         Utils.print("decodeConfig",6);
         isFubenFinish = false;
      }
      
      private static function redrawMap(graphics:Graphics) : void
      {
         var line:Array = null;
         var j:int = 0;
         var node:Object = null;
         var color:uint = 0;
         var source:Array = AStar._grid.Nodes;
         graphics.clear();
         var i:int = 0;
         while(i < source.length)
         {
            line = source[i];
            if(line != null)
            {
               j = 0;
               while(j < line.length)
               {
                  node = line[j];
                  if(!Boolean(node.block))
                  {
                     graphics.lineStyle(1,268431360,0.5);
                     color = Boolean(node.alpha) ? 65280 : 16711680;
                     graphics.beginFill(color,0.1);
                     graphics.drawRect(node.x * TILE_SIZE,node.y * TILE_SIZE,TILE_SIZE,TILE_SIZE);
                     graphics.endFill();
                  }
                  j++;
               }
            }
            i++;
         }
      }
      
      public static function decodeThumb(info:Object) : void
      {
         if(info.url.indexOf(Global.sceneMap) == -1)
         {
            return;
         }
         if(info.url.indexOf(mapInfo.id) == -1)
         {
            return;
         }
         Global.thumbdm = info.applicationDomain;
         UIManager.smallMap.refresh();
         UIManager.mappanel.refresh();
         isLoadMap = false;
      }
      
      public static function decodeMediumMap(info:Object) : void
      {
      }
      
      public static function setJumpItemVisible() : void
      {
         isFubenFinish = true;
         var i:int = 0;
         while(i < mapInfo.jumpItems.length)
         {
            mapInfo.jumpItems[i].visible = true;
            i++;
         }
      }
      
      public static function refreshMap(ngx:int, ngy:int) : void
      {
         var n:int = 0;
         var col:int = 0;
         var row:int = 0;
         var url:String = null;
         var node:Node = null;
         n = 0;
         while(n < list.length)
         {
            col = ngx + n % block_col;
            row = ngy + int(n / block_col);
            if(!(col < 0 || row < 0 || col > RIGHT_X + 1 || row > RIGHT_Y + 1))
            {
               url = "mapRes/map/" + Global.sceneMap + "/" + row + "_" + col + ".jpg";
               node = mapPool[url];
               if(!node)
               {
                  node = Node.getNode();
                  node.data = getBitmapData("M" + row + "_" + col,Global.thumbdm);
                  node.scale = 10;
                  mapPool[url] = node;
                  MassLoader.add(url,loadeComplete,null,MassLoader.LEVEL6,null,Enum_resType.MAP_URL);
               }
               list[n].name = url;
               list[n].bitmapData = node.data;
               list[n].scaleX = node.scale;
               list[n].scaleY = node.scale;
            }
            n++;
         }
      }
      
      private static function loadStep() : void
      {
         var item:LoadItem = null;
         if(Boolean(loadQueue.length) && numLoadingItem < MAX)
         {
            item = getMinItem();
            numLoadingItem += 1;
            MassLoader.add(item.url,loadComplete1,null,MassLoader.LEVEL6,item,Enum_resType.MAP_URL);
         }
      }
      
      private static function getMinItem() : LoadItem
      {
         var curItem:LoadItem = null;
         var len:int = int(loadQueue.length);
         var minItem:LoadItem = loadQueue[0];
         var minIndex:int = 0;
         var i:int = 0;
         while(i < len)
         {
            curItem = loadQueue[i];
            if(compareFunc1(curItem,minItem) < 0)
            {
               minItem = curItem;
               minIndex = i;
            }
            i += 1;
         }
         loadQueue.splice(minIndex,1);
         return minItem;
      }
      
      private static function load1(row:int, col:int, url:String) : void
      {
         var loadItem:LoadItem = LoadItem.createInstance();
         loadItem.row = row;
         loadItem.col = col;
         loadItem.centerY = row * 300 + 150;
         loadItem.centerX = col * 500 + 250;
         loadItem.url = url;
         loadQueue.push(loadItem);
         loadStep();
      }
      
      private static function compareFunc1(a:LoadItem, b:LoadItem) : int
      {
         var camRow:int = CameraManager._y;
         var camCol:int = CameraManager._x;
         var aa:Number = ((a1 = camRow - a.centerY) < 0 ? -a1 : a1) + ((a2 = camCol - a.centerX) < 0 ? -a2 : a2);
         var bb:Number = ((a1 = camRow - b.centerY) < 0 ? -a1 : a1) + ((a2 = camCol - b.centerX) < 0 ? -a2 : a2);
         return aa - bb;
      }
      
      private static function loadComplete1(info:Object) : void
      {
         var item:LoadItem = info.obj;
         loadeComplete(info);
         end(item);
      }
      
      public static function end(item:LoadItem) : void
      {
         item.dispose();
         numLoadingItem -= 1;
         loadStep();
      }
      
      private static function waitTips() : void
      {
      }
      
      private static function getBitmapData(str:String, dm:ApplicationDomain = null) : BitmapData
      {
         var imges:Class = dm.getDefinition(str) as Class;
         return new imges(0,0);
      }
      
      private static function loadeComplete(info:Object) : void
      {
         var block:Bitmap = null;
         var url:String = null;
         var isUse:Boolean = false;
         var node:Node = mapPool[info.url];
         if(!node)
         {
            return;
         }
         node.data = (info.content as Bitmap).bitmapData;
         node.scale = 1;
         for each(block in list)
         {
            if(block.name == info.url)
            {
               block.bitmapData = node.data;
               block.scaleX = node.scale;
               block.scaleY = node.scale;
               break;
            }
         }
         ++length;
         if(length < 50)
         {
            return;
         }
         for(url in mapPool)
         {
            isUse = false;
            for each(block in list)
            {
               if(block.name == url)
               {
                  isUse = true;
               }
            }
            if(!isUse)
            {
               mapPool[url].data.dispose();
               delete mapPool[url];
               --length;
            }
            if(length < 50)
            {
               break;
            }
         }
      }
      
      private static function retBoo() : void
      {
         isInitHome = false;
         isfirstEnterHome = false;
      }
      
      public static function dispose() : void
      {
         var url:String = null;
         var item:LoadItem = null;
         for(url in mapPool)
         {
            mapPool[url].data.dispose();
            Node.pool.push(mapPool[url]);
            delete mapPool[url];
         }
         for each(item in loadQueue)
         {
            item.dispose();
         }
         loadQueue.length = 0;
      }
   }
}

import flash.display.BitmapData;

class LoadItem
{
   
   private static var pool:Array = [];
   
   public var url:String;
   
   public var row:int;
   
   public var col:int;
   
   public var centerX:int;
   
   public var centerY:int;
   
   public var loadState:int;
   
   public function LoadItem()
   {
      super();
   }
   
   public static function createInstance() : LoadItem
   {
      return Boolean(pool.length) ? pool.shift() : new LoadItem();
   }
   
   public function dispose() : void
   {
      pool.push(this);
   }
}

class Node
{
   
   public static var pool:Array = [];
   
   public var data:BitmapData;
   
   public var scale:int;
   
   public function Node()
   {
      super();
   }
   
   public static function getNode() : Node
   {
      var node:Node = null;
      node = pool.length > 0 ? pool.pop() : new Node();
      node.data = null;
      node.scale = 1;
      return node;
   }
}
