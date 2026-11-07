package com.yiTian.gameUnit.role
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.config.State;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.utils.Pool;
   import com.yiTian.utils.Tween;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.utils.getTimer;
   
   public class BattleUnitParts extends Sprite
   {
      
      public static const SHADOW:int = 0;
      
      public static const BODY:int = 1;
      
      public static const WEAPON:int = 2;
      
      private static var yellow:ColorTransform = new ColorTransform(1,1,1,1,222,103,15,1);
      
      public static var bbmmArr:Array = [];
      
      private var battleUnit:BattleUnit;
      
      private var list:Array = [];
      
      private var beginTime:int;
      
      public var totalTime:int;
      
      private var rate:Number = 0;
      
      private var bbTotalTime:int = 30;
      
      private var __beginTime:int = 0;
      
      private var angle:Number = 0;
      
      public var stop:Boolean = false;
      
      public function BattleUnitParts(battleUnit:BattleUnit)
      {
         super();
         this.battleUnit = battleUnit;
         var i:int = 0;
         while(i < 3)
         {
            this.list[i] = new Part();
            this.list[i].visible = false;
            addChild(this.list[i]);
            i++;
         }
      }
      
      public static function getTime(action:int, speed:int, attackTime:int) : int
      {
         switch(action)
         {
            case Action.STAND:
               return 1000;
            case Action.RUN:
               return 700000 / speed;
            case Action.ATTACT:
               return attackTime;
            case Action.HIT:
               return 300;
            case Action.DEAD:
               return 100;
            default:
               return 0;
         }
      }
      
      public static function getPath(position:int, action:int, sex:int) : String
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
            default:
               positionStr = "";
         }
         switch(action)
         {
            case Action.STAND:
               actionStr = "stand/";
               break;
            case Action.RUN:
               actionStr = "run/";
               break;
            case Action.ATTACT:
               actionStr = "attack/";
               break;
            case Action.HIT:
               actionStr = "hit/";
               break;
            case Action.DEAD:
               actionStr = "dead/";
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
      
      public function showPart(position:int, value:Boolean) : void
      {
         this.list[position].visible = value;
      }
      
      public function setPart(position:int, value:String) : void
      {
         if(Boolean(value) && value != "0")
         {
            this.list[position].init("modelRes/" + getPath(position,this.battleUnit.action,this.battleUnit.sex) + value + ".swf");
            this.list[position].position = position;
            this.list[position].battleUnit = this.battleUnit;
            this.list[position].visible = true;
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
      
      public function BFBZEff() : void
      {
         this.list[BODY].transform.colorTransform = yellow;
      }
      
      public function removeBFBZEff() : void
      {
         this.list[BODY].transform.colorTransform = Util.colorNomal;
      }
      
      public function changePart(isWeaponDown:int = 1) : void
      {
         if(isWeaponDown == 1 && getChildIndex(this.list[BODY]) == BODY)
         {
            setChildIndex(this.list[BODY],WEAPON);
            setChildIndex(this.list[WEAPON],BODY);
            return;
         }
         if(isWeaponDown == 0 && getChildIndex(this.list[BODY]) != BODY)
         {
            setChildIndex(this.list[BODY],BODY);
            setChildIndex(this.list[WEAPON],WEAPON);
         }
      }
      
      public function showBBA(endCall:Function) : void
      {
         var bmd:BitmapData;
         var bodyBm:Part = null;
         var bb:Bitmap = Pool.getObject(Bitmap);
         bodyBm = this.list[BODY];
         bodyBm.stopCounts = -1;
         bmd = new BitmapData(bodyBm.width,bodyBm.height,true,0);
         bmd.draw(bodyBm);
         bb.bitmapData = bmd;
         bb.alpha = 0.6;
         ComponentUtil.setPropertie(bb,{
            "x":bodyBm.x,
            "y":bodyBm.y
         });
         if(Boolean(bodyBm.parent))
         {
            bodyBm.parent.addChild(bb);
         }
         Tween.to(bb,200,{
            "x":[bb.x,bb.x - bb.width / 2],
            "y":[bb.y,bb.y - bb.height / 2],
            "scaleX":[1,2],
            "scaleY":[1,2],
            "alpha":[0.8,0.3]
         },function(_bb:Bitmap):void
         {
            Tween.to(_bb,200,{
               "x":[_bb.x,bodyBm.x],
               "y":[_bb.y,bodyBm.y],
               "scaleX":[2,1],
               "scaleY":[2,1],
               "alpha":[0.3,0.8]
            },function(__bb:Bitmap):void
            {
               if(Boolean(__bb) && Boolean(__bb.parent))
               {
                  __bb.parent.removeChild(__bb);
               }
               Pool.saveObject(__bb);
               bodyBm.stopCounts = 400;
               endCall();
            });
         });
      }
      
      public function EffBFBZ(endCall:Function) : void
      {
         var temBmArr:Array;
         var objArr:Array;
         var i:int;
         var bodyBm:Part = null;
         var bb:Bitmap = null;
         var bmd:BitmapData = null;
         bodyBm = this.list[BODY];
         bodyBm.stopCounts = -1;
         temBmArr = [];
         objArr = [{
            "x":bodyBm.x,
            "y":bodyBm.y - 100
         },{
            "x":bodyBm.x - 150,
            "y":bodyBm.y
         },{
            "x":bodyBm.x,
            "y":bodyBm.y + 100
         },{
            "x":bodyBm.x + 150,
            "y":bodyBm.y
         }];
         i = 0;
         while(i < 4)
         {
            bb = Pool.getObject(Bitmap);
            bmd = new BitmapData(bodyBm.width,bodyBm.height,true,0);
            bmd.draw(bodyBm);
            bb.bitmapData = bmd;
            bb.alpha = 0.8;
            bb.scaleX = 2;
            bb.scaleY = 2;
            bb.transform.colorTransform = yellow;
            ComponentUtil.setPropertie(bb,objArr[i]);
            if(Boolean(bodyBm.parent))
            {
               bodyBm.parent.addChild(bb);
            }
            Tween.to(bb,400,{
               "x":[bb.x,bodyBm.x],
               "y":[bb.y,bodyBm.y],
               "scaleX":[2,1],
               "scaleY":[2,1],
               "alpha":[0.8,0.4]
            },function(_b:Bitmap):void
            {
               Tween.to(_b,80,{
                  "scaleX":[1,2],
                  "scaleY":[1,2],
                  "alpha":[1,0],
                  "x":[_b.x,_b.x - _b.width / 2],
                  "y":[_b.y,_b.y - _b.height / 2]
               },function(b2b:Bitmap):void
               {
                  if(Boolean(b2b) && Boolean(b2b.parent))
                  {
                     b2b.parent.removeChild(b2b);
                  }
                  Pool.saveObject(b2b);
                  bodyBm.stopCounts = 400;
                  BFBZEff();
                  endCall();
               });
            },function(thread:Object):void
            {
               var __b:Bitmap = null;
               __b = thread.target;
               var ___b:Bitmap = Pool.getObject(Bitmap);
               ___b.bitmapData = __b.bitmapData;
               ___b.scaleX = __b.scaleX;
               ___b.scaleY = __b.scaleY;
               ComponentUtil.setPropertie(___b,{
                  "x":__b.x,
                  "y":__b.y
               });
               if(Boolean(__b) && Boolean(__b.parent))
               {
                  __b.parent.addChild(___b);
               }
               Tween.to(___b,30,{"alpha":[1,0]},function(b_b:Bitmap):void
               {
                  if(Boolean(b_b.parent))
                  {
                     b_b.parent.removeChild(b_b);
                  }
                  Pool.saveObject(b_b);
               });
            },Tween.SIN);
            i++;
         }
      }
      
      public function isPartVisible(position:int) : Boolean
      {
         return Boolean(this.list[position]) ? Boolean(this.list[position].visible) : false;
      }
      
      public function update(now:int) : void
      {
         var part:Part = null;
         if(this.stop)
         {
            return;
         }
         if(now - this.beginTime >= this.totalTime)
         {
            if(this.battleUnit.action == Action.STAND || this.battleUnit.action == Action.RUN)
            {
               this.beginTime = now;
            }
            else if(this.battleUnit.action == Action.HIT)
            {
               if(this.battleUnit.state == State.LIFE)
               {
                  this.battleUnit.action = Action.STAND;
               }
               else if(this.battleUnit.type == UnitType.NPC)
               {
                  this.battleUnit.playDead();
               }
               else
               {
                  this.battleUnit.action = Action.DEAD;
               }
            }
         }
         if(this.battleUnit.state == State.LIFE)
         {
            this.rate = (now - this.beginTime) / this.totalTime;
         }
         else if(this.battleUnit.action == State.DEAD)
         {
            this.rate = 1;
         }
         for each(part in this.list)
         {
            if(part.visible)
            {
               part.update(this.battleUnit.way,this.rate,(this.list[BODY] as Part).url,now);
            }
         }
      }
      
      public function reset(action:int, speed:int, attackTime:int = 0) : void
      {
         this.totalTime = getTime(action,speed,attackTime);
         this.beginTime = getTimer();
      }
      
      public function dispose() : void
      {
         var part:Part = null;
         this.stop = false;
         for each(part in this.list)
         {
            part.dispose();
         }
      }
   }
}

import com.utils.DisplayData;
import com.utils.ResObj;
import com.utils.Util;
import com.yiTian.gameUnit.role.BattleUnit;
import com.yiTian.gameUnit.role.BattleUnitParts;
import com.yiTian.manager.ResourceManager;
import com.yiTian.utils.MassLoader;
import flash.display.Bitmap;

class Part extends Bitmap
{
   
   public var url:String;
   
   public var current:int;
   
   public var position:int;
   
   public var battleUnit:BattleUnit;
   
   public var stopCounts:int = 0;
   
   public function Part()
   {
      super();
   }
   
   public function init(url:String) : void
   {
      if(this.url != null && this.url != "")
      {
         ResourceManager.useComplete(this.url);
      }
      this.url = url;
      this.current = -1;
      ResourceManager.load(url,MassLoader.LEVEL4);
      ResourceManager.addCount(url);
   }
   
   public function isLoad() : Boolean
   {
      var res:ResObj = ResourceManager.resourceIndex[this.url];
      return res.isLoad;
   }
   
   public function update(way:int, rate:Number, bodyUrl:String, nowTime:int) : void
   {
      var frameRes:ResObj = null;
      var now:int = 0;
      var index:int = 0;
      var data:DisplayData = null;
      var frameIndex:int = 0;
      var tempWay:int = 0;
      if(this.stopCounts < 0)
      {
         return;
      }
      if(this.stopCounts > 0)
      {
         nowTime += this.stopCounts;
         this.stopCounts = 0;
      }
      var res:ResObj = ResourceManager.resourceIndex[this.url];
      if(Boolean(res))
      {
         res.lastUseTime = nowTime;
      }
      var bodyRes:ResObj = ResourceManager.resourceIndex[bodyUrl];
      if(!(bodyRes && bodyRes.isLoad))
      {
         return;
      }
      if(Boolean(res) && res.isLoad)
      {
         if(this.position == BattleUnitParts.BODY)
         {
            this.battleUnit.bodyLoaded = res.isLoad;
         }
         frameRes = this.position == BattleUnitParts.WEAPON ? bodyRes : res;
         now = rate * frameRes.actionFrame;
         if(now >= frameRes.actionFrame)
         {
            now = frameRes.actionFrame - 1;
         }
         if(now == this.current)
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
            if(frameRes.isSpecial)
            {
               frameIndex = int(frameRes.f[this.current]);
               if(frameIndex == -1)
               {
                  bitmapData = null;
                  return;
               }
               if(frameRes.f[this.current] == undefined)
               {
                  bitmapData = null;
                  return;
               }
               index = frameRes.rect.length / frameRes.way * way + frameRes.f[this.current];
            }
            else
            {
               tempWay = way;
               if(tempWay == 3)
               {
                  tempWay = 1;
               }
               if(tempWay == 7)
               {
                  tempWay = 0;
               }
               index = tempWay * res.actionFrame + this.current;
            }
         }
         else if(res.way == 1)
         {
            if(frameRes.isSpecial)
            {
               frameIndex = int(frameRes.f[this.current]);
               if(frameIndex == -1)
               {
                  bitmapData = null;
                  return;
               }
               if(frameRes.f[this.current] == undefined)
               {
                  bitmapData = null;
                  return;
               }
               index = int(frameRes.f[this.current]);
            }
            else
            {
               index = int(this.current);
            }
         }
         data = ResourceManager.find(res,index);
         x = data.x;
         y = data.y;
         bitmapData = data.p;
      }
      else if(this.position == BattleUnitParts.BODY)
      {
         this.battleUnit.bodyLoaded = false;
      }
   }
   
   public function dispose() : void
   {
      bitmapData = null;
      transform.colorTransform = Util.colorNomal;
      if(this.url != null && this.url != "")
      {
         ResourceManager.useComplete(this.url);
         this.url = null;
      }
   }
}
