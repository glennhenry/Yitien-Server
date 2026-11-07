package com.yiTian.utils
{
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_npc_type;
   import com.yiTian.data.vo.Vo_mapTarItem;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.MapManager;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class WorldConfig
   {
      
      private static var maps:Array = [];
      
      private static var paths:Array = [];
      
      public function WorldConfig()
      {
         super();
      }
      
      public static function getJumpTargetPos(mapId:int) : Array
      {
         var key:Object = null;
         var nearMapId:int = 0;
         var nearMapVo:MapVo = null;
         var item:ItemVo = null;
         var sMapId:int = int(MapManager.mapInfo.id);
         for(key in paths)
         {
            if(key.sid == sMapId && key.did == mapId)
            {
               nearMapId = int(key.path[key.path.length - 2]);
               nearMapVo = getMapConfig(nearMapId);
               if(Boolean(nearMapVo))
               {
                  for each(item in nearMapVo.items)
                  {
                     if(item.type == UnitType.JUMP_POINT && item.tarMap == mapId)
                     {
                        return [item.toX,item.toY];
                     }
                  }
               }
            }
         }
         return null;
      }
      
      public static function getMapNameById(id:int, type:int) : String
      {
         var map:MapVo = null;
         var item:ItemVo = null;
         loop0:
         for each(map in maps)
         {
            var _loc7_:int = 0;
            var _loc8_:* = map.items;
            do
            {
               for each(item in _loc8_)
               {
               }
               continue loop0;
            }
            while(!(item.id == id && item.type == type));
            return map.name;
         }
         return null;
      }
      
      public static function getMapName(mapId:int) : String
      {
         var map:MapVo = null;
         for each(map in maps)
         {
            if(map.id == mapId)
            {
               return map.name;
            }
         }
         return null;
      }
      
      public static function getPosition(id:int, type:int) : Array
      {
         var map:MapVo = null;
         var item:ItemVo = null;
         loop0:
         for each(map in maps)
         {
            var _loc7_:int = 0;
            var _loc8_:* = map.items;
            do
            {
               for each(item in _loc8_)
               {
               }
               continue loop0;
            }
            while(!(item.id == id && item.type == type));
            return [item.x,item.y,map.id];
         }
         return null;
      }
      
      public static function getPoint(tarId:int, type:int) : Array
      {
         var map:MapVo = null;
         var item:ItemVo = null;
         loop0:
         for each(map in maps)
         {
            var _loc7_:int = 0;
            var _loc8_:* = map.items;
            do
            {
               for each(item in _loc8_)
               {
               }
               continue loop0;
            }
            while(!(item.id == tarId && item.type == type));
            return [map.id,item.x,item.y];
         }
         return null;
      }
      
      public static function getDirectPath(mapId:int, target:Vo_mapTarItem = null) : Array
      {
         var key:PathVo = null;
         var sMapId:int = int(MapManager.mapInfo.id);
         if(sMapId == mapId)
         {
            if(Boolean(target))
            {
               return [target];
            }
            return null;
         }
         for each(key in paths)
         {
            if(key.sid == sMapId && key.did == mapId)
            {
               if(Boolean(target))
               {
                  return key.route.concat([target]);
               }
               return key.route.concat();
            }
         }
         return null;
      }
      
      public static function getPath(tarId:int, type:int) : Array
      {
         var destMapId:int = 0;
         var destPoint:ItemVo = null;
         var destItem:Vo_mapTarItem = null;
         var map:MapVo = null;
         var pathvo:PathVo = null;
         var item:ItemVo = null;
         var sMapId:int = int(MapManager.mapInfo.id);
         for each(map in maps)
         {
            for each(item in map.items)
            {
               if(item.id == tarId && item.type == type)
               {
                  destMapId = map.id;
                  destPoint = item;
                  break;
               }
            }
            if(destPoint != null)
            {
               break;
            }
         }
         if(destPoint == null)
         {
            return null;
         }
         destItem = new Vo_mapTarItem();
         destItem.tarMap = destPoint.tarMap;
         destItem.x = destPoint.x;
         destItem.y = destPoint.y;
         if(sMapId == destMapId)
         {
            return [destItem];
         }
         for each(pathvo in paths)
         {
            if(pathvo.sid == sMapId && pathvo.did == destMapId)
            {
               destItem = new Vo_mapTarItem();
               destItem.tarMap = destPoint.tarMap;
               destItem.x = destPoint.x;
               destItem.y = destPoint.y;
               return pathvo.route.concat([destItem]);
            }
         }
         return null;
      }
      
      public static function getMapConfig(mapId:int) : MapVo
      {
         var map:MapVo = null;
         for each(map in maps)
         {
            if(map.id == mapId)
            {
               return map;
            }
         }
         return null;
      }
      
      public static function getMapMonster(mapId:int) : Array
      {
         var map:MapVo = null;
         var dic:Dictionary = null;
         var len:int = 0;
         var itemvo:ItemVo = null;
         var i:int = 0;
         var arr:Array = null;
         var npcData:Array = null;
         var npcId:String = null;
         for each(map in maps)
         {
            if(map.id == mapId)
            {
               dic = new Dictionary();
               len = int(map.items.length);
               i = 0;
               while(i < len)
               {
                  itemvo = map.items[i];
                  if(itemvo.type == UnitType.NPC && Enum_npc_type.canBattle(Data_lib.npc[itemvo.id][Npc.NPC_TYPE]))
                  {
                     if(Boolean(dic[itemvo.id]))
                     {
                        dic[itemvo.id] = int(dic[itemvo.id]) + 1;
                     }
                     else
                     {
                        dic[itemvo.id] = 1;
                     }
                  }
                  i++;
               }
               arr = [];
               for(npcId in dic)
               {
                  npcData = Data_lib.npc[npcId];
                  arr.push([npcId,npcData[Npc.NAME],dic[npcId]]);
               }
               return arr;
            }
         }
         return null;
      }
      
      public static function init(info:Object) : void
      {
         var mapVo:MapVo = null;
         var item_length:int = 0;
         var j:int = 0;
         var itemVo:ItemVo = null;
         var path:PathVo = null;
         var source:ByteArray = info.data;
         source.uncompress();
         var sz_map:int = source.readInt();
         var i:int = 0;
         while(i < sz_map)
         {
            mapVo = new MapVo();
            mapVo.id = source.readInt();
            mapVo.name = source.readUTF();
            mapVo.width = source.readInt();
            mapVo.height = source.readInt();
            item_length = source.readShort();
            j = 0;
            while(j < item_length)
            {
               itemVo = new ItemVo();
               itemVo.id = source.readInt();
               itemVo.type = source.readShort();
               itemVo.x = source.readInt();
               itemVo.y = source.readInt();
               mapVo.items.push(itemVo);
               j++;
            }
            maps.push(mapVo);
            i++;
         }
         var sz_paths:int = source.readInt();
         i = 0;
         while(i < sz_paths)
         {
            path = new PathVo();
            path.decode(source);
            paths.push(path);
            i++;
         }
      }
   }
}

import com.yiTian.data.vo.Vo_mapTarItem;
import flash.utils.ByteArray;

class MapVo
{
   
   public var id:int;
   
   public var name:String;
   
   public var width:int;
   
   public var height:int;
   
   public var items:Array = [];
   
   public function MapVo()
   {
      super();
   }
}

class ItemVo
{
   
   public var id:int;
   
   public var type:int;
   
   public var x:int;
   
   public var y:int;
   
   public var tarMap:int;
   
   public var toX:int;
   
   public var toY:int;
   
   public function ItemVo()
   {
      super();
   }
}

class PathVo
{
   
   public var sid:int;
   
   public var did:int;
   
   public var route:Array = [];
   
   public function PathVo()
   {
      super();
   }
   
   public function decode(bytes:ByteArray) : void
   {
      var tarItem:Vo_mapTarItem = null;
      this.sid = bytes.readInt();
      this.did = bytes.readInt();
      var temp_size:int = bytes.readShort();
      var i:int = 0;
      while(i < temp_size)
      {
         tarItem = new Vo_mapTarItem();
         tarItem.x = bytes.readShort();
         tarItem.y = bytes.readShort();
         tarItem.tarMap = bytes.readInt();
         this.route.push(tarItem);
         i++;
      }
   }
}
