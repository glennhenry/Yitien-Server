package com.yiTian.view.modules.map
{
   import com.utils.Util;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.crossClanBattle.Model_CrossClanBattle;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   
   public class MapPoint extends Sprite
   {
      
      public static const SELF:int = 0;
      
      public static const PLAYER:int = 1;
      
      public static const FUN_NPC:int = 2;
      
      public static const MONSTER:int = 3;
      
      public static const JUMP_POINT:int = 5;
      
      public static const FUBENG_POINT:int = 8;
      
      public static const TEAM:int = 10;
      
      private static var pool:Array = [];
      
      private static var colorT:ColorTransform = new ColorTransform(1,1,1,1,250);
      
      private var _icon:Bitmap;
      
      private var _data:Object;
      
      private var pointData:Array;
      
      private var _enabled:Boolean = true;
      
      public function MapPoint()
      {
         this.pointData = [];
         super();
         this._icon = new Bitmap();
         this._icon.x = -7;
         this._icon.y = -7;
         addChild(this._icon);
         addEventListener(MouseEvent.ROLL_OVER,this.onOver);
         addEventListener(MouseEvent.ROLL_OUT,this.onOut);
         addEventListener(MouseEvent.MOUSE_MOVE,function(e:MouseEvent):void
         {
            e.stopPropagation();
         });
         addEventListener(MouseEvent.CLICK,this.go);
         buttonMode = true;
      }
      
      public static function getPoint() : MapPoint
      {
         return pool.length > 0 ? pool.pop() : new MapPoint();
      }
      
      public function init(data:Object) : void
      {
         this._data = data;
         this.getIcon(data.type);
      }
      
      public function reset(data:Object) : void
      {
         this._data = data;
         this.getIcon(data.type);
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set enabled(value:Boolean) : void
      {
         this._enabled = value;
      }
      
      public function dispose() : void
      {
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
         this._icon.transform.colorTransform = Util.colorNomal;
         pool.push(this);
         this.enabled = true;
         this._data = null;
      }
      
      private function onOver(e:MouseEvent) : void
      {
         if(!this._enabled)
         {
            return;
         }
         var temp:String = this._data.name == "0" ? "" : this._data.name;
         var tip:String = temp == "" ? temp : temp + "\n";
         TipManager.update(tip + "[" + int(x * (parent as Map).sx / 20) + "," + int(y * (parent as Map).sy / 20) + "]");
         e.stopPropagation();
      }
      
      private function onOut(e:MouseEvent) : void
      {
         if(!this._enabled)
         {
            return;
         }
         TipManager.hide();
         e.stopPropagation();
      }
      
      private function go(e:MouseEvent) : void
      {
         if(!this._enabled)
         {
            return;
         }
         Model_CrossClanBattle.mouseX = x * (parent as Map).sx;
         Model_CrossClanBattle.mouseY = y * (parent as Map).sy;
         GameUnitManager.hero.go(x * (parent as Map).sx,y * (parent as Map).sy);
         e.stopPropagation();
      }
      
      private function getIcon(type:int) : void
      {
         switch(type)
         {
            case FUN_NPC:
               Utils.getLoadBitmap("resource/image/mapPoint/NPC.png",this._icon);
               break;
            case MONSTER:
               Utils.getLoadBitmap("resource/image/mapPoint/GuaiWu.png",this._icon);
               break;
            case JUMP_POINT:
               Utils.getLoadBitmap("resource/image/mapPoint/PassPoint.png",this._icon);
               this._icon.transform.colorTransform = colorT;
               break;
            case FUBENG_POINT:
               Utils.getLoadBitmap("resource/image/mapPoint/PassPoint.png",this._icon);
               break;
            case PLAYER:
               Utils.getLoadBitmap("resource/image/mapPoint/Player.png",this._icon);
               break;
            case SELF:
               Utils.getLoadBitmap("resource/image/mapPoint/User.png",this._icon);
               break;
            case TEAM:
               Utils.getLoadBitmap("resource/image/mapPoint/Teamer.png",this._icon);
         }
      }
   }
}

