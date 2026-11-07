package com.yiTian.manager
{
   import com.yiTian.Global;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.modules.boatChall.BoatManager;
   import com.yiTian.view.modules.ship.Ship;
   import com.yiTian.view.modules.treeDownCL.Model_treeCL;
   
   public class CameraManager
   {
      
      public static var sightX:int;
      
      public static var sightY:int;
      
      private static var ngx:int;
      
      private static var ngy:int;
      
      private static var tx:int;
      
      private static var ty:int;
      
      private static var t:int;
      
      private static var _cm:CameraBehvBase;
      
      public static var watch_x:int;
      
      public static var watch_y:int;
      
      public static var _x:Number;
      
      public static var _y:Number;
      
      private static var sw:int = 3;
      
      private static var sh:int = 2;
      
      private static var gx:int = -1;
      
      private static var gy:int = -1;
      
      private static var isFirstCoorSild:Boolean = false;
      
      public function CameraManager()
      {
         super();
      }
      
      public static function setImpl(cm:CameraBehvBase) : void
      {
         _cm = cm;
      }
      
      public static function removeImpl() : void
      {
         _cm = null;
      }
      
      public static function wacth(global_x:int, global_y:int) : void
      {
         if(Boolean(_cm))
         {
            _cm.update(global_x,global_y);
            return;
         }
         if(Global.isInBattle)
         {
            return;
         }
         if(MapManager.isLoadMap)
         {
            return;
         }
         wacthIm(global_x,global_y);
         watch_x = global_x;
         watch_y = global_y;
      }
      
      public static function setToScaleCoord() : void
      {
         Tween.to(GameScene.mapLayer,1200,{
            "x":[undefined,0],
            "y":[undefined,0]
         });
         Tween.to(GameScene.mainLayer,1200,{
            "x":[undefined,0],
            "y":[undefined,0]
         });
         Tween.to(GameScene.gridLayer,1200,{
            "x":[undefined,0],
            "y":[undefined,0]
         });
      }
      
      public static function setOriScaleCoord(time:int) : void
      {
         Tween.to(GameScene.mapLayer,1200,{
            "x":[GameScene.mainLayer.y,ngx * MapManager.BLOCK_WIDTH - sightX],
            "y":[GameScene.mainLayer.y,ngy * MapManager.BLOCK_HEIGHT - sightY]
         });
         Tween.to(GameScene.mainLayer,1200,{
            "x":[GameScene.mainLayer.x,-sightX],
            "y":[GameScene.mainLayer.x,-sightY]
         });
         Tween.to(GameScene.gridLayer,1200,{
            "x":[GameScene.gridLayer.x,-sightX],
            "y":[GameScene.gridLayer.y,-sightY]
         });
      }
      
      public static function resetMapPosition(x:int, y:int) : void
      {
         sightX = x - Global.stage.stageWidth / GameScene.scaleRate / 2;
         sightY = y - Global.stage.stageHeight / GameScene.scaleRate / 2 - 60;
         if(sightX < 0)
         {
            sightX = 0;
         }
         if(sightY < 0)
         {
            sightY = 0;
         }
         MapManager.RIGHT_BORDER = MapManager.mapInfo.width - Global.stage.stageWidth / GameScene.scaleRate;
         MapManager.BOTTOM_BORDER = MapManager.mapInfo.height - Global.stage.stageHeight / GameScene.scaleRate;
         if(sightX > MapManager.RIGHT_BORDER)
         {
            sightX = MapManager.RIGHT_BORDER;
         }
         if(sightY > MapManager.BOTTOM_BORDER)
         {
            sightY = MapManager.BOTTOM_BORDER;
         }
         GameScene.mapLayer.x = -sightX;
         GameScene.mapLayer.y = -sightY;
         GameScene.mainLayer.x = -sightX;
         GameScene.mainLayer.y = -sightY;
         GameScene.gridLayer.x = GameScene.mainLayer.x;
         GameScene.gridLayer.y = GameScene.mainLayer.y;
         UIManager.smallMap.wacth();
         UIManager.mappanel.watch();
      }
      
      public static function wacthIm(x:int, y:int) : void
      {
         _x = x;
         _y = y;
         sightX = x - Global.stage.stageWidth / 2;
         sightY = y - Global.stage.stageHeight / 2 - 60;
         if(sightX < 0)
         {
            sightX = 0;
         }
         if(sightY < 0)
         {
            sightY = 0;
         }
         if(sightX > MapManager.RIGHT_BORDER)
         {
            sightX = MapManager.RIGHT_BORDER;
         }
         if(sightY > MapManager.BOTTOM_BORDER)
         {
            sightY = MapManager.BOTTOM_BORDER;
         }
         ngx = sightX / MapManager.BLOCK_WIDTH;
         ngy = sightY / MapManager.BLOCK_HEIGHT;
         GameScene.mapLayer.x = ngx * MapManager.BLOCK_WIDTH - sightX;
         GameScene.mapLayer.y = ngy * MapManager.BLOCK_HEIGHT - sightY;
         GameScene.mainLayer.x = -sightX;
         GameScene.mainLayer.y = -sightY;
         GameScene.gridLayer.x = GameScene.mainLayer.x;
         GameScene.gridLayer.y = GameScene.mainLayer.y;
         UIManager.smallMap.wacth();
         UIManager.mappanel.watch();
         if(ngx != gx || ngy != gy)
         {
            MapManager.refreshMap(ngx,ngy);
            gx = ngx;
            gy = ngy;
         }
      }
      
      public static function resize() : void
      {
         dispose();
         if(Global.isPlayingMarriageEffect)
         {
            wacthIm(_x,_y);
         }
         else if(Boolean(GuideManager.isPlaying) && Boolean(GuideManager.watchX) && Boolean(GuideManager.watchY))
         {
            wacth(GuideManager.watchX,GuideManager.watchY);
         }
         else if(Model_treeCL.watchX > 0 && Model_treeCL.watchY > 0)
         {
            wacth(Model_treeCL.watchX,Model_treeCL.watchY);
         }
         else if(Global.sceneMap == 14401)
         {
            if(Boolean(Ship.myShip))
            {
               wacth(Ship.myShip.global_x,Ship.myShip.global_y);
            }
            else if(!BoatManager.isMyShipEnding)
            {
               wacth(BoatManager.WATCH_X,BoatManager.WATCH_Y);
            }
            else if(Boolean(BoatManager.END_X) && Boolean(BoatManager.END_Y))
            {
               wacth(BoatManager.END_X,BoatManager.END_Y);
            }
         }
         else
         {
            wacth(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y);
         }
      }
      
      public static function cameraFromTo(sx:Number, sy:Number, ex:Number, ey:Number, time:int, endCallBack:Function = null, easing:String = "bee_line") : void
      {
         Global.isPlayingMarriageEffect = true;
         var p:PP = Singleton.getInstance(PP);
         p._sx = sx;
         p._sy = sy;
         p._ex = ex;
         p._ey = ey;
         Tween.to(p,time,{"percent":[0,1]},endCallBack);
      }
      
      public static function stopCameraMove() : void
      {
         Tween.stop(Singleton.getInstance(PP));
      }
      
      private static function moveEnd() : void
      {
      }
      
      public static function dispose() : void
      {
         gx = -1;
         gy = -1;
      }
   }
}

import com.yiTian.manager.CameraManager;

class PP
{
   
   public var _sx:Number;
   
   public var _sy:Number;
   
   public var _ex:Number;
   
   public var _ey:Number;
   
   private var _tickCallBack:Object;
   
   public function PP()
   {
      super();
   }
   
   public function set percent(value:Number) : void
   {
      var px:int = this._sx + (this._ex - this._sx) * value;
      var py:int = this._sy + (this._ey - this._sy) * value;
      CameraManager.wacthIm(px,py);
   }
}
