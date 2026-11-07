package com.yiTian.view.modules.ship
{
   import com.utils.Util;
   import com.yiTian.gameUnit.config.Action;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class Ship_part extends Sprite
   {
      
      private var list:Array = [];
      
      private var totalTime:int;
      
      private var beginTime:int;
      
      private var ship:Ship;
      
      public var hasAddEvent:Boolean = false;
      
      public function Ship_part(ship:Ship)
      {
         var part:InerPart = null;
         super();
         this.ship = ship;
         ship.addChild(this);
         var i:int = 0;
         while(i < 1)
         {
            part = new InerPart();
            addChild(part);
            this.list.push(part);
            i++;
         }
         this.addEvent();
      }
      
      private function setChoose(e:MouseEvent) : void
      {
         this.ship.interaction();
      }
      
      private function overEvent(e:MouseEvent) : void
      {
         transform.colorTransform = Util.colorGlow;
      }
      
      private function outEvent(e:MouseEvent) : void
      {
         transform.colorTransform = Util.colorNomal;
      }
      
      public function addEvent() : void
      {
         addEventListener(MouseEvent.CLICK,this.setChoose);
         addEventListener(MouseEvent.MOUSE_OVER,this.overEvent);
         addEventListener(MouseEvent.MOUSE_OUT,this.outEvent);
         this.hasAddEvent = true;
      }
      
      public function removeEvent() : void
      {
         removeEventListener(MouseEvent.CLICK,this.setChoose);
         removeEventListener(MouseEvent.MOUSE_OVER,this.overEvent);
         removeEventListener(MouseEvent.MOUSE_OUT,this.outEvent);
         this.hasAddEvent = false;
      }
      
      private function getUrl(action:int) : String
      {
         var url:String = null;
         switch(action)
         {
            case Action.STAND:
               url = "modelRes/role/ship/stand";
               break;
            case Action.RUN:
               url = "modelRes/role/ship/run";
               break;
            default:
               url = "";
         }
         return url;
      }
      
      public function setPart(value:int, position:int) : void
      {
         if(Boolean(value))
         {
            this.list[position].init(this.getUrl(this.ship.action) + "/" + value + ".swf");
            this.list[position].ship = this.ship;
         }
      }
      
      public function update(now:int) : void
      {
         var part:InerPart = null;
         if(now - this.beginTime >= this.totalTime)
         {
            this.beginTime = now;
         }
         var rate:Number = (now - this.beginTime) / this.totalTime;
         if(this.ship.zhuanDong)
         {
            this.zhuanHd();
            return;
         }
         for each(part in this.list)
         {
            part.update(this.ship.way,rate,now);
         }
      }
      
      public function setPartWay(value:int) : void
      {
         var part:InerPart = null;
         for each(part in this.list)
         {
            part.update(value,1,getTimer());
         }
      }
      
      public function turnToNormal() : void
      {
         this.rotation = 0;
      }
      
      public function zhuanHd() : void
      {
         this.rotation += 30;
      }
      
      public function getPart(index:int = 0) : Bitmap
      {
         return this.list[index];
      }
      
      public function reset(speed:int = 200) : void
      {
         this.totalTime = 90000 / speed;
         this.beginTime = getTimer();
      }
      
      public function dispose() : void
      {
         var part:InerPart = null;
         for each(part in this.list)
         {
            part.dispose();
         }
      }
   }
}

import com.utils.DisplayData;
import com.utils.ResObj;
import com.yiTian.manager.ResourceManager;
import com.yiTian.utils.MassLoader;
import com.yiTian.view.modules.ship.Ship;
import flash.display.Bitmap;

class InerPart extends Bitmap
{
   
   public var url:String;
   
   public var current:int;
   
   public var ship:Ship;
   
   public function InerPart()
   {
      super();
   }
   
   public function init(url:String = "") : void
   {
      if(this.url != null && this.url != "")
      {
         ResourceManager.useComplete(url);
      }
      this.url = url;
      this.current = -1;
      ResourceManager.load(url,MassLoader.LEVEL5);
      ResourceManager.addCount(url);
   }
   
   public function update(way:int, rate:Number, nowTime:int) : void
   {
      var now:int = 0;
      var data:DisplayData = null;
      var res:ResObj = ResourceManager.resourceIndex[this.url];
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
         this.current = (way < 7 ? way : 12 - way) * res.actionFrame + now;
         data = ResourceManager.find(res,this.current);
         x = data.x;
         y = data.y;
         bitmapData = data.p;
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
