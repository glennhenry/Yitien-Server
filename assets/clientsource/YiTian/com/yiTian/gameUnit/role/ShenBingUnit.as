package com.yiTian.gameUnit.role
{
   import com.utils.DisplayData;
   import com.utils.ResObj;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.gameUnit.GameUnit;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.ResourceManager;
   import flash.display.Bitmap;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class ShenBingUnit extends GameUnit
   {
      
      public static var list:Dictionary = new Dictionary();
      
      public static var pool:Array = [];
      
      public static var shenBingCounter:int = 0;
      
      public static const OFFSET_POINTS:Array = new Array(new Point(0,40),new Point(-20,20),new Point(-40,0),new Point(-20,-20),new Point(0,-40),new Point(20,-20),new Point(40,0),new Point(20,20));
      
      public var shenBingOwner:Player;
      
      protected var _part:Bitmap = new Bitmap();
      
      protected var _resUrl:String;
      
      private var tweDelta:Number = 0;
      
      private var lastUpdateTime:int;
      
      private var beginTime:int;
      
      public var totalTime:int = 1500;
      
      private var current:int;
      
      private var _lastPartX:Number = -100;
      
      private var _lastPartY:Number = -100;
      
      public var _isUseing:Boolean = false;
      
      public function ShenBingUnit(iner:inerClass)
      {
         super();
         state = 2;
         addChild(this._part);
         shenBingCounter += 1;
      }
      
      public static function getShenBingUnit() : ShenBingUnit
      {
         if(shenBingCounter >= 13)
         {
            return Boolean(pool.length) ? pool.pop() : null;
         }
         return new ShenBingUnit(new inerClass());
      }
      
      public function initSb(level:int, player:Player) : void
      {
         this.shenBingOwner = player;
         id = player.id + 0.1;
         if(!this._isUseing)
         {
            global_x = player.global_x;
            global_y = player.global_y;
         }
         this._resUrl = "modelRes/role/shenbin/" + Enum_job.getBaseJob(player.job) + "_" + level + ".swf";
         this._isUseing = true;
         list[id] = this;
         GameUnitManager.setSingleShenBingVisible(this);
      }
      
      override public function update(nowTime:int) : void
      {
         var yOff:Number = NaN;
         var res:ResObj = null;
         var now:int = 0;
         var data:DisplayData = null;
         if(!this.shenBingOwner || !this._isUseing)
         {
            this.dispose();
         }
         if(!visible)
         {
            return;
         }
         var disX:int = this.shenBingOwner.global_x + OFFSET_POINTS[this.shenBingOwner.way].x;
         var disY:int = this.shenBingOwner.global_y + OFFSET_POINTS[this.shenBingOwner.way].y;
         global_x = disX + (global_x - disX) * 0.8;
         global_y = disY + (global_y - disY) * 0.8;
         this.align();
         this.tweDelta += 0.02;
         this.tweDelta %= 2;
         yOff = Math.sin(this.tweDelta * Math.PI);
         this._part.y = this._lastPartY + yOff * 8 - 120;
         if(nowTime - this.lastUpdateTime < 200)
         {
            return;
         }
         res = ResourceManager.resourceIndex[this._resUrl];
         var percent:Number = 0;
         if(!res)
         {
            res = new ResObj();
            res.url = this._resUrl;
            ResourceManager.resourceIndex[this._resUrl] = res;
            ResourceManager.load(this._resUrl);
         }
         if(Boolean(res) && res.isLoad)
         {
            percent = (nowTime - this.lastUpdateTime) / this.totalTime * res.actionFrame;
            now = percent % res.actionFrame;
            if(now == this.current && Boolean(this._part.bitmapData))
            {
               return;
            }
            data = ResourceManager.find(res,now);
            this._lastPartY = data.y;
            this._part.x = data.x;
            this._part.y = data.y + yOff * 8 - 120;
            this._part.bitmapData = data.p;
            this.current = now;
            res.lastUseTime = nowTime;
         }
         this.lastUpdateTime = now;
      }
      
      override public function show() : void
      {
         list[id] = this;
      }
      
      override public function align() : void
      {
         x = global_x;
         y = global_y;
      }
      
      override public function dispose() : void
      {
         if(this.shenBingOwner != GameUnitManager.hero && this._isUseing)
         {
            this.shenBingOwner = null;
            if(pool.indexOf(this) == -1)
            {
               pool.push(this);
            }
            super.dispose();
            delete list[id];
         }
         visible = visible || true;
         this._isUseing = false;
      }
   }
}

class inerClass
{
   
   public function inerClass()
   {
      super();
   }
}
