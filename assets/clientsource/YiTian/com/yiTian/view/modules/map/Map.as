package com.yiTian.view.modules.map
{
   import com.yiTian.Global;
   import com.yiTian.gameUnit.role.Hero;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.MapManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.boatChall.MapShipPart;
   import com.yiTian.view.modules.crossClanBattle.Model_CrossClanBattle;
   import com.yiTian.view.modules.ship.Ship;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class Map extends Sprite
   {
      
      private static var listBmShip:Dictionary = new Dictionary();
      
      private static var listBmShip_curMap:Dictionary = new Dictionary();
      
      public var sx:Number;
      
      public var sy:Number;
      
      private var _bg:Bitmap;
      
      private var _up:Sprite;
      
      private var _hasPath:Boolean;
      
      public function Map()
      {
         super();
         this._bg = new Bitmap();
         this._bg.smoothing = true;
         addChild(this._bg);
         this._up = new Sprite();
         addChild(this._up);
         addEventListener(MouseEvent.CLICK,this.onMapClick);
         addEventListener(MouseEvent.MOUSE_MOVE,function(e:MouseEvent):void
         {
            if(e.target is MapPoint)
            {
               return;
            }
            TipManager.update("[ " + int(e.localX * sx / 20) + " , " + int(e.localY * sy / 20) + " ]");
         });
         addEventListener(MouseEvent.ROLL_OUT,function(e:MouseEvent):void
         {
            TipManager.hide();
         });
      }
      
      private function onMapClick(e:MouseEvent) : void
      {
         if(SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao || Global.sceneMap == 14401)
         {
            return;
         }
         var hero:Hero = GameUnitManager.hero;
         var x:int = e.localX * this.sx;
         var y:int = e.localY * this.sy;
         x = x > MapManager.mapInfo.width ? int(MapManager.mapInfo.width - 1) : x;
         y = y > MapManager.mapInfo.height ? int(MapManager.mapInfo.height - 1) : y;
         Model_CrossClanBattle.mouseX = x;
         Model_CrossClanBattle.mouseY = y;
         hero.go(x,y);
      }
      
      public function drawPath(path:Array, sx:Number, sy:Number) : void
      {
         var hero:Hero = null;
         this._hasPath = true;
         setChildIndex(this._up,numChildren - 1);
         if(Global.sceneMap == 14401)
         {
            trace("now drawing");
         }
         else
         {
            hero = GameUnitManager.hero;
            path.unshift([hero.global_x,hero.global_y]);
         }
         var endX:Number = Number(path[path.length - 1][0]);
         var endY:Number = Number(path[path.length - 1][1]);
         Utils.drawDashed(this._up.graphics,path,sx,sy);
         this.drawCircle(endX,endY,sx,sy);
      }
      
      public function clearPath() : void
      {
         this._hasPath = false;
         this._up.graphics.clear();
      }
      
      public function get hasPath() : Boolean
      {
         return this._hasPath;
      }
      
      public function addShip(ship:Ship, type:int = 0) : void
      {
         var littleShip:MapShipPart = null;
         var _littleShip:MapShipPart = null;
         if(type == 0)
         {
            if(Boolean(ship) && !listBmShip[ship])
            {
               littleShip = MapShipPart.instance;
               littleShip.addType(1);
               littleShip.ship = ship;
               if(Boolean(littleShip))
               {
                  addChild(littleShip);
               }
               littleShip.update(ship.way,ship.global_x,ship.global_y);
               listBmShip[ship] = littleShip;
            }
         }
         else if(Boolean(ship) && !listBmShip_curMap[ship])
         {
            _littleShip = MapShipPart.instance;
            _littleShip.addType(2);
            _littleShip.ship = ship;
            if(Boolean(_littleShip))
            {
               addChild(_littleShip);
            }
            _littleShip.update(ship.way,ship.global_x,ship.global_y);
            listBmShip_curMap[ship] = _littleShip;
         }
      }
      
      public function refreshShip(ship:Ship, type:int = 0) : void
      {
         if(type == 0)
         {
            if(Boolean(listBmShip[ship]))
            {
               listBmShip[ship].ship = ship;
               if(ship == Ship.myShip)
               {
                  listBmShip[ship].url = "modelRes/role/ship/stand/12346.swf";
               }
               else
               {
                  listBmShip[ship].url = "modelRes/role/ship/stand/12345.swf";
               }
               listBmShip[ship].update(ship.way,ship.global_x,ship.global_y);
            }
         }
         else if(Boolean(listBmShip_curMap[ship]))
         {
            listBmShip_curMap[ship].ship = ship;
            if(ship == Ship.myShip)
            {
               listBmShip_curMap[ship].url = "modelRes/role/ship/stand/12346.swf";
               listBmShip_curMap[ship].addJiaoTou();
            }
            else
            {
               listBmShip_curMap[ship].url = "modelRes/role/ship/stand/12345.swf";
               listBmShip_curMap[ship].removeJiaoTou();
            }
            listBmShip_curMap[ship].update(ship.way,ship.global_x,ship.global_y);
         }
      }
      
      public function removeShip(ship:Ship, type:int = 0) : void
      {
         var mapShipP:MapShipPart = null;
         var _mapShipP:MapShipPart = null;
         if(type == 0)
         {
            if(Boolean(listBmShip[ship]))
            {
               mapShipP = listBmShip[ship];
               if(Boolean(mapShipP))
               {
                  mapShipP.dispose();
               }
               delete listBmShip[ship];
            }
         }
         else if(Boolean(listBmShip_curMap[ship]))
         {
            _mapShipP = listBmShip_curMap[ship];
            if(Boolean(_mapShipP))
            {
               _mapShipP.dispose();
            }
            delete listBmShip_curMap[ship];
         }
      }
      
      public function set bitmapData(bm:BitmapData) : void
      {
         this._bg.bitmapData = bm;
         this._bg.smoothing = true;
      }
      
      public function get bitmapData() : BitmapData
      {
         return this._bg.bitmapData;
      }
      
      public function set smoothing(bool:Boolean) : void
      {
         this._bg.smoothing = true;
      }
      
      override public function set width(value:Number) : void
      {
         this._bg.width = value;
      }
      
      override public function get width() : Number
      {
         return this._bg.width;
      }
      
      override public function set height(value:Number) : void
      {
         this._bg.height = value;
      }
      
      override public function get height() : Number
      {
         return this._bg.height;
      }
      
      public function set enabled(value:Boolean) : void
      {
         mouseChildren = mouseEnabled = value;
      }
      
      private function drawCircle(endX:Number, endY:Number, sx:Number, sy:Number) : void
      {
         var lx:Number = endX / sx;
         var ly:Number = endY / sy;
         this._up.graphics.lineStyle(2,16383744);
         this._up.graphics.drawCircle(lx,ly,5);
         this._up.graphics.endFill();
      }
   }
}

