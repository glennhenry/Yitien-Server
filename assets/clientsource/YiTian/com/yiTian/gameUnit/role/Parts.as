package com.yiTian.gameUnit.role
{
   import com.yiTian.Global;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.config.State;
   import com.yiTian.manager.SceneConfig;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.utils.getTimer;
   
   public class Parts extends Sprite
   {
      
      public static const SHADOW:int = 0;
      
      public static const HORSE:int = 1;
      
      public static const BODY:int = 2;
      
      public static const WEAPON:int = 3;
      
      public static const HORSEHEAD:int = 4;
      
      public static const WING:int = 5;
      
      private var role:Role;
      
      private var list:Array = [];
      
      private var beginTime:int;
      
      private var totalTime:int;
      
      private var rate:Number = 0;
      
      public function Parts(role:Role)
      {
         super();
         this.role = role;
         var i:int = 0;
         while(i < 6)
         {
            this.list[i] = new Part();
            this.list[i].visible = false;
            addChild(this.list[i]);
            i++;
         }
      }
      
      public static function getTime(action:int, speed:int, role:Role) : int
      {
         switch(action)
         {
            case Action.STAND:
               if(Boolean(Global.sceneMap) && SceneConfig.getSceneType() == SceneConfig.KuaFuPaiDui)
               {
                  return 6000;
               }
               return role.standTime;
               break;
            case Action.RUN:
               return 90000 / speed;
            case Action.ATTACT:
               return 800;
            case Action.HIT:
               return 800;
            case Action.DEAD:
               return 800;
            case Action.SIT:
               return 200;
            case Action.FISH:
               return 200;
            case Action.SHAKE:
               return 900;
            default:
               return 0;
         }
      }
      
      private static function getPath(position:int, action:int, sex:int, hasHorse:Boolean) : String
      {
         var positionStr:String = null;
         var actionStr:String = null;
         switch(position)
         {
            case SHADOW:
               return "role/shadow/";
            case BODY:
               positionStr = "role/body/";
               break;
            case WEAPON:
               positionStr = "role/weapon" + sex + "/";
               break;
            case HORSE:
               positionStr = "role/horse/";
               break;
            case HORSEHEAD:
               positionStr = "role/houseHead/";
               break;
            case WING:
               positionStr = "role/wing/";
               break;
            default:
               positionStr = "";
         }
         switch(action)
         {
            case Action.STAND:
               if(position != HORSE && position != HORSEHEAD && hasHorse)
               {
                  actionStr = "hstand/";
                  break;
               }
               actionStr = "stand/";
               break;
            case Action.RUN:
               if(position != HORSE && position != HORSEHEAD && hasHorse)
               {
                  actionStr = "hrun/";
                  break;
               }
               actionStr = "run/";
               break;
            case Action.SIT:
               actionStr = "sit/";
               break;
            case Action.FISH:
               actionStr = "fish/";
               break;
            case Action.SHAKE:
               actionStr = "run/";
         }
         return positionStr + actionStr;
      }
      
      public function hideAll() : void
      {
         var i:String = null;
         for(i in this.list)
         {
            if(Boolean(this.list[i]))
            {
               this.list[i].visible = false;
            }
         }
      }
      
      public function setPart(position:int, value:int) : void
      {
         if(Boolean(value))
         {
            this.list[position].init("modelRes/" + getPath(position,this.role.action,this.role.sex,this.role.hasHorse()) + value + ".swf");
            this.list[position].position = position;
            this.list[position].role = this.role;
            if(position == HORSEHEAD)
            {
               if(this.role.way == 4 && this.role.action == Action.RUN && this.role.hasHorse())
               {
                  this.list[position].visible = true;
               }
               else
               {
                  this.list[position].visible = false;
               }
            }
            else
            {
               this.list[position].visible = true;
            }
         }
         else
         {
            this.list[position].visible = false;
         }
      }
      
      public function getPart(position:int) : Bitmap
      {
         return this.list[position];
      }
      
      public function changePart(isWeaponDown:int = 1) : void
      {
         if(isWeaponDown == 1 && getChildIndex(this.list[BODY]) < getChildIndex(this.list[WEAPON]))
         {
            setChildIndex(this.list[BODY],getChildIndex(this.list[WEAPON]));
         }
         else if(isWeaponDown == 0 && getChildIndex(this.list[BODY]) > getChildIndex(this.list[WEAPON]))
         {
            setChildIndex(this.list[WEAPON],getChildIndex(this.list[BODY]));
         }
      }
      
      public function changeWingLayer(wingLayer:int) : void
      {
         var smallIndex:int = 0;
         var bigIndex:int = 0;
         if(wingLayer == 1 || this.role.action == Action.SIT)
         {
            smallIndex = Math.min(getChildIndex(this.list[WEAPON]),getChildIndex(this.list[BODY]));
            if(getChildIndex(this.list[WING]) > smallIndex)
            {
               setChildIndex(this.list[WING],smallIndex);
            }
         }
         else
         {
            bigIndex = Math.max(getChildIndex(this.list[WEAPON]),getChildIndex(this.list[BODY]));
            if(getChildIndex(this.list[WING]) < bigIndex)
            {
               setChildIndex(this.list[WING],bigIndex);
            }
         }
      }
      
      public function isPartVisible(position:int) : Boolean
      {
         return Boolean(this.list[position]) ? Boolean(this.list[position].visible) : false;
      }
      
      public function update(now:int) : void
      {
         var part:Part = null;
         if(now - this.beginTime >= this.totalTime)
         {
            if(this.role.action == Action.STAND || this.role.action == Action.RUN || this.role.action == Action.SIT)
            {
               this.beginTime = now;
            }
            else if(this.role.action == Action.DEAD)
            {
               this.role.state = State.DEAD;
            }
         }
         if(this.role.state == State.LIFE || this.role.state == State.FLOOR)
         {
            this.rate = (now - this.beginTime) / this.totalTime;
         }
         else if(this.role.state == State.DEAD)
         {
            this.role.action = Action.DEAD;
            this.rate = 1;
         }
         for each(part in this.list)
         {
            if(part.visible)
            {
               part.update(this.role.way,this.rate,now);
            }
         }
      }
      
      public function reset(action:int, speed:int) : void
      {
         this.totalTime = getTime(action,speed,this.role);
         this.beginTime = getTimer();
      }
      
      public function dispose() : void
      {
         var part:Part = null;
         for each(part in this.list)
         {
            part.dispose();
         }
      }
   }
}

import com.utils.DisplayData;
import com.utils.ResObj;
import com.yiTian.gameUnit.role.Hero;
import com.yiTian.gameUnit.role.Parts;
import com.yiTian.gameUnit.role.Pet;
import com.yiTian.gameUnit.role.Player;
import com.yiTian.gameUnit.role.Role;
import com.yiTian.manager.ResourceManager;
import com.yiTian.utils.MassLoader;
import flash.display.Bitmap;

class Part extends Bitmap
{
   
   public var url:String;
   
   public var current:int;
   
   public var position:int;
   
   public var role:Role;
   
   public function Part()
   {
      super();
   }
   
   public function init(url:String) : void
   {
      var level:int = 0;
      if(this.url != null && this.url != "")
      {
         ResourceManager.useComplete(this.url);
      }
      this.url = url;
      this.current = -1;
      if(this.role is Player || this.role is Pet)
      {
         if(this.role is Hero)
         {
            level = MassLoader.LEVEL4;
         }
         else if(this.position == Parts.WING)
         {
            level = MassLoader.LEVEL7;
         }
         else
         {
            level = MassLoader.LEVEL5;
         }
      }
      ResourceManager.load(url,level);
      ResourceManager.addCount(url);
   }
   
   public function isLoad() : Boolean
   {
      var res:ResObj = ResourceManager.resourceIndex[this.url];
      return res.isLoad;
   }
   
   public function update(way:int, rate:Number, nowTime:int) : void
   {
      var res:ResObj = null;
      var now:int = 0;
      var index:int = 0;
      var data:DisplayData = null;
      res = ResourceManager.resourceIndex[this.url];
      if(Boolean(res))
      {
         res.lastUseTime = nowTime;
      }
      if(Boolean(res) && res.isLoad)
      {
         now = rate * res.actionFrame;
         if(now >= res.actionFrame)
         {
            now = res.actionFrame - 1;
         }
         if(now == this.current && Boolean(bitmapData))
         {
            return;
         }
         this.current = now;
         if(res.way == 5)
         {
            index = (way < 5 ? way : 8 - way) * res.actionFrame + this.current;
         }
         else if(res.way == 2)
         {
            if(way >= 2 && way <= 6)
            {
               index = res.actionFrame + this.current;
            }
            else
            {
               index = int(this.current);
            }
         }
         else
         {
            index = int(this.current);
         }
         data = ResourceManager.find(res,index);
         x = data.x;
         y = data.y;
         bitmapData = data.p;
         if(this.position == Parts.BODY)
         {
            this.role.bodyLoaded = res.isLoad;
         }
      }
      else if(this.position == Parts.BODY)
      {
         this.role.bodyLoaded = false;
      }
   }
   
   public function dispose() : void
   {
      bitmapData = null;
      if(this.url != null && this.url != "")
      {
         ResourceManager.useComplete(this.url);
         this.url = null;
      }
   }
}
